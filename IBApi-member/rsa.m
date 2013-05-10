//
//  RSA.m
//
#import "RSA.h"
#import "GTMBase64.h"
// 我们在前面使用openssl生成的public_key.der文件的base64值，用你自己的替换掉这里
@implementation sec

-(id)init
{
    self=[super init];
    if (self)
    {
        _public_key=nil;
    }
    return self;
}

//static SecKeyRef _public_key=nil;
-(SecKeyRef) getPublicKey:(NSString *)RSA_KEY_BASE64 { // 从公钥证书文件中获取到公钥的SecKeyRef指针
    if(_public_key == nil){
        NSData *certificateData = [GTMBase64 decodeString:RSA_KEY_BASE64];
        SecCertificateRef myCertificate =  SecCertificateCreateWithData(kCFAllocatorDefault, (CFDataRef)certificateData);
        SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
        SecTrustRef myTrust;
        OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
        SecTrustResultType trustResult;
        if (status == noErr) {
            status = SecTrustEvaluate(myTrust, &trustResult);
        }
        _public_key = SecTrustCopyPublicKey(myTrust);
        CFRelease(myCertificate);
        CFRelease(myPolicy);
        CFRelease(myTrust);
    }
    return _public_key;
}

-(NSString*) rsaEncryptString:(NSString*) string withpublickey:(NSString*)publickey{
    SecKeyRef key = [self getPublicKey:publickey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    NSData *stringBytes = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[[NSMutableData alloc] init] autorelease];
    for (int i=0; i<blockCount; i++) {
        int bufferSize = MIN(blockSize,[stringBytes length] - i * blockSize);
        NSData *buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes],
                                        [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            [encryptedBytes release];
        }else{
            if (cipherBuffer) free(cipherBuffer);
            return nil;
        }
    }
    if (cipherBuffer) free(cipherBuffer);
//          NSLog(@"Encrypted text (%ld bytes): %@", (unsigned long)[encryptedData length], [encryptedData description]);

  //  NSLog(@"Encrypted text base64: %@",[GTMBase64 stringByEncodingData:encryptedData]);
        return [GTMBase64 stringByEncodingData:encryptedData];
}
@end
