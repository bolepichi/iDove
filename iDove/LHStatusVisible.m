//
//  LHStatusVisible.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-21.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHStatusVisible.h"
#import "NSDictionary+Json.h"

@implementation LHStatusVisible

- (id)initWithJsonDictionary:(NSDictionary*)dic
{
	self = [super init];
    if (self) {
        self.visibleType = [dic intValueForKey:@"type"];
        self.groupId = [dic intValueForKey:@"list_id"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self.visibleType forKey:@"visibleType"];
    [encoder encodeInt:self.groupId forKey:@"groupId"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.visibleType = [decoder decodeIntForKey:@"visibleType"];
        self.groupId = [decoder decodeIntForKey:@"groupId"];
    }
    return self;
}


@end
