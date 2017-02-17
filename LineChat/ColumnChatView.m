//
//  ColumnChatView.m
//  LineChat
//
//  Created by wangtong on 2017/2/17.
//  Copyright © 2017年 wangtong. All rights reserved.
//


#import "ColumnChatView.h"
#define XStartPoint 20

@implementation ColumnChatView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat cellHeight = self.frame.size.height / 6;
    
    //添加每一个开头的标题
    [self addlable:CGRectMake(XStartPoint, 0,self.frame.size.width - XStartPoint * 2 , cellHeight) textFont:14 alignment:NSTextAlignmentCenter text:_headTitle];
    
    for (int i = 0; i < 5; i ++) {
        
        if (i == 2) {
            [self addLineImage:CGRectMake(XStartPoint, (i + 1) * cellHeight, self.frame.size.width - XStartPoint, 0.5) image:@"line_red"];
        }else{
            [self addLineImage:CGRectMake(XStartPoint, (i + 1) * cellHeight, self.frame.size.width - XStartPoint, 0.5) image:@"imaginary_line_02"];
        }
        
        //添加Y轴刻度
        [self addlable:CGRectMake(0, (i + 1) * cellHeight - 8, XStartPoint, 16) textFont:12 alignment:NSTextAlignmentCenter text:[NSString stringWithFormat:@"%d",5 - i]];
    }
    
    CGFloat perXwith = (self.frame.size.width -XStartPoint)/7;
    //添加X轴刻度
    for (int i = 0; i < _x_Array.count; i ++) {
        [self addlable:CGRectMake(XStartPoint + perXwith * i, cellHeight * 5 + 5, perXwith, 16) textFont:12 alignment:NSTextAlignmentCenter text:_x_Array[i]];
    }
    
    //绘制柱形高度
    for (int i = 0; i < _y_Array.count; i++) {
        
        CGFloat actYheight = [_y_Array[i] floatValue] * cellHeight - cellHeight;
        CGFloat yStart = cellHeight + cellHeight * 4 -actYheight;
        if ([_y_Array[i] floatValue] <= 1) {
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(XStartPoint + i * perXwith + perXwith/2 - 7.5, yStart, 15, 1)];
            lable.backgroundColor = [UIColor greenColor];
            [self addSubview:lable];
        }else{
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(XStartPoint + i * perXwith + perXwith/2 - 7.5, yStart, 15, actYheight)];
            [self addSubview:lable];
            
            if ([_y_Array[i] floatValue] > 3) {
                lable.backgroundColor = [UIColor redColor];
            }else{
                lable.backgroundColor = [UIColor greenColor];
            }
        }
        
    }
    
}

- (void)addlable:(CGRect)frame textFont:(CGFloat)textFont alignment:(NSTextAlignment)alignment text:(NSString *)text{
    UILabel * lable = [[UILabel alloc] initWithFrame:frame];
    lable.font = [UIFont systemFontOfSize:textFont];
    lable.textAlignment = alignment;
    lable.text = text;
    lable.textColor = [UIColor lightGrayColor];
    [self addSubview:lable];
}

- (void)addLineImage:(CGRect)frame image:(NSString *)image{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    [self addSubview:imageView];
}

@end

