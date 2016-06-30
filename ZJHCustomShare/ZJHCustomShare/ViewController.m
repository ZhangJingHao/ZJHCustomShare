//
//  ViewController.m
//  ZJHCustomShare
//
//  Created by ZhangJingHao on 16/6/30.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import "ViewController.h"
#import "CustomShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)clickBtn:(id)sender {
    
    CustomShareView *share = [[CustomShareView alloc] initWithFrame:self.view.bounds];
    share.shareTitle = @"我是标题";
    share.shareContent = @"我是内容";
    share.shareUrl = @"http://www.baidu.com";
    share.shareImage = [UIImage imageNamed:@"beautifulGirl.jpg"];
    share.shareVc = self;
    [self.view addSubview:share];
    [share showView];
}


@end
