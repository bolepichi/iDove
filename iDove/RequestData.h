//
//  RequestData.h
//  iDove
//
//  Created by apple on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

typedef void(^RequestBlock)(NSDictionary* dict,NSString *success,NSString* failure);


@interface RequestData : NSObject

//get
+(void)getRequest:(NSDictionary*)dic_patameter WithRequestUrlString:(NSString*)url_string message:(RequestBlock)requestMessage;



//post
+(void)postRequest:(NSDictionary*)dic_patameter WithRequestUrlString:(NSString*)url_string message:(RequestBlock)requestMessage;



//post上传
+(void)postUpdate:(NSDictionary *)dic_patameter WithRequestUrlString:(NSString*)url_string message:(RequestBlock)requestMessage;


@end
