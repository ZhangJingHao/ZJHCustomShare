//
//  CustomButton.m
//  SanQu
//
//  Created by ZhangJingHao on 16/6/26.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

// 设置类型、初始化基本数据
- (void)setType:(CustomButtonType)type
{
    _type = type;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = FONT_SIZE(13);
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    switch (type) {
        case CustomButtonType_Share:   // 分享
            
            break;
        case CustomButtonType_Login:   // 三方登录

            break;
        case CustomButtonType_Home:    // 首页
            
            break;

            
        default:
            break;
    }
}

// 图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat height = contentRect.size.height;
    CGFloat width = contentRect.size.width;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = 0;
    CGFloat imageH = 0;
    switch (self.type) {
        case CustomButtonType_Share:  // 分享
            imageW = width * 0.7;
            imageH = imageW;
            imageX = (width - imageW) / 2;
            imageY = height * 0.15;
            break;
        case CustomButtonType_Login:  // 三方登录
            imageW = width * 0.8;
            imageH = imageW;
            imageX = (width - imageW) / 2;
            imageY = height * 0.1;
            break;
        case CustomButtonType_Home:   // 首页
            imageW = width * 0.35;
            imageH = imageW;
            imageX = (width - imageW) / 2;
            imageY = height * 0.26;
            break;

            
        default:
            break;
    }
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

// 标题位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat height = contentRect.size.height;
    CGFloat width = contentRect.size.width;
    CGFloat tX = 0;
    CGFloat tY = 0;
    CGFloat tW = width;
    CGFloat tH = 0;
    switch (self.type) {
        case CustomButtonType_Share:   // 分享
            tY = height * 0.65;
            tH = height * 0.3;
            break;
        case CustomButtonType_Login:   // 三方登录
            tY = height * 0.75;
            tH = height * 0.3;
            break;
        case CustomButtonType_Home:    // 首页
            tY = height * 0.6;
            tH = height * 0.3;
            break;
            
        default:
            break;
    }
    
    return CGRectMake(tX, tY, tW, tH);
}



@end
