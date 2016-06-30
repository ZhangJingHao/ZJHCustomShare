//
//  CustomShareView.m
//  SanQu
//
//  Created by ZhangJingHao on 16/6/28.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import "CustomShareView.h"
#import "CustomButton.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"

// 视图高度
#define KCustomShareView_Height MY_WIDTH(190)

// 分享类型
typedef NS_ENUM(NSInteger, CustomShareType) {
    CustomShareType_WeiXinFriend    = 0,  // 微信好友
    CustomShareType_WeiXinCircle    = 1,  // 微信朋友圈
    CustomShareType_QQFreind        = 2,  // QQ好友
    CustomShareType_QQZone          = 3,  // QQ空间
    CustomShareType_Sina            = 4,  // 新浪微博
};

@interface CustomShareView()

// 背景按钮
@property (nonatomic, weak) UIButton *bgBtn;
// 工具视图
@property (nonatomic, weak) UIView *toolView;
// 标题
@property (nonatomic, weak) UILabel *titleLab;
// 取消按钮
@property (nonatomic, weak) UIButton *canceBtn;
// 按钮数组
@property (nonatomic ,strong) NSMutableArray *btnArr;

@end

@implementation CustomShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initOtherUI:frame];
    }
    return self;
}


- (void)initOtherUI:(CGRect)frame
{
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width;
    
    // 背景按钮
    UIButton *bgBtn = [[UIButton alloc] initWithFrame:frame];
    [bgBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    bgBtn.backgroundColor = [UIColor blackColor];
    bgBtn.alpha = 0;
    [self addSubview:bgBtn];
    self.bgBtn = bgBtn;
    
    // 工具视图
    CGFloat toolH = KCustomShareView_Height;
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, toolH)];
    toolView.backgroundColor = [UIColor whiteColor];
    [self addSubview:toolView];
    self.toolView = toolView;
    
    // 标题
    CGFloat titleH = MY_WIDTH(40);
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, titleH)];
    titleLab.textColor = [UIColor darkGrayColor];
    titleLab.font = FONT_SIZE(15);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [toolView addSubview:titleLab];
    self.titleLab = titleLab;
    titleLab.text = @"分 享";
    
    // 取消按钮
    CGFloat cancelH = MY_WIDTH(35);
    CGFloat cancelX = MY_WIDTH(15);
    CGFloat cancelW = width - 2 * cancelX;
    CGFloat cancelY = toolH - cancelH - MY_WIDTH(10);
    UIButton *canceBtn = [[UIButton alloc] initWithFrame:CGRectMake(cancelX, cancelY, cancelW, cancelH)];
    [canceBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [canceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    canceBtn.titleLabel.font = FONT_SIZE(15);
    [canceBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:canceBtn];
    self.canceBtn = canceBtn;
    self.canceBtn.layer.cornerRadius = MY_WIDTH(4);
    self.canceBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.canceBtn.layer.borderWidth = MY_WIDTH(0.5);
    
    // 横线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(cancelX, titleH - 0.5, cancelW, 0.5)];
    lineView.backgroundColor = RGB_ColorSame(222);
//    [toolView addSubview:lineView];
    
    // 按钮View
    CGFloat iconY = titleH - MY_WIDTH(10);
    CGFloat iconH = cancelY - iconY - MY_WIDTH(10);
    UIScrollView *iconView = [[UIScrollView alloc] initWithFrame:CGRectMake(cancelX, iconY, cancelW, iconH)];
    [toolView addSubview:iconView];
    
    NSArray *nameArr = @[@"微信好友", @"朋友圈", @"手机QQ", @"QQ空间", @"新浪微博"];
    NSArray *iconArr = @[@"share_wechat", @"share_friends", @"share_qq", @"QQZoneShare", @"icon_invitation_weibo"];
    // 按钮个数及布局
    NSArray *typeArr = nil;
    typeArr = @[@(CustomShareType_WeiXinFriend), @(CustomShareType_WeiXinCircle), @(CustomShareType_QQFreind), @(CustomShareType_QQZone), @(CustomShareType_Sina)];

//    if ([WXApi isWXAppInstalled]) { // 已经安装微信
//        typeArr = @[@(CustomShareType_WeiXinFriend), @(CustomShareType_WeiXinCircle), @(CustomShareType_QQFreind), @(CustomShareType_QQZone), @(CustomShareType_Sina)];
//    } else { // 未安装微信
//        typeArr = @[@(CustomShareType_Sina)];
//    }
    
    // 按钮
    NSInteger count = typeArr.count;
    CGFloat btnW = MY_WIDTH(60);
    CGFloat btnH = iconH * 0.8;
    CGFloat btnY = (iconH - btnH) / 2;
    CGFloat btnX = 0;
    CGFloat distance = (cancelW - btnW * 5) / 4.0;
    _btnArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        CustomShareType type = [typeArr[i] integerValue];
        btnX = (btnW + distance) * i;
        CustomButton *btn = [[CustomButton alloc] initWithFrame:CGRectMake(btnX, btnY + btnH, btnW, btnH)];
        btn.type = CustomButtonType_Share;
        btn.tag = type;
        [btn setImage:[UIImage imageNamed:iconArr[type]] forState:UIControlStateNormal];
        [btn setTitle:nameArr[type] forState:UIControlStateNormal];
        [iconView addSubview:btn];
        [_btnArr addObject:btn];
        [btn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// 展示视图
- (void)showView
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGFloat top2 = self.frame.size.height - KCustomShareView_Height;
        
        self.toolView.frame = CGRectMake(self.toolView.frame.origin.x, top2, self.toolView.frame.size.width, self.toolView.frame.size.height);
        self.bgBtn.alpha = 0.3;
        
        // 按钮动画
        for (int i = 0; i < _btnArr.count; i++) {
            UIButton *rr =  _btnArr[i];
            CGFloat top = rr.frame.origin.y - rr.frame.size.height;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    rr.frame = CGRectMake(rr.frame.origin.x, top, rr.frame.size.width, rr.frame.size.height);
                } completion:nil];
            });
        }
        
    } completion:^(BOOL finished) {}];
}

// 取消按钮
- (void)clickCancelBtn
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.bgBtn.alpha = 0;
        self.toolView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.toolView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 点击分享按钮
- (void)clickShareBtn:(UIButton *)btn
{
    // 退出
    [self clickCancelBtn];
    
    // 分享类型
    NSString *snsName = nil;

    switch (btn.tag) {
        case CustomShareType_WeiXinFriend:{  // 微信好友
            snsName = UMShareToWechatSession;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = self.shareTitle;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
        }
            break;
        case CustomShareType_WeiXinCircle:{  // 朋友圈
            snsName = UMShareToWechatTimeline;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.shareTitle;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
        }
            break;
        case CustomShareType_QQFreind:{  // 手机QQ
            snsName = UMShareToQQ;
            [UMSocialData defaultData].extConfig.qqData.url = self.shareUrl;
            [UMSocialData defaultData].extConfig.qqData.title = self.shareTitle;
        }
            break;
        case CustomShareType_QQZone:{  // QQ空间
            snsName = UMShareToQzone;
            [UMSocialData defaultData].extConfig.qzoneData.url = self.shareUrl;
            [UMSocialData defaultData].extConfig.qzoneData.title = self.shareTitle;
        }
            break;
        case CustomShareType_Sina:{  // 新浪微博
            snsName = UMShareToSina;
            if (self.shareUrl.length) {
                self.shareContent = [NSString stringWithFormat:@"%@ %@",self.shareContent, self.shareUrl];
            }
        }
            break;
            
        default:
            break;
    }
    
    // 分享
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[snsName] content:self.shareContent image:_shareImage location:nil urlResource:nil presentedController:self.shareVc completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功");
        } else if(response.responseCode != UMSResponseCodeCancel) {
            NSLog(@"分享失败 message : %@",response.message);
        }
    }];
}


@end








