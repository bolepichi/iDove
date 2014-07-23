//
//  LHPathHelper.m
//  iDove
//
//  Created by Leslie on 14-7-21.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHPathHelper.h"

@implementation LHPathHelper

+(BOOL)createPathIfNecessary:(NSString *)path{
    BOOL succeded = YES;
    
    NSFileManager *fm  =[NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:path]) {
        succeded = [fm createDirectoryAtPath:path
                 withIntermediateDirectories:YES
                                  attributes:nil
                                       error:nil];
    }
    return succeded;
}


+(NSString *)bundlePathWithName:(NSString *)name
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
}




+(NSString*)documentDirectoryPathWithName:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    NSString *cachePath = [cachesPath stringByAppendingPathComponent:name];
    
    [LHPathHelper createPathIfNecessary:cachesPath];
    [LHPathHelper createPathIfNecessary:cachesPath];
    
    return cachePath;
}

+(NSString*)cacheDirectoryPathWithName:(NSString *)name{
    return [self cacheDirectoryPathWithName:name createPathIfNecessary:YES];
}

+(NSString*)cacheDirectoryPathWithName:(NSString *)name createPathIfNecessary:(BOOL)createPathIfNecessary{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * cachesPath = [paths objectAtIndex:0];
    NSString * cachePath = [cachesPath stringByAppendingPathComponent:name];
    
    if (createPathIfNecessary) {
        [LHPathHelper createPathIfNecessary:cachesPath];
        [LHPathHelper createPathIfNecessary:cachePath];
    }
    return cachePath;
}




+ (NSString *)sanitizeFileNameString:(NSString *)fileName {
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [[fileName componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}




@end
