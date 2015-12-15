//
//  CityViewController.m
//  YMApp
//
//  Created by yannis on 15/12/14.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "CityViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "City.h"

@interface CityViewController ()

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(246, 246, 246)];
    [self.navigationController setNavigationBarHidden:false animated:YES];
   
    [self initHeaderView];
    [self initTableView ];
    [self getCityList];
    // Do any additional setup after loading the view.
}

-(void)initHeaderView
{
    self.headerView=[[UIView alloc]init];
    [self.headerView setFrame:CGRectMake(0, REAL_WIDTH1(18)+64, screen_width, REAL_WIDTH1(143))];
    [self.headerView setBackgroundColor:RGB(238, 245, 233)];
    [self.view addSubview:self.headerView];
    
    UIButton *positionButton=[[UIButton alloc]init];
    [positionButton setFrame:CGRectMake(0, 0, screen_width, REAL_WIDTH1(90))];
    [positionButton setBackgroundColor:[UIColor whiteColor]];
    [positionButton setImage:[UIImage imageNamed:@"position"] forState:UIControlStateNormal];
    [positionButton setTitle:@"上海" forState:UIControlStateNormal];
    [positionButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [positionButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [positionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [positionButton setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [self.headerView addSubview:positionButton];
    
    UILabel *tipsLabel=[[UILabel alloc]init];
    [tipsLabel setFrame:CGRectMake(15, H(positionButton), screen_width-15, H(self.headerView)-H(positionButton))];
    [tipsLabel setText:@"因城市所售商品不同，请根据您的收货地址进行选择"];
    [tipsLabel setFont:[UIFont systemFontOfSize:13]];
    [tipsLabel setTextColor:MAINCOLOR];
    [self.headerView addSubview:tipsLabel];
}

-(void)initTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+H(self.headerView)+REAL_WIDTH1(18), screen_width, screen_height-64-H(self.headerView)-REAL_WIDTH1(18)-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor=RGB(238, 245, 233);
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionIndexColor=MAINCOLOR;
    self.tableView.sectionIndexBackgroundColor=RGB(238, 245, 233);
    
    self.hotCityList=[[NSMutableArray alloc]init];
    self.cityList=[[NSMutableDictionary alloc]init];
    self.keys=[[NSMutableArray alloc]init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.keys==nil|| [self.keys count]==0) {
        static NSString *cellIdentifier=@"normalcell";
        UITableViewCell *cell;
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }else
    {
    static NSString *cellIdentifier=@"cityCell";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    
    NSString *key=self.keys[indexPath.section];
    
    NSArray *citys=[self.cityList objectForKey:key];
    
    City *city=citys[indexPath.row];
    cell.textLabel.text=city.Name;
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    
    return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }else
    {
        return [[self.cityList objectForKey:self.keys[section]] count];
    }
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = RGB(238, 245, 233);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screen_width, REAL_WIDTH1(60))];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text=[self.keys objectAtIndex:section];
    titleLabel.textColor=MAINCOLOR;
    [myView addSubview:titleLabel];
    return myView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return REAL_WIDTH1(60);
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}

-(void)getCityList{
    NSString *urlstr= [NSString stringWithFormat:@"http://h5.yiguo.com/DeliveryCityOpt/GetCityLists"] ;
    NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSDictionary *responseData=[[dict objectForKey:@"RspData"] objectForKey:@"data"];
        //self.hotCityList=[responseData objectForKey:@"HotCitys"];
        NSMutableArray *arrays=[[NSMutableArray alloc]init];
        
        [responseData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:@"HotCitys"]) {
                NSArray *hotcitys=obj;
                [hotcitys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    City *city=[City initWitgDic:obj];
                    [self.hotCityList addObject:city];
                }];
            }else
            {
                NSMutableArray *citys=[[NSMutableArray alloc]init];
                [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    City *city=[[City alloc]initWitgDic:obj];
                    [citys addObject:city];
                    
                }];
                [self.cityList setObject:citys forKey:key];
                [arrays addObject:key];
                
#pragma 数组排序
               self.keys= [arrays sortedArrayUsingSelector:@selector(compare:)];
                
            }
        }];
//        NSLog(@"%@",self.cityList);
        
        [self.tableView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
