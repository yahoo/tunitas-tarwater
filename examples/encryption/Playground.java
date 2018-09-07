// See https://github.com/digi-trust/dt-cdn/wiki/ID-encryption
// The Java compiler requires that programs are in an eponymous filename.
import java.io.File;
import java.nio.file.Files;
import java.security.Key;
import java.security.KeyFactory;
import java.security.spec.PKCS8EncodedKeySpec;

import javax.crypto.Cipher;

import org.apache.commons.codec.binary.Base64;
import java.math.BigInteger;

public class Playground {

    public static void main(String[] args) throws Exception {
        // openssl genrsa -out private.pem 2048
        // openssl rsa -in private.pem -outform PEM -pubout -out public.pem
        // openssl pkcs8 -topk8 -nocrypt -in private.pem -outform DER -out private.der
        // openssl rsa -in private.pem -pubout -outform DER -out public.der

        Key privKey = readPrivateKey();

        byte[] base64Ciphertext = Files.readAllBytes(new File("id-encrypted-base64.txt").toPath());
        byte[] ciphertext = Base64.decodeBase64(base64Ciphertext);

        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-1AndMGF1Padding");
        cipher.init(Cipher.DECRYPT_MODE, privKey);
        byte[] plainText = cipher.doFinal(ciphertext);
        System.out.println(new String(plainText));
        byte[] unencoded = Base64.decodeBase64(plainText);
        System.out.println(new BigInteger(unencoded));
    }

    private static Key readPrivateKey() throws Exception {
        byte[] privKeyBytes = Files.readAllBytes(new File("example.private.der").toPath());
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(privKeyBytes);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        Key privKey = kf.generatePrivate(spec);
        return privKey;
    }
}
