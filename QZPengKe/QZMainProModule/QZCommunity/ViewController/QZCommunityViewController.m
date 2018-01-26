//
//  QZCommunityViewController.m
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZCommunityViewController.h"
#import "QZCommunityHomePgHotCell.h"
@interface QZCommunityViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, weak) UITableView *communityTableView;
//model数组
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
//首页返回数据
@property (nonatomic, strong) NSDictionary *dataSource;

@end

@implementation QZCommunityViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"社区";
    
    [self initUI];
    
}

- (void)initUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *2, 0);
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [_scrollView setBounces:NO];
    _scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];
    
    UITableView *communitityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.communityTableView = communitityTableView;
    
    communitityTableView.showsVerticalScrollIndicator = NO;
    [communitityTableView registerNib:[UINib nibWithNibName:@"QZCommunityHomePgHotCell" bundle:nil] forCellReuseIdentifier:@"QZCommunityHomePgHotCell"];
    communitityTableView.dataSource = self;
    communitityTableView.delegate = self;
    communitityTableView.tag = 10087;
    communitityTableView.separatorStyle = 0;
    [_scrollView addSubview:communitityTableView];
}
#pragma mark - UITableViewDelegate
//返回区做头视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10087) {
        return self.dataSourceArray.count + 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10087) {
        if (indexPath.row == 0) {
            QZCommunityHomePgHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QZCommunityHomePgHotCell"];
            //热门达人头像
            NSArray *array = [[self.dataSource objectForKey:@"data"] objectForKey:@"userPic"];
            return cell;
        }
    }
    return nil;
}

#pragma mark - 热门达人头像
- (void)getImageViewOncell:(UITableView *)cell imageArray:(NSArray *)array
{
//    for (int i = 0; i < array.count; i++) {
//        UIImageView *headerImageView = [UIImageView new];
//        headerImageView.frame = CGRectMake(SCREEN_WIDTH - , <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    }
}

#pragma mark - 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10087) {
        if (indexPath.row == 0) {
            return 30;
        }
    }
    return 0;
}

#pragma mark - lizy load
- (NSDictionary *)dataSource
{
    if (!_dataSource) {
        _dataSource = @{}.copy;
    }
    return _dataSource;
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}
@end
