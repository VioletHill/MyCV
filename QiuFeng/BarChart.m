//
//  BarChart.m
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "BarChart.h"
#import "BarEvent.h"

@interface BarChart ()

@property (nonatomic,strong) NSMutableArray* lableArray;

@end

@implementation BarChart
{
    int repeatTime;
    int maxNumber;
    float average;        //每个柱子的宽度
    float maxData;
    float maxHeight;      //最高柱子的高度
    float maxWidth;       //总宽度
}

const int maxRepeatTime=50;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(NSArray*) data
{
    if (_data==nil)
    {
        _data=[self.delegate setDataInBarChart:self];
    }
    return _data;
}

-(NSArray*) color
{
    if (_color==nil)
    {
        _color=[self.delegate setColorInBarChart:self];
    }
    return _color;
}

-(NSArray*) footerLabel
{
    if (_footerLabel==nil)
    {
        _footerLabel=[self.delegate setFooterLabelInBarChart:self];
    }
    return _footerLabel;
}

-(NSMutableArray*) lableArray
{
    if (_lableArray==nil)
    {
        _lableArray=[[NSMutableArray alloc] init];
    }
    return _lableArray;
}

-(void) addLabel
{
    [self clearAllLable];
    float labelWidth=maxWidth/(float)self.footerLabel.count;
    for (int i=0; i<self.footerLabel.count; i++)
    {
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(labelWidth*i, maxHeight, labelWidth, 20)];
        label.font=[UIFont systemFontOfSize:10];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=self.footerLabel[i];
        [self.lableArray addObject:label];
        [self addSubview:label];
    }
}

-(void) clearAllLable
{
    for (UILabel* lable in self.lableArray)
    {
        [lable removeFromSuperview];
    }
    [self.lableArray removeAllObjects];
}

-(void) initData
{
    maxHeight=self.frame.size.height;
    maxWidth=self.frame.size.width;
    average=maxWidth/self.data.count;
    maxData=0;
    for (int i=0; i<self.data.count; i++)
    {
        BarEvent* event=self.data[i];
        maxData=MAX(maxData, event.total);
    }
    [self addLabel];
}


- (void)drawBarChartRect:(CGRect)rect withColor:(UIColor*)color inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    UIGraphicsPopContext();
}

-(void) drawBarChartInContext:(CGContextRef)context
{
    for (int i=0; i<self.data.count; i++)
    {
        BarEvent* barEvent=self.data[i];
        int from=0;
        int to=0;
        for (int j=0; j<barEvent.eventTotal.count; j++)
        {
            to=[barEvent.eventTotal[j] intValue]+to;
            CGRect rect;
            if (to/(float)maxData > repeatTime/(float)maxRepeatTime)
            {
                rect=CGRectMake(average*i+1,maxHeight-repeatTime/(float)maxRepeatTime*maxHeight, average-2, (repeatTime/(float)maxRepeatTime - from/(float)maxData)*maxHeight);
                [self drawBarChartRect:rect withColor:self.color[j] inContext:context];
                break ;
            }
            else
            {
                rect=CGRectMake(average*i+1,maxHeight-(to)/(float)maxData*maxHeight, average-2, (to-from)/(float)maxData*maxHeight);
                [self drawBarChartRect:rect withColor:self.color[j] inContext:context];
            }
            
            from=to;
        }
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (!self.isStart) return;
    
    if (repeatTime==0)
    {
        [self initData];
    }
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    [self drawBarChartInContext:context];
    
    [self performSelector:@selector(redraw) withObject:self afterDelay:0.01];
    // Drawing code
}

-(void) redraw
{
    if (repeatTime<maxRepeatTime)
    {
        repeatTime++;
        [self setNeedsDisplay];
    }
    else
    {
        self.isStart=NO;
        repeatTime = 0;
        if ([self.delegate respondsToSelector:@selector(drawDoneInBarChart:)])
        {
            [self.delegate drawDoneInBarChart:self];
        }
        return ;
    }
}

-(void) clearView
{
    self.isStart=NO;
    [self clearAllLable];
    [self setNeedsDisplay];
    
}

@end
