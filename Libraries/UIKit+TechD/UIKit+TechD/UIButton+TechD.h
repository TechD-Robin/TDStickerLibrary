//
//  UIButton+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/5/27.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

@interface UIButton (TechD)

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset;

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted
                          disabled:(UIImage *)disabled selected:(UIImage *)selected origin:(CGPoint)offset;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
