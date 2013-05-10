//
//  IBAmtViewController.h
//  IBApi-member-test
//
//  Created by Apple on 13-5-11.
//  Copyright (c) 2013年 thephoenixorg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBAmtViewController : UIViewController
- (IBAction)login;

@property (retain, nonatomic) IBOutlet UITextField *uname;
@property (retain, nonatomic) IBOutlet UITextField *upass;
@property (retain, nonatomic) IBOutlet UITextField *uzhname;
@end
