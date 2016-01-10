//
//  CommentViewController.m
//  YMApp
//
//  Created by yannis on 16/1/3.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CommentViewController.h"
#import "ProductComment.h"
#import "CommentDetailCell.h"
#import "MJRefresh/MJRefresh.h"

#define PAGESIZE 20

@interface CommentViewController ()
{
    MJRefreshFooter *_footer;
    NSString *_score;
    NSString *_percent;
    
    UILabel *_scoreLabel;
    UILabel *_percentLabel;
    
}

@end


@implementation CommentViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewDidLoad
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.pageIndex=1;
    self.title=@"评价";
    [self initHeader];
    [self initTableView];
    [self initFooterRefersh];
    [self getCommentList];
}

-(void)initHeader
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, REAL_WIDTH1(120))];
    [view setBackgroundColor:RGB(248, 248, 248)];
    view.layer.borderWidth=0.5;
    view.layer.borderColor=GRAYCOLOR.CGColor;
    [self.view addSubview:view];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(REAL_WIDTH1(30), 10, REAL_WIDTH1(150), REAL_WIDTH1(35))];
    titleLabel.text=@"总体满意度";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont boldSystemFontOfSize:15];
    titleLabel.textColor=GRAYCOLOR;
    [view addSubview:titleLabel];
    
    _scoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(REAL_WIDTH1(30), CGRectGetMaxY(titleLabel.frame), REAL_WIDTH1(150), REAL_WIDTH1(40))];
    _scoreLabel.text=@"5.0分";
    [_scoreLabel setFont:[UIFont systemFontOfSize:13]];
    [_scoreLabel setTextColor:[UIColor redColor]];
    _scoreLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:_scoreLabel];
    
    _percentLabel=[[UILabel alloc]initWithFrame:CGRectMake(screen_width-REAL_WIDTH1(118), 0, REAL_WIDTH1(150), REAL_WIDTH1(120))];
     _percentLabel.text=@"100%好评";
    [_percentLabel setTextColor:GRAYCOLOR];
    [_percentLabel setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:_percentLabel];
}

-(void)refershHeader:(NSString *)score percent:(NSString *)percent
{
    _scoreLabel.text=[NSString stringWithFormat:@"%@分",score];
    
    NSMutableAttributedString *attrs= [_scoreLabel.text AttributedStringWithFont:[UIFont boldSystemFontOfSize:18] withColor:nil range:NSMakeRange(0, [_scoreLabel.text length]-1)];
    _scoreLabel.attributedText=attrs;
    
    
    _percentLabel.text=[NSString stringWithFormat:@"%@好评",percent];
    NSMutableAttributedString *percentAttrs=[_percentLabel.text AttributedStringWithFont:nil withColor:[UIColor redColor] range:NSMakeRange(0, [_percentLabel.text length]-2)];
    _percentLabel.attributedText=percentAttrs;
}

-(void)initTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+REAL_WIDTH1(120), screen_width, screen_height-64-REAL_WIDTH1(120)) style:UITableViewStylePlain];
    self.tableView.backgroundColor=RGB(248, 248, 248);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    self.comments=[[NSMutableArray alloc]init];
}

#pragma 初始化上拉刷新控件
-(void)initFooterRefersh
{
    _footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getCommentList)];
    self.tableView.mj_footer=_footer;
}
#pragma 上拉刷新按钮代理事件
-(void)footerBeginRefreshing
{
    [self getCommentList];
}
-(void)getCommentList{
    //[_HUD show:YES];
    NSString *urlstr= [NSString stringWithFormat:@"http://h5.yiguo.com/ProductOpt/GetCommodityVoteList?CId=%@&PageIndex=%ld&PageSize=%d",self.commodityId,self.pageIndex,PAGESIZE] ;
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSArray *responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
        _percent=[[dict objectForKey:@"RspData"] objectForKey:@"voteRate"];
        _score=[[dict objectForKey:@"RspData"] objectForKey:@"totalScore"];

        if (_pageIndex==1&&[responseData count]==0) {
            [_tableView removeFromSuperview];
            UILabel *noneLabel=[[UILabel alloc]init];
            noneLabel.text=@"当前商品暂无用户评价";
            noneLabel.textAlignment=NSTextAlignmentCenter;
            noneLabel.frame=CGRectMake(0, 0, screen_width, 200);
            [self.view addSubview:noneLabel];
            noneLabel.center=self.view.center;
        }
        
        if(_pageIndex==1)
        {
            [self.comments removeAllObjects];
        }
        if ([responseData count]==0) {
            [_footer endRefreshingWithNoMoreData];
            _footer.hidden=YES;
        }else{
            [responseData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ProductComment *comment=[ProductComment initWithDictionart:obj];
                
                [self.comments addObject:comment];
            }];
            
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
            _pageIndex+=1;
        }
       [self refershHeader:_score percent:_percent];
       // [_HUD hide:YES];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        //[_HUD hide:YES];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comments count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"productcommentdetailcell";
    CommentDetailCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[CommentDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ProductComment *comment=[self.comments objectAtIndex:indexPath.row];
    [cell setComment:comment];
    return cell.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"productcommentdetailcell";
    CommentDetailCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[CommentDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ProductComment *comment=[self.comments objectAtIndex:indexPath.row];
    [cell setComment:comment];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
