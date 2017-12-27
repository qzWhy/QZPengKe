//
//  QZLeftSlideViewController.m
//  QZPengKe
//
//  Created by 000 on 17/12/27.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZLeftSlideViewController.h"
#import "QZTabBarController.h"

@interface QZLeftSlideViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat _scaleF; //实时横向位移
}

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, assign) CGFloat leftTableviewW;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation QZLeftSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithLeftView:(UIViewController *)leftVC andMainView:(UIViewController *)mainVC
{
    if (self = [super init]) {
        self.speedf = vSpeedFloat;
        
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        //滑动手势
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.mainVC.view addGestureRecognizer:self.pan];
        
        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
        
        self.leftVC.view.hidden = YES;
        
        [self.view addSubview:self.leftVC.view];
        
        //蒙板
        UIView *view = [[UIView alloc] init];
        view.frame = self.leftVC.view.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        self.contentView = view;
        [self.leftVC.view addSubview:view];
        
        //获取左侧tableView
//        for (UIView *obj in self.leftVC.view.subviews) {
//            if ([obj isKindOfClass:[UITableView class]]) {
//                self.leftTableView = (UITableView *)obj;
//            }
//        }
//        self.leftTableView.backgroundColor = [UIColor clearColor];
//        self.leftTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH - kMainPageDistance, SCREEN_HEIGHT);
//        //设置左侧tableView的初始位置和缩放系数
//        self.leftTableView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
//        self.leftTableView.center = CGPointMake(kLeftCenterX, SCREEN_HEIGHT * 0.5);
//        
//        [self.view addSubview:self.mainVC.view];
//        self.closed = YES;//初始时侧窗关闭
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftVC.view.hidden = NO;
}

#pragma mark - 滑动手势
//滑动手势
- (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:self.view];
    _scaleF = (point.x * self.speedf + _scaleF);
    
    BOOL needMoveWithTap = YES; // 是否还需要跟随手指移动
    if (((self.mainVC.view.x <= 0) && (_scaleF <= 0)) || ((self.mainVC.view.x >= (SCREEN_WIDTH - kMainPageDistance )) && (_scaleF >= 0))) {
        //边界值管控
        _scaleF = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap &&(panGesture.view.frame.origin.x >= 0) && (panGesture.view.frame.origin.x <= (SCREEN_WIDTH - kMainPageDistance))) {
        CGFloat panCenterX = panGesture.view.center.x + point.x *self.speedf;
        if (panCenterX < SCREEN_WIDTH *0.5 - 2) {
            panCenterX = SCREEN_WIDTH *0.5;
        }
        
        CGFloat panCenterY = panGesture.view.center.y;
        
        panGesture.view.center = CGPointMake(panCenterX, panCenterY);
        
        //scale 1.0~kMainzPageScale
        CGFloat scale = 1- (1 - kMainPageScale) * (panGesture.view.x /(SCREEN_WIDTH - kMainPageDistance));
        panGesture.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((SCREEN_WIDTH - kMainPageDistance) *0.5 - kLeftCenterX) *(panGesture.view.x / (SCREEN_WIDTH - kMainPageDistance));
        
        NSLog(@"%f",leftTabCenterX);
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftAlpha - kLeftAlpha * (panGesture.view.x/(SCREEN_WIDTH - kMainPageDistance));
        
        self.leftTableView.center = CGPointMake(leftTabCenterX, SCREEN_HEIGHT * 0.5);
        self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale, leftScale);
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (panGesture.view.x / (SCREEN_WIDTH - kMainPageDistance));
        self.contentView.alpha = tempAlpha;
    } else {
        //超出范围
        if (self.mainVC.view.x < 0) {
            [self closeLeftView];
            _scaleF = 0;
        } else if (self.mainVC.view.x > (SCREEN_WIDTH - kMainPageDistance)){
            [self openLeftView];
            _scaleF = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scaleF) > vCouldChangeDeckStateDistance)
        {
            if (self.closed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self.closed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scaleF = 0;
    }

}
#pragma mark - 单击手势
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded)) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        tap.view.center = CGPointMake(kScreenWidth / 2, SCREEN_HEIGHT/2);
        self.closed = YES;
        
        self.leftTableView.center = CGPointMake(kLeftCenterX, SCREEN_HEIGHT * 0.5);
        self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        self.contentView.alpha = kLeftAlpha;
        
        [UIView commitAnimations];
        _scaleF = 0;
        [self removeSingleTap];
    }
}
#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVC.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self.closed = YES;
    
    self.leftTableView.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
    self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
    self.contentView.alpha = kLeftAlpha;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,kMainPageScale,kMainPageScale);
    self.mainVC.view.center = kMainPageCenter;
    self.closed = NO;
    
    self.leftTableView.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, kScreenHeight * 0.5);
    self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}


#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [_mainVC.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.mainVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}
/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */

- (void)setPanEnabled: (BOOL) enabled
{
    [self.pan setEnabled:enabled];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(touch.view.tag == vDeckCanNotPanViewTag)
    {
        //        NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
        //        NSLog(@"响应侧滑");
        return YES;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (self.supportPoraitOnly) {
        return UIInterfaceOrientationPortrait == toInterfaceOrientation;
    }else
    {
        if ([self.mainVC isKindOfClass:[QZTabBarController class]])
        {
            QZTabBarController *tabVC = (QZTabBarController *)self.mainVC;
            
            if (tabVC.supportPortraitOnly) {
                return UIInterfaceOrientationPortrait == toInterfaceOrientation;
            }else {
                return [tabVC shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
            }
            
        }else
        {
            return UIInterfaceOrientationPortrait == toInterfaceOrientation;
        }
    }
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.supportPoraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    }else
    {
        if ([self.mainVC isKindOfClass:[QZTabBarController class]]) {
            QZTabBarController *tabVC = (QZTabBarController *)self.mainVC;
            if (tabVC.supportPortraitOnly) {
                return UIInterfaceOrientationMaskPortrait;
            }else {
                return [tabVC.selectedViewController supportedInterfaceOrientations];
            }
        }else
        {
            return UIInterfaceOrientationMaskPortrait;
        }
        
    }
}

// New Autorotation support.
- (BOOL)shouldAutorotate {
    
    
    if (self.supportPoraitOnly) {
        return NO;
    }else
    {
        if ([self.mainVC isKindOfClass:[QZTabBarController class]])
        {
            QZTabBarController *tabVC = (QZTabBarController *)self.mainVC;
            
            if (tabVC.supportPortraitOnly) {
                return NO;
            }else {
                return [tabVC.selectedViewController shouldAutorotate];
            }
            
        }else
        {
            return NO;
        }
    }
    
}

@end
