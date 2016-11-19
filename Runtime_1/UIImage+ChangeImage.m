//
//  UIImage+ChangeImage.m
//  Runtime_1
//
//  Created by 三米 on 16/11/17.
//  Copyright © 2016年 三米. All rights reserved.
//

/** 判断系统版本使用图片 */

#import "UIImage+ChangeImage.h"
#import <objc/runtime.h>

@implementation UIImage (ChangeImage)

+(void)load
{
    /**
     *  通过class_getInstanceMethod()函数从当前对象中的method list 获取method结构体,如果是类方法就使用class_getClassMethod()函数获取
     *
     *  @param class]     类
     *  @param suiBianXie 对象方法(减号方法)
     *
     *  @return 返回哪个类中的减号方法
     */
    //    Method methodObject = class_getInstanceMethod([self class], @selector(suiBianXie));
    
    //获取两个类的类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(xx_imageNamed:));
    
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)xx_imageNamed:(NSString *)name
{
    double verSion = [UIDevice currentDevice].systemVersion.doubleValue;
    if (verSion >= 7.0) {
        //如果系统版本是7.0以上, 使用另外一套文件名结尾是'_os7'的图片
        name = [name stringByAppendingString:@"_os7"];
    }
    UIImage *image = [UIImage xx_imageNamed:name];
    if (image == nil) {
        NSLog(@"图片没有加载出来");
    }
    return [UIImage xx_imageNamed:name];
}




@end
