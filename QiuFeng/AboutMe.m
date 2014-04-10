//
//  AboutMe.m
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "AboutMe.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ExperienceCell.h"
#import "ExperienceClient.h"

@interface AboutMe ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic,strong) NSMutableArray* adView;
@property (weak, nonatomic) IBOutlet UITableView *myInfo;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray* data;

@end

@implementation AboutMe
{
    int index;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) addAd
{
    UIImageView* mySelf=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    [mySelf setImageWithURL:[NSURL URLWithString:@"http://sseclass.tongji.edu.cn/qiufeng/About/myself.png"]];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray*)data
{
    if (_data==nil)
    {
        _data=[[NSMutableArray alloc] init];
    }
    return _data;
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

#pragma mark - tableview 

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) return 4;
    else return self.data.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.data.count==0) return 1;
    else return 2;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UILabel* lable=[[UILabel alloc] initWithFrame:CGRectMake(14, 0, 100, 22)];
    lable.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    lable.textAlignment=NSTextAlignmentLeft ;
    if (section==0)
    {
        lable.text=@"Education";
    }
    else lable.text=@"Experience";
    
    [view addSubview:lable];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExperienceCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExperenceCell" forIndexPath:indexPath];
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            [cell setCellWithTitle:@"School" andSubtitle:@"Tongji University"];
        }
        else if (indexPath.row==1)
        {
            [cell setCellWithTitle:@"Major" andSubtitle:@"Software Engineering"];
        }
        else if (indexPath.row==2)
        {
            [cell setCellWithTitle:@"Degree" andSubtitle:@"Bachelor"];
        }
        else
        {
            [cell setCellWithTitle:@"Direction" andSubtitle:@"iOS and Web development"];
        }
    }
    else
    {
        [cell setCellWithExperience:self.data[indexPath.row]];
    }
    return cell;
}

-(void) loadData
{
    [[ExperienceClient sharedExperienceClient] getDataFromServer:^(NSArray* result,NSError* error){
        if (error)
        {
            NSLog(@"%@",error);
        }
        else
        {
            for (NSDictionary* dic in result)
            {
                Experience* ex=[[Experience alloc] initWithDictionary:dic];
                [self.data addObject:ex];
            }
            [self.tableView reloadData];
        }
    }];
}

@end
