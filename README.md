# CustomTabBar
自定义TabBar，点击选中时字体变大，解决改变字体时顺序会乱问题。自定义中间按钮，可设置凸起。

由于改变tabBarItem字体大小时，会调用layoutSubviews，会深拷贝UITabBarButton，所以不能用遍历self.subviews找到UITabBarButton的方法设置frame，所以用了一个占位VC占中间位置，再用代理判断点击选中是不是中间按钮。
![image](https://github.com/coderMyron/CustomTabBar/blob/master/tabbarvc.png)
