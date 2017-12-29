//
//  QZTableView.m
//  QZPengKe
//
//  Created by 000 on 17/12/27.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZTableView.h"

@implementation QZTableView

- (void)setExtraCellLineHidden
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = QZ_TABBAR_TINTCOLOR;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (DEVICE_VERSION >= 8.0) {
        self.layoutMargins = UIEdgeInsetsZero;
    }
    [self setExtraCellLineHidden];
    
}

@end
