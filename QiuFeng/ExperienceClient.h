//
//  ExperienceClient.h
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ExperienceClient : AFHTTPSessionManager

+(ExperienceClient*) sharedExperienceClient;

-(NSURLSessionDataTask*) getDataFromServer:(void (^)(NSArray* ,NSError*))complete;

@end
