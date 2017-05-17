//
//  PageScrollView.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/17.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "PageScrollView.h"

@implementation PageScrollView
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        // 处于第一页且向左滑时
        if (self.contentOffset.x == 0 && [pan translationInView:self].x > 0) {
            return NO;
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
