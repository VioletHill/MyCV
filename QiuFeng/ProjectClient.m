//
//  ProjectClient.m
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "ProjectClient.h"

@implementation ProjectClient

#define projectAddress @"http://sseclass.tongji.edu.cn/qiufeng/Works.php"

//#define projectAddress @"http://10.0.1.35/~violethill/qiufeng/Works.php"

+(ProjectClient*) sharedProjectClient
{
    static ProjectClient* sharedProjectClient=nil;
    static dispatch_once_t projectClientToken;
    dispatch_once(&projectClientToken, ^(){
        sharedProjectClient=[[ProjectClient alloc] init];
        
        sharedProjectClient.responseSerializer=[AFJSONResponseSerializer serializer];
        
    });
    return sharedProjectClient;
}

-(NSURLSessionDataTask*) getDataFromServer:(void (^)(NSArray* ,NSError*))complete
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSessionDataTask* task=[self GET:projectAddress parameters:nil success:^(NSURLSessionDataTask* task, id responseObj){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        dispatch_async(dispatch_get_main_queue(), ^(){
   
            NSLog(@"%@",responseObj);
          
            complete(responseObj,nil);
        });
       
    }failure:^(NSURLSessionDataTask* task, NSError* error){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        dispatch_async(dispatch_get_main_queue(), ^(){
            NSLog(@"%@",error);
            complete(nil,error);
        });
    }];
    return task;
}

@end
