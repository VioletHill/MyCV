//
//  UIColor+ColorArray.m
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "UIColor+ColorArray.h"

@implementation UIColor (ColorArray)


+(UIColor*) colorWith16Number:(int)number andAlpha:(float)alpha
{
    int ff=(1<<8)-1;
    int r=(number >> 16) & ff;
    int g=(number >> 8) & ff;
    int b=number & ff;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

+(UIColor*) colorWith16Number:(int)number
{
    return [UIColor colorWith16Number:number andAlpha:1.0];
}

+(NSArray*) colorArrayFromGithub
{
    NSMutableArray* result=[[NSMutableArray alloc] init];
    NSArray* color=@[@(0x1f77b4),@(0xff7f0e),@(0x2ca02c),@(0xd62728),@(0x9467bd)];
    
    for (int i=0; i<color.count; i++)
    {
        [result addObject:[UIColor colorWith16Number:[color[i] intValue] andAlpha:0.8] ];
    }
    return result;
}

@end
