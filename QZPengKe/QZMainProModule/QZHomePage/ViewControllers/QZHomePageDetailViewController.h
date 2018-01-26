//
//  QZHomePageDetailViewController.h
//  QZPengKe
//
//  Created by 000 on 18/1/24.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZBaseViewController.h"

@interface QZHomePageDetailViewController : QZBaseViewController

@property (nonatomic, copy) NSString *status;//踩和咱的状态
@property (nonatomic, copy) NSString *type;//类型（视频图文）
@property (nonatomic, copy) NSString *collectStatus;//收藏状态
@property (nonatomic, copy) NSString *sharePage; //分享页面
@property (nonatomic, copy) NSString *useid;//用户id
@property (nonatomic, copy) NSString *zan;//赞的个数
@property (nonatomic, copy) NSString *cai;//踩的个数


@end
