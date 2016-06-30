//
//  AppDelegate.m
//  ZJHCustomLogin
//
//  Created by ZhangJingHao on 16/6/30.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"

// 友盟
#define KYM_AppKey        @"53290df956240b6b4a0084b3"
// 微信参数
#define KWeiXinAppId      @"wxdc1e388c3822c80b"
#define KWeiXinAppSecret  @"a393c1527aaccb95f3a4c88d6d1455f6"
#define KWeiXinAppUrl     @"http://www.umeng.com/social"
#define KWeiXinReqScope   @"snsapi_userinfo"
#define KWeiXinReqState   @"0744"
// 新浪
#define KWeiBoAppKey      @"3921700954"
#define KWeiBoAppSecret   @"04b48b094faeb16683c32669824ebdad"
#define KWeiBoRedirectUri @"http://sns.whalecloud.com/sina2/callback"
// QQ
#define KQQAppKey         @"100424468"
#define KQQAppSecret      @"c7394704798a158208a74ab60104f0ba"
#define KQQRedirectUri    @"http://www.umeng.com/social"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册友盟分享
    [UMSocialData setAppKey:KYM_AppKey];
    // 设置微信
    [UMSocialWechatHandler setWXAppId:KWeiXinAppId appSecret:KWeiXinAppSecret url:KWeiXinAppUrl];
    // 设置微博
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:KWeiBoAppKey secret:KWeiBoAppSecret RedirectURL:KWeiBoRedirectUri];
    // 设置QQ
    [UMSocialQQHandler setQQWithAppId:KQQAppKey appKey:KQQAppSecret url:KQQRedirectUri];
    
    return YES;
}

// 系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        // 调用其他SDK，例如支付宝SDK等
        
    }
    return result;
}


@end
