//
//  CustomShareView.h
//  SanQu
//
//  Created by ZhangJingHao on 16/6/28.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义分享视图
 */

@interface CustomShareView : UIView

// 分享标题
@property (nonatomic, copy) NSString *shareTitle;
// 分享内容
@property (nonatomic, copy) NSString *shareContent;
// 分享链接
@property (nonatomic, copy) NSString *shareUrl;
// 分享图片
@property (nonatomic, strong) UIImage *shareImage;
// 分享页面控制器
@property (nonatomic ,strong) UIViewController *shareVc;

// 展示视图
- (void)showView;

@end
