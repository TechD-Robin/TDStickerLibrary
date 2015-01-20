//
//  NSLayoutConstraint+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/1/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
@interface NSLayoutConstraint (TechD)

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) constraintForWidthStretchy:(UIView *)subView top:(CGFloat)top height:(CGFloat)height in:(UIView *)superView;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
