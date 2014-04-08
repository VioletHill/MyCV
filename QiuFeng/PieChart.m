//
//  PieChart.m
//  QiuFeng
//
//  Created by 邱峰 on 4/6/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "PieChart.h"

@interface PieChart ()

@property (nonatomic,strong) NSMutableArray* numberView;

@end

@implementation PieChart
{
    int repeatTime;
    int sum;
    CGPoint midPoint;
    float radius;
}

const int maxRepeatTime=50;

const int fontSize=15;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - getter & setter


-(NSArray*) data
{
    if (_data==nil)
    {
        _data=[self.delegate setDataInPieChart:self];
    }
    return _data;
}

-(NSArray*) color
{
    if (_color==nil)
    {
        _color=[self.delegate setColorInPieChart:self];
    }
    return _color;
}

-(NSMutableArray*) numberView
{
    if (_numberView==nil)
    {
        self.numberView=[[NSMutableArray alloc] init];
    }
    return _numberView;
}

#pragma mark - init data

-(void) initData
{
    midPoint=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    radius=MIN(midPoint.x, midPoint.y);
    sum=0;
    for (int i=0; i<self.data.count; i++)
    {
        sum=sum+[self.data[i] intValue];
    }
}


#pragma mark - draw

-(void) drawCircleAtMiddlePoint:(CGPoint)point withRadius:(float)r from:(float)from to:(float)to inContext:(CGContextRef)context useColor:(UIColor*)color
{
//    NSLog(@"%f %f",from,to);
    from=(from-0.25)*2*M_PI;
    to=(to-0.25)*2*M_PI;
   
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    
    [color set];
    CGContextMoveToPoint(context, point.x, point.y);
    
    CGContextAddArc(context, point.x, point.y, r, from, to, NO);
    
    
    
    CGContextFillPath(context);
    UIGraphicsPopContext();
}

/**
 *  画出repeatTime之前的所有圆
 */

-(void) drawInContext:(CGContextRef)context
{
    int to=0;
    int from=0;
    for (int i=0; i<self.data.count; i++)
    {
        to=[self.data[i] intValue]+to;
        if (to/(float)sum>repeatTime/(float)maxRepeatTime)
        {
            [self drawCircleAtMiddlePoint:midPoint withRadius:radius from:from/(float)sum to:repeatTime/(float)maxRepeatTime inContext:context useColor:self.color[i]];
            break ;
        }
        else
        {
            [self drawCircleAtMiddlePoint:midPoint withRadius:radius from:from/(float)sum to:to/(float)sum inContext:context useColor:self.color[i]];
            from=to;
        }
    }
    
}

-(void) clearNumberView
{
    for (UILabel* label in self.numberView)
    {
        [label removeFromSuperview];
    }
    [self.numberView removeAllObjects];
}

-(void) addNumber
{
    
    [self clearNumberView];
    int to=0;
    int from=0;
    float width=30;
    float height=30;
    for (int i=0; i<self.data.count; i++)
    {
        to=[self.data[i] intValue]+to;
        float mid= (to+from)/2.0;
        float angle=(mid/sum -0.25) * 2 * M_PI;
        

        UILabel* numberLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0, width, height)];
        numberLabel.font=[UIFont systemFontOfSize:fontSize];
        numberLabel.center=CGPointMake(midPoint.x+(radius+width/2)*cos(angle), midPoint.y+(radius+height/2)*sin(angle));
        numberLabel.textColor=self.color[i];
        numberLabel.textAlignment=NSTextAlignmentCenter;
        numberLabel.text=[NSString stringWithFormat:@"%@",self.data[i]];
      //  numberLabel.hidden=YES;
        numberLabel.alpha=0;
        [self addSubview:numberLabel];
        
        [self.numberView addObject:numberLabel];
        
        from=to;
    }
}

-(void) showNumber
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    for (UILabel* label in self.numberView) {
        label.alpha=1;
    }
    
    [UIView commitAnimations];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (!self.isStart) return;
   
    if (repeatTime==0)
    {
        [self initData];
        [self addNumber];
    }
    
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    [self drawInContext:context];
    
    [self performSelector:@selector(redraw) withObject:self afterDelay:0.01];
    
}


-(void) redraw
{
    if (repeatTime<=maxRepeatTime)
    {
        repeatTime++;
        [self setNeedsDisplay];
    }
    else
    {
        [self showNumber];
        self.data=nil;
        self.color=nil;
        self.isStart=NO;
        repeatTime = 0;
        if ([self.delegate respondsToSelector:@selector(drawDoneInPieChart:)])
        {
            [self.delegate drawDoneInPieChart:self];
        }
        return ;
    }
}

-(void) clearView
{
    self.isStart=NO;
    [self clearNumberView];
    [self setNeedsDisplay];
}


@end
