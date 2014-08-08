//
//  LHStatus.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHStatus.h"
#import "NSDictionary+Json.h"

@implementation LHStatus

+(LHStatus*)statusWithJsonDictionary:(NSDictionary *)dic{
    return [[LHStatus alloc] initWithJosnDictionary:dic];
}

-(id)initWithJosnDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.created_At = [dic timeValueForKey:@"created_at"];
        self.weiboId = [dic longLongValueForKey:@"id"];
        self.weiboMId = [dic longLongValueForKey:@"mid"];
        self.weiboIDChar = [dic stringValueForKey:@"idstr"];
        self.text = [dic stringValueForKey:@"text"];
        self.source = [dic stringValueForKey:@"source"];
        self.favorited = [dic boolValueForKey:@"favorited"];
        self.truncated = [dic boolValueForKey:@"truncated"];
        self.repostsCount = [dic intValueForKey:@"reposts_count"];
        self.commentsCount = [dic intValueForKey:@"comments_count"];
        self.attitudesCount = [dic intValueForKey:@"attitudes_count"];
        self.images = [dic arrayValueForKey:@"pic_urls"];
        
        NSDictionary *geoDic = [dic dictionaryValueForKey:@"geo"];
        if (geoDic) {
            self.geo = [[LHGeo alloc]  initWIthJsonDictionary:geoDic];
        }
        else
        {
            self.geo = nil;
        }
        
        NSDictionary *userDic = [dic dictionaryValueForKey:@"user"];
        if (userDic) {
            self.user = [[LHUser alloc] initWithJsonDictionary:userDic];
        }
        else{
            self.user = nil;
        }
        
        NSDictionary *retweetedStatuseDic = [dic dictionaryValueForKey:@"retweeted_status"];
        if (retweetedStatuseDic) {
            self.retweetedStatus = [LHStatus statusWithJsonDictionary:retweetedStatuseDic];
        }
        else{
            self.retweetedStatus = nil;
        }
        
        
        // parse source parameter
        NSString *source, *sourceUrl;
		NSString *src = [dic stringValueForKey:@"source"];
	
        NSRange r = [src rangeOfString:@"<a href"];
        NSRange end;
        if (r.location != NSNotFound) {

            NSRange start = [src rangeOfString:@"<a href=\""];
            
            if (start.location != NSNotFound) {
                
                NSInteger l = [src length];
                
                NSRange fromRange = NSMakeRange(start.location+start.length, l-start.length-start.location);
                
                end = [src rangeOfString:@"\"" options:NSCaseInsensitiveSearch
                                   range:fromRange];
                if (end.location != NSNotFound) {
                    r.location = start.location +start.length;
                    r.length = end.location -r.location;
                    sourceUrl = [src substringWithRange:r];
                }
                else{
                    sourceUrl = @"";
                }
                
            }
            else{
                sourceUrl =@"";
            }
            start = [src rangeOfString:@"\">"];
            end  = [src rangeOfString:@"</a>"];
            if (start.location != NSNotFound && end.location != NSNotFound) {
                r.location = start.location + start.length;
                r.length = end.location - r.location;
                source = [src substringWithRange:r];
            }
            else {
                source = @"";
            }
        }
        else{
            source = src;
        }

        self.source =source;
        self.sourceUrl =sourceUrl;
    
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeInt:self.created_At forKey:@"created_At"];
    [encoder encodeObject:[NSNumber numberWithLongLong:self.weiboId] forKey:@"weiboId"];
    [encoder encodeObject:[NSNumber numberWithLongLong:self.weiboMId] forKey:@"weiboMId"];
    [encoder encodeObject:self.weiboIDChar forKey:@"weiboIDChar"];
    [encoder encodeObject:self.text forKey:@"text"];
    [encoder encodeObject:self.source forKey:@"source"];
    [encoder encodeObject:self.sourceUrl forKey:@"sourceUrl"];
    [encoder encodeBool:self.favorited forKey:@"favorited"];
    [encoder encodeBool:self.truncated forKey:@"truncated"];
    [encoder encodeObject:self.images forKey:@"images"];
    [encoder encodeObject:self.thumbnailPic forKey:@"thumbnailPic"];
    [encoder encodeInt:self.repostsCount forKey:@"repostsCounent"];
    [encoder encodeInt:self.commentsCount forKey:@"commentsCount"];
    [encoder encodeInt:self.attitudesCount forKey:@"attitudesCount"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
    
        self.created_At = [decoder decodeIntForKey:@"created_At"];
        self.weiboId = [[decoder decodeObjectForKey:@"weiboId"] longLongValue];
        self.weiboMId = [[decoder decodeObjectForKey:@"weiboMId"] longLongValue];
        self.weiboIDChar = [decoder decodeObjectForKey:@"weiboIDChar"];
        self.text = [decoder decodeObjectForKey:@"text"];
        self.source = [decoder decodeObjectForKey:@"source"];
        self.sourceUrl = [decoder decodeObjectForKey:@"sourceUrl"];
        self.favorited = [decoder decodeBoolForKey:@"favorited"];
        self.truncated = [decoder decodeBoolForKey:@"truncated"];
        self.images = [decoder decodeObjectForKey:@"images"];
        self.thumbnailPic = [decoder decodeObjectForKey:@"thumbnailPic"];
        self.repostsCount = [decoder decodeIntForKey:@"repostsCounent"];
        self.commentsCount = [decoder decodeIntForKey:@"commentsCount"];
        self.attitudesCount = [decoder decodeIntForKey:@"attitudesCount"];
        
    }
    return self;
}

- (NSNumber *)statusKey {
    if (!_statusKey) {
        _statusKey = [[NSNumber alloc]initWithLongLong:self.weiboId];
    }
    return _statusKey;
}

- (NSString*)timestamp:(time_t)t
{
	NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, t);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @" second ago" : @" seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @" minute ago" : @" minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @" hour ago" : @" hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @" day ago" : @" days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @" week ago" : @" weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
}




- (NSString*)statusTimeString{
    return  [self timestamp:_created_At];
}
- (NSString*)statusDateTimeString{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_created_At];
    
    return [dateFormatter stringFromDate:date];
}




@end
