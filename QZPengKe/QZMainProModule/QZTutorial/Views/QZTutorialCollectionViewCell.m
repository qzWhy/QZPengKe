//
//  QZTutorialCollectionViewCell.m
//  QZPengKe
//
//  Created by 000 on 18/1/22.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZTutorialCollectionViewCell.h"

@implementation QZTutorialCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10*scaleH;
    UIImageView *bgImg = [[UIImageView alloc] init];
    bgImg.frame = self.frame;
    [self addSubview:bgImg];
    self.bgImg = bgImg;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, PicScalH - 60*scaleH, self.width, 60*scaleH);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIButton *playBtn = [[UIButton alloc] init];
    playBtn.frame = CGRectMake(0, 0, 70*scaleW, 70*scaleH);
    playBtn.center = self.center;
    [self addSubview:playBtn];
    self.playBtn = playBtn;
    
    
}

@end
