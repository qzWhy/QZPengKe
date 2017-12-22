//
//  QZNavigtaionController.m
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZNavigtaionController.h"

@interface QZNavigtaionController ()

@end

@implementation QZNavigtaionController

- (void)viewDidLoad {
    [super viewDidLoad];
    //改变navigtaionBar上字体颜色和字体
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:QZWhiteColor,NSForegroundColorAttributeName, QZFontSIYUAN_NORMAL(14),NSFontAttributeName, nil];
    [self.navigationBar setTitleTextAttributes:textAttributes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
