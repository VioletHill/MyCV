//
//  UIColor+ColorArray.h
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorArray)



+(NSArray*) colorArrayFromGithub;

/**
 *  根据一个16进制的数字 返回对应的颜色
 *
 *  @param number like  0x ff7f0e
 *  @param alpha  透明度
 *
 *  @return uicolor
 */
+(UIColor*) colorWith16Number:(int)number andAlpha:(float)alpha;

/**
 *  根据一个16进制的数字 返回对应的颜色 默认返回透明度为1
 *
 *  @param number number like  0x ff7f0e
 *
 *  @return uicolor
 */
+(UIColor*) colorWith16Number:(int)number;

@end
