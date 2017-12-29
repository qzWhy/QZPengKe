//
//  AppDelegate.h
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZLeftSlideViewController.h"
#import "QZNavigtaionController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

//-----侧滑------
@property (nonatomic, strong) QZLeftSlideViewController *leftSlideVC;

@property (nonatomic, strong) QZNavigtaionController*mainNavigationController;

@property (strong, nonatomic) UIWindow *window;


@end

