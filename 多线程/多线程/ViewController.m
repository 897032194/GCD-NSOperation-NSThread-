//
//  ViewController.m
//  多线程
//
//  Created by 连京帅 on 2017/4/11.
//  Copyright © 2017年 chuang. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

#import "NSThreadViewController.h"
#import "NSOpertionViewController.h"
#import "GCDViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"线程";
    
    [self TableView];
}


- (void)TableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseID = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.font = [UIFont systemFontOfSize:13];
    }
    
    if (indexPath.row == 0) {
        cell.label.text = @"NSThread Load Picture.  NSThread下载图片";
    }
    else if (indexPath.row == 1) {
        cell.label.text = @"NSOpertion Load Picture.  NSOpertion下载图片";
    }
    else if (indexPath.row == 2) {
        cell.label.text = @"GCD Load Picture.  GCD下载图片";
    }
    
    return cell;
}

// 返回每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// cell的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

// cell 回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NSThreadViewController *nsThreadVC = [[NSThreadViewController alloc] init];
        [self.navigationController pushViewController:nsThreadVC animated:YES];
    }
    else if (indexPath.row == 1) {
        NSOpertionViewController *nsThreadVC = [[NSOpertionViewController alloc] init];
        [self.navigationController pushViewController:nsThreadVC animated:YES];
    }
    else if (indexPath.row == 2) {
        GCDViewController *nsThreadVC = [[GCDViewController alloc] init];
        [self.navigationController pushViewController:nsThreadVC animated:YES];
    }
    
}

@end
