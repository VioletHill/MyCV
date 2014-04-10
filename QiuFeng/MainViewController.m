//
//  MainViewController.m
//  QiuFeng
//
//  Created by 邱峰 on 4/7/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *project;
@property (weak, nonatomic) IBOutlet UIButton *usage;
@property (weak, nonatomic) IBOutlet UIButton *aboutMe;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) bezierPathAnimationInView:(UIButton*)view toPoint:(CGPoint)toPoint withControlPoint1:(CGPoint)point1 point2:(CGPoint)point2 andTime:(float)time
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:view.center];    //一定要设置 不然底层的CGPath找不到起始点，将会崩溃
    [path addCurveToPoint:toPoint controlPoint1:point1 controlPoint2:point2];    //以左下角和右上角为控制点
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:animation forKey:nil];
}

-(void)dismiss:(void(^)())complete
{
    CGPoint projectEndPoint=CGPointMake(self.project.frame.size.width/2, self.view.frame.size.height+self.project.frame.size.height/2);
    [self bezierPathAnimationInView:self.project toPoint:projectEndPoint withControlPoint1:CGPointMake(0, 340) point2:CGPointMake(0, self.view.frame.size.height) andTime:0.5];

    CGPoint usageEndPoint=CGPointMake(320-self.usage.frame.size.height/2, self.view.frame.size.height+self.usage.frame.size.height/2);
    [self bezierPathAnimationInView:self.usage toPoint:usageEndPoint withControlPoint1:CGPointMake(320, 320) point2:CGPointMake(340, self.view.frame.size.height) andTime:0.5];
    CGPoint aboutMeEndPoint=CGPointMake(self.view.frame.size.width/2, -self.aboutMe.frame.size.height/2);

    [self bezierPathAnimationInView:self.aboutMe toPoint:aboutMeEndPoint withControlPoint1:aboutMeEndPoint point2:aboutMeEndPoint andTime:0.5];
    
    [UIView animateWithDuration:0.7 animations:^(){
        self.aboutMe.center=CGPointMake(self.view.frame.size.width/2, -self.aboutMe.frame.size.height/2);
    }completion:^(BOOL finish){
        self.project.center=CGPointMake(self.project.frame.size.width/2, self.view.frame.size.height+self.project.frame.size.height/2);
        self.usage.center=CGPointMake(320-self.usage.frame.size.height/2, self.view.frame.size.height+self.usage.frame.size.height/2);
        if (finish){
           complete();
        }
    }];
}



-(void) viewDidAppear:(BOOL)animated
{
    self.aboutMe.userInteractionEnabled=NO;
    self.project.userInteractionEnabled=NO;
    self.usage.userInteractionEnabled=NO;

    
    self.project.center=CGPointMake(self.project.frame.size.width/2, self.view.frame.size.height+self.project.frame.size.height/2);
    self.usage.center=CGPointMake(320-self.usage.frame.size.height/2, self.view.frame.size.height+self.usage.frame.size.height/2);
    self.aboutMe.center=CGPointMake(self.view.frame.size.width/2, -self.aboutMe.frame.size.height/2);
    
    [self bezierPathAnimationInView:self.project toPoint:CGPointMake(80, 340) withControlPoint1:CGPointMake(0, self.view.frame.size.height) point2:CGPointMake(0, 320) andTime:1];
   [self bezierPathAnimationInView:self.usage toPoint:CGPointMake(240, 340) withControlPoint1:CGPointMake(340, self.view.frame.size.height) point2:CGPointMake(320, 320) andTime:1];
    
    [self bezierPathAnimationInView:self.aboutMe toPoint:CGPointMake(160, 198) withControlPoint1:CGPointMake(160, 198) point2:CGPointMake(160, 198) andTime:1];
    
    [UIView animateWithDuration:1 animations:^(){
        self.aboutMe.center=CGPointMake(160, 198);
    }completion:^(BOOL finish){
        self.project.center=CGPointMake(80, 340);
        self.usage.center=CGPointMake(240, 340);
        self.aboutMe.userInteractionEnabled=YES;
        self.project.userInteractionEnabled=YES;
        self.usage.userInteractionEnabled=YES;
    }];
}

 
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.project.layer.cornerRadius=self.project.frame.size.width/2;
 
    self.aboutMe.layer.cornerRadius=self.aboutMe.frame.size.width/2;
  
    self.usage.layer.cornerRadius=self.usage.frame.size.width/2;
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)gotoUsage:(id)sender
{
    [self dismiss:^(){
        UIStoryboard* storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* controller=[storyBoard instantiateViewControllerWithIdentifier:@"UsageController"];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}


- (IBAction)gotoAboutMe:(id)sender
{
    [self dismiss:^(){
        UIStoryboard* storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* controller=[storyBoard instantiateViewControllerWithIdentifier:@"AboutMeController"];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}


- (IBAction)gotoProject:(id)sender
{
    [self dismiss:^(){
        UIStoryboard* storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* controller=[storyBoard instantiateViewControllerWithIdentifier:@"ProjectController"];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

@end
