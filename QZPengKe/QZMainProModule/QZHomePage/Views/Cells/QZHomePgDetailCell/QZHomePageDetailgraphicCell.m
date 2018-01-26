//
//  QZHomePageDetailgraphicCell.m
//  QZPengKe
//
//  Created by 000 on 18/1/24.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZHomePageDetailgraphicCell.h"

@implementation QZHomePageDetailgraphicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImage.clipsToBounds = YES;
    self.headerImage.layer.cornerRadius = 50/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
