//
//  UIImage+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/2/8.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "UIImage+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation UIImage (TechD)

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) resize:(CGSize)newSize
{
    if ( ( CGSizeEqualToSize( newSize, CGSizeZero ) == true ) || ( CGSizeEqualToSize( newSize, [self size] ) ) )
    {
        return self;
    }
    
    NSInteger                       H;
    NSInteger                       W;
    CGImageRef                      imageRef;
    CGColorSpaceRef                 colorSpaceInfo;
    CGContextRef                    bitmap;
    
    W                               = newSize.width;
    H                               = newSize.height;
    imageRef                        = [self CGImage];
    colorSpaceInfo                  = CGImageGetColorSpace( imageRef );
    bitmap                          = CGBitmapContextCreate( NULL, W, H, 8, (4 * W ), colorSpaceInfo, ( kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little ) );
    
    if ( ( [self imageOrientation] == UIImageOrientationLeft ) || ( [self imageOrientation] == UIImageOrientationRight ) )
    {
        W = newSize.height;
        H = newSize.width;
    }
    
    if( ( [self imageOrientation] == UIImageOrientationLeft ) || ( [self imageOrientation] == UIImageOrientationLeftMirrored ) )
    {
        CGContextRotateCTM ( bitmap, ( M_PI / 2 ) );
        CGContextTranslateCTM ( bitmap, 0, -H );
    }
    else if ( ( [self imageOrientation] == UIImageOrientationRight ) || ( [self imageOrientation] == UIImageOrientationRightMirrored ) )
    {
        CGContextRotateCTM ( bitmap, -M_PI / 2 );
        CGContextTranslateCTM ( bitmap, -W, 0 );
    }
    else if ( ( [self imageOrientation] == UIImageOrientationUp ) || ( [self imageOrientation] == UIImageOrientationUpMirrored ) )
    {
        // do nothing
    }
    else if ( ( [self imageOrientation] == UIImageOrientationDown ) || ( [self imageOrientation] == UIImageOrientationDownMirrored) )
    {
        CGContextTranslateCTM ( bitmap, W, H );
        CGContextRotateCTM ( bitmap, -M_PI );
    }
    CGContextDrawImage( bitmap, CGRectMake( 0, 0, W, H ), imageRef );
    
    CGImageRef                      newImageRef;
    UIImage                       * newImage;
    
    newImageRef                     = CGBitmapContextCreateImage( bitmap );
    newImage                        = [UIImage imageWithCGImage: newImageRef];
    
    CGContextRelease( bitmap );
    CGImageRelease( newImageRef );
    return newImage;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) clipping:(CGRect)clippingRect
{
    CGPoint                         origin;
    UIImage                       * newImage;
    
    newImage                        = nil;
    origin                          = CGPointMake( -clippingRect.origin.x,  -clippingRect.origin.y );
    
    UIGraphicsBeginImageContext( CGSizeMake( clippingRect.size.width, clippingRect.size.height ) );
    [self                           drawAtPoint: origin];
    
    newImage                        = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create a image with tinted color.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) imageWithTintedColor:(UIColor *)tintedColor
{
    return [self imageWithTintedColor: tintedColor colorAlpha: 0.0f blendMode: kCGBlendModeDestinationIn];
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) imageWithTintedColor:(UIColor *)tintedColor colorAlpha:(CGFloat)alpha
{
    return [self imageWithTintedColor: tintedColor colorAlpha: alpha blendMode: kCGBlendModeDestinationIn];
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) imageWithTintedColor:(UIColor *)tintedColor colorAlpha:(CGFloat)fraction blendMode:(CGBlendMode)blendMode
{
    if ( nil == tintedColor )
    {
        return nil;
    }
    
    CGRect                          bounds;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    bounds                          = CGRectZero;
    bounds.origin                   = CGPointMake( 0.0f, 0.0f );
    bounds.size                     = [self size];
    
    UIGraphicsBeginImageContextWithOptions( [self size], NO, 0.0f );
    [tintedColor                    setFill];
    UIRectFill( bounds );
    
    // Mask tint color-swatch to this image's opaque mask.
    // We want behaviour like NSCompositeDestinationIn on Mac OS X.
    [self                           drawInRect: bounds blendMode: blendMode alpha: 1.0f];

    // Finally, composite this image over the tinted mask at desired opacity.
    if ( 0.0f < fraction )
    {
        // We want behaviour like NSCompositeSourceOver on Mac OS X.
        [self                       drawInRect: bounds blendMode: kCGBlendModeSourceAtop alpha: fraction];
    }
    tintedImage                     = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return tintedImage;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




