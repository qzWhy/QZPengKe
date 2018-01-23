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
#import "HYBNetworking.h"
#import "QZSearchBarViewController.h"
#import "MUCollectionViewFlowLayout.h"
#import "QZTuttorialHomePageModel.h"
#import "QZTutorialCollectionViewCell.h"
#define QZkScale [UIScreen mainScreen].scale

#define kAdH 200   //后面要放在navgationBar里面
#define kAdH2 160
#define kTitleBtnCount 2
@interface QZHomePgViewController ()<UIScrollViewDelegate,MUCollectionViewFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) UIButton *kxBtn;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UICollectionView *firstCollectionView;

@property (nonatomic, strong) UICollectionView *secondCollectionView;
//@property (nonatomic, strong) HZSigmentView *sigment;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, strong) NSMutableArray *pidArray;
@property (nonatomic, strong) NSMutableArray *typeArray;

///烤箱数组
@property (nonatomic, strong) NSMutableArray *KaoXiangArray;

///蒸箱数组
@property (nonatomic, strong) NSMutableArray *ZhengXiangArray;



@property (nonatomic, assign) BOOL isLoad;

@end

@implementation QZHomePgViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
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
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300*SCREEN_HEIGHT/1334.f) imageURLStringsGroup:self.imageArray];
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"Default"];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleScrollView.autoScrollTimeInterval = 2;
    __weak typeof(self) weakSelf = self;
    self.cycleScrollView.clickItemOperationBlock = ^(NSInteger A) {};
    [self.mainScrollView addSubview:self.cycleScrollView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.kxBtn.frame) + 20 *scaleH, SCREEN_WIDTH*2, SCREEN_HEIGHT)];
    [self.mainScrollView addSubview:bottomView];
    
    MUCollectionViewFlowLayout *flowLayout = [[MUCollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.columnCount = 1;
    
    UICollectionView *firstCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    firstCollectionView.dataSource = self;
    firstCollectionView.delegate = self;
    
    firstCollectionView.scrollEnabled = NO;
    firstCollectionView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:firstCollectionView];
    
    [firstCollectionView registerNib:[UINib nibWithNibName:@"QZTutorialCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HomePageCollectionCellReusedID];
    self.firstCollectionView = firstCollectionView;
    
    self.homePage = 1;
    
    [self creatSearchBar];
    
    [self initDataType:@"1"];
    
    //蒸烤分类
    [self creatSigment];
    
}
/**
 *  创建搜索框
 */

- (void)creatSearchBar
{
    UIView *searchBar = [UIView new];
    
    searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH - 32, 25);
    
    searchBar.layer.cornerRadius = 5;
    
    searchBar.backgroundColor = QZHEXCOLOR(@"f2f2f2");
    
    UIImageView *searchImage = [UIImageView new];
    searchImage.frame = CGRectMake(8, 6, 14, 14);
    searchImage.image = [UIImage imageNamed:@"common_search"];
    [searchBar addSubview:searchImage];
    
    UIButton *searchButton = [UIButton new];
    searchButton.frame = CGRectMake(30, 0, searchBar.width - 30, searchBar.height);
    [searchButton addTarget:self action:@selector(openSearchUI) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"搜索关键词" forState:UIControlStateNormal];
    [searchButton setTitleColor:QZLightGrayColor forState:UIControlStateNormal];
    searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    searchButton.titleLabel.font = [UIFont fontWithName:@"SourceHanSansCN-Extralight" size:14];
    [searchBar addSubview:searchButton];
    
    self.navigationItem.titleView = searchBar;
}
/**
 *  跳转搜索控制器
 */
- (void)openSearchUI
{
    QZSearchBarViewController *searchVC = [QZSearchBarViewController new];
    [self.navigationController pushViewController:searchVC animated:NO];
}

//创建sigment
- (void)creatSigment
{
    UIButton *KXBtn = [[UIButton alloc] init];
    KXBtn.frame = CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame) + 20*scaleH, 150*scaleW, 100*scaleH);
    KXBtn.centerX = SCREEN_WIDTH /4.f;
    [KXBtn setBackgroundImage:[UIImage imageNamed:@"KaoTitleImg"] forState:UIControlStateNormal];
    [KXBtn setBackgroundImage:[UIImage imageNamed:@"KaoTitleSeleImg"] forState:UIControlStateDisabled];
    KXBtn.tag = 1000;
    self.selectedBtn = KXBtn;
    KXBtn.enabled = NO;
    [KXBtn addTarget:self action:@selector(XBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:KXBtn];
    self.kxBtn = KXBtn;
    
    
    UIButton *ZXBtn = [[UIButton alloc] init];
    ZXBtn.frame = CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame) + 20*scaleH, 150*scaleW, 100*scaleH);
    ZXBtn.centerX = SCREEN_WIDTH*3 /4.f;
    ZXBtn.tag = 10001;
//    ZXBtn.enabled = NO;
    [ZXBtn setBackgroundImage:[UIImage imageNamed:@"ZhengTitleImg"] forState:UIControlStateNormal];
    [ZXBtn setBackgroundImage:[UIImage imageNamed:@"ZhengTitleSeleImg"] forState:UIControlStateDisabled];
    [ZXBtn addTarget:self action:@selector(XBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:ZXBtn];
}
- (void)XBtnClick:(UIButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
}

/**
 * 数据请求
 */

- (void)initDataType:(NSString *)type
{
    if (self.imageArray.count > 0) {
        [self.imageArray removeAllObjects];
    }
    NSString *page = [NSString stringWithFormat:@"%d",self.homePage];
    
    __weak QZHomePgViewController *weakSelf = self;
    if ([type isEqualToString:@"1"]) {
        self.type = @"1";
        NSString *url = [NSString stringWithFormat:HOST_MAIN_APP];
        NSString *paramStr = [NSString stringWithFormat:@"{\"uid\":\"%@\",\"limit\":\"%@\",\"page\":\"%@\",\"type\":\"%@\"}",@"3",@"10",page,type];
        NSDictionary *paramDict = @{@"CODE":@(156),@"JSON":paramStr};
        [HYBNetworking postWithUrl:url refreshCache:NO params:paramDict success:^(id response) {
            NSDictionary *dict = response;
            NSArray *array = [[dict objectForKey:@"data"] objectForKey:@"info"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            if (weakSelf.isLoad == NO) {
                [weakSelf.KaoXiangArray removeAllObjects];
            }
            
            for (int i = 0; i < array.count; i++) {
                QZTuttorialHomePageModel *model = [QZTuttorialHomePageModel mj_objectWithKeyValues:array[i]];
                [dataArray addObject:model];
            }
            [weakSelf.urlArray removeAllObjects];
            [weakSelf.pidArray removeAllObjects];
            [weakSelf.typeArray removeAllObjects];
            
            NSArray *imageArray = [[dict objectForKey:@"data"] objectForKey:@"ad"];
            for (NSInteger i = imageArray.count -1; i >= 0; i--) {
                NSDictionary *Dic = imageArray[i];
                [weakSelf.imageArray addObject:[Dic objectForKey:@"ad_pic"]];
                [weakSelf.urlArray addObject:[Dic objectForKey:@"ad_url"]];
                [weakSelf.pidArray addObject:[Dic objectForKey:@"pid"]];
                [weakSelf.typeArray addObject:[Dic objectForKey:@"type"]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.cycleScrollView.localizationImageNamesGroup = weakSelf.imageArray;
                if (weakSelf.isLoad == NO) {
                    self.KaoXiangArray = [NSMutableArray arrayWithArray:dataArray];
                } else{
                    [self.KaoXiangArray addObjectsFromArray:dataArray];
                }
                [self.firstCollectionView reloadData];
                
            });
            
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.firstCollectionView) {
        if ([self.type isEqualToString:@"1"]) {
            return self.KaoXiangArray.count;
        }
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QZTutorialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageCollectionCellReusedID forIndexPath:indexPath];
    QZTuttorialHomePageModel *model = [QZTuttorialHomePageModel new];
    if (collectionView == self.firstCollectionView) {
        if ([self.type isEqualToString:@"1"]) {
            model = [self.KaoXiangArray objectAtIndex:indexPath.item];
        }
    }
    QZkSDWebImage(cell.bgImg, model.img);
    cell.titleLabel.text = model.name;
    cell.playBtn.tag = indexPath.row;
    return cell;
}

#pragma mark - 代理方法
/**
 *  UIScrollView的代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
