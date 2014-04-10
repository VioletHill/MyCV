//
//  ProjectTableViewController.m
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "ProjectClient.h"
#import "Project.h"
#import "ProjectTableViewCell.h"

@interface ProjectTableViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray* data;

@end

@implementation ProjectTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSMutableArray*) data
{
    if (_data==nil)
    {
        _data=[[NSMutableArray alloc] init];
    }
    return _data;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier=@"ProjectTableViewCell";
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setCellWithProject:self.data[indexPath.row]];
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project* project=self.data[indexPath.row];
    if ([project.state isEqual:@"已经上架"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:project.itunesLink]];
    }
    else
    {
        UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"亲 该应用还没来得急上架哦~~" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - load data

-(void) loadData
{
    [[ProjectClient sharedProjectClient] getDataFromServer:^(NSArray* result, NSError* error){
        if (error)
        {
            UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"获取信息错误" message:@"获取信息错误 检查网路是否正常,如果一切正常 尽快联系我哦~~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.delegate=self;
            [alertView show];

        }
        else
        {
            for (NSDictionary* dic in result)
            {
                Project* project=[[Project alloc] initWithDictionary:dic];
                [self.data addObject:project];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - alertview delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  //网络错误
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
