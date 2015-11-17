//
//  UIView+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/4/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

@interface UIView (TechD)

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the view's owner, that is view controller.
 *  get the view's owner, that is view controller.
 *
 *  @return viewController|nil      the view's view controller or nil.
 */
- ( UIViewController * ) viewController;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief grab the layer's contents into image object.
 *  grab the layer's contents into image object.
 *
 *  @return image|nil               the image or nil.
 */
- ( UIImage *) grabLayerToImage;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
