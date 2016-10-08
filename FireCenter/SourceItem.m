//
//  SourceItem.m
//  FireCenter
//
//  Created by gaochao on 16/10/4.
//  Copyright © 2016年 gaochao. All rights reserved.
//

#import "SourceItem.h"

@interface SourceItem()

@property (nonatomic) NSString * desc;

@end

@implementation SourceItem

-(instancetype) initWithIndex:(NSString *)index {
    self = [super init];
    
    [self setRandomDescription:index];
    
    return self;
}

-(void)setRandomDescription:(NSString *)index {
    self.desc = [[NSString alloc] initWithFormat:@"%@%@",@"hellworld-", index];
}

-(void)setDescription:(NSString *)desc {
    self.desc = desc;
}

-(NSString *)getDesc{
    return self.desc;
}

@end
