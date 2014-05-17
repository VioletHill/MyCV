//
//  BarChart.h
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

//for vinago test

#import <UIKit/UIKit.h>

@class BarChart;

@protocol BarChartDataSource <NSObject>

@required

/**
 *
 *  @return 传递BarEvent类型的数据
 */
-(NSArray*) setDataInBarChart:(BarChart*)barChart;

-(NSArray*) setColorInBarChart:(BarChart*)barChart;

-(NSArray*) setFooterLabelInBarChart:(BarChart*)barChart;

@optional

-(void) drawDoneInBarChart:(BarChart*)barChart;

@end

@interface BarChart : UIView

@property (nonatomic,weak) id<BarChartDataSource> delegate;


@property (nonatomic,strong) NSArray* color;
@property (nonatomic,strong) NSArray* data;
@property (nonatomic,strong) NSArray* footerLabel;

@property (nonatomic) BOOL isStart;

-(void) clearView;

@end
