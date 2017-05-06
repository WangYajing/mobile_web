//
//  WYJDateManager.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/6.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJDateManager.h"

@implementation WYJDateManager
+ (NSString *)weekday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSInteger index = [components weekday];
    NSArray *weekArray = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    return weekArray[index-1];

}

+ (NSString *)dateWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:[NSDate date]];
    
}

+ (NSString *)transformDateToFomat:(NSString *)toFormat formFormat:(NSString *)fromFormat DateString:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromFormat];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:toFormat];
    return [formatter stringFromDate:date];
}
@end
