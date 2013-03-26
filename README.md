Purpose
--------------

This open source repo is designed to provide a convenient wrapper for the inbuilt iOS RSA cryptographic functionality.


Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 6.0 / Mac OS 10.8 (Xcode 4.5, Apple LLVM compiler 4.1)


ARC Compatibility
------------------

This project is written according to ARC conventions.

Installation
---------------

Copy the crypto library into your project or workspace.  You must link the Security.framework to any targets that will be using this library.  Also add the -ObjC and -all_load linker flags to dependent targets.


Examples
---------------

Examples for usage can be found in ViewController.m.

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateKeysExample];
    [self importKeysExample];
}


- (void)generateKeysExample
{
    BDError *error = [[BDError alloc] init];
    BDRSACryptor *RSACryptor = [[BDRSACryptor alloc] init];
    
    BDRSACryptorKeyPair *RSAKeyPair = [RSACryptor generateKeyPairWithKeyIdentifier:@"key_pair_tag"
                                                                             error:error];
    
    BDDebugLog(@"Private Key:\n%@\n\nPublic Key:\n%@", RSAKeyPair.privateKey, RSAKeyPair.publicKey);
    
    [self encryptionCycleWithRSACryptor:RSACryptor
                                keyPair:RSAKeyPair
                                  error:error];
}


- (void)importKeysExample
{
    BDError *error = [[BDError alloc] init];
    BDRSACryptor *RSACryptor = [[BDRSACryptor alloc] init];
    
    NSString *privateKey = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"txt"]
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
    NSString *publicKey = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"txt"]
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    BDRSACryptorKeyPair *RSAKeyPair = [[BDRSACryptorKeyPair alloc] initWithPublicKey:publicKey
                                                                          privateKey:privateKey];
    
    [self encryptionCycleWithRSACryptor:RSACryptor
                                keyPair:RSAKeyPair
                                  error:error];
}


- (void)encryptionCycleWithRSACryptor:(BDRSACryptor *)RSACryptor
                              keyPair:(BDRSACryptorKeyPair *)RSAKeyPair
                                error:(BDError *)error
{
    NSString *cipherText =
    [RSACryptor encrypt:@"Plain Text"
                    key:RSAKeyPair.publicKey
                  error:error];
    
    BDDebugLog(@"Cipher Text:\n%@", cipherText);
    
    NSString *recoveredText =
    [RSACryptor decrypt:cipherText
                    key:RSAKeyPair.privateKey
                  error:error];
    
    BDDebugLog(@"Recovered Text:\n%@", recoveredText);
}
```
