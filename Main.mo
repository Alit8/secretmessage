import Text "mo:base/Text";
import Nat32 "mo:base/Nat32";
import Random "mo:base/Random";
import Debug "mo:base/Debug";
import Char "mo:base/Char";



actor SecretMessageGenerator {
  // The secret message type with encryption key
  public type SecretMessage = {
    encryptedText : Text;
    key : Nat32;
  };

  // Basic XOR encryption function
  private func encrypt(message : Text, key : Nat32) : Text {
    Text.map(message, func(char) {
      let charCode = Char.toNat32(char);
      let encryptedChar = Char.fromNat32(charCode ^ key);
      return encryptedChar;
    });
  };

  // Decryption is the same as encryption due to XOR properties
  private func decrypt(encryptedMessage : Text, key : Nat32) : Text {
    encrypt(encryptedMessage, key);
  };

  // Generate a secret message with a randomly generated key
  public func generateSecretMessage(message : Text) : async SecretMessage {
    let seed : Blob = "\14\C9\72\09\03\D4\D5\72\82\95\E5\43\AF\FA\A9\44\49\2F\25\56\13\F3\6E\C7\B0\87\DC\76\08\69\14\CF";
let random = Random.Finite(seed);
let randomKey = switch (random.range(32)) {
      case (null) { 0 : Nat32 };
      case (?key) { Nat32.fromNat(key) };
    };
    let encrypted = encrypt(message, randomKey);
    return {
      encryptedText = encrypted;
      key = randomKey;
    };
  };

  // Encrypt a message with a provided key
  public func encryptMessage(message : Text, secretKey : Nat32) : async SecretMessage {
    let encrypted = encrypt(message, secretKey);
    return {
      encryptedText = encrypted;
      key = secretKey;
    };
  };

  // Decrypt a secret message
  public func decryptMessage(secret : SecretMessage) : async Text {
    return decrypt(secret.encryptedText, secret.key);
  };
}
