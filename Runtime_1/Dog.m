//
//  Dog.m
//  Runtime_1
//
//  Created by 三米 on 16/11/16.
//  Copyright © 2016年 三米. All rights reserved.
//

#import "Dog.h"

//首先定义一个全局变量，用它的地址作为关联对象的key
static char associatedObjectKey;

@implementation Dog

////添加关联对象
//- (void)addAssociatedObject:(id)object{
//    objc_setAssociatedObject(self, @selector(getAssociatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
////获取关联对象
////这里面我们把getAssociatedObject方法的地址作为唯一的key，_cmd代表当前调用方法的地址。
//- (id)getAssociatedObject{
//    return objc_getAssociatedObject(self, _cmd);
//}

//- (void)setName:(NSString *)name
//{
//    objc_setAssociatedObject(self, &associatedObjectKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSString *)name
//{
//    return objc_getAssociatedObject(self, &associatedObjectKey);
//}
//

@end
