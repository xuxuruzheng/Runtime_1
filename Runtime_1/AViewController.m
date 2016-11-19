//
//  AViewController.m
//  Runtime_1
//
//  Created by 三米 on 16/11/16.
//  Copyright © 2016年 三米. All rights reserved.
//

/** 3.动态添加方法  AViewController */


#import "AViewController.h"
#import <objc/runtime.h>
#import "Dog.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillApper");
}


/*三：动态添加方法
 重写了拦截调用的方法并且返回了YES，我们要怎么处理呢？
 有一个办法是根据传进来的SEL类型的selector动态添加一个方法。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐式调用方法
    [self performSelector:@selector(resolveAdd:) withObject:@"test" afterDelay:1];
    
}
void runAddMethod(id self, SEL _cmd, NSString *string){
    NSLog(@"add C IMP %@", string);
}

//拦截调用
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"resolveAdd:"]) {
        class_addMethod(self, sel, (IMP)runAddMethod, "v@:*");
    }
    return YES;
}

/**
 拦截调用:
 在方法调用中说到了，如果没有找到方法就会转向拦截调用。
 那么什么是拦截调用呢。
 拦截调用就是，在找不到调用的方法程序崩溃之前，你有机会通过重写NSObject的四个方法来处理。
 
 + (BOOL)resolveClassMethod:(SEL)sel;
 + (BOOL)resolveInstanceMethod:(SEL)sel;
 //后两个方法需要转发到其他的类处理
 - (id)forwardingTargetForSelector:(SEL)aSelector;
 - (void)forwardInvocation:(NSInvocation *)anInvocation;
 
 第一个方法是当你调用一个不存在的类方法的时候，会调用这个方法，默认返回NO，你可以加上自己的处理然后返回YES。
 第二个方法和第一个方法相似，只不过处理的是实例方法。
 第三个方法是将你调用的不存在的方法重定向到一个其他声明了这个方法的类，只需要你返回一个有这个方法的target。
 第四个方法是将你调用的不存在的方法打包成NSInvocation传给你。做完你自己的处理后，调用invokeWithTarget:方法让某个target触发这个方法。
 
 原文链接：http://www.jianshu.com/p/927c8384855a
 */

@end
