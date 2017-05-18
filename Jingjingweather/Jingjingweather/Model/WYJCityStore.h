//
//  WYJCityStore.h
//  MyDiary
//
//  Created by 王亚静 on 2017/4/12.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WYJDiaryItem;

@interface WYJDiaryStore : NSObject
@property (nonatomic, readonly) NSArray *allItems;
+ (instancetype)sharedStore;

- (void)addDiary:(WYJDiaryItem *) diary;
- (void)removeDiary:(WYJDiaryItem *) item;
- (void)moveDiaryAtIndex:(NSInteger) fromIndex toIndex:(NSInteger) toIndex;
- (void)updateDiaryAtIndex:(NSInteger) index withDiary:(WYJDiaryItem *)diary;
@end
