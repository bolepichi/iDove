//
//  RequestData.m
//  iDove
//
//  Created by apple on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData


+(void)getRequest:(NSDictionary *)dic_patameter WithRequestUrlString:(NSString *)url_string message:(RequestBlock)requestMessage{
    
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    
    [manager GET:url_string parameters:dic_patameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error;
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:&error];
        
        NSDictionary *dic_json = (NSDictionary*)jsonObj;

        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
            
        requestMessage(dic_json,@"success",@"");

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        requestMessage(nil,nil,[error description]);
        
    }];


    
}



+(void)postRequest:(NSDictionary *)dic_patameter WithRequestUrlString:(NSString *)url_string message:(RequestBlock)requestMessage{
    
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    
    [manager POST:url_string parameters:dic_patameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSError *error;
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:&error];
        
        NSDictionary *dic_json = (NSDictionary*)jsonObj;
        
        requestMessage(dic_json,@"success",@"");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        requestMessage(nil,nil,[error description]);
        
        
    }];
    
    
}


+(void)postUpdate:(NSDictionary *)dic_patameter WithRequestUrlString:(NSString *)url_string message:(RequestBlock)requestMessage{
    
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    
    [manager POST:url_string parameters:dic_patameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        
    }];
    
}


@end
