//
//  ViewController.m
//  LineChat
//
//  Created by wangtong on 2017/2/17.
//  Copyright © 2017年 wangtong. All rights reserved.
//

#import "ViewController.h"
#import "LineChatView.h"
#import "ColumnChatView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet LineChatView *lineChatView;
@property (weak, nonatomic) IBOutlet ColumnChatView *columView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.lineChatView setData:[@[@50,@30,@70,@20,@90,@50,@30,@70,@20,@90] mutableCopy] x_SiteArray:[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"] mutableCopy]];
    
    //获取到点击的button
    self.lineChatView.btnClick = ^(NSInteger tag){
    
        NSLog(@"%ld",tag);
    
    };
    
    
    //柱形图
    self.columView.headTitle = @"柱形图";
    self.columView.x_Array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    self.columView.y_Array = [NSMutableArray arrayWithObjects:@"1",@"4",@"3",@"2",@"4",@"5",@"3", nil];
}

@end
