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
#import "CommentViewController.h"
#import "CookieCartModel.h"
#import "CookieProductModel.h"
#import "CartService.h"

@interface ProductViewController ()
{
    NSMutableArray *cells;
    MBProgressHUD *_HUD;
}
@end

@implementation ProductViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha=0;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha=1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initTableView];
    [self setNav];
    _HUD = [Utils createHUD];
    [self.view addSubview:_HUD];
    [self getProductList];
}

-(void)setNav
{
    UIView *backview=[[UIView alloc ]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    [self.view addSubview:backview];
    [self.view bringSubviewToFront:backview];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [button setImage:[UIImage imageNamed:@"iconfont-zuo"] forState:UIControlStateNormal];
//    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:button];
}
-(void) backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, screen_width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    UIButton *addCartButton=[[UIButton alloc]initWithFrame:CGRectMake(screen_width-REAL_WIDTH1(150), screen_height-49-REAL_WIDTH1(150), REAL_WIDTH1(100), REAL_WIDTH1(100))];
    [addCartButton setImage:[UIImage imageNamed:@"add_cart"] forState:UIControlStateNormal];
    addCartButton.layer.cornerRadius=REAL_WIDTH1(50);
    addCartButton.backgroundColor=MAINCOLOR;
    [addCartButton addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCartButton];
    [self.view bringSubviewToFront:addCartButton ];
}

-(void)addToCart:(id)sender
{
    CookieProductModel *product=[[CookieProductModel alloc]init];
    product.Id=self.product.CommodityId;
    product.Code=self.product.CommodityCode;
    product.GId=@"";
    
    ProductNameCell *cell=cells[0];
    product.Amount=cell.number;
    
    CartService *svc=[[CartService alloc]init];
    
    NSInteger count= [svc addProduct:product];
    
    self.tabBarController.tabBar.items[3].badgeValue=[NSString stringWithFormat:@"%ld",count];
//    self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%ld",count];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProductHeaderView *headerView=[[ProductHeaderView alloc]initWithFrame:CGRectMake(0, 0, screen_width, REAL_WIDTH1(600))];
    headerView.backgroundColor=[UIColor whiteColor];
    [headerView setImages:self.product.Pictures];
    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [cells count];
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
    NSString *urlstr= [NSString stringWithFormat:@"http://weixin.m.yiguo.com/ProductOpt/GetProductInfo?commodityCode=%@",self.commodityCode] ;
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
    if (![product.PlaceOfOrigin isEqualToString:@""]||![product.DeliveryTips isEqualToString:@""]) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseProductCell *cell=[cells objectAtIndex:indexPath.row];
    if ([cell.reuseIdentifier isEqual:@"productcommentcell"]) {
        self.hidesBottomBarWhenPushed=YES;
        CommentViewController *commentController=[[CommentViewController alloc]init];
        commentController.commodityId=self.product.CommodityId;
        [self.navigationController pushViewController:commentController animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
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
