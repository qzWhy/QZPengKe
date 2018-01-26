//
//  QZHomePageDetailViewController.m
//  QZPengKe
//
//  Created by 000 on 18/1/24.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZHomePageDetailViewController.h"
#import "QZHomePageDetailgraphicCell.h"
#import "QZHomePgDetailFinishedImgCell.h"
#import "HYBNetworking.h"
#define topHeight (96*scaleH)
#define backBtnH  (60*scaleW)

@interface QZHomePageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;//视频播放放在头视图中
@property (nonatomic, strong) UIImageView *headerImgView;//头视图中的图片
//接口返回数据
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSDictionary *dataSourceDic;

@property (nonatomic, strong) UIButton *collectBtn;

@end

@implementation QZHomePageDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self initData];
}

- (void)initUI
{
    //顶部
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 20, SCREEN_WIDTH, topHeight);
    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIButton *backbtn = [[UIButton alloc] init];
    backbtn.frame = CGRectMake(20*scaleW, ((topHeight-backBtnH)*0.5), backBtnH, backBtnH);
    backbtn.backgroundColor = [UIColor yellowColor];
    [backbtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backbtn];

    [self.view addSubview:self.tableView];
//    self.tableView = [[UITableView alloc] init];
//    self.tableView.style = UITableViewStylePlain;
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QZHomePageDetailgraphicCell" bundle:nil] forCellReuseIdentifier:@"QZHomePageDetailgraphicCell"];
    [self.tableView registerClass:[QZHomePgDetailFinishedImgCell class] forCellReuseIdentifier:@"QZHomePgDetailFinishedImgCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellReuseIdentifier:@""];
//    [self.tableView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellReuseIdentifier:@""];
//    [self.tableView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellReuseIdentifier:@""];
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(topHeight);
    }];
}

#pragma mark - 网络请求
- (void)initData
{
    __weak typeof(self)weakSelf = self;
    NSString *url = [NSString stringWithFormat:HOST_MAIN_APP];
    NSString *paramStr = [NSString stringWithFormat:@"{\"uid\":\"%@\",\"id\":\"%@\",\"type\":\"%@\"}",@"3",@"425",@"1"];
    NSDictionary *param = @{@"CODE":@(148),@"JSON":paramStr};
    
    [HYBNetworking postWithUrl:url refreshCache:NO params:param success:^(id response) {
        NSDictionary *dict = response;
        weakSelf.dataSourceDic = [response objectForKey:@"data"];
        
        weakSelf.status = [NSString stringWithFormat:@"%@",[weakSelf.dataSourceDic objectForKey:@"status"]];
        weakSelf.collectStatus = [NSString stringWithFormat:@"%@",[weakSelf.dataSourceDic objectForKey:@"iscollect"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.collectStatus isEqualToString:@"1"]) {
//                [weakSelf.collecti]
            }
            [weakSelf.tableView reloadData];
            if ([weakSelf.dataSourceDic[@"url"] isEqualToString:@""]) {
                QZkSDWebImage(weakSelf.headerImgView, [weakSelf.dataSourceDic objectForKey:@"img"]);
            } else {
                QZkSDWebImage(weakSelf.headerImgView, [weakSelf.dataSourceDic objectForKey:@"img"]);
                NSLog(@"%s",__func__);
            }
        });
    } fail:^(NSError *error) {
        NSLog(@"%s",__func__);
    }];
}

#pragma mark - 方法
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2){
        return 1;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QZHomePageDetailgraphicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QZHomePageDetailgraphicCell"];
        cell.titleLabel.text = @"小佐小佑";
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *ID = @"ID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                cell.backgroundColor = [UIColor whiteColor];
            }
            NSArray *array = [self.dataSourceDic objectForKey:@"food"];
            [self getTabView:cell.contentView array:array];
            return cell;
        }
    } else if (indexPath.section == 2) {
        static NSString *cellidentifier = @"QZHomePgDetailFinishedImgCell";
        QZHomePgDetailFinishedImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        QZkSDWebImage(cell.finishImgView, [self.dataSourceDic objectForKey:@"img"]);
        return cell;

    } else if (indexPath.section == 3) {
            }
    return nil;
    
}

#pragma mark - 创建表格
- (void)getTabView:(UIView *)contentView array:(NSArray *)array
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 8*scaleH, SCREEN_WIDTH, array.count*80*scaleH);
    UILabel *lab = [UILabel new];
    lab.frame = CGRectMake(8, 24*scaleH, SCREEN_WIDTH - 16, 32*scaleH);
    lab.textAlignment = NSTextAlignmentCenter;
    NSString *textStr = @"食材清单";
    
    //下划线
    NSDictionary *attributDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:textStr attributes:attributDic];
    lab.attributedText = attribtStr;
    lab.textColor = QZHEXCOLOR(@"303030");
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0;
    view.layer.borderWidth = 0.0;
    view.layer.borderColor = [QZHEXCOLOR(@"e3e8e8") CGColor];
    [view addSubview:lab];
    
    //创建横向的分割线及数据展示
    for (int row = 0; row < array.count; row++) {
        //分割线
        UIView *partitionView = [[UIView alloc] initWithFrame:CGRectMake(8*scaleW, 80*scaleH*(row+1), SCREEN_WIDTH - 16, 1)];
        partitionView.backgroundColor = QZHEXCOLOR(@"e8e8e8");
        
        NSString *pidString = @"0";
        if (![array[row] isKindOfClass:[NSNull class]]) {
            //创建 选择的背景方块
            pidString = (NSString *)[array[row] objectForKey:@"pid"];
        }
        if ([pidString isKindOfClass:[NSNull class]]) {
            pidString = @"0";
        }
        
        NSString *priceStr = @"0";
        if (![array[row] isKindOfClass:[NSNull class]]) {
            //创建 选择的背景方块
            priceStr = (NSString *)[array[row] objectForKey:@"price"];
        }
        
        if ([priceStr isKindOfClass:[NSNull class]]) {
            priceStr = @"0";
        }
        
        if (![pidString isEqualToString:@"0"] &&![priceStr isEqualToString:@"0"]) {
            UIImageView *bgImgView = [UIImageView new];
            bgImgView.frame = CGRectMake(0, 80*scaleH*(row+1), SCREEN_WIDTH, 78*scaleH);
            bgImgView.image = [UIImage imageNamed:@""];
            bgImgView.userInteractionEnabled = YES;
            bgImgView.tag = row;
            
            [view addSubview:bgImgView];
        }
        
        //数据
        UILabel *foodName = [UILabel new];
        foodName.frame = CGRectMake(30*scaleW, 80*scaleH*(row+1)+1, SCREEN_WIDTH/2.0, 78*scaleH);
        if (![[array[row] objectForKey:@"attr"] isKindOfClass:[NSNull class]]) {
            foodName.text = [array[row] objectForKey:@"attr"];
        } else {
            foodName.text = @"";
        }
        foodName.font = [UIFont systemFontOfSize:14];
        foodName.textColor = QZHEXCOLOR(@"666666");
        
        
        UILabel *weightLab = [UILabel new];
        weightLab.frame = CGRectMake((SCREEN_WIDTH/3.0), 80*scaleH*(row+1)+1, SCREEN_WIDTH/3.0, 78*scaleH);
        if (![[array[row] objectForKey:@"attr_value"] isKindOfClass:[NSNull class]]) {
            weightLab.text = [array[row] objectForKey:@"attr_value"];
        } else {
            weightLab.text = @"";
        }
        weightLab.textColor = QZHEXCOLOR(@"666666");
        weightLab.font = [UIFont systemFontOfSize:14];
        weightLab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:weightLab];
        
        
        [view addSubview:foodName];
        [view addSubview:partitionView];
        [contentView addSubview:view];
    }
}

#pragma mark - 返回行高 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180 ;
    } else if (indexPath.section == 1) {
        NSArray *array = [self.dataSourceDic objectForKey:@"food"];
        return (array.count)*80*scaleH;
    } else if (indexPath.section == 2) {
        return PicScalH;
    }
    return 0;
}
#pragma -mark-动态行高
-(CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]} context:nil];
    return rectToFit.size.height;
}
#pragma mark - 区尾间隔view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80*scaleH);
    view.backgroundColor = QZHEXCOLOR(@"f1eeee");
    return view;
}
#pragma mark - 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8*scaleH;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + topHeight, SCREEN_WIDTH, SCREEN_HEIGHT - topHeight*2-20) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, PicScalH);
        _headerImgView = [UIImageView new];
        _headerImgView.frame = _headerView.frame;
        
        [_headerView addSubview:_headerImgView];
    }
    return _headerView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (NSDictionary *)dataSourceDic
{
    if (!_dataSourceDic) {
        _dataSourceDic = @{}.copy;
    }
    return _dataSourceDic;
}
@end
