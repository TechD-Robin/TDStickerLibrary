//
//  TDBaseTabMenuItem.h
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the base tab menu item will group the same class objects, when tap it will show relation view at the same time.
 */
@interface TDBaseTabMenuItem : UIImageView

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
/**
 *  assign a view pointer for a relation view.
 */
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) UIView                      * relationView;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a base Tab Menu Item  Object with frame & a image.
 *  create a base Tab Menu Item  Object with frame & a image.
 *
 *  @param frame                    item's frame.
 *  @param image                    a image attach to the item object for show.
 *
 *  @return object|nil              the base Tab Menu Item Object or nil.
 */
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image;

//  ------------------------------------------------------------------------------------------------
/**
 *  @create a base Tab Menu Item  Object with frame & a image and high lighted image.
 *  create a base Tab Menu Item  Object with frame & a image and high lighted image.
 *
 *  @param frame                    item's frame.
 *  @param image                    a image attach to the item object for show.
 *  @param highlightedImage         a image attach to the item object for object set to high lighted.
 *
 *  @return object|nil              the base Tab Menu Item Object or nil.
 */
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;


//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




