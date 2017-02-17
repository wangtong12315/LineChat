//
//  LineChatView.h
//  LineChat
//
//  Created by wangtong on 2017/2/17.
//  Copyright © 2017年 wangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChatView : UIView

@property(nonatomic,strong)void(^btnClick)(NSInteger tag);

- (void)setData:(NSMutableArray *)yPointArray x_SiteArray:(NSMutableArray *)x_SiteArray;

@end
