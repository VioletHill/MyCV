//
//  ExperienceClient.m
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "ExperienceClient.h"

@implementation ExperienceClient

#define projectAddress @"http://sseclass.tongji.edu.cn/qiufeng/Experience.php"

//#define projectAddress @"http://10.0.1.35/~violethill/qiufeng/Works.php"

+(ExperienceClient*) sharedExperienceClient
{
    static ExperienceClient* sharedExperienceClient=nil;
    static dispatch_once_t experienceClientToken;
    dispatch_once(&experienceClientToken, ^(){
        sharedExperienceClient=[[ExperienceClient alloc] init];
        
        sharedExperienceClient.responseSerializer=[AFJSONResponseSerializer serializer];
        
    });
    return sharedExperienceClient;
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
