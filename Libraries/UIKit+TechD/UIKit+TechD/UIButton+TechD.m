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
+ ( instancetype ) buttonWithImage:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    UIButton                      * button;
    CGRect                          buttonFrame;
    
    button                          = [UIButton buttonWithType: UIButtonTypeCustom];
    NSParameterAssert( nil != button );
    
    buttonFrame.origin              = offset;
    buttonFrame.size.width          = MAX( [image size].width, [highlighted size].width );
    buttonFrame.size.height         = MAX( [image size].height, [highlighted size].height );
    [button                         setFrame: buttonFrame];
    [button                         setBackgroundImage: image forState: UIControlStateNormal];
    [button                         setBackgroundImage: highlighted forState: UIControlStateHighlighted];
    
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
    [button                         setBackgroundImage: image forState: UIControlStateNormal];

    if ( nil != highlighted )
    {
        [button                     setBackgroundImage: highlighted forState: UIControlStateHighlighted];
    }
    if ( nil != disabled )
    {
        [button                     setBackgroundImage: disabled forState: UIControlStateDisabled];
    }
    if ( nil != selected )
    {
        [button                     setBackgroundImage: selected forState: UIControlStateSelected];
    }
    return button;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





