//
//  ViewController.m
//  QiuFeng
//
//  Created by 邱峰 on 4/6/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "UsageViewController.h"

#import "GithubAnalyse.h"
#import "GithubLanguage.h"
#import "GithubEvent.h"
#import "UIColor+ColorArray.h"

#import "PieChart.h"
#import "BarChart.h"
#import "BarEvent.h"

@interface UsageViewController ()<PieChartDataSource,BarChartDataSource,UIAlertViewDelegate>

@property (nonatomic,strong) NSArray* languagesArray;

@property (nonatomic,strong) NSArray* eventsArray;


@property (weak, nonatomic) IBOutlet PieChart *eventsPieChart;
@property (weak, nonatomic) IBOutlet PieChart *languagePieChart;

@property (weak, nonatomic) IBOutlet BarChart *weekBarChart;
@property (weak, nonatomic) IBOutlet BarChart *dayBarchart;

@property (weak, nonatomic) IBOutlet UIButton *nextImage;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIButton *lastImage;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;

@property (weak, nonatomic) IBOutlet UIView *panleView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *nextGesture;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *lastGesture;
@property (weak, nonatomic) IBOutlet UIView *eventPanel;
@property (weak, nonatomic) IBOutlet UIView *schedulePanle;

@property (strong,nonatomic) UIActivityIndicatorView* activity;

@end

@implementation UsageViewController

@synthesize weekBarChart=_weekBarChart;
@synthesize dayBarchart=_dayBarchart;

-(void) handleLanguages:(NSDictionary*)dictionary
{
    NSMutableArray* languages=[[NSMutableArray alloc] init];
    for (NSDictionary* newObjDictionary in dictionary)
    {
        GithubLanguage* newObj=[[GithubLanguage alloc] initWithDictionary:newObjDictionary];
        [languages addObject:newObj];
    }
    self.languagesArray=languages;

}

-(void) handleEvents:(NSDictionary*)dictionary
{
    NSMutableArray* events=[[NSMutableArray alloc] init];
    for (NSDictionary* newObjDictionary in dictionary)
    {
        GithubEvent* newObj=[[GithubEvent alloc] initWithDictionary:newObjDictionary];
        [events addObject:newObj];
    }
    self.eventsArray=events;
}

-(void) registerAllUserInterface
{
    self.nextGesture.enabled=YES;
    self.nextImage.hidden=NO;
    [self shine:self.nextImage];
    
    [self shine:self.lastImage];
}

-(void) setScheduleLabel
{
    float x=20;
    float y=70;
    NSArray* color=[UIColor colorArrayFromGithub];
    for (int i=0; i<self.eventsArray.count; i++)
    {
        GithubEvent* event=self.eventsArray[i];
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 56)];
        label.textColor=color[i];
        label.text=event.eventType;
        label.font=[UIFont systemFontOfSize:17];
        [self.schedulePanle addSubview:label];
        y=y+29;
    }
    [self hideAllLabelInView:self.schedulePanle];
}

-(void) setEventTitle
{
    int x=20;
    int y=70;
    NSArray* color=[UIColor colorArrayFromGithub];
    for (int i=0; i<self.eventsArray.count; i++)
    {
        GithubEvent* event=self.eventsArray[i];
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 25)];
        label.textColor=color[i];
        label.text=event.eventType;
        label.font=[UIFont systemFontOfSize:17];
        label.alpha=0;
        [self.eventPanel addSubview:label];
        y=y+35;

    }
    
    y=300;
    for (int i=0; i<self.languagesArray.count; i++)
    {
        GithubLanguage* language=self.languagesArray[i];
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 25)];
        label.textColor=color[i];
        label.text=language.language;
        label.font=[UIFont systemFontOfSize:17];
        [self.eventPanel addSubview:label];
        y=y+35;
    }
    [self hideAllLabelInView:self.eventPanel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.activity];
    [self.activity startAnimating];
    
    [[GithubAnalyse sharedGithubAnalyse] getDataFromGithub:^(NSDictionary* results,NSError* error)
     {
         [self.activity removeFromSuperview];
         if (error)
         {
             UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"获取信息错误" message:@"获取信息错误 检查网路是否正常,如果一切正常 尽快联系我哦~~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             alertView.delegate=self;
             [alertView show];
         }
         else
         {
             [self handleLanguages:results[@"usage"][@"languages"]];
         
             [self handleEvents:results[@"usage"][@"events"]];
         
             [self setScheduleLabel];
             [self setEventTitle];
         
             self.weekBarChart.isStart=YES;
             [self.weekBarChart setNeedsDisplay];
         
             self.dayBarchart.isStart=YES;
             [self.dayBarchart setNeedsDisplay];
         
             [self registerAllUserInterface];
         }
     }];

	// Do any additional setup after loading the view, typically from a nib.
}


-(UIActivityIndicatorView*) activity
{
    if (_activity==nil)
    {
        _activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    }
    return _activity;
}

-(void) setWeekBarChart:(BarChart *)weekBarChart
{
    if (_weekBarChart!=weekBarChart)
    {
        _weekBarChart=weekBarChart;
        _weekBarChart.delegate=self;
    }
}

-(void) setDayBarchart:(BarChart *)dayBarchart
{
    if (_dayBarchart!=dayBarchart)
    {
        _dayBarchart=dayBarchart;
        _dayBarchart.delegate=self;
    }
}

-(void) setEventsPieChart:(PieChart *)eventsPieChart
{
    if (_eventsPieChart==nil)
    {
        _eventsPieChart=eventsPieChart;
        _eventsPieChart.delegate=self;
    }
}

-(void) setLanguagePieChart:(PieChart *)languagePieChart
{
    if (_languagePieChart!=languagePieChart)
    {
        _languagePieChart=languagePieChart;
        _languagePieChart.delegate=self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - pie chart data source

- (NSArray*) setDataInPieChart:(PieChart *)pieChart
{
    NSMutableArray* data=[[NSMutableArray alloc] init];
    if (pieChart==self.languagePieChart)
    {
        for (GithubLanguage* obj in self.languagesArray)
        {
            [data addObject:@(obj.count)];
        }
    }
    else
    {
        for (GithubEvent* obj in self.eventsArray)
        {
            [data addObject:@(obj.total)];
        }
    }
    return data;
}

-(NSArray*) setColorInPieChart:(PieChart *)pieChart
{
    return [UIColor colorArrayFromGithub];
}

#pragma mark - bar chart data source

-(NSArray*) setDataInBarChart:(BarChart *)barChart
{
    NSMutableArray* result=[[NSMutableArray alloc] init];
    
    if (barChart==self.weekBarChart)
    {
        for (int day=0; day<7; day++)
        {
            BarEvent* barEvent=[[BarEvent alloc] init];
            NSMutableArray* eventTotal=[[NSMutableArray alloc] init];
            NSMutableArray* eventType=[[NSMutableArray alloc] init];
            int total=0;
            for (int k=0; k<self.eventsArray.count; k++)
            {
                GithubEvent* githubEvent=self.eventsArray[k];
                [eventTotal addObject:githubEvent.week[day]];
                total=total+[githubEvent.week[day] intValue];
                [eventType addObject:githubEvent.type];
            }
            barEvent.eventTotal=eventTotal;
            barEvent.total=total;
            barEvent.eventType=eventType;
            [result addObject:barEvent];
        }
    }
    else
    {
        for (int day=0; day<24; day++)
        {
            BarEvent* barEvent=[[BarEvent alloc] init];
            NSMutableArray* eventTotal=[[NSMutableArray alloc] init];
            NSMutableArray* eventType=[[NSMutableArray alloc] init];
            int total=0;
            for (int k=0; k<self.eventsArray.count; k++)
            {
                GithubEvent* githubEvent=self.eventsArray[k];
                [eventTotal addObject:githubEvent.day[(day+2)%24]];
                total=total+[githubEvent.day[(day+2)%24] intValue];
                [eventType addObject:githubEvent.type];
            }
            barEvent.eventTotal=eventTotal;
            barEvent.total=total;
            barEvent.eventType=eventType;
            [result addObject:barEvent];
        }
    }
    
    return result;
}

-(NSArray*) setColorInBarChart:(BarChart *)barChart
{
    return [self setColorInPieChart:nil];
}

-(NSArray*) setFooterLabelInBarChart:(BarChart *)barChar
{
    if (barChar==self.weekBarChart)
    {
        return @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    }
    else
    {
        return @[@"3",@"6",@"9",@"12",@"15",@"6",@"9",@"12"];
    }
}

#pragma mark - animate

-(void) fadeOut:(UIView*)view complete:(void (^)(void) )complete
{
    [UIView animateWithDuration:0.8 animations:^(){
        view.alpha=0;
    }completion:^(BOOL finish){
        if (finish) complete();
    }];
}

-(void) fadeIn:(UIView*)view complete:(void (^)(void) )complete
{
    [UIView animateWithDuration:0.8 animations:^(){
        view.alpha=1;
    }completion:^(BOOL finish){
        if (finish) complete();
    }];
}

-(void) shine:(UIView*)view
{
    [self fadeIn:view complete:^(void){
        [self fadeOut:view complete:^(){
            [self shine:view];
        }];
    }];
}

-(void) drawDoneInPieChart:(PieChart *)pieChart
{
    if (pieChart==self.eventsPieChart)
    {
        [UIView animateWithDuration:1 animations:^(){
            [self showAllLabelInView:self.eventPanel];
        }completion:^(BOOL finish){
            if (finish)
            {
                self.panleView.userInteractionEnabled=YES;
            }
        }];
    }
}

-(void) drawDoneInBarChart:(BarChart *)barChart
{
    if (barChart==self.dayBarchart)
    {
        [UIView animateWithDuration:1 animations:^(){
            [self showAllLabelInView:self.schedulePanle];
        }completion:^(BOOL finish){
            if (finish)
            {
                self.panleView.userInteractionEnabled=YES;
            }
        }];
    }
}

-(void) hideAllLabelInView:(UIView*)view
{
    for (UIView* lable in view.subviews)
    {
        if ([lable isKindOfClass:[UILabel class]])
        {
            lable.alpha=0;
        }
    }
}

-(void) showAllLabelInView:(UIView*)view
{
    for (UIView* lable in view.subviews)
    {
        if ([lable isKindOfClass:[UILabel class]])
        {
            lable.alpha=1;
        }
    }
}

- (IBAction)nextButtonClick:(UIButton *)sender
{
    self.panleView.userInteractionEnabled=NO;
    [UIView animateWithDuration:1 animations:^(){
        self.panleView.frame=CGRectMake(0, -self.view.frame.size.height, self.panleView.frame.size.width, self.panleView.frame.size.height);
    }completion:^(BOOL finish){
        if (finish)
        {
            [self hideAllLabelInView:self.schedulePanle];
            
            [self.weekBarChart clearView];
            [self.dayBarchart clearView];
            
            self.eventsPieChart.isStart=YES;
            [self.eventsPieChart setNeedsDisplay];
            self.languagePieChart.isStart=YES;
            [self.languagePieChart setNeedsDisplay];
            
            self.title=@"Events";
        }
        
    }];
}
- (IBAction)nextGesture:(id)sender
{
    [self nextButtonClick:self.nextButton];
}

- (IBAction)lastButtonClick:(id)sender
{
    self.panleView.userInteractionEnabled=NO;
    [UIView animateWithDuration:1 animations:^(){
        self.panleView.frame=CGRectMake(0, 0, self.panleView.frame.size.width, self.panleView.frame.size.height);
    }completion:^(BOOL finish){
        if (finish)
        {
            [self hideAllLabelInView:self.eventPanel];
            
            [self.languagePieChart clearView];
            [self.eventsPieChart clearView];
            
            self.weekBarChart.isStart=YES;
            [self.weekBarChart setNeedsDisplay];
            self.dayBarchart.isStart=YES;
            [self.dayBarchart setNeedsDisplay];
            
            self.title=@"Schedule";
        }
    }];
}
- (IBAction)lastGesture:(id)sender
{
    [self lastButtonClick:self.lastButton];
}

#pragma mark - alertview delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  //网络错误
{
     [self.navigationController popViewControllerAnimated:YES];
}

@end
