//
//  UIImageView+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/2/6.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDMath.h"
#import "UIImageView+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@implementation UIImageView (TechD)

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) proportionalImageView:(UIImage *)image reference:(CGSize)baseSize originWith:(CGSize)parentSize
{
    if ( ( nil == image ) || ( CGSizeEqualToSize( baseSize, CGSizeZero ) == true ) || ( CGSizeEqualToSize( parentSize, CGSizeZero ) == true ) )
    {
        return nil;
    }
    
    UIImageView                   * imageView;
    CGFloat                         imageRatio;
    
    imageRatio                      = 1.0f;
    imageView                       = [[UIImageView alloc] initWithImage: image];
    if ( nil == imageView )
    {
        return nil;
    }
    
    imageRatio                      = ( [image size].height / [image size].width );
    [imageView                      setFrame: calculateProportionalRectWithParentSize( imageRatio, baseSize, parentSize )];
    return imageView;
}

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


