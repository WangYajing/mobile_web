//
//  DownLoadData.m
//  jingjignWeather
//
//  Created by 王亚静 on 16/6/14.
//  Copyright © 2016年 王亚静. All rights reserved.
//

#import "DownLoadData.h"
#import "AFAppDotNetAPIClient.h"
#import "WYJRealTimeInfo.h"
#import "WYJForecast.h"
#import "WYJDateManager.h"

const NSString *APIKey = @"b6f5f239bb8e4bc1802c0644788aa3b8";

static DownLoadData *instance = nil;

@implementation DownLoadData

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

+ (NSURLSessionDataTask *)getRealTimeDataWithBlock:(void (^)(NSArray *, NSError *))block andCityID:(NSString*)cityID {
    
    NSString *URL = [NSString stringWithFormat:@"?city=%@&key=%@",cityID,APIKey];
    NSString *URLString = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSDictionary *dict = responseObject[@"HeWeather5"][0];
        NSDictionary *now  = dict[@"now"];
        NSDictionary *aqi  = dict[@"aqi"][@"city"];
        
        WYJRealTimeInfo *realTimeInfo = [[WYJRealTimeInfo alloc] init];
        realTimeInfo.condition     = now[@"cond"][@"txt"];
        realTimeInfo.condCode      = now[@"cond"][@"code"];
        realTimeInfo.humidity      = now[@"hum"];
        realTimeInfo.precipitation = now[@"pcpn"];
        realTimeInfo.pressure      = now[@"pres"];
        realTimeInfo.temperature   = now[@"tmp"];
        realTimeInfo.visibility    = now[@"vis"];
        realTimeInfo.aqi           = aqi[@"aqi"];
        realTimeInfo.aqiQuality    = aqi[@"qlty"];
        realTimeInfo.windDirection = now[@"wind"][@"dir"];
        realTimeInfo.windScale     = now[@"wind"][@"sc"];
        
        NSArray *forecastArray = dict[@"daily_forecast"];
        NSMutableArray *forecasts = [NSMutableArray arrayWithCapacity:0];
        
        [forecastArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WYJForecast *forecast = [[WYJForecast alloc] init];
            NSString *dateString = obj[@"date"];
            NSString *date = [WYJDateManager transformDateToFomat:@"M.d" formFormat:@"yyyy-MM-dd" DateString:dateString];
            NSString *weekday   = [WYJDateManager transformDateToFomat:@"EEE" formFormat:@"yyyy-MM-dd" DateString:dateString];
            if (idx == 0) {
                forecast.weekday = @"今天";
            } else {
               forecast.weekday    = weekday;
            }
            forecast.date       = date;
            forecast.code_d     = obj[@"cond"][@"code_d"];
            forecast.code_n     = obj[@"cond"][@"code_n"];
            forecast.txt_d      = obj[@"cond"][@"txt_d"];
            forecast.txt_n      = obj[@"cond"][@"txt_n"];
            forecast.tmp_max    = obj[@"tmp"][@"max"];
            forecast.tmp_min    = obj[@"tmp"][@"min"];
            forecast.uv         = obj[@"uv"];
            forecast.pop        = obj[@"pop"];
            forecast.pcpn       = obj[@"pcpn"];
            forecast.humidity   = obj[@"hum"];
            forecast.pressure   = obj[@"pres"];
            forecast.visibility = obj[@"vis"];
            
            [forecasts addObject:forecast];
        }];
        
        block(@[realTimeInfo,forecasts],nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
@end
