//
//  QZTableView.m
//  QZPengKe
//
//  Created by 000 on 17/12/27.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZTableView.h"

@implementation QZTableView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = QZKBACKGROUND_COLOR;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

@end
