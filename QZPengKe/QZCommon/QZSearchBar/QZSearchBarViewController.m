//
//  QZSearchBarViewController.m
//  QZPengKe
//
//  Created by 000 on 18/1/2.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZSearchBarViewController.h"
#import "QZShopHomePageCollectionViewModel.h"
#import "QZHomeSearchResultViewController.h"
#import "HYBNetworking.h"
#import "JCTagListView.h"
#import "MJExtension.h"
@interface QZSearchBarViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) JCTagListView *tagListView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) NSString *cnameStr;


@property (nonatomic, weak) UISearchBar *searchBar;

@end

@implementation QZSearchBarViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //-------键盘管理
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNav];
    
}

- (void)setupNav
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:QZBlackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataKeyword:@""];
    self.view.backgroundColor = QZKBACKGROUND_COLOR;
    self.navigationItem.hidesBackButton = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatSearchBar];
    
    
}

#pragma mark - 创建tagView
- (void)creatJCTagListView
{
    self.tagListView = [JCTagListView new];
    self.tagListView.backgroundColor = QZHEXCOLOR(@"f5f5f5");
    self.tagListView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.view addSubview:self.tagListView];
    
    self.tagListView.canSelectTags = YES;
    self.tagListView.tagStrokeColor = QZHEXCOLOR(@"cccccc");
    self.tagListView.tagTextColor = QZHEXCOLOR(@"999999");
    
    self.tagListView.tagCornerRadius = 2.0f;
}

- (void)initDataKeyword:(NSString *)keyword
{
    __weak typeof(self) weakSelf = self;
    NSString *url = HOST_MAIN_APP;
    NSString *paramStr = [NSString stringWithFormat:@"{\"keyword\":\"%@\"}",keyword];
    NSDictionary *param = @{@"CODE":@(123),@"JSON":paramStr};
    [HYBNetworking postWithUrl:url refreshCache:NO params:param success:^(id response) {
        if ([keyword isEqualToString:@""]) {
            weakSelf.dataSource = response[@"data"][@"keyword"];
            [weakSelf.tagListView.tags addObjectsFromArray:response[@"data"][@"keyword"]];
            NSLog(@"---->%@,,,,%@",self.tagListView.tags,response[@"data"][@"keyword"]);
            [weakSelf.tagListView setCompletionBlockWithSelected:^(NSInteger index) {
                NSLog(@"_______%ld____",(long)index);
//                
                [self.searchBar resignFirstResponder];
                
                [weakSelf initDataKeyword:QZUTF8_STRING(weakSelf.dataSource[index])];
//                NSLog(@"--%@",QZUTF8_STRING(weakSelf.dataSource[index]));
                
                self.cnameStr = weakSelf.dataSource[index];
                
            } ];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"=====>%@",self.tagListView.tags);
                [weakSelf.tagListView.collectionView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = @[].mutableCopy;
                
                [response[@"data"][@"info"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    QZShopHomePageCollectionViewModel *model = [QZShopHomePageCollectionViewModel mj_objectWithKeyValues:obj];
                    [array addObject:model];
                }];
                
                for (UIViewController *controller in weakSelf.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[QZSearchBarViewController class]]) {
                        //传搜索结果值
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"QZSearchResultArray" object:array];
                        [weakSelf.navigationController popToViewController:controller animated:NO];
                        return ;
                    }
                }
                
                if ([self.judgeVC isEqualToString:@"首页"]||
                    [self.judgeVC isEqualToString:@"教程"]) {
                    if ([self.judgeVC isEqualToString:@"教程"]) {
                        QZHomeSearchResultViewController *searchVC = [[QZHomeSearchResultViewController alloc] init];
                        searchVC.judgeVC = self.judgeVC;
                        searchVC.module = self.module;
                        searchVC.cid = self.cid;
                        searchVC.type = self.type;
                        searchVC.name = self.cnameStr;
                        [self.navigationController pushViewController:searchVC animated:YES];
                        return;
                    } else {
                        QZHomeSearchResultViewController *searchVC = [[QZHomeSearchResultViewController alloc] init];
                        searchVC.judgeVC= self.judgeVC;
                        searchVC.name = self.cnameStr;
                        [self.navigationController pushViewController:searchVC animated:YES];
                        return;
                    }
                }
                
                
            });
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)creatSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.placeholder = @"搜索";
    
    [searchBar setImage:[UIImage imageNamed:@"common_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    searchBar.delegate = self;
    
    [self fm_setCancelButtonTitle:@"取消"];
    
    searchBar.tintColor = QZGrayColor;
    
    [searchBar setTranslucent:YES];
    [searchBar showsCancelButton];
    [searchBar setShowsCancelButton:YES animated:YES];
    
    self.navigationItem.titleView = searchBar;
    
    [searchBar becomeFirstResponder];
    
    self.searchBar = searchBar;
    
}
- (void)fm_setCancelButtonTitle:(NSString *)title
{
    if (QZIOS_VERSION >= 9.0) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]]setTitle:title];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}
#pragma mark -- 搜索的代理方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - 点击搜索代理方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].copy;
    }
    return _dataSource;
}

- (JCTagListView *)tagListView
{
    if (!_tagListView) {
        self.tagListView = [JCTagListView new];
        self.tagListView.backgroundColor = QZHEXCOLOR(@"f5f5f5");
        self.tagListView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self.view addSubview:self.tagListView];
        
        self.tagListView.canSelectTags = YES;
        self.tagListView.tagStrokeColor = QZHEXCOLOR(@"cccccc");
        self.tagListView.tagTextColor = QZHEXCOLOR(@"999999");
        
        self.tagListView.tagCornerRadius = 2.0f;
    }
    return _tagListView;
}

@end
