//
//  ProductListViewController.m
//  YMApp
//
//  Created by yannis on 15/11/23.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductListViewController.h"
#import "ListProductCell.h"
#import "Product.h"
#import "ProductViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MJRefresh/MJRefresh.h"


@interface ProductListViewController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_products;
    NSMutableArray *_productcells;
    MBProgressHUD *_HUD;
    UIView *_headerView;
    UILabel *_lineLabel;
    MJRefreshFooter *_footer;
    
    NSString *_sort;
    NSUInteger _pageSize;
    NSUInteger _pageIndex;
    BOOL _scrollUporDown;
    BOOL _hidden;
}

@end

@implementation ProductListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_titleName;
    self.categoryCode=_categoryCode;
    _pageIndex=1;
    _pageSize=20;
    _sort=@"default";
    
    _products=[[NSMutableArray alloc]init];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0, screen_width, screen_height)];
    view.backgroundColor=RGB(246, 246, 246);
    self.view=view;
    
    // 定义所有子页面返回按钮的名称
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    _HUD= [Utils createHUD];
    
    [self initHeader];
    [self initTableView];
    [self initFooterRefersh];
    
    [self getProductList];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if ([scrollView isEqual:_tableView]) {
//        static float newy = 0;
//        static float oldy = 0;
//        newy = scrollView.contentOffset.y ;
//        NSLog(@"%f",newy);
//        if (newy>0) {
//            if (newy>oldy) {
//                NSLog(@"向上");
//                [UIView animateWithDuration:0.5 animations:^{
//                    _headerView.frame=CGRectMake(0, 0, W(_headerView), H(_headerView));
//                    _tableView.frame=CGRectMake(0, 64, W(_tableView), H(_tableView)+64);
//                    newy=scrollView.contentOffset.y;
//                }];
//            }else if(newy<oldy-30)
//            {
//                [UIView animateWithDuration:0.5 animations:^{
//                    NSLog(@"向下");
//                    _headerView.frame=CGRectMake(0, 64, W(_headerView), H(_headerView));
//                    _tableView.frame=CGRectMake(0, 64+H(_headerView)+2, W(_tableView), H(_tableView));
//                    newy=scrollView.contentOffset.y;
//                }];
//            }
//        }
//    }
//}

-(void)initHeader
{
    _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, REAL_WIDTH1(87))];
    _headerView.backgroundColor=[UIColor whiteColor ];
    [self.view addSubview:_headerView ];
    
    NSArray *titles=[NSArray arrayWithObjects:@"默认",@"价格",@"销量", nil];
    
    
    
    for (int i=0; i<3; i++) {
//        UIView *buttonview=[[UIView alloc]init];
//        CGRect frame=CGRectMake((screen_width/3.0)*i, 0, screen_width/3.0, H(_headerView));
//        [buttonview setFrame:frame];
//        [_headerView addSubview:buttonview];
        
        UIButton *button=[[UIButton alloc]init];
        CGRect buttonFrame=CGRectMake(i*(W(_headerView)/3.0), 0, W(_headerView)/3.0, H(_headerView)-2);
        [button setFrame:buttonFrame];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        [button setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
        //[buttonview addSubview:button];
        [_headerView addSubview:button];
        [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        }
    }
    
    _lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(REAL_WIDTH1(45), H(_headerView)-2, W(_headerView)/3.0-REAL_WIDTH1(90), 2)];
    
    _lineLabel.backgroundColor=MAINCOLOR;
    [_headerView addSubview:_lineLabel];
}

-(void)sortButtonClick:(id)sender
{
    UIButton *button=sender;
    NSString *title=button.titleLabel.text;
    if([title isEqualToString:@"默认"])
    {
        _sort=@"default";
    }
    if([title isEqualToString:@"价格"])
    {
        _sort=@"PriceAsc";
    }else if ([title isEqualToString:@"销量"])
    {
        _sort=@"SalesVolumeAsc";
    }
    CGRect frame=_lineLabel.frame;
    frame.origin.x=button.frame.origin.x+REAL_WIDTH1(45);
    _lineLabel.frame=frame;
    [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    NSArray *buttons=[_headerView subviews];
    [buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UIButton class]]) {
            UIButton *tmpbutton=obj;
            if([tmpbutton.titleLabel.text isEqualToString:title])
            {
                [tmpbutton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            }else
            {
                [tmpbutton setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
            }
        }
       }];
    _pageIndex=1;
    [self getProductList];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:FALSE];
}

-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+H(_headerView)+2, screen_width, screen_height-64-H(_headerView)-49-2) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellAccessoryNone;
    _tableView.backgroundColor=RGB(246, 246, 246);
    [self.view addSubview:_tableView];
}

-(void)initFooterRefersh
{
    _footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getProductList)];
    _tableView.mj_footer=_footer;
}

-(void)footerBeginRefreshing
{
    [self getProductList];
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"ListProductCell";
    ListProductCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[ListProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Product *product=_products[indexPath.row];
    [cell setProduct:product];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return REAL_WIDTH1(200);
}

-(void)getProductList{
    [_HUD show:YES];
    NSString *urlstr= [NSString stringWithFormat:@"http://weixin.m.yiguo.com/ProductOpt/GetProductLists?CatCode=%@&Sort=%@&PageIndex=%d&PageSize=%d",self.categoryCode,_sort,_pageIndex,_pageSize] ;
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSArray *responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
        
        if(_pageIndex==1)
        {
            [_products removeAllObjects];
        }
      
        [responseData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_products addObject:[Product initWithDictionary:obj]];
        }];
        
        if ([responseData count]==0) {
            [_footer endRefreshingWithNoMoreData];
            _footer.hidden=YES;
        }else{
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
            _pageIndex+=1;
        }
        [_HUD hide:YES];
        NSLog(@"%lu",(unsigned long)_pageIndex);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        //[HUD removeFromSuperview];
        [_HUD hide:YES];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController *productcontroller=[[ProductViewController alloc]init];
    
    [self.navigationController pushViewController:productcontroller animated:YES];
}

@end
