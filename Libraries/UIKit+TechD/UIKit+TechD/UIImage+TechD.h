//
//  UIImage+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/2/8.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

@interface UIImage (TechD)

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief resize the image size to new size.
 *  resize the image size to new size. (reference from github CLImageEditor)
 *
 *  @param size                     new size.
 *
 *  @return image|nil               the image object or nil.
 */
- ( instancetype ) resize:(CGSize)newSize;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief clipping the image of rect.
 *  clipping the image of rect.
 *
 *  @param clippingRect             rect of clip.
 *
 *  @return image|nil               the image object or nil.
 */
- ( instancetype ) clipping:(CGRect)clippingRect;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
