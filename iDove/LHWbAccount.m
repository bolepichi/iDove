//
//  LHWbAccount.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-17.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHWbAccount.h"
#import "LHWbAuthentication.h"
#import "LHUser.h"
@implementation LHWbAccount

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithAuthentication:(LHWbAuthentication *)auth
                        user:(LHUser *)user{
    
    self = [super init];
    if (self) {
        self.accessToken = auth.accessToken;
        self.userId = auth.userId;
        self.expirationDate = auth.expirationDate;
        self.user = user;
    }
    return self;
}

// 写入归档
-(void)writeUserInfoToDocuments{
    
    NSString *fileDir = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"userinfo.arc"];
    
    NSLog(@"%@",fileDir);
    
    [NSKeyedArchiver archiveRootObject:self toFile:fileDir];
    
}

//读取归档
-(void)readUserInfoFromDocuments{
    
    NSString *fileDir =  [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"userinfo.arc"];
    
    LHWbAccount *wbAccount;
        
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:fileDir]) {
        
        wbAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:fileDir];
    }

    
}


-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.accessToken forKey:@"accessToken"];
     [encoder encodeObject:self.expirationDate forKey:@"expirationDate"];
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeBool:self.selected forKey:@"selected"];
    
}
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
        self.expirationDate = [decoder decodeObjectForKey:@"expirationDate"];
        self.user = [decoder decodeObjectForKey:@"user"];
        self.selected = [decoder decodeBoolForKey:@"selected"];
    }
    return self;
}


@end
