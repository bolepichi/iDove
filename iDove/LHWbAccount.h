//
//  LHWbAccount.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHWbAuthentication.h"
#import "LHUser.h"
@interface LHWbAccount : NSObject<NSCoding>

@property(nonatomic, copy) NSString *userId; //用户Id
@property(nonatomic, copy) NSString *accessToken; //授权凭证
@property(nonatomic, strong) NSDate *expirationDate; //过期时间
@property(nonatomic, strong) LHUser *user;
@property(nonatomic, assign) BOOL selected;    //是否选中（当前用户）

- (id)initWithAuthentication:(LHWbAuthentication *)auth
                        user:(LHUser *)user;

@end
