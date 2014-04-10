//
//  Project.h
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

/**
 *  project id
 */
@property (nonatomic) int projectID;

/**
 *  project name
 */
@property (nonatomic,strong) NSString* name;

/**
 *  project icon address
 */
@property (nonatomic,strong) NSString* iconAddress;

/**
 *  project description
 */
@property (nonatomic,strong) NSString* description;

/**
 *  itunesLink  
 *  如果没有上架 返回nil
 */
@property (nonatomic,strong) NSString* itunesLink;

/**
 *  状态 相当于hint
 */
@property (nonatomic,strong) NSString* state;

-(instancetype) initWithDictionary:(NSDictionary*)dictionary;

@end
