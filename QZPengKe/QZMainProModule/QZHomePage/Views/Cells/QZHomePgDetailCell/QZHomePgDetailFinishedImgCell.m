//
//  QZHomePgDetailFinishedImgCell.m
//  QZPengKe
//
//  Created by 000 on 18/1/26.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZHomePgDetailFinishedImgCell.h"

@implementation QZHomePgDetailFinishedImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.finishImgView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (UIImageView *)finishImgView
{
    if (!_finishImgView) {
        _finishImgView = [UIImageView new];
        _finishImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, PicScalH);
    }
    return _finishImgView;
}

@end
