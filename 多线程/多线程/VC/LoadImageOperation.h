//
//  LoadImageOperation.h
//  多线程
//
//  Created by 连京帅 on 2017/4/11.
//  Copyright © 2017年 chuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadImageOperation : NSOperation

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, copy) void(^loadImageFinish)(UIImage *image);

@end
