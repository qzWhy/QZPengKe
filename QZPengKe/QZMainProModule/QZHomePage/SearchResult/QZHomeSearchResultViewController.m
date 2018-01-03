//
//  QZHomeSearchResultViewController.m
//  QZPengKe
//
//  Created by 000 on 18/1/3.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZHomeSearchResultViewController.h"
#import "QZCollectionViewCell.h"
#import "QZHomePgViewController.h"
#import "QZTutorialHomePageController.h"
#import "QZSearchBarViewController.h"

@interface QZHomeSearchResultViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_array;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *tutroialSearchArray;

@end

@implementation QZHomeSearchResultViewController

- (NSMutableArray *)tutroialSearchArray
{
    if (!_tutroialSearchArray) {
        _tutroialSearchArray = [NSMutableArray array];
    }
    return _tutroialSearchArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.layout.itemSize = CGSizeMake((SCREEN_WIDTH - 16)/2, 230);
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"homepageCollectionID"];
    self.collectionView.backgroundColor = QZKBACKGROUND_COLOR;
    
    _array = @[@"QZHomePage_prise",@"QZHomePage_comments",@"QZHomePage_share",@"QZHomePage_collection"];
    
    [self createShoppingCard];
    
}

- (void)createShoppingCard
{
    //创建返回按钮123
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_full"] style:UIBarButtonItemStylePlain target:self action:@selector(touchBack:)];
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.leftBarButtonItem.tintColor = QZGrayColor;
}

- (void)touchBack:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[QZHomePgViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        } else if ([controller isKindOfClass:[QZTutorialHomePageController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
}

#pragma mark - 创建搜索按钮
- (void)creatSearchBar
{
    UIView *searchBar = [UIView new];
    searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH - 100, 25);
    
    searchBar.layer.cornerRadius = 5;
    searchBar.backgroundColor = QZHEXCOLOR(@"f2f2f2");
    
    UIImageView *searchImage = [UIImageView new];
    searchImage.frame = CGRectMake(8, 6, 14, 14);
    searchImage.image = [UIImage imageNamed:@"common_search"];
    searchImage.userInteractionEnabled = YES;
    
    [searchBar addSubview:searchImage];
    
    UIButton *searchButton = [UIButton new];
    searchButton.frame = CGRectMake(30, 0, searchBar.width - 30, searchBar.height);
    [searchButton addTarget:self action:@selector(openSearchUI) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"" forState:UIControlStateNormal];
    [searchButton setTitleColor:QZLightGrayColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont fontWithName:@"SourceHanSanCN-ExtraLight" size:14];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [searchButton addSubview:searchButton];
    
    self.navigationItem.titleView = searchBar;
}

- (void)openSearchUI
{
    QZSearchBarViewController *searchVC = [QZSearchBarViewController new];
    searchVC.judgeVC = @"首页";
    [self.navigationController pushViewController:searchVC animated:NO];
}


@end
