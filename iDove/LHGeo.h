//
//  LHGeo.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHGeo : NSObject<NSCoding>

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) int city;
@property (nonatomic, assign) int province;
@property (nonatomic, copy) NSString *city_Name;
@property (nonatomic, copy) NSString *province_Name;
@property (nonatomic, copy) NSString *address_Name;

-(id)initWIthJsonDictionary:(NSDictionary*)dic;

@end
