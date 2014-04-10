//
//  Experience.m
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "Experience.h"

@implementation Experience

-(instancetype) initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        self.year=[dict[@"time"] intValue];
        self.event=dict[@"event"];
    }
    return self;
}

@end
