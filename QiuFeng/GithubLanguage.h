//
//  GithubLanguage.h
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubLanguage : NSObject

/**
 *   the number of contributions  made to repositories mainly written
 */

@property (nonatomic) NSInteger count;

@property (nonatomic,strong) NSString* language;

@property (nonatomic) NSInteger quantile;


/**
 *  根据dictionary创建实例
 *
 *  @param dictionary 关于count language quantitle的dictionary
 *
 *  @return 实例
 */
-(instancetype) initWithDictionary:(NSDictionary*)dictionary;

@end
