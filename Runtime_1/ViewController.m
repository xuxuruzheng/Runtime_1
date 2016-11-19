//
//  ViewController.m
//  Runtime_1
//
//  Created by 三米 on 16/11/16.
//  Copyright © 2016年 三米. All rights reserved.
//

/**
 runtime的理解
 1.关联对象  UILabel+SuiBian
 2.方法交换  UIViewController+SuiBian
 3.动态添加方法  AViewController
 具体讲解的文章：
 http://www.jianshu.com/p/927c8384855a
 */

#import "ViewController.h"
#import <objc/runtime.h>
#import "Dog.h"
#import "UILabel+SuiBian.h"
#import "AViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark -- runtime 获取 属性列表  方法列表 成员变量列表 协议列表
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    [self setStr:@"haha" array:@[@23,@12,@45] integer:15];
    
    
#pragma mark -- 关联对象
    //关联对象
    UILabel *label = [UILabel new];
    label.name = @"123";
    NSLog(@"name = %@",label.name);

    AViewController *avc = [AViewController new];
    [self presentViewController:avc animated:YES completion:nil];
    
#pragma mark -- 使用runtime获取私有成员,然后使用KVC赋值
    //获取dog 的成员变量列表
    Ivar *dogList = class_copyIvarList([Dog class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar dogIvar = dogList[i];
        const char *ivarName = ivar_getName(dogIvar);
        NSLog(@"dogIvarName == %@",[NSString stringWithUTF8String:ivarName]);
    }
    //使用KVC进行赋值
    Dog *dog = [[Dog alloc]init];
    [dog setValue:@"汪汪" forKey:@"name"];
    NSString *dogName = [dog valueForKey:@"name"];
    NSLog(@"dogName == %@",dogName);
    
}






#pragma mark --- 测试用到的方法
- (instancetype)initWithInteger:(int)integer str:(NSString *)str array:(NSArray *)array
{
    if (self = [super init]) {
        _str = [str copy];
        _array = array;
        _integer = integer;
    }
    return self;
}

-(void)setStr:(NSString *)str array:(NSArray *)array integer:(int)integer
{
    _str = str;
    _array = array;
    _integer = integer;
}


@end
