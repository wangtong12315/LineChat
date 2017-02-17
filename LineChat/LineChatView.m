//
//  LineChatView.m
//  LineChat
//
//  Created by wangtong on 2017/2/17.
//  Copyright © 2017年 wangtong. All rights reserved.
//

#import "LineChatView.h"

#define XStartPoint 40

@implementation LineChatView
{
    CGFloat cellHeight;
    NSMutableArray * yValueArray;
    NSMutableArray * xSiteArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    cellHeight = self.frame.size.height / 12;
    [self addBaseLine];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        cellHeight = self.frame.size.height / 12;
        
        [self addBaseLine];
    }
    return self;
}

- (void)addBaseLine{
    
    for (int i = 0; i < 11; i ++) {
        if (i == 3) {
            [self addLineImage:CGRectMake(XStartPoint, cellHeight * (i + 1), self.frame.size.width - XStartPoint, 0.5) image:@"line_red"];
        }else{
            [self addLineImage:CGRectMake(XStartPoint, cellHeight * (i + 1), self.frame.size.width - XStartPoint, 0.5) image:@"imaginary_line_02"];
        }
        if (i%2 == 0) {
            [self addlable:CGRectMake(0, (i + 1) * cellHeight - 8, XStartPoint, 16) textFont:11 alignment:NSTextAlignmentCenter text:[NSString stringWithFormat:@"%d%%",100 - i * 10]];
        }
    }
    
}


- (void)drawRect:(CGRect)rect {
    //防止越界
    if (xSiteArray.count == yValueArray.count && xSiteArray.count > 0) {
        CGFloat perXwith = (self.frame.size.width -XStartPoint)/xSiteArray.count;
        //添加X轴刻度
        for (int i = 0; i < xSiteArray.count; i ++) {
            UILabel * xLable = [self addlable:CGRectMake(XStartPoint + perXwith * i, cellHeight * 11, perXwith, 16) textFont:12 alignment:NSTextAlignmentCenter text:xSiteArray[i]];
            xLable.tag = 100 + i;
            if (i == xSiteArray.count - 1) {
                xLable.textColor = [UIColor redColor];
            }
        }
        
        UIColor * blackColor = [UIColor redColor];
        [blackColor set];
        // 创建path
        UIBezierPath *path = [UIBezierPath bezierPath];
        //        [path moveToPoint:CGPointMake(XStartPoint , cellHeight * 11)];//起点，可编辑 00开始的
        [path moveToPoint:CGPointMake(XStartPoint + perXwith/2,cellHeight +  (1 - [yValueArray[0] floatValue]/100) * (cellHeight * 10))];
        
        
        for (int i = 0; i < yValueArray.count; i ++) {
            [path addLineToPoint:CGPointMake(XStartPoint + perXwith * i + perXwith/2,cellHeight +  (1 - [yValueArray[i] floatValue]/100) * (cellHeight * 10))];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 1000 + i;
            button.frame = CGRectMake(XStartPoint + perXwith * i + perXwith/2 - 10,cellHeight +  (1 - [yValueArray[i] floatValue]/100) * (cellHeight * 10) - 10, 20, 20);
            [button setImage:[UIImage imageNamed:@"circleEmpty"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"icon_indication_point"] forState:UIControlStateSelected];
            button.layer.cornerRadius = 6;
            [button addTarget:self action:@selector(showBtnTag:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            if (i == yValueArray.count - 1) {
                button.selected = YES;
            }
        }
        
        // 将path绘制出来
        [path stroke];
        
    }
    
}

- (void)setData:(NSMutableArray *)yPointArray x_SiteArray:(NSMutableArray *)x_SiteArray{
    yValueArray = yPointArray;
    xSiteArray = x_SiteArray;
    [self setNeedsDisplay];
}

- (void)showBtnTag:(UIButton *)sender{
    
    for (UIView * view in sender.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)view;
            btn.selected = NO;
        }
        
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel * selLable = (UILabel *)view;
            if (selLable.tag - 100 == sender.tag - 1000) {
                selLable.textColor = [UIColor redColor];
            }else{
                selLable.textColor = [UIColor lightGrayColor];
            }
        }
    }
    
    
    
    sender.selected = YES;
    
    if (self.btnClick) {
        self.btnClick(sender.tag);
    }
    
}

- (UILabel *)addlable:(CGRect)frame textFont:(CGFloat)textFont alignment:(NSTextAlignment)alignment text:(NSString *)text{
    UILabel * lable = [[UILabel alloc] initWithFrame:frame];
    lable.font = [UIFont systemFontOfSize:textFont];
    lable.textAlignment = alignment;
    lable.textColor = [UIColor lightGrayColor];
    lable.text = text;
    [self addSubview:lable];
    return lable;
}

- (void)addLineImage:(CGRect)frame image:(NSString *)image{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    [self addSubview:imageView];
}

@end

