//
//  SearchViewController.m
//  chasingBooksFiction
//
//  Created by iMac on 18/11/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import "SearchViewController.h"
#import "PYSearchViewController.h"
#import "AFNetworking.h"
#import "TempViewController.h"
@interface SearchViewController ()<PYSearchViewControllerDelegate>
{
    NSMutableArray *hotSeaches;
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.一开始就获取数据
    [self hotSeachesInterface];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn addTarget:self action:@selector(searchaction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

-(void)searchaction{
    hotSeaches = @[@"1",@"2",@"3"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        //        [searchViewController.navigationController pushViewController:[[TempViewController alloc] init] animated:YES];
        TempViewController * vc = [[TempViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@",searchText);
    }];
    // 3. 设置风格
    //        searchViewController.hotSearchStyle = PYHotSearchStyleNormalTag; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
    
    
}



//  热门搜索的接口
-(void)hotSeachesInterface{
    //url
    NSString *url = @"http://guoqin20181007.y1n2.cn/guoqin20181007/hot/hotkey";
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //加载数据
    [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        获取数据
        NSArray *data = responseObject[@"data"];
        hotSeaches = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in data) {
            NSString *str = [dict objectForKey:@"name"];
            
            [hotSeaches addObject:str];
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
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
