//
//  IBApi_member.h
//  IBApi-member
//
//  Created by Apple on 13-5-11.
//  Copyright (c) 2013年 thephoenixorg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "rsa.h"
@interface IBApi_member : NSObject
{
    NSString *public_key_der_base64;
}

+(NSDictionary*) loginwithUsername:(NSString*)username Password:(NSString*)password;
@end
