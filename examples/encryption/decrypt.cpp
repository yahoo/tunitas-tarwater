// https://www.cryptopp.com/wiki/Keys_and_Formats
// https://www.cryptopp.com/wiki/Rsa_encryption_schemes#RSA_Encryption_Scheme_.28OAEP_and_SHA.29
// https://www.cryptopp.com/w/images/2/23/RSA-ES-OAEP-SHA-Filter-Test.zip
// https://www.cryptopp.com/w/images/4/4f/Cryptopp-key-gen.zip
// https://www.cryptopp.com/w/images/e/e5/RSA-ES-OAEP-SHA-Test.zip
// https://www.cryptopp.com/w/images/f/f7/Cryptopp-key-encode.zip
#include <cryptopp/base64.h>   // CryptoPP::Base64Encoder, Base64Decoder
#include <cryptopp/cryptlib.h> // CryptoPP::PrivateKey, PublicKey, BufferedTransformation
#include <cryptopp/files.h>    // CryptoPP::FileSource, FileSink
#include <cryptopp/filters.h>  // CryptoPP::StringSink
#include <cryptopp/osrng.h>    // CryptoPP::AutoSeededRandomPool
#include <cryptopp/queue.h>    // CryptoPP::ByteQueue;
#include <cryptopp/rsa.h>      // CryptoPP::InvertibleRSAFunction
#include <cryptopp/secblock.h> // CryptoPP::SecByteBlock
namespace cryptopp = CryptoPP;
#include <cassert>
#include <deque>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>
#include <system_error>
#include <cerrno>
namespace our {
  namespace exception {
    class Benign : public std::runtime_error {
    protected:
      ~Benign() = default;
    public:
      using runtime_error::runtime_error;
    };
    struct Usage : public Benign {
      using Benign::Benign;
    };
    class Malignant : public std::runtime_error {
    protected:
      ~Malignant() = default;
    public:
      using runtime_error::runtime_error;
    };
    struct Config : public Malignant {
      using Malignant::Malignant;
    };
    struct Mismatch : public Malignant {
      using Malignant::Malignant;
    };
    struct Invalid : public Malignant {
      using Malignant::Malignant;
    };
  }
}
namespace our {
  // Nobody likes to implement key comparisons?
  //   https://github.com/golang/go/issues/21704
  // For ssh they suggest "marshall the key to a byte buffer, compare the bytes"
  template<typename KEY> auto compare(KEY const &a, KEY const b) -> bool {
    cryptopp::ByteQueue qa, qb;
    a.Save(qa);
    b.Save(qb);
    return qa == qb;
  }
}
auto main(int c, char *v[]) -> int {
  std::string NAME{v[0]};
  try {
    //
    // Step -1, validate the inputs to the program
    //
    std::deque<std::string> av(&v[0], &v[c]);
    if (3 != av.size() || av.front().empty() || '-' == av.front().front()) {
      throw our::exception::Usage{"usage: decrypt example.private.der id-encrypted-base64.txt"};
    }
    //
    // Step 0, recover the arguments from the TUI (Text UI, the command line).
    //
    av.pop_front();
    auto const private_key_filename = av.front();
    av.pop_front();
    auto const encrypted_blob_base64_filename = av.front();
    if (private_key_filename.size() != 4+private_key_filename.find(".der")) {
      throw our::exception::Config{"the private key filename must end in '.der'"};
    } 
    if (encrypted_blob_base64_filename.size() != 4+encrypted_blob_base64_filename.find(".txt")) {
      throw our::exception::Config{"the encrypted message base64 filename must end in '.txt'"};
    } 
    // and ... you'll need this
    cryptopp::AutoSeededRandomPool rng; 
    //
    // Step 1, Recover the private key from the filesystem & validate it.
    //
    auto const private_key = [&rng, &private_key_filename]() -> cryptopp::RSA::PrivateKey {
      // http://www.cryptopp.com/docs/ref/class_file_source.html
      cryptopp::FileSource file(private_key_filename.c_str(), true /*pumpAll*/);
      // http://www.cryptopp.com/docs/ref/class_byte_queue.html
      cryptopp::ByteQueue q;
      file.TransferTo(q);
      q.MessageEnd();
      cryptopp::RSA::PrivateKey recovered_key;
      recovered_key.Load(q);
      {
        // <quote>Level denotes the level of thoroughness:
        // 0 - using this object won't cause a crash or exception (rng is ignored);
        // 1 - this object will probably function (encrypt, sign, etc.) correctly (but may not check for weak keys and such);
        // 2 - make sure this object will function correctly, and do reasonable security checks;
        // 3 - do checks that may take a long time.</quote>
        auto const VALIDATION_LEVEL = 3;
        if (!recovered_key.Validate(rng, VALIDATION_LEVEL)) {
          throw our::exception::Invalid{"private key does not validate at level " + std::to_string(VALIDATION_LEVEL)};
        }
      }
      return std::move(recovered_key);
    }();
    //
    // Step 2, Slurp out the cryptoblob from the filesystem.
    //
    auto const cryptoblob = [&encrypted_blob_base64_filename]() -> std::string {
      std::string payload;
      cryptopp::FileSource file{encrypted_blob_base64_filename.c_str(), true /*pumpAll*/, new cryptopp::Base64Decoder{new cryptopp::StringSink{payload}}};
      return std::move(payload);
    }();
    //
    // Step 3, Decrypt the cryptoblob.
    // Step 4. Profit!
    //
    auto const plaintext = [&rng, &cryptoblob, &private_key]() -> cryptopp::SecByteBlock {
      cryptopp::RSAES_OAEP_SHA_Decryptor decryptor{private_key};
      // Now that there is a concrete object, we can check sizes
      // [[UNDERSTAND]] -- when can this occur?
      if (0 == decryptor.FixedCiphertextLength()) {
        throw our::exception::Invalid{"the decryptor is unuseable, being zero sized"};
      }
      // This can occur when the cryptoblob is too outrageously big to for the algo.
      // This "can never happen" with a valid DigiTrust cryptoblob of ~340 bytes.
      if (cryptoblob.size() > decryptor.FixedCiphertextLength()) {
        std::ostringstream buf;
        buf << "the cryptoblob at " << cryptoblob.size() << " bytes"
            << " is too big to be decrypted by the RSA/OAEP/SHA-1/blahblahblah"
            << " with a limit of " << decryptor.FixedCiphertextLength() << " bytes";
        throw our::exception::Invalid{buf.str()};
      }
      // Create recovered text space
      std::size_t dpl = decryptor.MaxPlaintextLength(cryptoblob.size());
      if (0 == dpl) {
        // [[MAYBE]] truncate this down, entersify this into "the decryptor is unusable #1"
        throw our::exception::Invalid{"the decryptor is unusable, supporting only 0 length messages"};
      }
      cryptopp::SecByteBlock recovered{dpl};
      auto bytes = reinterpret_cast</*not std::byte*/ ::byte const *>(cryptoblob.data()); 
      cryptopp::DecodingResult result = decryptor.Decrypt(rng, bytes, cryptoblob.size(), recovered);
      if (!result.isValidCoding) {
        // [[MAYBE]] truncate this down, entersify this into "the decryptor is unusable #2"
        throw our::exception::Invalid{"the decryptor is unusable, the resulting coding is invalid"};
      }
      auto const max_plaintext_length = decryptor.MaxPlaintextLength(cryptoblob.size());
      if (result.messageLength > max_plaintext_length) {
        // [[MAYBE]] truncate this down, entersify this into "the decryptor is unusable #3"
        std::ostringstream buf;
        buf << "the decryptor is unusable, the message length of " << result.messageLength << " bytes"
            << " was truncated by the decryptor at " << max_plaintext_length << " bytes";
        throw our::exception::Invalid{buf.str()};
      }
      // At this point, we can set the size of the recovered data.
      // Until decryption occurs (successfully), we only knew its maximum size.
      recovered.resize(result.messageLength);
      return std::move(recovered);
    }();
    std::cout << NAME << ": OK, recovered ";
    std::copy(plaintext.begin(), plaintext.end(), std::ostream_iterator<char>{std::cout});
    std::cout << '\n';
    return 0;
  } catch (cryptopp::Exception const &e) {
    std::cerr << NAME << ": error, " << e.what() << '\n';
  } catch (our::exception::Benign const &e) {
    std::cout << e.what() << '\n';
    return 0;
  } catch (our::exception::Malignant const &e) {
    std::cerr << NAME << ": error, " << e.what() << '\n';
    return 1;
  } catch (std::exception const &e) {
    std::cerr << NAME << ": error, (SURPRISE!) " << e.what() << '\n';
    return 1;
  }
}
