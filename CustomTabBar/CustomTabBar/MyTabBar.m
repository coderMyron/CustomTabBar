//
//  MyTabBar.m
//  CustomTabBar
//
//  Created by Myron on 2019/7/27.
//  Copyright © 2019 李木义. All rights reserved.
//

#import "MyTabBar.h"

#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define K_iPhoneXStyle ((KScreenWidth == 375.f && KScreenHeight == 812.f ? YES : NO) || (KScreenWidth == 414.f && KScreenHeight == 896.f ? YES : NO))

@interface MyTabBar ()

@property(nonatomic,weak) UIButton *centerButton;

@end

@implementation MyTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.centerButton];
    }
    return self;
}

- (UIButton *)centerButton{
    if (!_centerButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateSelected];
        CGRect frame = button.frame;
        frame.size = button.currentBackgroundImage.size;
        button.frame = frame;
        CGFloat y = 10;//当y小于24.5时，显示中间，实际根据图片微调
        button.center = CGPointMake(KScreenWidth/2, y);
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _centerButton = button;
        [self addSubview:_centerButton];
    }
    return _centerButton;
}

- (void)buttonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]) {
        [self.delegate tabBarDidClickCenterButton:self];
    }
}

//调整子空间的位置
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat w = self.bounds.size.width;
//    CGFloat h = self.bounds.size.height;
//    CGFloat btnX = 0;
//    CGFloat btnY = 0;
//    CGFloat btnW = w / 5;
//    CGFloat btnH = h;
//    int i = 0;
//    //遍历当前tabBar上的所有view
//    for (UIView *tabBarBtn in self.subviews) {
//        //如果是UITabBarButton，就取出来重新设置他们的位置
//        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            btnX = i * btnW;
//            if (K_iPhoneXStyle) {
//                tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, 49);
//            }else{
//                tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//            }
//            i++;
//            //当到了第二个时候，留一个空位置添加中间按钮。
//            if (i==2) {
//                i++;
//            }
//        }
//    }
//
//}

//当中间按钮是自定义凸起的，点击凸起没反应时重写下面这方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //转换坐标
    CGPoint tempPoint = [self convertPoint:point toView:self.centerButton];
    //判断点击的点是否在按钮区域内
    if ([self.centerButton pointInside:tempPoint withEvent:event]) {
        return self.centerButton;
    } else {
        return [super hitTest:point withEvent:event];
    }}


@end
