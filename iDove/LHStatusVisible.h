//
//  LHStatusVisible.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-21.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>
//0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；
typedef enum {
    VisibleTypeNormal = 0,
    VisibleTypePrivate = 1,
    VisibleTypeAssignedGroup = 3,
    VisibleTypeCloseFriend = 4
} VisibleType;


@interface LHStatusVisible : NSObject<NSCoding>

@property (nonatomic, assign) VisibleType visibleType; //微博的可见性
@property (nonatomic, assign) int groupId; //指定可见分组信息

@end
