//
//  LHWbAuthentication.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-16.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHWbAuthentication : NSObject

-(id)initWithAuthorizeID:(NSString *)authorizeID
             accessToken:(NSString *)accessToken
          expirationDate:(NSDate *)expirationDate
                  AppKey:(NSString *)appKey
               appSecret:(NSString *)appSecret;


@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *redirectURI;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, retain) NSDate *expirationDate;


- (NSString *)authorizeRequestUrl;

@end
