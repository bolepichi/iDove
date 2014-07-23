//
//  LHWbAuthentication.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-16.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHWbAuthentication.h"

@implementation LHWbAuthentication


-(id)initWithAuthorizeURL:(NSString *)authorizeURL
           accessTokenURL:(NSString *)accessTokenURL
                   AppKey:(NSString *)appKey
                appSecret:(NSString *)appSecret{
    
    self = [super init];
    
    if (self) {
        self.authorizeURL = authorizeURL;
        self.accessTokenURL = accessTokenURL;
        self.appKey = appKey;
        self.appSecret = appSecret;
        self.redirectURI = @"https://api.weibo.com/oauth2/authorize";
    }
    
    return self;
}



- (NSString *)authorizeRequestUrl{
    
    return [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&redirect_uri=%@&display=mobile", self.authorizeURL,
            [self.appKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
            [self.redirectURI stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}



@end
