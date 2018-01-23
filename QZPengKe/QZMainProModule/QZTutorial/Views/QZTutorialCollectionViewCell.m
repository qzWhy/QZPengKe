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
    UIImageView *bgImg = [[UIImageView alloc] init];
    bgImg.frame = self.bounds;
    [self addSubview:bgImg];
    self.bgImg = bgImg;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, self.width, 30*scaleH);
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *playBtn = [[UIButton alloc] init];
    playBtn.frame = CGRectMake(0, 0, 70*scaleW, 70*scaleH);
    playBtn.center = self.center;
    [self addSubview:playBtn];
    self.playBtn = playBtn;
    
    
}

@end
