//
//  LaunchDemo.m
//  LaunchDemo
//
//  Created by wxiao on 15/12/19.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "LaunchDemo.h"
//#import "HLGuidePageView.h"
//#import "HLLoginOperation.h"
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define LDSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define LDSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface LaunchDemo ()
@property (nonatomic, strong) UIImageView	*bgImage;
@property (nonatomic, strong) UIImageView	*iconImage;
@property (nonatomic, strong) UIImageView	*launchimage;
@property (nonatomic, strong) UIView		*dumy;

//@property (nonatomic, strong) HLLoginOperation *operation;
@end

@implementation LaunchDemo

//- (HLLoginOperation *)operation {
//    if (!_operation) {
//        _operation = [HLLoginOperation new];
//    }
//    return _operation;
//}


- (void)loadLaunchImage:(NSString *)imgName
			   iconName:(NSString*)iconName
			appearStyle:(JRApperaStyle)style
				bgImage:(NSString *)bgName
			  disappear:(JRDisApperaStyle)disappear
		 descriptionStr:(NSString *)des {
	
    
    
	// 1. 背景
	if (bgName.length != 0) {
		self.bgImage = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
		self.bgImage.image = [UIImage imageNamed:bgName];
	}
	
	// 2. 加载图
	if (imgName.length != 0) {
		self.launchimage = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
        
		
	}
	
	// 3. icon
	if (iconName.length != 0) {
		self.iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
		self.iconImage.frame = self.iconFrame;
	}
	
	// 4. label
	if (des.length != 0) {
		self.desLabel = [[UILabel alloc] init];
		self.desLabel.textAlignment = NSTextAlignmentCenter;
		self.desLabel.frame = self.desLabelFreme;
		self.desLabel.text = des;
		[self.launchimage addSubview:_desLabel];
	}
	
	
	
	[self appera:style];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissAll:disappear];
    });
}


- (void)appera:(JRApperaStyle)style {
    
    
	// 0. keywindow
	
	if (style == JRApperaStyleNone) {
		[[UIApplication sharedApplication].delegate.window addSubview:_bgImage];
		[[UIApplication sharedApplication].delegate.window addSubview:_launchimage];
		[[UIApplication sharedApplication].delegate.window addSubview:_iconImage];
	} else if (style == JRApperaStyleOne) {
		
		[[UIApplication sharedApplication].delegate.window addSubview:_bgImage];
		[[UIApplication sharedApplication].delegate.window addSubview:_launchimage];
		[[UIApplication sharedApplication].delegate.window addSubview:_iconImage];
//		_launchimage.alpha = 0.0;
//		
//		[UIView animateWithDuration:1.0 animations:^{
//			_launchimage.alpha = 1.0;
//		} completion:^(BOOL finished) {
//			
//		}];
	}
    
    
}

- (void)dismissAll:(JRDisApperaStyle)style {
	
	if (style == JRDisApperaStyleOne) {
		
		_bgImage.alpha = 0.0f;
		[UIView animateWithDuration:1.5f
							  delay:0.0f
							options:UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 _iconImage.alpha = 0.0f;
							 _launchimage.alpha = 0.0f;
							 _launchimage.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1);
						 }
						 completion:^(BOOL finished) {
							 [_bgImage removeFromSuperview];
							 [_launchimage removeFromSuperview];
							 [_iconImage removeFromSuperview];
						 }];
		
		return;
	} else if (style == JRDisApperaStyleTwo) {
		_bgImage.alpha = 0.0f;
		[UIView animateWithDuration:1.5f
							  delay:0.0f
							options:UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 _iconImage.alpha = 0.0f;
							 _launchimage.alpha = 0.0f;
						 }
						 completion:^(BOOL finished) {
							 [_bgImage removeFromSuperview];
							 [_launchimage removeFromSuperview];
							 [_iconImage removeFromSuperview];
						 }];
		return;
	} else if (style == JRDisApperaStyleLeft) {
		
		_bgImage.alpha = 0.0;
		[UIView animateWithDuration:1.0f
							  delay:0.0f
							options:UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 _iconImage.alpha = 0.0f;
							 _launchimage.alpha = 0.0f;
							 CGRect frame = _launchimage.frame;
							 frame.origin.x = -SCREEN_WIDTH;
							 _launchimage.frame = frame;
							 
							 frame = _iconImage.frame;
							 frame.origin.x = -SCREEN_WIDTH;
							 _iconImage.frame = frame;
							 
							 frame = _bgImage.frame;
							 frame.origin.x = -SCREEN_WIDTH;
							 _bgImage.frame = frame;
							 
							 frame = _desLabel.frame;
							 frame.origin.x = -SCREEN_WIDTH;
							 _desLabel.frame = frame;

							 frame = _dumy.frame;
							 frame.origin.x = -SCREEN_WIDTH;
							 _dumy.frame = frame;
						 }
						 completion:^(BOOL finished) {
							 [_bgImage removeFromSuperview];
							 [_launchimage removeFromSuperview];
							 [_iconImage removeFromSuperview];
							 [_desLabel removeFromSuperview];
							 
							 [_dumy removeFromSuperview];
						 }];
		return;
	} else if (style == JRDisApperaStyleRight) {
		
		[UIView animateWithDuration:1.0f
							  delay:0.0f
							options:UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 _iconImage.alpha = 0.0f;
							 _launchimage.alpha = 0.0f;
							 CGRect frame = _launchimage.frame;
							 frame.origin.x += SCREEN_WIDTH;
							 _launchimage.frame = frame;
							 
							 frame = _iconImage.frame;
							 frame.origin.x += SCREEN_WIDTH;
							 _iconImage.frame = frame;
							 
							 frame = _bgImage.frame;
							 frame.origin.x += SCREEN_WIDTH;
							 _bgImage.frame = frame;
							 
							 frame = _desLabel.frame;
							 frame.origin.x += SCREEN_WIDTH;
							 _desLabel.frame = frame;
							 
							 frame = _dumy.frame;
							 frame.origin.x += SCREEN_WIDTH;
							 _dumy.frame = frame;
						 }
						 completion:^(BOOL finished) {
							 [_bgImage removeFromSuperview];
							 [_launchimage removeFromSuperview];
							 [_iconImage removeFromSuperview];
							 [_desLabel removeFromSuperview];
							 
							 [_dumy removeFromSuperview];
						 }];
		return;
	} else if (style == JRDisApperaStyleBottom) {
		
		[UIView animateWithDuration:1.0f
							  delay:0.0f
							options:UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 _iconImage.alpha = 0.0f;
							 _launchimage.alpha = 0.0f;
							 CGRect frame = _launchimage.frame;
							 frame.origin.y += SCREEN_HEIGHT;
							 _launchimage.frame = frame;
							 
							 frame = _iconImage.frame;
							 frame.origin.y += SCREEN_HEIGHT;
							 _iconImage.frame = frame;
							 
							 frame = _bgImage.frame;
							 frame.origin.y += SCREEN_HEIGHT;
							 _bgImage.frame = frame;
							 
							 frame = _desLabel.frame;
							 frame.origin.y += SCREEN_HEIGHT;
							 _desLabel.frame = frame;
							 
							 frame = _dumy.frame;
							 frame.origin.y += SCREEN_HEIGHT;
							 _dumy.frame = frame;
						 }
						 completion:^(BOOL finished) {
							 [_bgImage removeFromSuperview];
							 [_launchimage removeFromSuperview];
							 [_iconImage removeFromSuperview];
							 [_desLabel removeFromSuperview];
							 
							 [_dumy removeFromSuperview];
						 }];
		return;
	} else if (style == JRDisApperaStyleTop) {
		
		[UIView animateWithDuration:1.0f
							  delay:0.0f
							options:UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 _iconImage.alpha = 0.0f;
							 _launchimage.alpha = 0.0f;
							 CGRect frame = _launchimage.frame;
							 frame.origin.y = -SCREEN_HEIGHT;
							 _launchimage.frame = frame;
							 
							 frame = _iconImage.frame;
							 frame.origin.y = -SCREEN_HEIGHT;
							 _iconImage.frame = frame;
							 
							 frame = _bgImage.frame;
							 frame.origin.y = -SCREEN_HEIGHT;
							 _bgImage.frame = frame;
							 
							 frame = _desLabel.frame;
							 frame.origin.y = -SCREEN_HEIGHT;
							 _desLabel.frame = frame;
							 
							 frame = _dumy.frame;
							 frame.origin.y = -SCREEN_HEIGHT;
							 _dumy.frame = frame;
						 }
						 completion:^(BOOL finished) {
							 [_bgImage removeFromSuperview];
							 [_launchimage removeFromSuperview];
							 [_iconImage removeFromSuperview];
							 [_desLabel removeFromSuperview];
							 
							 [_dumy removeFromSuperview];
						 }];
		return;
	}
//	else if (style == JRDisApperaStyleThree) {
//		NSLog(@"55");
//		_bgImage.alpha = 0.0f;
//		[UIView animateWithDuration:1.5f
//							  delay:0.0f
//							options:UIViewAnimationOptionBeginFromCurrentState
//						 animations:^{
//							 _iconImage.alpha = 0.0f;
//							 _launchimage.alpha = 0.0f;
//							 _launchimage.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.1, 0.1, 1);
//						 }
//						 completion:^(BOOL finished) {
//							 [_bgImage removeFromSuperview];
//							 [_launchimage removeFromSuperview];
//							 [_iconImage removeFromSuperview];
//						 }];
//		
//		return;
//	}
	
	[_desLabel removeFromSuperview];
	[_bgImage removeFromSuperview];
	[_launchimage removeFromSuperview];
	[_iconImage removeFromSuperview];
}


@end



// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
