//
//  QZCollectionViewCell.h
//  QZPengKe
//
//  Created by 000 on 18/1/3.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
