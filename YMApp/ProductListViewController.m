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

@interface ProductListViewController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_products;
    NSMutableArray *_productcells;
    MBProgressHUD *_HUD;
}

@end

@implementation ProductListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_titleName;
    self.categoryCode=_categoryCode;
    
    
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0, screen_width, screen_height)];
    self.view=view;
    self.view.backgroundColor=[UIColor whiteColor];

    // 定义所有子页面返回按钮的名称
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    _HUD= [[MBProgressHUD alloc] initWithWindow:window];
    _HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:_HUD];
    [_HUD show:YES];
    _HUD.userInteractionEnabled = NO;
    [_HUD showWhileExecuting:@selector(getProductList) onTarget:self withObject:nil animated:YES];
    
    [self initTableView];
    
}
-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, screen_width, screen_height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellAccessoryNone;

    [self.view addSubview:_tableView];
    
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

-(void)getProductList
{
    NSString *urlstr= [NSString stringWithFormat:@"http://weixin.m.yiguo.com/ProductOpt/GetProductLists?CatCode=%@&PageIndex=1&PageSize=20&Sort=Default",self.categoryCode] ;
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        id responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
        //NSLog(@"+++++%@",dict);
        _products=[[NSMutableArray alloc]init];
        [responseData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_products addObject:[Product initWithDictionary:obj]];
        }];
        [_tableView reloadData];
        
        //NSLog(@"++++++%@",categoryList);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        //[HUD removeFromSuperview];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *p=_products[indexPath.row];
    ProductViewController *productcontroller=[[ProductViewController alloc]init];
    
    [self.navigationController pushViewController:productcontroller animated:YES];
}

@end
