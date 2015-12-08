//
//  CategoryViewController.m
//  YMApp
//
//  Created by yannis on 15/11/28.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "CategoryViewController.h"
#import "AFNetworking.h"
#import "MCategory.h"
#import "CategoryTableViewCell.h"
#import "ProductListViewController.h"
#import "MBProgressHUD.h"

@interface CategoryViewController ()<MBProgressHUDDelegate, UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_categoryList;
    UITableView *_tableview;
    MBProgressHUD *_HUD;
}
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initTableView];
    
    
    _HUD = [Utils createHUD];
    [self.view addSubview:_HUD];
   
    [self getData];
    // 定义所有子页面返回按钮的名称
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
  }
#pragma mark -
#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}

-(void) initTableView
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellAccessoryNone;
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categoryList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"CategoryTableViewCell";
    CategoryTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[CategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MCategory *category=_categoryList[indexPath.row];
    [cell setCategory:category];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

#pragma 使UITableView的分割线与屏幕同宽
/*

-(void)viewDidLayoutSubviews {
    
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

 */
 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return REAL_WIDTH1(160);
}

-(void)getData
{
    //sleep(3);
    NSString *urlstr=@"http://weixin.m.yiguo.com/CategoryOpt/GetCategory";
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        id responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
        //NSLog(@"+++++%@",dict);
        _categoryList=[[NSMutableArray alloc]init];
        [responseData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_categoryList addObject:[[MCategory alloc]initWithDic:obj]];
        }];
        [_tableview reloadData];
        [_HUD hide:YES];
    //NSLog(@"++++++%@",categoryList);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    [_HUD hide:YES];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListViewController *listcontroller=[[ProductListViewController alloc]init];
    
    MCategory *category=[_categoryList objectAtIndex:indexPath.row];
    listcontroller.titleName=category.categoryName;
    listcontroller.categoryCode=category.categoryCode;
    [self.navigationController pushViewController:listcontroller animated:YES ];
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
