//
//  LHWbAuthentication.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-16.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHWbAuthentication.h"

@implementation LHWbAuthentication


-(id)initWithAuthorizeID:(NSString *)authorizeID
           accessToken:(NSString *)accessToken
          expirationDate:(NSDate *)expirationDate
                  AppKey:(NSString *)appKey
               appSecret:(NSString *)appSecret{
    
    self = [super init];
    
    if (self) {
        self.userId = authorizeID;
        self.accessToken = accessToken;
        self.appKey = appKey;
        self.appSecret = appSecret;
        self.expirationDate = expirationDate;
        self.redirectURI = @"https://api.weibo.com/oauth2/authorize";
    }
    
    return self;
}



- (NSString *)authorizeRequestUrl{
    
    return [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&redirect_uri=%@&display=mobile", self.userId,
            [self.appKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
            [self.redirectURI stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}



@end
