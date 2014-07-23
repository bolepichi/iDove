//
//  LHPathHelper.h
//  iDove
//
//  Created by Leslie on 14-7-21.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHPathHelper : NSObject{
    
}

+ (BOOL)createPathIfNecessary:(NSString*)path;
+ (NSString*)bundlePathWithName:(NSString *)name;
+ (NSString*)documentDirectoryPathWithName:(NSString*)name;

+ (NSString*)cacheDirectoryPathWithName:(NSString*)name;
+ (NSString*)cacheDirectoryPathWithName:(NSString*)name createPathIfNecessary:(BOOL)createPathIfNecessary;


+ (NSString *)sanitizeFileNameString:(NSString *)fileName;
@end
