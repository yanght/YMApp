//
//  CartViewController.m
//  YMApp
//
//  Created by yannis on 15/12/14.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "CartViewController.h"
#import "CookieTest.h"
#import "CookieHelper.h"
#import "CartTableViewCell.h"
#import "CartService.h"
#import "YMRadioButton.h"
#import "CartSettleView.h"

@interface CartViewController ()

@end

@implementation CartViewController

-(void)viewWillAppear:(BOOL)animated
{
     [self getCartModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initCoupanView];
    [self initSettleView];
    [self initTableView];
}

-(void)initTableView
{
    self.tableView=[[UITableView alloc]init];
    self.tableView.frame=CGRectMake(0, 64, screen_width, self.view.frame.size.height-self.settleView.frame.size.height-49-64);
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.view addSubview:self.tableView];
}
-(void)initCoupanView
{
    self.coupanView=[[UIView alloc]init];
    self.coupanView.frame=CGRectMake(0, 0, screen_width, REAL_WIDTH1(70));
        [self.view addSubview:self.coupanView];
}
-(void)initSettleView
{
    CGRect frame=CGRectMake(0, self.view.frame.size.height-REAL_WIDTH1(100)-49, screen_width, REAL_WIDTH1(100));
    self.settleView=[[CartSettleView alloc]initWithFrame:frame];
    self.settleView.layer.borderWidth=0.5;
    self.settleView.layer.borderColor=GRAYCOLOR.CGColor;
    [self.settleView setPromotionPrice:0 totleAmount:0 selectCount:0];
    [self.view addSubview:self.settleView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number= [self.cartModel.RspData.dataCommoditys count];
    return number;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return REAL_WIDTH1(190);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.cartModel.RspData.dataCommoditys count]==0)
    {
        static NSString *cellIndentifier = @"nomorecell";
        CartTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        cell=[[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        return cell;
    }else
    {
        static NSString *cellIndentifier = @"carttableviewcell";
        CartTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        cell=[[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        Product *product=self.cartModel.RspData.dataCommoditys[indexPath.row];
        [cell setProduct:product];
        cell.delegate=self;
        return cell;
    }
}

/**
 *  滑动删除购物车商品
 *
 *  @param tableView    tableView description
 *  @param editingStyle editingStyle description
 *  @param indexPath    indexPath description
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Product *product=[self.cartModel.RspData.dataCommoditys objectAtIndex:indexPath.row];
        CartService *svc=[[CartService alloc]init];
        [svc updateCartWith:2:product.CommodityId];
        
        NSMutableArray *cartprodicuts=[self.cartModel.RspData.dataCommoditys mutableCopy];
        [cartprodicuts removeObjectAtIndex:indexPath.row];
        self.cartModel.RspData.dataCommoditys=[cartprodicuts copy];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/**
 *   实现购物车TableViewCell增减商品的刷新购物车代理
 */
-(void)updateShopCart
{
    [self getCartModel];
}

-(void)CheckButtonClick
{
    
}

/**
 *  获取购物车数据
 */
-(void)getCartModel{
    //[_HUD show:YES];
    NSString *urlstr= [NSString stringWithFormat:@"http://h5.yiguo.com/CartOpt/GetCartCommodityList"] ;
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        
        CartModel *cartmodel=[[CartModel alloc]initWithString:html error:NULL];
        
        self.cartModel=cartmodel;
        [self.tableView reloadData];
        [self.settleView setPromotionPrice:self.cartModel.RspData.discountAmount totleAmount:self.cartModel.RspData.totalPrice selectCount:[[[CartService alloc]init] getCartCount]];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        // [_HUD hide:YES];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
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
