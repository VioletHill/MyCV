//
//  GithubEvent.m
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "GithubEvent.h"
#import "NSString+Github.h"

@implementation GithubEvent

-(instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    if (self=[super init])
    {
        self.day=dictionary[@"day"];
        self.total=[dictionary[@"total"] intValue];
        self.type=dictionary[@"type"];
        self.eventType=[NSString githubTypeWithString:self.type];
        self.week=dictionary[@"week"];
    }
    return self;
}

@end
