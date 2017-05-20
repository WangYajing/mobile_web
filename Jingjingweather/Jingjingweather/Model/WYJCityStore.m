//
//  WYJDiaryStore.m
//  MyDiary
//
//  Created by 王亚静 on 2017/4/12.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJCityStore.h"
@interface WYJCityStore()
@property (nonatomic) NSMutableArray *privateCities;
@end

@implementation WYJCityStore

+ (instancetype)sharedStore {
    static WYJCityStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[WYJDiaryStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *historyArchivePath = [docPath stringByAppendingPathComponent:@"history.dat"];
        _privateCities = [NSKeyedUnarchiver unarchiveObjectWithFile:historyArchivePath];
        if (!_privateCities || _privateCities.count == 0) {
            WYJCity *defaultCity = [[WYJCity alloc] init];
            defaultCity.cityZh = @"北京";
            _privateCities = [NSMutableArray arrayWithCapacity:0];
            [_privateCities addObject:defaultCity];
        }
        
    }
    return self;
}

- (NSArray *)allCities {
    return [self.privateCities copy];
}

- (void)addCity:(WYJCity *)city {
    [self.privateCities addObject:city];
}

- (void)removeCity:(WYJCity *)city {
    [self.privateCities removeObjectIdenticalTo:city];
}

- (void)updateCityAtIndex:(NSInteger) index withCity:(WYJCity *)city  {
    [self.privateCities replaceObjectAtIndex:index withObject:city];
}

- (void)moveCityAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    //得到要移动的对象的指针
    WYJCity *item = self.privateCities[fromIndex];
    
    [self.privateCities removeObjectAtIndex:fromIndex];
    [self.privateCities insertObject:item atIndex:toIndex];
}

- (void)saveHistoryCities {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *historyArchivePath = [docPath stringByAppendingPathComponent:@"history.dat"];
    BOOL success = [NSKeyedArchiver archiveRootObject:_privateCities toFile:historyArchivePath];
    if (success) {
        NSLog(@"归档成功");
    }
}

@end
