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
        _privateCities = [[NSMutableArray alloc] init];
//        WYJDiaryItem *diary = [[WYJDiaryItem alloc] initWithTitle:@"未命名新日记" content:@"调整内心,写点东西"];
//        [_privateItems addObject:diary];
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

@end
