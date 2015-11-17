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
/**
 *  @brief set the layout constraint for object's width stretchy.
 *  set the layout constraint for object's width stretchy when object's superview's or relation view's frame be changed, or device orientation be changed.
 *
 *  @param subView                  the subview for auto layout.
 *  @param top                      reference value for subview's top position.
 *  @param height                   reference value for subview's height.
 *  @param superView                relation view for subview.
 *
 *  @return YES|NO                  method success or failure
 */
+ ( BOOL ) constraintForWidthStretchy:(UIView *)subView top:(CGFloat)top height:(CGFloat)height in:(UIView *)superView;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set the layout constraint for object's width stretchy.
 *  set the layout constraint for object's width stretchy when object's superview's or relation view's frame be changed, or device orientation be changed.
 *
 *  @param subView                  the subview for auto layout.
 *  @param bottom                   reference value for subview's bottom positioin.
 *  @param height                   reference value for subview's height.
 *  @param superView                relation view for subview.
 *
 *  @return YES|NO                  method success or failure
 */
+ ( BOOL ) constraintForWidthStretchy:(UIView *)subView bottom:(CGFloat)bottom height:(CGFloat)height in:(UIView *)superView;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
