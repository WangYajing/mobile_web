//
//  WYJLocationManager.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/4/27.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface WYJLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@end

static WYJLocationManager *_shardLocationManager = nil;
@implementation WYJLocationManager

+ (instancetype)sharedLocationManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shardLocationManager = [[WYJLocationManager alloc] init];
    });
    return _shardLocationManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shardLocationManager = [super allocWithZone:zone];
    });
    return _shardLocationManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _geocoder = [[CLGeocoder alloc] init];
        // 设置代理
        _locationManager.delegate = self;
        
        // 设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 设置定位频率
        CLLocationDistance distance = 10;
        _locationManager.distanceFilter = distance;
    }
    return self;
}

- (void)startUpdateLocation {
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations[0];//取出第一个位置
    CLLocationCoordinate2D cordinate = location.coordinate;//位置坐标
    
    //根据经纬度获取地名
    [self getAddressByLatitude:cordinate.latitude longitude:cordinate.longitude];
    
    //使用完关闭定位服务
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            // 开始定位
            [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"定位服务没有开启,请前往设置中开启");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"定位受限");
            break;
        default:
            break;
    }
}

#pragma mark - 地理反编码
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            self.updateLocationHandler(error, nil);
        } else {
            CLPlacemark *placemark = placemarks[0];
            NSLog(@"%@",placemark.addressDictionary);
            self.updateLocationHandler(nil,placemark.addressDictionary);
        }
    }];
}

@end
