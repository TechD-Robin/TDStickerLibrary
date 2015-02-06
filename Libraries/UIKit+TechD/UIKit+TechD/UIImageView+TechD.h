//
//  UIImageView+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/2/6.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

@interface UIImageView (TechD)

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
/**
 *  @breif create a image view for proportional of image, and set the frame with reference size.
 *  create a image view for proportional of image, and set the frame with reference size.
 *
 *  @param image                    image object.
 *  @param baseSize                 base size of image.
 *  @param parentSize               parent size for reference.
 *
 *  @return imageView|nil           the image view object or nil.
 */
+ ( instancetype ) proportionalImageView:(UIImage *)image reference:(CGSize)baseSize originWith:(CGSize)parentSize;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
