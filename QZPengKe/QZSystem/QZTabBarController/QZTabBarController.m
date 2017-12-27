//
//  QZTabBarController.m
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZTabBarController.h"
#import "UIColor+Expanded.h"

@interface QZTabBarController ()

@end

@implementation QZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = QZ_TABBAR_TINTCOLOR;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  ios6对于app屏幕朝向支持以及自动旋转屏时的处理方式的变动
 ＊
 ＊  iOS6下第一个方法不会再被调用
 **/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationPortrait == toInterfaceOrientation;
    } else {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
}
/**
 *  取而代之的是这两个组合
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
}

- (BOOL)shouldAutorotate
{
    if (self.supportPortraitOnly) {
        return NO;
    } else {
        return [self.selectedViewController shouldAutorotate];
    }
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.tabBar.frame;
    if ([UIScreen mainScreen].scale<=2) {
        frame.size.height = 49;
    } else {
        frame.size.height = 49;
    }
    
    frame.origin.y = self.view.frame.size.height -frame.size.height;
    self.tabBar.frame = frame;
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
//    self.tabBar.barStyle = UIBarStyleBlack;//此处需要设置barStyle，否则颜色会分上下两层
}

@end
