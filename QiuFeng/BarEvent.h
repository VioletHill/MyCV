//
//  BarEvent.h
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  BarEvent 传递 barChart中一个柱条的属性
 */
@interface BarEvent : NSObject

/**
 *  一个array  每个事件的数量 没有会传递0进去
 */
@property (nonatomic,strong) NSArray* eventTotal;

/**
 *  eventTotal 中每个值对应的事件名称
 */
@property (nonatomic,strong) NSArray* eventType;


/**
 *  这个值=eventTotal中每个数字相加
 */
@property (nonatomic) int total;

@end
