//
//  ADWebVC.h
//  ADExample
//
//  Created by 马文帅 on 16/5/27.
//  Copyright © 2016年 ekeguan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZBaseViewController.h"

@interface ADWebVC : QZBaseViewController
/** webview要加载的url */
@property (nonatomic, copy) NSString *url;
@end
