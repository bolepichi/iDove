//
//  LHUser.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHUser.h"
#import "NSDictionary+Json.h"
#import "Resources.h"
@implementation LHUser


-(id)initWithJsonDictionary:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        
        self.userId = [dic longLongValueForKey:@"id"];
        self.screenName = [dic stringValueForKey:@"screen_name"];
        self.name = [dic stringValueForKey:@"name"];
        self.location =[dic stringValueForKey:@"location"];
        self.url = [dic stringValueForKey:@"url"];
        self.profileImageUrl = [dic stringValueForKey:@"profile_image_url"];
        self.profileUrl = [dic stringValueForKey:@"profile_url"];
        self.domain = [dic stringValueForKey:@"domain"];
        self.zaku = [dic stringValueForKey:@"zaku"];
        self.remark = [dic stringValueForKey:@"remark"];
        self.lang = [dic stringValueForKey:@"lang"];
        self.avatarLarge = [dic stringValueForKey:@"avatar_large"];
        self.avatarHd = [dic stringValueForKey:@"avatar_hd"];
        self.verifiedReason = [dic stringValueForKey:@"verified_reason"];
        NSString *provinceID = [dic stringValueForKey:@"province"];
        NSString *cityID = [dic stringValueForKey:@"city"];
        self.province = [Resources getProvinceName:provinceID];
        self.city = [Resources getCityNameWithProvinceId:provinceID withCityId:cityID];
        
        NSString *genderChar = [dic stringValueForKey:@"gender"];
        if ([genderChar isEqualToString:@"m"]) {
            self.gender = GenderMale;
        }
        else if ([genderChar isEqualToString:@"f"]){
            self.gender = GenderFemale;
        }
        else
        {
            self.gender = GenderUnknow;
        }
        
        
        self.followersCount = [dic intValueForKey:@"followers_count"];
        self.friendsCount = [dic intValueForKey:@"friends_count"];
        self.statueseCount = [dic intValueForKey:@"statuses_count"];
        self.favouritesCount = [dic intValueForKey:@"favourites_count"];
        self.biFollowersCount = [dic intValueForKey:@"bi_followers_count"];
        self.created_Time = [dic timeValueForKey:@"created_at"];
        

        self.allowAllActMsg = [dic boolValueForKey:@"allow_all_act_msg"];
        self.geoEnabled = [dic boolValueForKey:@"geo_enabled"];
        self.verified = [dic boolValueForKey:@"verified"];
        self.followMe = [dic boolValueForKey:@"follow_me"];
        self.allowAllComment = [dic boolValueForKey:@"allow_all_comment"];
        
        
    }
    return self;
}




-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        [self setUserId:[[decoder decodeObjectForKey:@"userId"] longLongValue]];
        self.screenName = [decoder decodeObjectForKey:@"screenName"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.province = [decoder decodeObjectForKey:@"province"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.profileImageUrl = [decoder decodeObjectForKey:@"profileImageUrl"];
        self.profileUrl = [decoder decodeObjectForKey:@"profileUrl"];
        self.domain = [decoder decodeObjectForKey:@"domain"];
        self.verifiedReason = [decoder decodeObjectForKey:@"verifiedReason"];
        
        self.gender = [decoder decodeIntForKey:@"gender"];
        self.followersCount = [decoder decodeIntForKey:@"followersCount"];
        self.friendsCount = [decoder decodeIntForKey:@"friendsCount"];
        self.statueseCount = [decoder decodeIntForKey:@"statueseCount"];
        self.favouritesCount = [decoder decodeIntForKey:@"favouritesCount"];
        self.biFollowersCount = [decoder decodeIntForKey:@"biFollowersCount"];
        self.created_Time = [decoder decodeIntForKey:@"created_Time"];
        self.onlineStatus = [decoder decodeIntForKey:@"onlineStatus"];
        
        
        self.allowAllActMsg = [decoder decodeBoolForKey:@"allowAllActMsg"];
        self.geoEnabled = [decoder decodeBoolForKey:@"geoEnabled"];
        self.verified = [decoder decodeBoolForKey:@"verified"];
        self.allowAllComment = [decoder decodeBoolForKey:@"allowAllComment"];
        
    }
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
   

    [encoder encodeObject:[NSNumber numberWithLongLong:self.userId] forKey:@"userId"];
    [encoder encodeObject:self.screenName forKey:@"screenName"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.profileImageUrl forKey:@"profileImageUrl"];
    [encoder encodeObject:self.profileUrl forKey:@"profileUrl"];
    [encoder encodeObject:self.domain forKey:@"domain"];
    [encoder encodeObject:self.zaku forKey:@"zaku"];
    [encoder encodeObject:self.remark forKey:@"remark"];
    [encoder encodeObject:self.lang forKey:@"lang"];
    [encoder encodeObject:self.avatarLarge forKey:@"avatarLarge"];
    [encoder encodeObject:self.avatarHd forKey:@"avatarHd"];
    [encoder encodeObject:self.verifiedReason forKey:@"verifiedReason"];
    [encoder encodeObject:self.province forKey:@"province"];
    [encoder encodeObject:self.city forKey:@"city"];
    
    [encoder encodeInt:self.gender forKey:@"gender"];
    [encoder encodeInt:self.followersCount forKey:@"followersCount"];
    [encoder encodeInt:self.friendsCount forKey:@"friendsCount"];
    [encoder encodeInt:self.statueseCount forKey:@"statueseCount"];
    [encoder encodeInt:self.favouritesCount forKey:@"favouritesCount"];
    [encoder encodeInt:self.biFollowersCount forKey:@"biFollowersCount"];
    [encoder encodeInt:self.onlineStatus forKey:@"onlineStatus"];
    [encoder encodeInt:self.created_Time forKey:@"created_Time"];
    [encoder encodeBool:self.allowAllActMsg forKey:@"allowAllActMsg"];
    [encoder encodeBool:self.geoEnabled forKey:@"geoEnabled"];
    [encoder encodeBool:self.verified forKey:@"verified"];
    [encoder encodeBool:self.followMe forKey:@"followMe"];
    [encoder encodeBool:self.allowAllComment forKey:@"allowAllComment"];
    

}



@end
