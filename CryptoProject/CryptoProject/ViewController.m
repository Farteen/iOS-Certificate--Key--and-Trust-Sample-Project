//
//  Created by Patrick Hogan on 3/26/13.
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "ViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "BDRSACryptor.h"
#import "BDRSACryptorKeyPair.h"
#import "BDError.h"
#import "BDLog.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ViewController


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
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


@end
