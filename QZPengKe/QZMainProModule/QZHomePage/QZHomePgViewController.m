//
//  QZHomePgViewController.m
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZHomePgViewController.h"
#import "ADWebVC.h"
#import "SDCycleScrollView.h"
#define QZkScale [UIScreen mainScreen].scale

#define kAdH 200   //后面要放在navgationBar里面
#define kAdH2 160
#define kTitleBtnCount 2
@interface QZHomePgViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation QZHomePgViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    
    if (url) {
        ADWebVC *adWebVC = [[ADWebVC alloc] init];
        adWebVC.url = url;
        [self.navigationController pushViewController:adWebVC animated:NO];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"key"];
    }
    //跳转广告页的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectJumpData:) name:@"HMjumpUrl" object:nil];
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 300);
    mainScrollView.delegate = self;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 300)];
    
    [mainScrollView addSubview:contentView];
    
    CGFloat adheight;
    if (QZkScale <= 2) {
        adheight = kAdH2;
    } else {
        adheight = kAdH;
    }
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, adheight) imageURLStringsGroup:self.imageArray];
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"Default"];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleScrollView.autoScrollTimeInterval = 2;
    __weak typeof(self) weakSelf = self;
    self.cycleScrollView.clickItemOperationBlock = ^(NSInteger A) {};
    
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
