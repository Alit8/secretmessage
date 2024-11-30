Certainly! Here's a **README** file for the `SecretMessageGenerator` actor:

---

# SecretMessageGenerator README

## Overview

The `SecretMessageGenerator` actor is a simple library for generating, encrypting, and decrypting secret messages using a basic XOR encryption scheme. It allows you to:
- Encrypt messages using a randomly generated key.
- Encrypt messages using a provided secret key.
- Decrypt encrypted messages back to their original form.

This actor leverages Motoko's `Text`, `Nat32`, `Random`, and `Char` libraries to perform the encryption and decryption processes. The XOR encryption algorithm is symmetric, meaning the same function is used for both encryption and decryption.

## Features

- **Generate Secret Message**: Create a secret message with a randomly generated encryption key.
- **Encrypt Message**: Encrypt a message using a provided key.
- **Decrypt Message**: Decrypt a previously encrypted message using the associated key.

## Prerequisites

This actor depends on the following Motoko base libraries:
- `mo:base/Text`: For working with text strings.
- `mo:base/Nat32`: For handling 32-bit unsigned integers.
- `mo:base/Random`: For generating random values, which are used for key generation.
- `mo:base/Char`: For converting characters to their ASCII values (and vice versa).

## Functions

### 1. `generateSecretMessage(message : Text) : async SecretMessage`
Generates a secret message by encrypting the provided `message` with a randomly generated encryption key.

#### Parameters:
- `message`: The message to encrypt (of type `Text`).

#### Returns:
- A `SecretMessage` containing:
  - `encryptedText`: The encrypted message (of type `Text`).
  - `key`: The randomly generated encryption key (of type `Nat32`).

#### Example:
```motoko
let secretMessage = await SecretMessageGenerator.generateSecretMessage("Hello, world!");
Debug.print(debug_show(secretMessage)); // { encryptedText = "encrypted text"; key = 12345678 }
```

### 2. `encryptMessage(message : Text, secretKey : Nat32) : async SecretMessage`
Encrypts the provided `message` using the specified `secretKey`.

#### Parameters:
- `message`: The message to encrypt (of type `Text`).
- `secretKey`: The encryption key (of type `Nat32`).

#### Returns:
- A `SecretMessage` containing:
  - `encryptedText`: The encrypted message (of type `Text`).
  - `key`: The encryption key used (of type `Nat32`).

#### Example:
```motoko
let secretMessage = await SecretMessageGenerator.encryptMessage("Hello, world!", 12345678);
Debug.print(debug_show(secretMessage)); // { encryptedText = "encrypted text"; key = 12345678 }
```

### 3. `decryptMessage(secret : SecretMessage) : async Text`
Decrypts an encrypted message using the associated key stored in the `SecretMessage`.

#### Parameters:
- `secret`: A `SecretMessage` containing the `encryptedText` and the `key` used to encrypt it.

#### Returns:
- The decrypted message (of type `Text`).

#### Example:
```motoko
let decryptedMessage = await SecretMessageGenerator.decryptMessage(secretMessage);
Debug.print(decryptedMessage); // "Hello, world!"
```

### 4. Internal `encrypt` function
The `encrypt` function performs XOR encryption on a given `message` using a provided `key`.

#### Parameters:
- `message`: The message to encrypt (of type `Text`).
- `key`: The encryption key (of type `Nat32`).

#### Returns:
- The encrypted message (of type `Text`).

### 5. Internal `decrypt` function
The `decrypt` function uses the same XOR logic as `encrypt`, as XOR encryption is symmetric.

#### Parameters:
- `encryptedMessage`: The encrypted message to decrypt (of type `Text`).
- `key`: The encryption key (of type `Nat32`).

#### Returns:
- The decrypted message (of type `Text`).

---

## How It Works

### XOR Encryption
The encryption method used is **XOR (Exclusive OR)**, a simple symmetric encryption algorithm where each character in the message is XORed with a key. The same function can be used for both encryption and decryption due to the properties of XOR:
- `(A ^ B) ^ B = A`, meaning applying XOR twice with the same key returns the original message.

The `encrypt` function iterates through each character in the message, converts it to its ASCII code (`Nat32`), applies XOR with the encryption key, and then converts it back to a character. This process creates the encrypted message.

### Random Key Generation
When generating a secret message, a random key is generated using a random number generator seeded with a hardcoded value. This key is used for the XOR operation during encryption.

---

## Example Workflow

1. **Generate Secret Message with Random Key**:
   - Call `generateSecretMessage("Hello, world!")` to get a secret message with an encrypted text and a random key.

2. **Encrypt Message with Provided Key**:
   - Call `encryptMessage("Hello, world!", 12345678)` to encrypt the message using a predefined key.

3. **Decrypt the Message**:
   - Call `decryptMessage(secretMessage)` to decrypt the encrypted message using the key embedded in the `secretMessage`.

---

## Usage Example

```motoko
actor Main {
  public async func run() {
    // Generate a secret message
    let secretMessage = await SecretMessageGenerator.generateSecretMessage("Hello, world!");
    Debug.print(debug_show(secretMessage));  // prints encrypted message and key

    // Decrypt the message
    let decryptedMessage = await SecretMessageGenerator.decryptMessage(secretMessage);
    Debug.print(decryptedMessage);  // prints "Hello, world!"
  };
};
```

---

## Notes

- XOR encryption is a simple technique but should not be used for real-world security purposes, as it's vulnerable to various attacks.
- The `Random` module's `Finite` function is used here with a fixed seed for generating a random key, but in a real application, it’s important to use a secure random number generator.
- The `Text.map` function is used to apply the XOR operation to each character in the message.

---

