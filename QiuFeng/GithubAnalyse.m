//
//  GithubAnalyse.m
//  QiuFeng
//
//  Created by 邱峰 on 4/6/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "GithubAnalyse.h"
#import "AFNetworking.h"

@implementation GithubAnalyse

+(GithubAnalyse*) sharedGithubAnalyse
{
    static GithubAnalyse* sharedGithubAnalyse = nil;
    static dispatch_once_t githubAnalyseToken;
    dispatch_once(&githubAnalyseToken, ^(){
        
        sharedGithubAnalyse=[[GithubAnalyse alloc] init];
 
        sharedGithubAnalyse.responseSerializer=[AFJSONResponseSerializer serializer];
    });
    return sharedGithubAnalyse;
}


-(NSURLSessionDataTask*) getDataFromGithub:(void (^)(NSDictionary* ,NSError*))complete
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSessionDataTask* task=[self GET:@"http://osrc.dfm.io/violethill.json" parameters:nil
                                 success:^(NSURLSessionDataTask* task,id responseObject){
                
                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                     complete(responseObject,nil);
                                 }
                                 failure:^(NSURLSessionDataTask* task,NSError* error){
                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                     complete(nil,error);
                                 }];
    return task;
}

@end
