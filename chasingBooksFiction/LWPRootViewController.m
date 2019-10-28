//
//  LWPRootViewController.m
//  chasingBooksFiction
//
//  Created by iMacon 18/11/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import "LWPRootViewController.h"
#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define Iphone6Y(height)(float) (height)/1334*ScreenHeight
#define Iphone6X(width)(float) (width)/750*ScreenWidth
#define LWPColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorRGB(value) [UIColor colorWithRed:value/255.0 green:value/255.0 blue:value/255.0 alpha:1.0]
#define nvbH Iphone6Y(200)
#import "BookShelfViewController.h"
#import "StackRoomViewController.h"
#import "SearchViewController.h"
@interface LWPRootViewController (){
    UISegmentedControl *segment;
    UIScrollView *_scrollView;
}
@property(nonatomic,strong)UIViewController *fristVc;
@property(nonatomic,strong)UIViewController *secondVc;
@property(nonatomic,strong)UIViewController *currentVC;
@end

@implementation LWPRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //setting
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(Iphone6X(32), Iphone6Y(66), Iphone6X(40), Iphone6X(40))];
    setBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:setBtn];
    //massage
    UIButton *massageBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - Iphone6X(32) - Iphone6X(40), Iphone6Y(66), Iphone6X(40), Iphone6X(40))];
    massageBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:massageBtn];
    //追书小说
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - Iphone6X(137))/2, Iphone6Y(70), Iphone6X(137), Iphone6Y(33))];
    titleLabel.text = @"追书小说";
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.tintColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    //segment
    [self.navigationController.navigationBar setHidden:YES];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setSegmentedControl];
    [self build];
   
}
-(void)build
{
    
    
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = LWPColor(239, 235, 231);
    _scrollView.frame = CGRectMake(0,nvbH,SCREEN_WIDTH,SCREEN_HEIGHT-nvbH);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3,SCREEN_HEIGHT-nvbH);
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];
    
    
    BookShelfViewController *TableView = [[BookShelfViewController alloc]init];
    TableView.view.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-nvbH);
    
    [self addChildViewController:TableView];
    [_scrollView addSubview:TableView.view];
    
    
    
    StackRoomViewController *Table = [[StackRoomViewController alloc]init];
    CGRect aframe = CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT-nvbH);
    
    Table.view.frame =aframe;
    
//    [self addChildViewController:Table];
    [_scrollView addSubview:Table.view];
    
    SearchViewController *search = [[SearchViewController alloc]init];
    CGRect bframe = CGRectMake(SCREEN_WIDTH*2,0,SCREEN_WIDTH,SCREEN_HEIGHT-nvbH);
    
    search.view.frame =bframe;
    
    [self addChildViewController:search];
    [_scrollView addSubview:search.view];
}

-(void)setSegmentedControl{
    
    if (!segment) {
        
        segment = [[UISegmentedControl alloc]initWithItems:nil];
        segment.tintColor = UIColorRGB(52);
        segment.frame=CGRectMake(Iphone6X(194), Iphone6Y(132), ScreenWidth - Iphone6X(194)*2, Iphone6Y(50));
        [segment insertSegmentWithTitle:
         @"书架" atIndex: 0 animated: NO ];
        [segment insertSegmentWithTitle:
         @"书库" atIndex: 1 animated: NO ];
        [segment insertSegmentWithTitle:
         @"搜索" atIndex: 2 animated: NO ];
        
        //segment.segmentedControlStyle= UISegmentedControlStyleBar;
        
        segment.selectedSegmentIndex = 0;//设置默认选择项索引
        //设置跳转的方法
        [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segment];
    }
    
}
-(void)change:(UISegmentedControl *)Seg{
    switch (Seg.selectedSegmentIndex) {
            
        case 0:{
            [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * Seg.selectedSegmentIndex, 0) animated:NO];
            break;
        }
        case 1:{
            [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * Seg.selectedSegmentIndex, 0) animated:NO];
            break;
        }
        case 2:{
            
            [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * Seg.selectedSegmentIndex, 0) animated:NO];
            break;
        }
        default:
            break;
    }
}@end
