//
//  LHStatus.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHGeo.h"
#import "LHUser.h"


@interface LHStatus : NSObject<NSCoding>{
    NSNumber *_statusKey;
    
}

+(LHStatus*)statusWithJsonDictionary:(NSDictionary*)dic;
-(id)initWithJosnDictionary:(NSDictionary*)dic;

@property (nonatomic, assign) time_t created_At;
@property (nonatomic, assign) long long weiboId;
@property (nonatomic, assign) long long weiboMId;
@property (nonatomic, copy)NSString *weiboIDChar;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *source;
@property (nonatomic, copy)NSString *sourceUrl;
@property (nonatomic, assign)BOOL favorited;
@property (nonatomic, assign)BOOL truncated;
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, copy)NSString *thumbnailPic;
@property (nonatomic, strong)LHGeo *geo;
@property (nonatomic, strong)LHUser *user;
@property (nonatomic,strong) LHStatus *retweetedStatus;
@property (nonatomic, assign) int repostsCount;
@property (nonatomic, assign) int commentsCount;
@property (nonatomic, assign) int attitudesCount;

@property (nonatomic, readonly) NSNumber *statusKey;

- (NSString*)statusTimeString;
- (NSString*)statusDateTimeString;

@end
