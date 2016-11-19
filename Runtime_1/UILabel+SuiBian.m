//
//  UILabel+SuiBian.m
//  Runtime_1
//
//  Created by 三米 on 16/11/16.
//  Copyright © 2016年 三米. All rights reserved.
//

#import "UILabel+SuiBian.h"
#import <objc/runtime.h>

//首先定义一个全局变量，用它的地址作为关联对象的key
static char associatedObjectKey;

//static char *associated;
@implementation UILabel (SuiBian)

/*一：关联对象
 现在你准备用一个系统的类，但是系统的类并不能满足你的需求，你需要额外添加一个属性。
 这种情况的一般解决办法就是继承。
 但是，只增加一个属性，就去继承一个类，总是觉得太麻烦类。
 这个时候，runtime的关联属性就发挥它的作用了。
 http://www.jianshu.com/p/927c8384855a
 */

//1.小群的方法
- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, &associatedObjectKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, &associatedObjectKey);
}

//2.
//添加关联对象
//这里面我们把getAssociatedObject方法的地址作为唯一的key，_cmd代表当前调用方法的地址。
- (void)addAssociatedObject:(id)object{
    objc_setAssociatedObject(self, @selector(getAssociatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//获取关联对象
- (id)getAssociatedObject{
    return objc_getAssociatedObject(self, _cmd);
}


/** 去除字符串中的null */
+(void)load
{
    [super load];
    Method method = class_getInstanceMethod([self class], @selector(setText:));
    Method removeMethod = class_getInstanceMethod([self class], @selector(removeNullSetText:));
    method_exchangeImplementations(method, removeMethod);
}

- (void)removeNullSetText:(NSString *)string
{
    if (string == nil || [string isEqualToString:@"(null)"]) {
        string = @"";
    }
#pragma mark ----字符串中包含某个字符串
    else if ([string rangeOfString:@"(null)"].location != NSNotFound)
    {
#pragma mark ----使用某字符串代替原来的字符串
        string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    [self removeNullSetText:string];
}







@end
