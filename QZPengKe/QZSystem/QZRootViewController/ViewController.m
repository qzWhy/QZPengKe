//
//  ViewController.m
//  QZPengKe
//
//  Created by 000 on 17/12/22.
//  Copyright © 2017年 XiaoZuoXiaoYou. All rights reserved.
//

#import "ViewController.h"
#import "QZTabBarController.h"
#import "QZNavigtaionController.h"
#import "AppDelegate.h"
#import "ADViewController.h"

@interface ViewController ()

@property (nonatomic, strong) QZNavigtaionController *homePageNav;

@property (nonatomic, strong) QZTabBarController *tabBar;

@property (nonatomic, strong) QZNavigtaionController *shopNav;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabBar = [[QZTabBarController alloc] init];
    
    _homePageNav = [self createTabWithStoryboardName:@"QZHomePage" identifier:@"homePageNav" title:@"首页" image:@"home_hover"];
    
    QZNavigtaionController *communityNav = [self createTabWithStoryboardName:@"QZCommunity" identifier:@"communityNav" title:@"首页" image:@"community_hover"];
    QZNavigtaionController *tutorialNav = [self createTabWithStoryboardName:@"QZTutorial" identifier:@"turorialNav" title:@"教程" image:@"course_hover"];
    _shopNav = [self createTabWithStoryboardName:@"QZShop" identifier:@"shopNav" title:@"商城" image:@"mall_hover"];
    QZNavigtaionController *mineNav = [self createTabWithStoryboardName:@"QZMine" identifier:@"mineNav" title:@"我" image:@"mine_hover"];
    _tabBar.viewControllers = [NSArray arrayWithObjects:_homePageNav,communityNav,tutorialNav,_shopNav,mineNav,nil];
    
    [self normalLoad];
}

- (void)normalLoad
{
    AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    ADViewController *adVC =[[ADViewController alloc] init];
    appDele.window.rootViewController = adVC;
    
    __weak typeof(self) weakSelf = self;
    adVC.completion = ^(ADItem *item) {
        if (item) {
            [[NSUserDefaults standardUserDefaults] setObject:item.adURL forKey:@"key"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
      [UIView transitionWithView:appDele.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
          AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      } completion:<#^(BOOL finished)completion#>]
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (QZNavigtaionController *)createTabWithStoryboardName:(NSString *)storyName identifier:(NSString *)identifier title:(NSString *)title image:(NSString *)imageName
{
    QZNavigtaionController *nav = StoryboardAcquiredController(storyName, identifier);
    if (title && imageName) {
        UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Selected",imageName]]];
        
        firstItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
//        nav.topViewController.tabBarItem = firstItem;
    }
    return nav;
}

@end
