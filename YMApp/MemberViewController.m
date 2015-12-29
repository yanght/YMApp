//
//  MemberViewController.m
//  YMApp
//
//  Created by yannis on 15/12/14.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberTableViewCell.h"

@interface MemberViewController ()

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellzqIndentifier=@"membertableviewcell";
    MemberTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
    if(cell==nil)
    {
        cell=[[MemberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screen_height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
