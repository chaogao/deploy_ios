//
//  CenterDataSource.h
//  FireCenter
//
//  Created by gaochao on 16/10/4.
//  Copyright © 2016年 gaochao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SourceItem;

@interface CenterDataSource : NSObject

+(instancetype)shareStore;

@property (nonatomic, readonly) NSArray * allItems;

- (SourceItem *)createItem:(NSString *)count;

- (SourceItem *)createItem:(NSString *)count forIndex:(NSString *) index;

- (void)removeItem:(SourceItem *)item;

- (void)moveItem:(NSInteger)fromIndex to:(NSInteger)toIndex;

@end
