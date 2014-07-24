//
//  THViewController.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-23.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THViewController.h"
#import "WeiboSDK.h"

@interface THViewController ()

@end

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100,100,80,40);
    button.backgroundColor = [UIColor blueColor];
    button.tag = 1;
    [button setTitle:@"login" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

-(void)loginButton:(UIButton *)sender
{
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"THViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
