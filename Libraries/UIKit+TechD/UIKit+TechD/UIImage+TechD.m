//
//  UIImage+TechD.m
//  TDStickerLibrary
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
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




