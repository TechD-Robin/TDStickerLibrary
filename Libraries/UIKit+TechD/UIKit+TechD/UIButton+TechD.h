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
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a button object with image of normal and highlighted state.
 *  create a button object with image of normal and highlighted state.
 *
 *  @param image                    normal image.
 *  @param highlighted              highlighted image.
 *  @param offset                   offset of origin position.
 *
 *  @return object|nil              the button object or nil.
 */
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a button object with image of several states.
 *
 *  @param image                    normal image.
 *  @param highlighted              highlighted image.
 *  @param disabled                 disabled image.
 *  @param selected                 selected image.
 *  @param offset                   offset of origin position.
 *
 *  @return object|nil              the button object or nil.
 */
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted
                          disabled:(UIImage *)disabled selected:(UIImage *)selected origin:(CGPoint)offset;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for change imageView's position.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief change image view to title label's right side.
 *  change image view to title label's right side, the method must has title's object , otherwise has not effect of change.
 *  in this method has used sizeToFit, that will change object's initial size.
 *
 *  @param offsetX                  offset of X after position is changed. ( value > 0 is move to right, else is move to left )
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) changeImageToTitleRightSide:(CGFloat)offsetX;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief enforce move image view to new position for horizontal alignment.
 *  enforce move image view to new position for horizontal alignment,
 *  this method will ignore the property UIControl's contentHorizontalAlignment for imageView.
 *
 *  @param imageAlignment           image's horizontal alignment. ( UI...Fill has no effect. )
 *  @param offsetX                  offset of X after position is changed. ( value > 0 is move to right, else is move to left )
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) enforceMoveImageHorizontalAlignment:(UIControlContentHorizontalAlignment)imageAlignment offset:(CGFloat)offsetX;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief enforce move image view to new position for vertical alignment.
 *  enforce move image view to new position for vertical alignment,
 *  this method will ignore the property UIControl's contentVerticalAlignment for imageView.
 *
 *  @param imageAlignment           image's vertical alignment. ( UI...Fill has no effect. )
 *  @param offsetY                  offset of Y after position is changed. ( value > 0 is move to bottom, elase is move to top )
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) enforceMoveImageVerticalAlignment:(UIControlContentVerticalAlignment)imageAlignment offset:(CGFloat)offsetY;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------






