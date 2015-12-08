//
//  HomeViewController.m
//  YMApp
//
//  Created by yannis on 15/11/2.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerCell.h"
#import "ZQBannerCell.h"
#import "ZQBannerCell1.h"
#import "BannerButtonCell.h"
#import "BannerAdCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "HomeBanner.h"
#import "HomeGroup.h"
#import "RushTableViewCell.h"


@interface HomeViewController()<UITableViewDelegate,UITableViewDataSource>
{
    HomeGroup *_banners;
    HomeGroup *_group1;
    HomeGroup *_group2;
    HomeGroup *_group3;
    HomeGroup *_group4;
    HomeGroup *_group5;
    HomeGroup *_group6;
    HomeGroup *_shortcutIcons;
}
@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=RGB(246, 246, 246);

    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    
    headerView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:headerView];
    [self initData];
    [self getHomeData];
    [self initTableView];
    
    [self setupRefresh];
    
}
-(void)initData
{
    _banners=[[HomeGroup alloc]init];
    _group1=[[HomeGroup alloc]init];
    _group2=[[HomeGroup alloc]init];
    _group3=[[HomeGroup alloc]init];
    _group4=[[HomeGroup alloc]init];
    _group5=[[HomeGroup alloc]init];
    _group6=[[HomeGroup alloc]init];
    _shortcutIcons=[[HomeGroup alloc]init];
}

-(void) initTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64-49) style:UITableViewStyleGrouped ];
    self.tableView.backgroundColor=[UIColor colorWithRed:239.0/255 green:243.0/255 blue:246.0/255 alpha:1];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
}

-(void)getHomeData
{
    NSString *urlstr=@"http://weixin.m.yiguo.com/MallOpt/GetMallBanners";
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        id responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
       
        [self initGroupData:@"Banners" :[responseData objectForKey:@"Banners"]];
        [self initGroupData:@"Group1" :[responseData objectForKey:@"Group1"]];
        [self initGroupData:@"Group2" :[responseData objectForKey:@"Group2"]];
        [self initGroupData:@"Group3" :[responseData objectForKey:@"Group3"]];
        [self initGroupData:@"Group4" :[responseData objectForKey:@"Group4"]];
        [self initGroupData:@"Group5" :[responseData objectForKey:@"Group5"]];
        [self initGroupData:@"Group6" :[responseData objectForKey:@"Group6"]];
        [self initGroupData:@"ShortcutIcons" :[responseData objectForKey:@"ShortcutIcons"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //NSLog(@"++++++%@",categoryList);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        //[HUD removeFromSuperview];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

-(void)initGroupData:(NSString *)groupName :(NSDictionary *)dic
{
    HomeGroup *group=[HomeGroup initWithDic:dic];
    NSMutableArray *banners=[[NSMutableArray alloc]init];
    NSArray *dicBanners=[dic objectForKey:@"Banners"];
    [dicBanners enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HomeBanner *banner=[HomeBanner initWithDic:obj];
        [banners addObject:banner];
    }];
    group.HomeBanners=banners;
    if ([groupName isEqualToString:@"Banners"]) {
         _banners=group;
    }else if ([groupName isEqualToString:@"Group1"])
    {
        _group1=group;
    }
    else if ([groupName isEqualToString:@"Group2"])
    {
        _group2=group;
    }
    else if ([groupName isEqualToString:@"Group3"])
    {
        _group3=group;
    }
    else if ([groupName isEqualToString:@"Group4"])
    {
        _group4=group;
    }
    else if ([groupName isEqualToString:@"Group5"])
    {
        _group5=group;
    }
    else if ([groupName isEqualToString:@"Group6"])
    {
        _group6=group;
    }
    else if ([groupName isEqualToString:@"ShortcutIcons"])
    {
        _shortcutIcons=group;
    }
   
}
//有多少个子节点
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

//每个子节点与多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//每个子节点的高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 150;
    }
    else if(indexPath.section==3)
    {
        static NSString *cellzqIndentifier=@"banneradcell";
        BannerAdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
        if(cell==nil)
        {
            cell=[[BannerAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group2];
        }
        [cell setGroup:_group2];
        return cell.height;
    }
    else if(indexPath.section==2)
    {
        return REAL_WIDTH1(314);
        
    }else if(indexPath.section==1)
    {
        return REAL_WIDTH(270);
    }else if(indexPath.section==4||indexPath.section==5)
    {
        return REAL_WIDTH1(456);
    }else if(indexPath.section==6)
    {
        static NSString *cellzqIndentifier=@"banneradcellhot";
        BannerAdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
        if(cell==nil)
        {
            cell=[[BannerAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group6];
        }
        [cell setTitle:_group6.GroupTitle];
        [cell setGroup:_group6];
        return cell.height;
    }
    return 200;
    
}

//每个子节点的页眉高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

//每个子节点的页尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==1||section==0)
    {
        return 0.1;
    }
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    headerView.backgroundColor = [UIColor colorWithRed:239 green:239 blue:244 alpha:0];
    //    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}
     
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    footerView.backgroundColor = [UIColor colorWithRed:239 green:239 blue:244 alpha:0];

    //    footerView.backgroundColor = [UIColor yellowColor];
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        NSMutableArray *images=[[NSMutableArray alloc]init];
        [_banners.HomeBanners enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeBanner *banner=obj;
            [images addObject:banner.PictureUrl];
        }];
        if(images.count==0)
        {
            static NSString *cellIndentifier = @"nomorecell";
            HomeBannerCell *cell=[_tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            cell=[[HomeBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            return cell;
        }else
        {
            static NSString *cellIndentifier = @"homebannercell";
            HomeBannerCell *cell=[_tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            cell=[[HomeBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            [cell setImages:images];
            return cell;
        }
    }
    else if(indexPath.section==1)
    {
        static NSString *cellzqIndentifier=@"bannerbuttoncell";
        BannerButtonCell *cell=[[BannerButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier banners:_shortcutIcons.HomeBanners];
        return cell;
    }else if(indexPath.section==2)
    {
        if(_group2.HomeBanners.count==0)
        {
            static NSString *cellzqIndentifier=@"nomorecell";
            RushTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[RushTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group1];
            }
            return cell;
        }else
        {
            static NSString *cellzqIndentifier=@"rushtableviewcell";
            RushTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[RushTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group1];
            }
            [cell setGroup:_group1];
            return cell;
        }
        
    }else if(indexPath.section==3)
    {
        if(_group2.HomeBanners.count==0)
        {
            static NSString *cellzqIndentifier=@"nomorecell";
            BannerAdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[BannerAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group2];
            }
            return cell;
        }else
        {
            static NSString *cellzqIndentifier=@"banneradcell";
            BannerAdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[BannerAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group2];
            }
            [cell setTitle:_group2.GroupTitle];
            [cell setGroup:_group2];
            return cell;
        }
    
    
    }else if(indexPath.section==4)
    {
        if(_group3.HomeBanners.count==0)
        {
            static NSString *cellzqIndentifier=@"nomorecell";
            ZQBannerCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[ZQBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group3];
            }
            return cell;
        }else
        {
            static NSString *cellzqIndentifier=@"zabannercell";
            ZQBannerCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[ZQBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group3];
            }
            [cell setGroup:_group3];
            return cell;
        }
    }else if(indexPath.section==5)
    {
        if(_group3.HomeBanners.count==0)
        {
            static NSString *cellzqIndentifier=@"nomorecell";
            ZQBannerCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[ZQBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group4];
            }
            return cell;
        }else
        {
            static NSString *cellzqIndentifier=@"zabannercell";
            ZQBannerCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[ZQBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group4];
            }
            [cell setGroup:_group4];
            return cell;
        }
    }else if(indexPath.section==6)
    {
        if(_group6.HomeBanners.count==0)
        {
            static NSString *cellzqIndentifier=@"nomorecell";
            BannerAdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[BannerAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group6];
            }
             [cell setTitle:_group6.GroupTitle];
            return cell;
        }else
        {
            static NSString *cellzqIndentifier=@"banneradcellhot";
            BannerAdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellzqIndentifier];
            if(cell==nil)
            {
                cell=[[BannerAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellzqIndentifier group:_group6];
            }
            [cell setTitle:_group6.GroupTitle];
            [cell setGroup:_group6];
            return cell;
        }

    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor colorWithRed:239.0/255  green:243.0/255  blue:246.0/255  alpha:1];
}


-(void) setupRefresh
{
    NSMutableArray *images=[NSMutableArray array];
    UIImage *image=[UIImage imageNamed:@"dropdown_loading_01"];
       [images addObject:image];
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTable)];
    [header setImages:images forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:images forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:images forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}
-(void)refreshTable
{
    [self getHomeData];
    //[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
