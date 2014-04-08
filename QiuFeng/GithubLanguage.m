//
//  GithubLanguage.m
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "GithubLanguage.h"

@implementation GithubLanguage


-(instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    if (self=[super init])
    {
        self.count=[dictionary[@"count"] intValue];
        self.language=dictionary[@"language"];
        self.quantile=[dictionary[@"quantile"] intValue];
    }
    return self;
}

@end
