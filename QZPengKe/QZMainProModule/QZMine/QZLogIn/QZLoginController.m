//
//  QZLoginController.m
//  QZPengKe
//
//  Created by 000 on 18/1/9.
//  Copyright © 2018年 XiaoZuoXiaoYou. All rights reserved.
//

#import "QZLoginController.h"
#import <ShareSDK/ShareSDK.h>
@interface QZLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *sinaLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;

@end

@implementation QZLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)WeiBoBtnClick:(id)sender {
    
}
- (IBAction)WeChatBtnClick:(id)sender {
    //例如微信登录
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
        } else {
            NSLog(@"%@",error);
        }
    }];
}



@end
