//
//  rsa.h
//  x509test
//
//  Created by Apple on 13-5-10.
//  Copyright (c) 2013年 thephoenixorg. All rights reserved.
//

// 我们在前面使用openssl生成的public_key.der文件的base64值，用你自己的替换掉这里
#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface sec:NSObject
{

     SecKeyRef _public_key;
}
- (SecKeyRef) getPublicKey:(NSString *)RSA_KEY_BASE64; // 从公钥证书文件中获取到公钥的SecKeyRef指针

- (NSString*) rsaEncryptString:(NSString*) string withpublickey:(NSString*)publickey;
@end