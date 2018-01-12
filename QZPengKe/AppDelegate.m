//
//  AppDelegate.m
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "AppDelegate.h"
#import "HYBNetworking.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台 （对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK
#import "WeiboSDK.h"
//截屏分享
#import "MobScreenshotCenter.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 通常放在appdelegate就可以了
    [HYBNetworking updateBaseUrl:@"http://app.depelec.com.cn/index.php/Yapi"];
    [HYBNetworking enableInterfaceDebug:YES];
    
    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
//    [HYBNetworking configRequestType:kHYBRequestTypePlainText
//                        responseType:kHYBResponseTypeJSON
//                 shouldAutoEncodeUrl:YES
//             callbackOnCancelRequest:NO];
    // 设置GET、POST请求都缓存
    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
    //开启截屏分享监听 与ShareSDK本身无关
    [[MobScreenshotCenter shareInstance] start];
    [self registerShareSDK];
    return YES;
}
/**
 *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
 *  在将生成的AppKey传入到此方法中。
 *  方法中的第二个第三个参数为需要链接社交平台SDK时触发
 *  在此时间中写入连接代码。 第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
 *  如果您使用的是服务端托管平台信息时，第二、四项参数可以穿入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
 */
- (void)registerShareSDK
{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType) {
                                                case SSDKPlatformTypeWechat:
                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [ShareSDKConnector connectWeChat:[QQApiInterface class]];
                                                    break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                    [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                            switch (platformType) {
                                                case SSDKPlatformTypeSinaWeibo:
                                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                                    /*
                                                     echo 'ibase=10;obase=16;1105592430'|bc
                                                     41E6006E
                                                     */
                                                    [appInfo SSDKSetupSinaWeiboByAppKey:@"926918128" appSecret:@"0d99a1bbd8e1490b24ce7dea8ddad55f" redirectUri:@"http://www.sina.com" authType:SSDKAuthTypeBoth];
                                                    break;
                                                case SSDKPlatformTypeWechat:
                                                    [appInfo SSDKSetupWeChatByAppId:@"wx03131e6650179244" appSecret:@"a54262a4a3785f52a5e26c9444021170"];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [appInfo SSDKSetupQQByAppId:@"1105592430" appKey:@"7rSMjjlDwB0q1ckT" authType:SSDKAuthTypeBoth];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
