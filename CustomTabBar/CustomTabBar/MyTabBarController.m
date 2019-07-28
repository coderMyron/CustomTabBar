//
//  MyTabBarController.m
//  CustomTabBar
//
//  Created by Myron on 2019/7/27.
//  Copyright © 2019 Myron. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyTabBar.h"
#import "MyNavigationController.h"

@interface MyTabBarController ()<MyTabBarDelegate,UITabBarControllerDelegate>

//tabbarVC数组
@property(nonatomic,copy) NSArray *array;
//normal状态图片显示数组
@property(nonatomic,copy) NSArray *imageArray;
//select状态图片显示数组
@property(nonatomic,copy) NSArray *selectImageArray;
//tabbarbutton上显示的文字数组
@property(nonatomic,copy) NSArray *tabTitles;
//中间占位VC
@property(nonatomic,weak) UIViewController *emptyVC;
//保留点击的tabBarItem
@property(nonatomic,weak) UITabBarItem *item;

@end

@implementation MyTabBarController


+ (void)load{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = UIColor.redColor;
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    [[UITabBarItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MyTabBar *tabBar = [[MyTabBar alloc] init];
    tabBar.delegate = self;
    self.tabBar.translucent = NO;

    //用kvc把readly的tabBar属性改成自定义的
    [self setValue:tabBar forKey:@"tabBar"];
    [self setTabBar];
    self.delegate = self;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)setTabBar{
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.navigationItem.title = @"vc1";
    [vc1.view setBackgroundColor:UIColor.whiteColor];
    MyNavigationController *shipingNav = [[MyNavigationController alloc] initWithRootViewController:vc1];
//    [self addChildViewController:shipingNav];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.navigationItem.title = @"vc2";
    [vc2.view setBackgroundColor:UIColor.redColor];
    MyNavigationController *shebeiNav = [[MyNavigationController alloc] initWithRootViewController:vc2];
//    [self addChildViewController:shebeiNav];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.navigationItem.title = @"vc3";
    [vc3.view setBackgroundColor:UIColor.greenColor];
    MyNavigationController *xiangbuNav = [[MyNavigationController alloc] initWithRootViewController:vc3];
//    [self addChildViewController:xiangbuNav];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.navigationItem.title = @"vc4";
    [vc4.view setBackgroundColor:UIColor.blueColor];
    MyNavigationController *gerenNav = [[MyNavigationController alloc] initWithRootViewController:vc4];
//    [self addChildViewController:gerenNav];
    
    
    self.imageArray = @[@"shipingDF",@"shebeiDF",@"xiangbuDF",@"gerenDF"];
    self.selectImageArray = @[@"shipingSE",@"shebeiSE",@"xiangbuSE",@"gerenSE"];
    self.tabTitles = @[@"视频",@"摄备",@"相薄",@"个人"];
    UIViewController *emptyVC = [[UIViewController alloc] init];
    self.emptyVC = emptyVC;
    self.array = [[NSArray alloc]initWithObjects: shipingNav,shebeiNav,emptyVC,xiangbuNav,gerenNav,nil];
    self.viewControllers = self.array;
    NSLog(@"tabBarItems count--------%lu",self.tabBar.items.count);
    for(int i = 0; i < self.tabBar.items.count; i++){
        
        if (i == 2) {
            continue;
        }
        UITabBarItem* tabBarItem = self.tabBar.items[i];
        
        int k = i;
        if (i>=3) {
            k --;
        }
        
        [tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        tabBarItem.title = self.tabTitles[k];
        tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.selectImageArray[k]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[k]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
    }
    
    //默认开始显示哪一个tabBarItem
    int firstSelect = 0;
    self.selectedIndex = firstSelect;
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [self.tabBar.items[firstSelect] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
}

#pragma mark - 点击中间按钮
- (void)tabBarDidClickCenterButton:(MyTabBar *)tabBar{
    NSLog(@"tabBarDidClickCenterButton");
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    self.item = item;
    }

- (bool)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (viewController == _emptyVC) {
        return false;
    }else{
        for (UITabBarItem *tabBaritem in tabBarController.tabBar.items) {
            if (tabBaritem == self.item) {
                NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
                textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
                [tabBaritem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
                
            }else {
                NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
                textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
                textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
                [tabBaritem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            }
        }

        return true;
    }
}

@end
