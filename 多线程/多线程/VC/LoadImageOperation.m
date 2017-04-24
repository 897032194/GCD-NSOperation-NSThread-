//
//  LoadImageOperation.m
//  多线程
//
//  Created by 连京帅 on 2017/4/11.
//  Copyright © 2017年 chuang. All rights reserved.
//

#import "LoadImageOperation.h"

@implementation LoadImageOperation

// 自动运行
- (void)main {
    
    // 如果取消了 就return
    if (self.isCancelled) return;
    
    NSURL *url = [NSURL URLWithString:self.imgUrl];         // 图片链接
    NSData *imageData = [NSData dataWithContentsOfURL:url]; // 下载图片
    
    // 如果取消了 就return
    if (self.isCancelled) {
        url = nil;
        imageData = nil;
        return;
    }
    
    // 把data转化为image
    UIImage *image = [UIImage imageWithData:imageData];
    
    // 如果取消了 就return
    if (self.isCancelled) {
        image = nil;
        return;
    }
    
    // 方法1 在主线程运行
    [self performSelectorOnMainThread:@selector(refreshImageView:) withObject:image waitUntilDone:YES];
    
//    // 方法2 在主线程运行            这是GCD方法 UI线程执行(只是为了测试,长时间的加载不能放在主线程)
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.loadImageFinish(image);
//    });
    
}

- (void)refreshImageView:(UIImage *)image {
    self.loadImageFinish(image);
}

@end
