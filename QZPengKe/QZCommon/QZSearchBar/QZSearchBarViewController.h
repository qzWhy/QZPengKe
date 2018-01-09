//
//  QZSearchBarViewController.h
//  QZPengKe
//
//  Created by 000 on 18/1/2.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

/**
 *  搜索界面 
 */

#import <UIKit/UIKit.h>

@interface QZSearchBarViewController : UIViewController

//判断跳转的是哪个界面
@property (nonatomic, copy) NSString *judgeVC;
//如果是教程界面 需传哪个模块的值
@property (nonatomic, copy) NSString *module;
//对应品类的选择
@property (nonatomic, copy) NSString *cid;
//对应属性的选择
@property (nonatomic, copy) NSString *type;


@end
