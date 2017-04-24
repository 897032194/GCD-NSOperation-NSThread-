//
//  GCDViewController.m
//  多线程
//
//  Created by 连京帅 on 2017/4/11.
//  Copyright © 2017年 chuang. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@property (nonatomic, strong)NSString *imgUrl1;
@property (nonatomic, strong)NSString *imgUrl2;
@property (nonatomic, strong)UIImageView *imageView1;
@property (nonatomic, strong)UILabel *loadingLb1;
@property (nonatomic, strong)UIImageView *imageView2;
@property (nonatomic, strong)UILabel *loadingLb2;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"GCD";
    _imgUrl1 = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*zF0J7XHubBjojgJdYRS0FA.jpeg";
    _imgUrl2 = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*kE8-X3OjeiiSPQFyhL2Tdg.jpeg";

    
    //动态创建线程
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 10, screen_width-100, 30)];
    button1.backgroundColor = [UIColor lightGrayColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    [button1 setTitle:@"global queue, 后台执行" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(buttondianjishijian1) forControlEvents:UIControlEventTouchUpInside];
    
    //静态创建线程
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button1.frame)+10, screen_width-100, 30)];
    button2.backgroundColor = [UIColor lightGrayColor];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    [button2 setTitle:@"main queue, UI线程执行(只是为了测试,长时间的加载不能放在主线程)" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(buttondianjishijian2) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button3 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button2.frame)+10, screen_width-100, 30)];
    button3.backgroundColor = [UIColor lightGrayColor];
    button3.titleLabel.font = [UIFont systemFontOfSize:13];
    [button3 setTitle:@"dispatch once, 一次性执行(常用来写单例)" forState:UIControlStateNormal];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(buttondianjishijian3) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button4 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button3.frame)+10, screen_width-100, 30)];
    button4.backgroundColor = [UIColor lightGrayColor];
    button4.titleLabel.font = [UIFont systemFontOfSize:13];
    [button4 setTitle:@"dispatch apply, 并发地执行循环迭代" forState:UIControlStateNormal];
    [self.view addSubview:button4];
    [button4 addTarget:self action:@selector(buttondianjishijian4) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button5 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button4.frame)+10, screen_width-100, 30)];
    button5.backgroundColor = [UIColor lightGrayColor];
    button5.titleLabel.font = [UIFont systemFontOfSize:13];
    [button5 setTitle:@"global queue 2,后台执行：加载两张图片" forState:UIControlStateNormal];
    [self.view addSubview:button5];
    [button5 addTarget:self action:@selector(buttondianjishijian5) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button6 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button5.frame)+10, screen_width-100, 30)];
    button6.backgroundColor = [UIColor lightGrayColor];
    button6.titleLabel.font = [UIFont systemFontOfSize:13];
    [button6 setTitle:@"👉dispatch group, 并发线程组" forState:UIControlStateNormal];
    [self.view addSubview:button6];
    [button6 addTarget:self action:@selector(buttondianjishijian6) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button7 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button6.frame)+10, screen_width-100, 30)];
    button7.backgroundColor = [UIColor lightGrayColor];
    button7.titleLabel.font = [UIFont systemFontOfSize:13];
    [button7 setTitle:@"dispatch after, 延迟执行" forState:UIControlStateNormal];
    [self.view addSubview:button7];
    [button7 addTarget:self action:@selector(buttondianjishijian7) forControlEvents:UIControlEventTouchUpInside];
    
    //隐式创建线程
    UIButton * button8 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button7.frame)+10, screen_width-100, 30)];
    button8.backgroundColor = [UIColor lightGrayColor];
    button8.titleLabel.font = [UIFont systemFontOfSize:13];
    [button8 setTitle:@"define dispatch, 自定义dispatch_queue_t" forState:UIControlStateNormal];
    [self.view addSubview:button8];
    [button8 addTarget:self action:@selector(buttondianjishijian8) forControlEvents:UIControlEventTouchUpInside];
    
    // 图片
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(button8.frame)+10, screen_width-100, 100)];
    _imageView1.contentMode = UIViewContentModeScaleAspectFill;
    _imageView1.backgroundColor = [UIColor lightGrayColor];
    _imageView1.clipsToBounds = YES;
    [self.view addSubview:_imageView1];
    // 加载
    _loadingLb1 = [[UILabel alloc] initWithFrame:_imageView1.bounds];
    _loadingLb1.backgroundColor = [UIColor clearColor];
    _loadingLb1.textAlignment = NSTextAlignmentCenter;
    _loadingLb1.text = @"加载中...";
    _loadingLb1.hidden = YES;
    [_imageView1 addSubview:_loadingLb1];
    
    // 图片
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_imageView1.frame)+10, screen_width-100, 100)];
    _imageView2.contentMode = UIViewContentModeScaleAspectFill;
    _imageView2.backgroundColor = [UIColor lightGrayColor];
    _imageView2.clipsToBounds = YES;
    [self.view addSubview:_imageView2];
    
    // 加载
    _loadingLb2 = [[UILabel alloc] initWithFrame:_imageView2.bounds];
    _loadingLb2.backgroundColor = [UIColor clearColor];
    _loadingLb2.textAlignment = NSTextAlignmentCenter;
    _loadingLb2.text = @"加载中...";
    _loadingLb2.hidden = YES;
    [_imageView2 addSubview:_loadingLb2];
}

// 置空
- (void)zhikong {
    _imageView1.image = nil;
    _loadingLb1.hidden = NO;
}
- (void)zhikong2 {
    _imageView1.image = nil;
    _loadingLb1.hidden = NO;
    _imageView2.image = nil;
    _loadingLb2.hidden = NO;
}

#warning 1111👇👇👇👇
// @"global queue, 后台执行"
- (void)buttondianjishijian1 {
    [self zhikong]; // 置空
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self loadImageSource:_imgUrl1];
    });
}

#warning 2222👇👇👇👇
// @"main queue, UI线程执行(只是为了测试,长时间的加载不能放在主线程)"
- (void)buttondianjishijian2 {
    [self zhikong]; // 置空
    NSLog(@"这是在主线程执行的，只是为了测试,长时间的加载不能放在主线程");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadImageSource:_imgUrl1];
    });
}

#warning 3333👇👇👇👇
// @"dispatch once, 一次性执行(常用来写单例)"
- (void)buttondianjishijian3 {
    [self zhikong]; // 置空
    NSLog(@"这是在主线程执行的，并且是一个单例，只会执行一次");
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadImageSource:_imgUrl1];
    });
}

#warning 4444👇👇👇👇
// @"dispatch apply, 并发地执行循环迭代"
- (void)buttondianjishijian4 {
    [self zhikong]; // 置空
    NSLog(@"这个是打印出来了，循环打印的");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = 10;
    dispatch_apply(count, queue, ^(size_t i) {
        NSLog(@"循环执行第%li次",i);
        //[self loadImageSource:imgUrl1];
    });
}

#warning 5555👇👇👇👇
// @"global queue 2,后台执行：加载两张图片"
- (void)buttondianjishijian5 {
    [self zhikong2]; // 置空
    
    // 在子线程下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 下载两张图片
        UIImage *image1 = [self loadImage:_imgUrl1];
        UIImage *image2 = [self loadImage:_imgUrl2];
        
        // 在主线程设置两张图片
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView1.image = image1;
            _imageView2.image = image2;
        });
    });
}

#warning 6666👇👇👇👇
// @"dispatch group, 并发线程组"
- (void)buttondianjishijian6 {
    [self zhikong2]; // 置空
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_group_t group = dispatch_group_create();
        
        __block UIImage *image1 = nil;
        __block UIImage *image2 = nil;
        
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            image1 = [self loadImage:_imgUrl1];
        });
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            image2 = [self loadImage:_imgUrl2];
        });
        
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            _imageView1.image = image1;
            _loadingLb1.hidden = YES;
            
            _imageView2.image = image2;
            _loadingLb2.hidden = YES;
        });
    });
}

#warning 7777👇👇👇👇
// @"dispatch after, 延迟执行"
- (void)buttondianjishijian7 {
    [self zhikong]; // 置空
    
    NSLog(@"延迟2秒");
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self loadImageSource:_imgUrl1];
    });
}

#warning 8888👇👇👇👇
// @"define dispatch, 自定义dispatch_queue_t"
- (void)buttondianjishijian8 {
    [self zhikong]; // 置空
    
    dispatch_queue_t urls_queue = dispatch_queue_create("minggo.app.com", NULL);
    dispatch_async(urls_queue, ^{
        [self loadImageSource:_imgUrl1];
    });
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

// 这里只是下载图片 没有设置图片 所以不需要在子线程执行
-(UIImage *)loadImage:(NSString *)url{
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]; // 下载数据
    UIImage *image = [UIImage imageWithData:imgData];                           // 转化为图片
    if (image!=nil) {
        return image;
    }else{
        NSLog(@"there no image data");
        return image;
    }
    
}

-(void)refreshImageView:(UIImage *)image{
    // 在主线程设置图片
    _imageView1.image = image;
    _loadingLb1.hidden = YES;
}


@end
