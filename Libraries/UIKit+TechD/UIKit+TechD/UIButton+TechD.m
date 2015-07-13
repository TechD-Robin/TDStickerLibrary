//
//  UIButton+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/5/27.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "UIButton+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation UIButton (TechD)

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    NSParameterAssert( nil != image );
    
    UIButton                      * button;
    CGRect                          buttonFrame;
    
    button                          = [UIButton buttonWithType: UIButtonTypeCustom];
    NSParameterAssert( nil != button );
    
    buttonFrame.origin              = offset;
    
    buttonFrame.size.width          = [image size].width;
    buttonFrame.size.height         = [image size].height;
    if ( nil != highlighted )
    {
        buttonFrame.size.width      = MAX( [image size].width, [highlighted size].width );
        buttonFrame.size.height     = MAX( [image size].height, [highlighted size].height );
    }
    
    [button                         setFrame: buttonFrame];
    [button                         setImage: image forState: UIControlStateNormal];
    [button                         setImage: highlighted forState: UIControlStateHighlighted];
    
    return button;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted
                          disabled:(UIImage *)disabled selected:(UIImage *)selected origin:(CGPoint)offset
{
    NSParameterAssert( nil != image );
    
    UIButton                      * button;
    CGRect                          buttonFrame;
    
    button                          = [UIButton buttonWithType: UIButtonTypeCustom];
    NSParameterAssert( nil != button );
    
    buttonFrame.origin              = offset;
    buttonFrame.size                = [image size];
    [button                         setFrame: buttonFrame];
    [button                         setImage: image forState: UIControlStateNormal];

    if ( nil != highlighted )
    {
        [button                     setImage: highlighted forState: UIControlStateHighlighted];
    }
    if ( nil != disabled )
    {
        [button                     setImage: disabled forState: UIControlStateDisabled];
    }
    if ( nil != selected )
    {
        [button                     setImage: selected forState: UIControlStateSelected];
    }
    return button;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for change imageView's position.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) changeImageToTitleRightSide:(CGFloat)offsetX
{
    if ( [self imageView] == nil )
    {
        return NO;
    }
    
    CGFloat                         titleWidth;
    CGFloat                         imageWidth;
    CGFloat                         gapWidth;
    UIEdgeInsets                    titleEdgeInsets;
    UIEdgeInsets                    imageEdgeInsets;
    
    [self                           sizeToFit];
    titleWidth                      = ( ( [self titleLabel] != nil ) ? [[self titleLabel] frame].size.width : 0.0f );
    imageWidth                      = [[self imageView] frame].size.width;
    gapWidth                        = ( [self frame].size.width - ( titleWidth + imageWidth ) );
    
    titleEdgeInsets                 = ( ( [self titleLabel] != nil ) ? [self titleEdgeInsets] : UIEdgeInsetsZero );
    imageEdgeInsets                 = [self imageEdgeInsets];
    
    titleEdgeInsets.left            -= imageWidth;
    titleEdgeInsets.right           = ( imageWidth - titleEdgeInsets.right );
    
    imageEdgeInsets.left            += ( titleWidth + gapWidth + offsetX );
    imageEdgeInsets.right           -= ( titleWidth + gapWidth + offsetX );
    
    [self                           setTitleEdgeInsets: titleEdgeInsets];
    [self                           setImageEdgeInsets: imageEdgeInsets];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) enforceMoveImageHorizontalAlignment:(UIControlContentHorizontalAlignment)imageAlignment offset:(CGFloat)offsetX
{
    if ( [self imageView] == nil )
    {
        return NO;
    }
    
    //  has no effect's alignment.
    if ( UIControlContentHorizontalAlignmentFill == imageAlignment )
    {
        return NO;
    }
    
    CGRect                          imageRect;
    CGPoint                         imageCenter;
    CGFloat                         calculateOffset;
    UIEdgeInsets                    newImageEdgeInsets;
    
    calculateOffset                 = 0.0f;
    imageCenter                     = [[self imageView] center];
    imageRect                       = [[self imageView] frame];
    newImageEdgeInsets              = [self imageEdgeInsets];
    
    //  first, calculate offset value for center.
    calculateOffset                 = ( ( [self bounds].size.width / 2.0f ) - imageCenter.x );
    
    //  second, calculate offset value for object's alignment.
    switch ( imageAlignment )
    {
        case UIControlContentHorizontalAlignmentCenter:
        {
            newImageEdgeInsets.left     = ( calculateOffset + offsetX );
            newImageEdgeInsets.right    = -( calculateOffset + offsetX );
            break;
        }
        case UIControlContentHorizontalAlignmentLeft:
        {
            calculateOffset             -= ( ( [self bounds].size.width - imageRect.size.width ) / 2.0f );
            newImageEdgeInsets.left     += ( calculateOffset + offsetX );
            newImageEdgeInsets.right    += -( calculateOffset + offsetX );
            break;
        }
        case UIControlContentHorizontalAlignmentRight:
        {
            calculateOffset             += ( ( [self bounds].size.width - imageRect.size.width ) / 2.0f );
            newImageEdgeInsets.left     += ( calculateOffset + offsetX );
            newImageEdgeInsets.right    += -( calculateOffset + offsetX );
            break;
        }
        default:
            break;
    }
    
    [self                           setImageEdgeInsets: newImageEdgeInsets];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) enforceMoveImageVerticalAlignment:(UIControlContentVerticalAlignment)imageAlignment offset:(CGFloat)offsetY
{
    if ( [self imageView] == nil )
    {
        return NO;
    }
    
    //  has no effect's alignment.
    if ( UIControlContentVerticalAlignmentFill == imageAlignment )
    {
        return NO;
    }
    
    CGRect                          imageRect;
    CGPoint                         imageCenter;
    CGFloat                         calculateOffset;
    UIEdgeInsets                    newImageEdgeInsets;
    
    calculateOffset                 = 0.0f;
    imageCenter                     = [[self imageView] center];
    imageRect                       = [[self imageView] frame];
    newImageEdgeInsets              = [self imageEdgeInsets];
    
    //  first, calculate offset value for center.
    calculateOffset                 = ( ( [self bounds].size.height / 2.0f ) - imageCenter.y );
    
    //  second, calculate offset value for object's alignment.
    switch ( imageAlignment )
    {
        case UIControlContentVerticalAlignmentCenter:
        {
            newImageEdgeInsets.top      = ( calculateOffset + offsetY );
            newImageEdgeInsets.bottom   = -( calculateOffset + offsetY );
            break;
        }
        case UIControlContentVerticalAlignmentTop:
        {
            calculateOffset             -= ( ( [self bounds].size.height - imageRect.size.height ) / 2.0f );
            newImageEdgeInsets.top      += ( calculateOffset + offsetY );
            newImageEdgeInsets.bottom   += -( calculateOffset + offsetY );
            break;
        }
        case UIControlContentVerticalAlignmentBottom:
        {
            calculateOffset             += ( ( [self bounds].size.height - imageRect.size.height ) / 2.0f );
            newImageEdgeInsets.top      += ( calculateOffset + offsetY );
            newImageEdgeInsets.bottom   += -( calculateOffset + offsetY );
            break;
        }
        default:
            break;
    }

    [self                           setImageEdgeInsets: newImageEdgeInsets];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





