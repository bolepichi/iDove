//
//  Resources.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resources : NSObject

+ (NSString *)getProvinceName:(NSString *)provinceId;
+ (NSString *)getCityNameWithProvinceId:(NSString *)provinceId
							 withCityId:(NSString *)cityId;

@end


