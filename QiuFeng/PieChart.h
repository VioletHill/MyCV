//
//  PieChart.h
//  QiuFeng
//
//  Created by 邱峰 on 4/6/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieChart;

@protocol PieChartDataSource <NSObject>

@required

-(NSArray*) setDataInPieChart:(PieChart*)pieChart;
-(NSArray*) setColorInPieChart:(PieChart*)pieChart;

@optional

-(void) drawDoneInPieChart:(PieChart*)pieChart;

@end


@interface PieChart : UIView

@property (nonatomic,weak) id<PieChartDataSource> delegate;

@property (nonatomic,strong) NSArray* data;
@property (nonatomic,strong) NSArray* color;

@property (nonatomic) BOOL isStart;

-(void) clearView;

@end
