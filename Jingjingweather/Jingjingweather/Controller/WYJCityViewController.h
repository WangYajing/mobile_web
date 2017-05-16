//
//  WYJCityViewController.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/4/27.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYJCityViewController : UIViewController
@property (nonatomic, assign) NSUInteger page;
- (id)initWithPageNumber:(NSUInteger)page cityName:(NSString *)cityName;
@end
