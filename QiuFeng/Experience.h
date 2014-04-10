//
//  Experience.h
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Experience : NSObject

@property (nonatomic) int year;
@property (nonatomic,strong) NSString* event;

-(instancetype) initWithDictionary:(NSDictionary*)dict;

@end
