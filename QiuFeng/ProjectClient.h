//
//  ProjectClient.h
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ProjectClient : AFHTTPSessionManager

+(ProjectClient*) sharedProjectClient;

-(NSURLSessionDataTask*) getDataFromServer:(void (^)(NSArray* ,NSError*))complete;

@end
