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
#pragma mark declare for create a image with tinted color.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a new image with tinted color.
 *  create a new image with tinted color.
 *
 *  @param tintedColor              a tinted color
 *
 *  @return image|nil               the image object or nil.
 */
- ( instancetype ) imageWithTintedColor:(UIColor *)tintedColor;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a new image with tinted color and color's alpha.
 *  create a new image with tinted color and color's alpha
 *
 *  @param tintedColor              a tinted color
 *  @param alpha                    a color's alpha ( value is 0 ~ 1.0f ).
 *
 *  @return image|nil               the image object or nil.
 */
- ( instancetype ) imageWithTintedColor:(UIColor *)tintedColor colorAlpha:(CGFloat)alpha;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
