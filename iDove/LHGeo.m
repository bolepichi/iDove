//
//  LHGeo.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHGeo.h"
#import "NSDictionary+Json.h"
@implementation LHGeo

-(id)initWIthJsonDictionary:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        self.longitude = [[dic objectForKey:@"longitude"] doubleValue];
        self.latitude = [[dic  objectForKey:@"latitude"] doubleValue];
        self.city = [[dic objectForKey:@"city"] intValue];
        self.province = [[dic objectForKey:@"province"] intValue];
        self.city_Name = [dic objectForKey:@"city_name"];
        self.province_Name = [dic objectForKey:@"province_name"];
        self.address_Name = [dic objectForKey:@"address_Name"];
    
    }
    return self;
}



-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.longitude forKey:@"longitude"];
    [encoder encodeDouble:self.latitude  forKey:@"latitude"];
    [encoder encodeInt:self.city forKey:@"city"];
    [encoder encodeInt:self.province forKey:@"province"];
    [encoder encodeObject:self.city_Name forKey:@"city_Name"];
    [encoder encodeObject:self.province_Name forKey:@"province_Name"];
    [encoder encodeObject:self.address_Name forKey:@"address_Name"];
    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.latitude = [decoder decodeDoubleForKey:@"latitude"];
        self.longitude = [decoder decodeDoubleForKey:@"longitude"];
        self.city = [decoder decodeDoubleForKey:@"city"];
        self.province = [decoder decodeDoubleForKey:@"province"];
        self.city_Name = [decoder decodeObjectForKey:@"city_Name"];
        self.province_Name = [decoder decodeObjectForKey:@"province_Name"];
        self.address_Name = [decoder decodeObjectForKey:@"address_Name"];
    }
    return  self;
}
@end
