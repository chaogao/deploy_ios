//
//  SourceItem.h
//  FireCenter
//
//  Created by gaochao on 16/10/4.
//  Copyright © 2016年 gaochao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceItem : NSObject

-(instancetype) initWithIndex:(NSString *) index;

-(NSString *) getDesc;

-(void) setDescription:(NSString *)desc;

@end
