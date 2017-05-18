//
//  WYJDiaryStore.m
//  MyDiary
//
//  Created by 王亚静 on 2017/4/12.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJDiaryStore.h"
#import "WYJDiaryItem.h"
@interface WYJDiaryStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation WYJDiaryStore

+ (instancetype)sharedStore {
    static WYJDiaryStore *sharedStore = nil;
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
        _privateItems = [[NSMutableArray alloc] init];
        WYJDiaryItem *diary = [[WYJDiaryItem alloc] initWithTitle:@"未命名新日记" content:@"调整内心,写点东西"];
        [_privateItems addObject:diary];
    }
    return self;
}

- (NSArray*)allItems {
    return [self.privateItems copy];
}

- (void)addDiary:(WYJDiaryItem *)diary {
    [self.privateItems addObject:diary];
}

- (void)removeDiary:(WYJDiaryItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)updateDiaryAtIndex:(NSInteger) index withDiary:(WYJDiaryItem *)diary  {
    [self.privateItems replaceObjectAtIndex:index withObject:diary];
}

- (void)moveDiaryAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    //得到要移动的对象的指针
    WYJDiaryItem *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
