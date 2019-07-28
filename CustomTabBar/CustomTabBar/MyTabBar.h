//
//  MyTabBar.h
//  CustomTabBar
//
//  Created by Myron on 2019/7/27.
//  Copyright © 2019 Myron. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyTabBar;
@protocol MyTabBarDelegate <NSObject,UITabBarDelegate>

@optional
- (void)tabBarDidClickCenterButton:(MyTabBar *)tabBar;

@end

@interface MyTabBar : UITabBar

@property(nonatomic,weak) id<MyTabBarDelegate> delegate;
@property(nonatomic,assign) bool isLayoutFinish;

@end

NS_ASSUME_NONNULL_END
