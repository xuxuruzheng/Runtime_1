//
//  Dog.h
//  Runtime_1
//
//  Created by 三米 on 16/11/16.
//  Copyright © 2016年 三米. All rights reserved.
//

/** 1.关联对象  UILabel+SuiBian */

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Dog : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;


@end
