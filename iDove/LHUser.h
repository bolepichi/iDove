//
//  LHUser.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    GenderUnknow = 0,
    GenderMale,
    GenderFemale,
} Gender;

typedef enum {
    OnlineStatusOffline = 0,
    OnlineStatusOnline = 1,
} OnlineStatus;
@interface LHUser : NSObject<NSCoding>

-(id)initWithJsonDictionary:(NSDictionary*)dic;


@property (nonatomic, assign) long long userId;
@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *profileUrl;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *zaku;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *avatarLarge;
@property (nonatomic, copy) NSString *avatarHd;
@property (nonatomic, copy) NSString *verifiedReason;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) int     followersCount;
@property (nonatomic, assign) int     friendsCount;
@property (nonatomic, assign) int     statueseCount;
@property (nonatomic, assign) int     favouritesCount;
@property (nonatomic, assign) int     biFollowersCount;
@property (nonatomic, assign) time_t  created_Time;
@property (nonatomic, assign) BOOL   allowAllActMsg;
@property (nonatomic, assign) BOOL   geoEnabled;
@property (nonatomic, assign) BOOL   verified;
@property (nonatomic, assign) BOOL    followMe;
@property (nonatomic, assign) BOOL    allowAllComment;

@property (nonatomic, assign) OnlineStatus  onlineStatus;



@end
