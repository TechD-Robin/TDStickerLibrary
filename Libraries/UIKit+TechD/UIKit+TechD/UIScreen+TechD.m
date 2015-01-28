//
//  UIScreen+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/1/16.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "UIScreen+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@implementation UIScreen (TechD)

//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) getStatusBarHeight
{
    CGSize                          mainBoundsSize;
    CGSize                          applicationFrameSize;
//    UIApplication                 * application;
//    
//    application                     = [UIApplication sharedApplication];
//    NSLog( @"status bar hidden :%d", [application isStatusBarHidden] );
    
    mainBoundsSize                  = [[UIScreen mainScreen] bounds].size;
    applicationFrameSize            = [[UIScreen mainScreen] applicationFrame].size;
    return ( ( fabsf( mainBoundsSize.width - applicationFrameSize.width ) + fabsf( mainBoundsSize.height - applicationFrameSize.height ) ) );
}

//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) scaleMultiple
{
    if ( ( [[UIScreen mainScreen] respondsToSelector: @selector( displayLinkWithTarget: selector: )] == NO ) || ( [UIScreen mainScreen].scale == 1.0f ) )
    {
        return 1.0f;
    }
    return [UIScreen mainScreen].scale;
}

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


