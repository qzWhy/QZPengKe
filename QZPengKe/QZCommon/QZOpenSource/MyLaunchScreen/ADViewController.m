//
//  ADViewController.m
//  ADExample
//
//  Created by 马文帅 on 16/5/27.
//  Copyright © 2016年 ekeguan. All rights reserved.
//

#import "ADViewController.h"
#import "UIImageView+WebCache.h"
#import "HYBNetworking.h"
//#import "HLLoginOperation.h"
static const CGFloat skipButtonRadius = 20;

//static NSString *const HOST_MAIN_APP = @"http://app.depelec.com.cn/index.php/Yapi";

@interface ADViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) UIView *skipButtonBackgroundView;
@property (nonatomic, strong) ADItem *adItem;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger leftTime;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

//@property (nonatomic, strong) HLLoginOperation *operation;

@property (nonatomic, assign) BOOL isNetworkginFail;
@property (nonatomic, assign) BOOL isNetworkginFailStatu;
@end

@implementation ADViewController
- (BOOL)prefersStatusBarHidden {
    return YES;
}

//- (HLLoginOperation *)operation {
//    if (!_operation) {
//        _operation = [HLLoginOperation new];
//    }
//    return _operation;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isNetworkginFailStatu = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.adImageView];
    [self.adImageView addSubview:self.skipButtonBackgroundView];
    [self.adImageView addSubview:self.skipButton];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkginFail) name:@"HLNetworkginFail" object:nil];
}

- (void)networkginFail {
    _isNetworkginFail = YES;
    
    if (_isNetworkginFail && _isNetworkginFailStatu) {
        _isNetworkginFailStatu = NO;
        [self loadData];
    }
//    [self checkStatus:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadData {
    /* 大家正式使用时，打开这段注释,写上自己的接口地址
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ADItem *item = [ADItem mj_objectWithKeyValues:responseObject];
        if (!item.adURL.length) {
            [self.adImageView removeGestureRecognizer:self.tapGesture];
        }
        self.adItem = item;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkStatus:nil];
    }];
     */
    
    if (!_isNetworkginFailStatu) {
        ADItem *item = [[ADItem alloc] init];
        item.imageURL = @"";
        item.second = @"3";
        item.visiable = YES;
        item.adURL = @"";
        self.adItem = item;
    } else {
        NSString *url = [NSString stringWithFormat:@"%@",HOST_MAIN_APP];
        NSString *paramStr = [NSString stringWithFormat:@"{\"type\":\"%@\"}",@"1"];
        NSDictionary *param = @{@"CODE":@(158),@"JSON":paramStr};
        [HYBNetworking postWithUrl:url refreshCache:NO params:param success:^(id result) {
            NSLog(@"%@",result);
            
            ADItem *item = [[ADItem alloc] init];
            item.imageURL = result[@"data"][@"ad_pic"];
            
            item.second = @"3";
            item.visiable = YES;
            item.adURL = result[@"data"][@"ad_url"];
            if (!item.adURL.length) {
                [self.adImageView removeGestureRecognizer:self.tapGesture];
            }
            self.adItem = item;
        
            
        } fail:^(NSError *error) {
            NSLog(@"error");
        }];
//        [self.operation advertisementIsTurnChrysanthemum:NO type:@"1" completeBlock:^(id result, NSError *error) {
//            //result[@"data"][@"ad_pic"]
//            
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //            ADItem *item = [ADItem mj_objectWithKeyValues:result];
//                //            if (!item.adURL.length) {
//                //                [self.adImageView removeGestureRecognizer:self.tapGesture];
//                //            }
//                //            self.adItem = item;
//                
//                ADItem *item = [[ADItem alloc] init];
//                item.imageURL = result[@"data"][@"ad_pic"];
//                
//                item.second = @"3";
//                item.visiable = YES;
//                item.adURL = result[@"data"][@"ad_url"];
//                if (!item.adURL.length) {
//                    [self.adImageView removeGestureRecognizer:self.tapGesture];
//                }
//                self.adItem = item;
//            });
//        }];
    }
    
    
    
    
//    //因为没有接口，写个model测试下，正式使用时删除以下代码即可
//    ADItem *item = [[ADItem alloc] init];
//    item.imageURL = @"http://img.zcool.cn/community/01fe1757112d2d6ac72513436f2e6f.jpg";
//    item.second = @"3";
//    item.visiable = YES;
//    item.adURL = @"https://m.baidu.com";
//    self.adItem = item;
}

- (void)skipButtonPressed {
    [self checkStatus:nil];
}

- (void)tapAdImageView {
    
    if (!_isNetworkginFailStatu) {
        return;
    }
    
    [self checkStatus:self.adItem];
}

- (void)addLayer:(NSInteger)time {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, skipButtonRadius*2, skipButtonRadius*2)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 2;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = time+0.15;
    [layer addAnimation:animation forKey:@""];
    [self.skipButton.layer addSublayer:layer];
}

#pragma mark - private
- (void)counter {
    --self.leftTime;
    if (self.leftTime <= 0) {
        [self checkStatus:nil];
    }
}

- (void)checkStatus:(ADItem *)item {
    if (self.completion) {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.completion(item);
    }
}

- (UIImage *)getLaunchImage {
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    NSString *launchImage = nil;
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, self.view.frame.size)) {
            launchImage = dict[@"UILaunchImageName"];
            return [UIImage imageNamed:launchImage];
        }
    }
    return nil;
}

#pragma mark - setter
- (void)setAdItem:(ADItem *)adItem {
    _adItem = adItem;
    if (adItem.visiable) {
        self.adImageView.hidden = NO;
        __weak __typeof(self) weakSelf = self;
        
        if (!_isNetworkginFailStatu) {
            
            
//            self.adImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, HLkScreenHeight);
//            self.adImageView.image = HLPlaceholderImage;
            
            _adImageView.contentMode = UIViewContentModeScaleToFill;
            
            self.leftTime = [adItem.second integerValue];
            [self addLayer:self.leftTime];
            self.skipButton.hidden = NO;
            self.skipButtonBackgroundView.hidden = NO;
            if (!self.timer) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(counter) userInfo:nil repeats:YES];
            }
        } else {
            [self.adImageView sd_setImageWithURL:[NSURL URLWithString:adItem.imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    __strong __typeof(weakSelf) strongSelf = weakSelf;
                    CGFloat adImageViewHeight = (strongSelf.view.frame.size.width * image.size.height)/image.size.width;
                    strongSelf.adImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, adImageViewHeight);
                    
                    self.leftTime = [adItem.second integerValue];
                    [self addLayer:self.leftTime];
                    self.skipButton.hidden = NO;
                    self.skipButtonBackgroundView.hidden = NO;
                    if (!self.timer) {
                        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(counter) userInfo:nil repeats:YES];
                    }
                }
            }];
        }
        
    } else {
        [self checkStatus:nil];
    }
}

#pragma mark - lazy init
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[self getLaunchImage]];
        _backgroundImageView.frame = self.view.bounds;
    }
    return _backgroundImageView;
}

- (UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        _adImageView.frame = self.view.bounds;
        _adImageView.userInteractionEnabled = YES;
        _adImageView.contentMode = UIViewContentModeScaleAspectFit;
        _adImageView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdImageView)];
        [_adImageView addGestureRecognizer:tap];
        self.tapGesture = tap;
    }
    return _adImageView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        CGFloat centerX = self.view.frame.size.width-skipButtonRadius*2;
        CGFloat centerY = skipButtonRadius*2;
        
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        _skipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skipButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.hidden = YES;
        
        _skipButton.bounds = CGRectMake(0, 0, skipButtonRadius*2, skipButtonRadius*2);
        _skipButton.center = CGPointMake(centerX, centerY);
    }
    return _skipButton;
}

- (UIView *)skipButtonBackgroundView {
    if (!_skipButtonBackgroundView) {
        CGFloat centerX = self.view.frame.size.width-skipButtonRadius*2;
        CGFloat centerY = skipButtonRadius*2;
        
        _skipButtonBackgroundView = [[UIView alloc] init];
        _skipButtonBackgroundView.backgroundColor = [UIColor blackColor];
        _skipButtonBackgroundView.alpha = 0.5;
        _skipButtonBackgroundView.layer.cornerRadius = skipButtonRadius;
        _skipButtonBackgroundView.layer.masksToBounds = YES;
        _skipButtonBackgroundView.hidden = YES;
        
        _skipButtonBackgroundView.bounds = CGRectMake(0, 0, skipButtonRadius*2, skipButtonRadius*2);
        _skipButtonBackgroundView.center = CGPointMake(centerX, centerY);
    }
    return _skipButtonBackgroundView;
}

@end
