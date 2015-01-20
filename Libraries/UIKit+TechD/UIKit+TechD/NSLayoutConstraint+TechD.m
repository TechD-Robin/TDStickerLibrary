//
//  NSLayoutConstraint+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/1/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "NSLayoutConstraint+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@implementation NSLayoutConstraint (TechD)

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) constraintForWidthStretchy:(UIView *)subView top:(CGFloat)top height:(CGFloat)height in:(UIView *)superView
{
    if ( ( nil == subView ) || ( nil == superView ) )
    {
        return NO;
    }
    
    NSLayoutConstraint            * layoutTop;
    NSLayoutConstraint            * layoutLeft;
    NSLayoutConstraint            * layoutRight;
    NSLayoutConstraint            * layoutHeight;
    
    layoutTop                       = [NSLayoutConstraint constraintWithItem: subView attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual
                                                                      toItem: superView attribute:  NSLayoutAttributeTop multiplier: 1.0f constant: top ];
    
    layoutLeft                      = [NSLayoutConstraint constraintWithItem: subView attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual
                                                                      toItem: superView attribute: NSLayoutAttributeLeft multiplier: 1.0f constant: 0.0f];
    
    layoutRight                     = [NSLayoutConstraint constraintWithItem: subView attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual
                                                                      toItem: superView attribute: NSLayoutAttributeRight multiplier: 1.0f constant: 0.0f];
    
    layoutHeight                    = [NSLayoutConstraint constraintWithItem: subView attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual
                                                                      toItem: nil attribute: NSLayoutAttributeHeight multiplier: 1.0f constant: height ];
    
    [subView                        setClipsToBounds: YES];
    [subView                        setTranslatesAutoresizingMaskIntoConstraints: NO];
    [superView                      addConstraint: layoutTop];
    [superView                      addConstraint: layoutLeft];
    [superView                      addConstraint: layoutRight];
    [superView                      addConstraint: layoutHeight];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
