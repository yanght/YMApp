//
//  ProductViewController.m
//  YMApp
//
//  Created by yannis on 15/11/25.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "ProductTableViewCell.h"
#import "ProductNameCell.h"
#import "ProductPromotionCell.h"
#import "BaseProductCell.h"
#import "ProductSpecCell.h"
#import "ProductSpec.h"
#import "PlaceOfOriginCell.h"
#import "ProductCommentCell.h"
#import "BaseProductCell.h"
#import "ProductHeaderView.h"

@interface ProductViewController ()
{
    NSMutableArray *cells;
    MBProgressHUD *_HUD;
}
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.hidden=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initTableView];
    _HUD = [Utils createHUD];
    [self.view addSubview:_HUD];
    [self getProductList];
    
}

-(void)initTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, screen_width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return REAL_WIDTH1(600);
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return REAL_WIDTH1(600);
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProductHeaderView *headerView=[[ProductHeaderView alloc]initWithFrame:CGRectMake(0, 0, screen_width, REAL_WIDTH1(600))];
    headerView.backgroundColor=[UIColor whiteColor];
    [headerView setImages:self.product.Pictures];
    return headerView;
}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    ProductHeaderView *headerView=[[ProductHeaderView alloc]initWithFrame:CGRectMake(0, 0, screen_width, REAL_WIDTH1(600))];
//    headerView.backgroundColor=[UIColor whiteColor];
//    [headerView setImages:self.product.Pictures];
//    return headerView;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self.product.Promotions isEqual:[NSNull null]]) {
        return 5+[self.product.Promotions count];
    }
    return 5;
   }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cells count]>0) {
        BaseProductCell *cell=[cells objectAtIndex:indexPath.row];
        return cell.height;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cells count]>0) {
        BaseProductCell *cell= [cells objectAtIndex:indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellIdentifier=@"normalcell";
        UITableViewCell *cell;
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
    
}

-(void)getProductList{
    //[_HUD show:YES];
    NSString *urlstr= [NSString stringWithFormat:@"http://h5.yiguo.com/ProductOpt/GetProductInfo?commodityCode=%@",self.commodityCode] ;
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSDictionary *responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
        
        self.product=[Product initWithDictionary:responseData];
        self.productViewModel=[[ProductViewModel alloc]initWithProduct:self.product];
        [self initCells:self.product];
        [self.tableView reloadData];
        [_HUD hide:YES];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [_HUD hide:YES];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

-(void)initCells:(Product *)product
{
    cells=[[NSMutableArray alloc]init];
    
    NSString *cellIdentifier=@"normalcell";
    
    if (product.CommodityName!=nil) {
        cellIdentifier=@"productnamecell";
        ProductNameCell *cell=[[ProductNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setProductName:product.CommodityName productPrice:product.CommodityPrice oldProductPrice:product.OriginalPrice];
        [cells addObject:cell];
    }
    if (![product.Promotions isEqual:[NSNull null]]) {
        cellIdentifier=@"productpromotioncell";
        NSArray *promotions=product.Promotions;
        [promotions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductPromotionCell *cell=[[ProductPromotionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            NSDictionary *dic=obj;
            Promotion *promotion=[Promotion initWithDictionary:dic];
            [cell setPromotion:promotion];
            [cells addObject:cell];
        }];
    }
    if (![product.Speces isEqual:[NSNull null]]) {
        cellIdentifier=@"productspeccell";
        ProductSpecCell *cell=[[ProductSpecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        NSMutableArray *productSpecs=[[NSMutableArray alloc]init];
        
        [product.Speces enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic=obj;
            ProductSpec *prductspec=[ProductSpec initWithDictionary:dic];
            [productSpecs addObject:prductspec];
        }];
        [cell setSpecs:productSpecs commodityCode:product.CommodityCode];
        cell.delegate=self;
        [cells addObject:cell];
    }
    if (![product.PlaceOfOrigin isEqualToString:@""]) {
        cellIdentifier=@"placeodorigincell";
        PlaceOfOriginCell *cell=[[PlaceOfOriginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setPlaceOfOrigin:product.PlaceOfOrigin deliveryTips:product.DeliveryTips];
        [cells addObject:cell];
    }
    if (product.VoteCount>=0) {
        cellIdentifier=@"productcommentcell";
        ProductCommentCell *cell=[[ProductCommentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell setCommentCount:[product.VoteCount integerValue] goodPercent:[product.VotePositiveRate floatValue]*100];
        [cells addObject:cell];
    }
    
    cellIdentifier=@"defaultcell";
    BaseProductCell *cell=[[BaseProductCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.text=@"商品图文详情(建议在WIFI下查看)";
    cell.textLabel.textColor=GRAYCOLOR;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.height=cell.frame.size.height;
    [cells addObject:cell];
}

-(void)didSelectProduct:(NSString *)commodityCode
{
    self.commodityCode=commodityCode;
    [self getProductList];
    
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
