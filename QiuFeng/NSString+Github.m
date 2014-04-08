//
//  NSString+Github.m
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "NSString+Github.h"

@implementation NSString (Github)

+(NSString*)githubTypeWithString:(NSString *)type
{
    if ([type isEqualToString:@"PushEvent"]) return @"pushes";
    else if ([type isEqualToString:@"CreateEvent"]) return @"repos or branches";
    else if ([type isEqualToString:@"MemberEvent"]) return @"collaborations";
    else if ([type isEqualToString:@"IssuesEvent"]) return @"issues";
    else if ([type isEqualToString:@"WatchEvent"]) return @"watching";
    else return type;
}

@end
