//
//  QZShopHomePageCollectionViewModel.h
//  QZPengKe
//
//  Created by 000 on 18/1/4.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZShopHomePageCollectionViewModel : NSObject

@property (nonatomic, copy) NSString *iscollect;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *price;
//商品类型 1 秒杀 2 满减
@property (nonatomic, copy) NSString *type;
//满减活动的id
@property (nonatomic, copy) NSString *mid;
//满减活动的名字
@property (nonatomic, copy) NSString *mname;

@end
