//
//  QZBaseViewController.m
//  QZPengKe
//
//  Created by 000 on 17/12/26.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZBaseViewController.h"

@interface QZBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation QZBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(touchBack:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 70, 44);
        UIImage *img = [UIImage imageNamed:@"back_full"];
        CGFloat width = img.size.width;
        CGFloat height = img.size.height;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        imgView.center = button.center;
        imgView.frame = CGRectMake(0, imgView.frame.origin.y, width, height);
        [button addSubview:imgView];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = back;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIColor *color = [UIColor blackColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,QZFontSIYUAN_NORMAL(17),NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)touchBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
