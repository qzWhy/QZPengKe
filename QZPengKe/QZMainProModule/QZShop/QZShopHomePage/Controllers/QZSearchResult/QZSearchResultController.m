//
//  QZSearchResultController.m
//  QZPengKe
//
//  Created by 000 on 18/1/4.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZSearchResultController.h"
#import "QZSearchBarViewController.h"

@interface QZSearchResultController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation QZSearchResultController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createShoppingCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createShoppingCard
{
    //创建返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_full"] style:UIBarButtonItemStylePlain target:self action:@selector(touchBack:)];
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.leftBarButtonItem.tintColor = QZGrayColor;
    
    //购物车
    UIBarButtonItem *shoppingCardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_shoppingCart"] style:UIBarButtonItemStylePlain target:self action:@selector(openShoppingCardUI)];
    self.navigationItem.rightBarButtonItem = shoppingCardItem;
    self.navigationItem.rightBarButtonItem.tintColor = QZGrayColor;
}

- (void)touchBack:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[QZShop]]) {
//            <#statements#>
//        }
    }
}

@end
