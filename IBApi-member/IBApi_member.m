//
//  IBApi_member.m
//  IBApi-member
//
//  Created by Apple on 13-5-11.
//  Copyright (c) 2013年 thephoenixorg. All rights reserved.
//

#import "IBApi_member.h"

@implementation IBApi_member
-(id)init
{
    self=[super init];
    if(self)
    {
        //[self registerHTTPOperationClass:[nshttp` class]];
    
        public_key_der_base64=nil;
    }
    return self;
}
+(NSDictionary*) loginwithUsername:(NSString*)username Password:(NSString*)password forapp:(IBApp*)app;
{
    return [self loginwithUsername:username
                          Password:password
                            forurlgetkey:[app urlbuilderwithtable:@"member"
                                                           action:@"getloginkey_ios_der"
                                          ]
                          urllogin:[app urlbuilderwithtable:@"member"
                                                     action:@"login_ios"
                                                      query: @"&info=%@"
                                    ]
            
            ];
}


+(NSDictionary*) loginwithUsername:(NSString*)username Password:(NSString*)password forurlgetkey:(NSString*)url1 urllogin:(NSString*)url2
{
    NSMutableURLRequest *ur=[[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url1]]retain];
    
    NSData *res=[[NSURLConnection sendSynchronousRequest:ur returningResponse:nil error:nil]retain];
    NSString *_response=[[[NSString alloc]initWithData:res encoding:NSUTF8StringEncoding]retain];
    
    NSData *da=[[_response dataUsingEncoding:NSUTF8StringEncoding]retain];
    
    NSArray *data=[[NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil]retain];
    //NSLog(@"res1=%@",[data objectAtIndex:0]);
    
    sec *s=[[[sec alloc]init]retain];
    
    NSString *enstr=[[[s rsaEncryptString:[NSString stringWithFormat:@"%@|%@|%.0f" ,username,password,[[NSDate date]timeIntervalSince1970]] withpublickey:[data objectAtIndex:0]]copy]autorelease];
    enstr=[[enstr stringByReplacingOccurrencesOfString: @"+"withString:@"*"]retain];
    
    //NSLog(@"enstr=%@",enstr);
    ur=[[[NSMutableURLRequest alloc]initWithURL:
         [NSURL URLWithString:
          [NSString stringWithFormat:url2,enstr]
          ]
         ]
        retain
        ];
    res=[[NSURLConnection sendSynchronousRequest:ur returningResponse:nil error:nil]retain];
    _response=[[[NSString alloc]initWithData:res encoding:NSUTF8StringEncoding]retain];
    //NSLog(@"res=%@\n",_response);
    da=[[_response dataUsingEncoding:NSUTF8StringEncoding]retain];
    //printf("s5\n");
    NSDictionary *data2=[[NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil]retain];
    //NSLog(@"res1=%@",[data2 objectForKey:@"username"]);
    return [[data2 copy]autorelease];
}
@end

