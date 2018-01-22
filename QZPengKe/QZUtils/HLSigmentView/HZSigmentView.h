//
//  HZSigmentView.h
//  HZSigmentView
//
//  Created by 王会洲 on 16/5/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#define DDMWIDTH [UIScreen mainScreen].bounds.size.width

#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height

#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#import <UIKit/UIKit.h>

@class HZSigmentView;

@protocol HZSigmentViewDelegate <NSObject>

@optional
/**
 *  点击横向点击事件
 *
 *  @param sengment sengment对象
 *  @param index    点击的索引
 */
-(void)segment:(HZSigmentView *)sengment didSelectColumnIndex:(NSInteger)index;

@end



@interface HZSigmentView : UIView

@property (nonatomic,strong) NSArray * titleArry;

/**
 *  未选中时的文字颜色
 */
@property (nonatomic,strong) UIColor * titleNomalColor;

/**
 *  选中时的文字颜色
 */
@property (nonatomic,strong) UIColor * titleSelectColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont  * titleFont;

/**
 *  默认选中的index=1，即第一个
 */
@property (nonatomic,assign) NSInteger defaultIndex;


@property (nonatomic, strong) NSString * text;

@property (nonatomic, weak) id<HZSigmentViewDelegate>  delegate;

-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height;


@end
