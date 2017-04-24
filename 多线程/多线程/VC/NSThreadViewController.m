//
//  NSThreadViewController.m
//  多线程
//
//  Created by 连京帅 on 2017/4/11.
//  Copyright © 2017年 chuang. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@property (nonatomic, strong)NSString *imgUrl;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *loadingLb;

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"NSThread";
    _imgUrl = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*zF0J7XHubBjojgJdYRS0FA.jpeg";
    
    //动态创建线程
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, screen_width-100, 44)];
    button1.backgroundColor = [UIColor lightGrayColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    [button1 setTitle:@"dynamic create thread, 动态创建线程" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(button1dianjishijian) forControlEvents:UIControlEventTouchUpInside];

    //静态创建线程
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button1.frame)+50, screen_width-100, 44)];
    button2.backgroundColor = [UIColor lightGrayColor];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    [button2 setTitle:@"static create thread, 静态创建线程" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(button2dianjishijian) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button3 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button2.frame)+50, screen_width-100, 44)];
    button3.backgroundColor = [UIColor lightGrayColor];
    button3.titleLabel.font = [UIFont systemFontOfSize:13];
    [button3 setTitle:@"implicit create thread, 隐式创建线程" forState:UIControlStateNormal];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(button3dianjishijian) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(button3.frame)+50, screen_width-100, 200)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    // 加载
    _loadingLb = [[UILabel alloc] initWithFrame:_imageView.bounds];
    _loadingLb.backgroundColor = [UIColor clearColor];
    _loadingLb.textAlignment = NSTextAlignmentCenter;
    _loadingLb.text = @"加载中...";
    _loadingLb.hidden = YES;
    [_imageView addSubview:_loadingLb];
}

#warning 👇👇👇👇
//动态创建线程
- (void)button1dianjishijian {
    _imageView.image = nil;
    _loadingLb.hidden = NO;
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageSource:) object:_imgUrl];
    thread.threadPriority = 1;// 设置线程的优先级(0.0 - 1.0，1.0最高级)
    [thread start];
}

#warning 👇👇👇👇
//静态创建线程
- (void)button2dianjishijian {
    _imageView.image = nil;
    _loadingLb.hidden = NO;
    
    [NSThread detachNewThreadSelector:@selector(loadImageSource:) toTarget:self withObject:_imgUrl];
}

#warning 👇👇👇👇
//隐式创建线程
- (void)button3dianjishijian {
    _imageView.image = nil;
    _loadingLb.hidden = NO;
    
    [self performSelectorInBackground:@selector(loadImageSource:) withObject:_imgUrl];
}


-(void)loadImageSource:(NSString *)url{
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]; // 下载数据
    UIImage *image = [UIImage imageWithData:imgData];                           // 转化为图片
    if (imgData!=nil) {
        // 在主线程设置图片
        [self performSelectorOnMainThread:@selector(refreshImageView:) withObject:image waitUntilDone:YES];
    }else{
        NSLog(@"没有图片");
    }
    
}

-(void)refreshImageView:(UIImage *)image{
    // 在主线程设置图片
    _imageView.image = image;
    _loadingLb.hidden = YES;
}

@end
