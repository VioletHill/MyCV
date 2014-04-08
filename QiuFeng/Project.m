//
//  Project.m
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "Project.h"

@implementation Project

-(instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    if (self=[super init])
    {
        self.projectID=[dictionary[@"projectID"] intValue];
        self.name=dictionary[@"name"];
        self.iconAddress=dictionary[@"iconAddress"];
        self.itunesLink=dictionary[@"itunesLink"];
        self.description=dictionary[@"description"];
    }
    return self;
}

@end
