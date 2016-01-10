//
//  ActivityViewController.m
//  YMApp
//
//  Created by yannis on 15/12/19.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ActivityViewController.h"
#import "MBProgressHUD.h"

@interface ActivityViewController ()
{
    MBProgressHUD *_hud;
}
@end

@implementation ActivityViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initWebView];
}

-(void)initWebView
{
    //NSLog(@"%@",self.url);
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    NSURLRequest *request=[NSURLRequest requestWithURL:[[NSURL alloc]initWithString:self.url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        CGRect webViewFrame=self.webView.frame;
//        CGRect tabFrame=self.tabBarController.tabBar.frame;
//        webViewFrame.size.height+=tabFrame.size.height;
//        
//        self.webView.frame=webViewFrame;
//        tabFrame.origin.y=screen_height;
//        self.tabBarController.tabBar.frame=tabFrame;
//    }];

   
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
   _hud=[Utils createHUD];
    [self.webView addSubview:_hud];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_hud setHidden:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_hud setHidden:YES];
    NSLog(@"%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisAppear:(BOOL)animated
{
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect webViewFrame=self.webView.frame;
        CGRect tabFrame=self.tabBarController.tabBar.frame;
//        webViewFrame.size.height-=tabFrame.size.height;
    
        //self.webView.frame=webViewFrame;
        tabFrame.origin.y=300;
        self.tabBarController.tabBar.frame=tabFrame;
//    }];
    

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
