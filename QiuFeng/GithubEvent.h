//
//  GithubEvent.h
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubEvent : NSObject

/**
 *  一天24个小时的事件数量 一共24个
 */
@property (nonatomic,strong) NSArray* day;

/**
 *  总共数量
 */
@property (nonatomic) int total;


/**
 *  类型 PushEvent Commit。。。
 */
@property (nonatomic,strong) NSString* type;

/**
 *  在图表中显示的字
 */
@property (nonatomic,strong) NSString* eventType;

/**
 *  一周每天的事件数量 一共7个
 */
@property (nonatomic,strong) NSArray* week;


-(instancetype) initWithDictionary:(NSDictionary*)dictionary;

@end
