//
//  IBAmtViewController.m
//  IBApi-member-test
//
//  Created by Apple on 13-5-11.
//  Copyright (c) 2013年 thephoenixorg. All rights reserved.
//

#import "IBAmtViewController.h"
#import "IBApi_member.h"

@interface IBAmtViewController ()

@end

@implementation IBAmtViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login {
    _uzhname.text=[IBApi_member loginwithUsername:_uname.text Password:_upass.text];
   
}
- (void)dealloc {
    [_uname release];
    [_upass release];
    [_uzhname release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUname:nil];
    [self setUpass:nil];
    [self setUzhname:nil];
    [super viewDidUnload];
}
@end