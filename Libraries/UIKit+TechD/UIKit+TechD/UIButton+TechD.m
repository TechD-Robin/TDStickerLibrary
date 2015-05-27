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
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





