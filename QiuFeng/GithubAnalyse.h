//
//  GithubAnalyse.h
//  QiuFeng
//
//  Created by 邱峰 on 4/6/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GithubAnalyse : AFHTTPSessionManager

+(GithubAnalyse*) sharedGithubAnalyse;

-(NSURLSessionDataTask*) getDataFromGithub:(void (^)(NSDictionary* results,NSError* error))complete;

@end
