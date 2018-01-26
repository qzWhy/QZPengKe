//
//  QZHomePgDetailgrahicCell.m
//  QZPengKe
//
//  Created by 000 on 18/1/24.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZHomePgDetailgrahicCell.h"

@implementation QZHomePgDetailgrahicCell

+ (QZHomePgDetailgrahicCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"QZHomePgDetailgrahicCell";
    QZHomePgDetailgrahicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QZHomePgDetailgrahicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
