//
//  CustomButton.h
//  SanQu
//
//  Created by ZhangJingHao on 16/6/26.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义Btn, 图片、文字混排
 */

// 基本宏定义
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define MY_WIDTH(a) ((a) * SCREEN_WIDTH / 375.f)
#define RGB_ColorSame(r) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:1.0]
// 字体大小
#define FONT_SIZE(size) [UIFont systemFontOfSize:MY_WIDTH(size)]

// 按钮类型
typedef NS_ENUM(NSInteger,CustomButtonType) {
    CustomButtonType_Share,      // 分享
    CustomButtonType_Login,      // 三方登录
    CustomButtonType_Home,       // 首页
    
};

@interface CustomButton : UIButton

// 按钮类型
@property (nonatomic, assign) CustomButtonType type;

@end
