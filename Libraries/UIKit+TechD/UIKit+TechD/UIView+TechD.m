//
//  UIView+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/4/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "UIView+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation UIView (TechD)

//  ------------------------------------------------------------------------------------------------
- ( UIViewController * ) viewController;
{
    UIResponder                   * nextResponder;
    
    nextResponder                   = self;
    do
    {
        nextResponder               = [nextResponder nextResponder];
        if ( [nextResponder isKindOfClass:[UIViewController class]] == YES )
        {
            return (UIViewController *)nextResponder;
        }
    } while ( nil != nextResponder );
    return nil;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage *) grabLayerToImage
{
    UIImage                       * image;
    
    // Create a "canvas" (image context) to draw in.
    //UIGraphicsBeginImageContext( [self bounds].size );
    UIGraphicsBeginImageContextWithOptions( [self bounds].size, [self isOpaque], 0.0f );
    
    // Make the CALayer to draw in our "canvas".
    [[self                          layer] renderInContext: UIGraphicsGetCurrentContext()];
    
    // Fetch an UIImage of our "canvas".
    image                           = UIGraphicsGetImageFromCurrentImageContext();
    
    // Stop the "canvas" from accepting any input.
    UIGraphicsEndImageContext();
    
    // Return the image.
    return image;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




