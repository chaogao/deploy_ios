//
//  CenterDataSource.m
//  FireCenter
//
//  Created by gaochao on 16/10/4.
//  Copyright © 2016年 gaochao. All rights reserved.
//

#import "CenterDataSource.h"
#import "SourceItem.h"

@interface CenterDataSource()

@property (nonatomic) NSMutableArray * privateItems;

@end

@implementation CenterDataSource

+(instancetype)shareStore {
    static CenterDataSource * centerDataSource = nil;
    
    if (!centerDataSource) {
        centerDataSource = [[self alloc] initPrivate];
    }
    
    return centerDataSource;
}

-(instancetype) initPrivate {
    self = [super init];
    
    if (self) {
        self.privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) removeItem:(SourceItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void) moveItem:(NSInteger)fromIndex to:(NSInteger)toIndex {
    SourceItem * item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectIdenticalTo:item];
    
    [self.privateItems insertObject:item atIndex:toIndex];
}

-(NSArray *) allItems {
    return [self.privateItems copy];
}

-(SourceItem *)createItem:(NSString *)count {
    SourceItem * item = [[SourceItem alloc] initWithIndex:count];
    
    [self.privateItems addObject:item];
    
    return item;
}


@end
