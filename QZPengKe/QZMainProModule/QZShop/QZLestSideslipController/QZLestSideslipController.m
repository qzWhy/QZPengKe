//
//  QZLestSideslipController.m
//  QZPengKe
//
//  Created by 000 on 17/12/28.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZLestSideslipController.h"
#import "QZLestSideslipFirstCell.h"
#import "QZLestSideslipSecondCell.h"
#import "HYBNetworking.h"
#import "AppDelegate.h"
@interface QZLestSideslipController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet QZTableView *classificationTableView;
@property (weak, nonatomic) IBOutlet QZTableView *subClassificationTableView;
@property (nonatomic, strong) NSMutableArray *firstCellBackColorArray;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSArray *subDataSource;

@end

@implementation QZLestSideslipController

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].copy;
    }
    return _dataSource;
}

- (NSArray *)subDataSource
{
    if (!_subDataSource) {
        _subDataSource = @[].copy;
    }
    return _subDataSource;
}

- (NSMutableArray *)firstCellBackColorArray
{
    if (!_firstCellBackColorArray) {
        _firstCellBackColorArray = @[].mutableCopy;
    }
    return _firstCellBackColorArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self dataInit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = QZKBACKGROUND_COLOR;
    
    [self setTableView];
}

- (void)dataInit
{
    __weak typeof(self) aSelf = self;
    NSString *apiUrl = [NSString stringWithFormat:@"%@", HOST_MAIN_APP];
    NSDictionary *param = @{@"CODE":@(108),@"JSON":@""};
    [HYBNetworking postWithUrl:apiUrl refreshCache:NO params:param success:^(id response) {
        NSLog(@"%@---%@",response,response[@"data"][@"info"]);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setTableView
{
    self.classificationTableView.delegate = self;
    self.classificationTableView.dataSource = self;
    self.classificationTableView.tag = 110011;
    self.classificationTableView.rowHeight = 40;
    self.classificationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.subClassificationTableView.delegate = self;
    self.subClassificationTableView.dataSource = self;
    self.subClassificationTableView.tag = 911119;
    self.subClassificationTableView.rowHeight = 40;
    self.subClassificationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 110011) {
        return self.dataSource.count;
    } else {
        return self.subDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 110011) {
        static NSString *cellIdentifier = @"QZLestSideslipFirstCell";
        QZLestSideslipFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[QZLestSideslipFirstCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        if ([self.firstCellBackColorArray[indexPath.row] isEqualToString:@"white"]) {
            cell.backgroundColor = QZWhiteColor;
        } else {
            cell.backgroundColor = QZKBACKGROUND_COLOR;
        }
        //    [cell.imageView ]
        //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:QZPlaceholderImage];
        QZkSDWebImage(cell.imageView, self.dataSource[indexPath.row][@"icon"]);
        cell.nameLabel.text = self.dataSource[indexPath.row][@"name"];
        return cell;
    } else {
        static NSString *Identifier = @"QZLestSideslipSecondCell";
        QZLestSideslipSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            cell = [[QZLestSideslipSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.backgroundColor = QZWhiteColor;
        cell.nameLabel.text = self.subDataSource[indexPath.row][@"name"];
        
        if (self.subDataSource.count - 1 == indexPath.row) {
            cell.lineView.hidden = YES;
        } else {
            cell.lineView.hidden = NO;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 110011) {
        __weak typeof(self) weakSelf = self;
        
        if ([self.dataSource[indexPath.row][@"cate"] isKindOfClass:[NSArray class]]) {
            self.subDataSource = self.dataSource[indexPath.row][@"cate"];
        } else {
            self.subDataSource = @[].copy;
        }
        
        [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                weakSelf.firstCellBackColorArray[indexPath.row] = @"white";
            } else {
                weakSelf.firstCellBackColorArray[idx] = @"gray";
            }
        }];
        
        [self.classificationTableView reloadData];
        [self.subClassificationTableView reloadData];
        
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate.leftSlideVC closeLeftView];//关闭左侧抽屉
        
        NSDictionary *dic = self.subDataSource[indexPath.row];
        //跳转界面了
        
        
    }
}

@end
