//
//  UIScreen+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/1/16.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

@interface UIScreen (TechD)

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief easy to get the height of status bar.
 *
 *  @return                         height of status bar.
 */
- ( CGFloat ) getStatusBarHeight;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a multiple of scale of device, that is  Canvas Size (pts) to Design Canvas (px).
 @  get a multiple of scale of device, that is  Canvas Size (pts) to Design Canvas (px).
 *
 *  @return                         multiple of scale.
 */
- ( CGFloat ) scaleMultiple;
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

