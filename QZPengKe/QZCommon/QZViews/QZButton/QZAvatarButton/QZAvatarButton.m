//
//  QZAvatarButton.m
//  QZPengKe
//
//  Created by 000 on 18/1/9.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZAvatarButton.h"

@implementation QZAvatarButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 76/2;
    self.layer.masksToBounds = YES;
    
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.image = [UIImage imageNamed:@"avatar"];
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end
