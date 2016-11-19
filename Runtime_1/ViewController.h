//
//  ViewController.h
//  Runtime_1
//
//  Created by 三米 on 16/11/16.
//  Copyright © 2016年 三米. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property int integer;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *str;
- (instancetype)initWithInteger:(int)integer str:(NSString *)str array:(NSArray *)array;
-(void)show;

@end

