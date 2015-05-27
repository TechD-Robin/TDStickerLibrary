//
//  TDSystemCustomization.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/5/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDSystemCustomization : NSObject
{
    
    @public
    
    UIColor                       * styleBackgroundColor;
    UIColor                       * styleTintedColor;
    CGFloat                         styleTintedColorAlpha;
    
    //  for UIimage.
    UIImage                       * backToMenuImage;
    UIImage                       * backToMenuImageHighlighted;
    
    UIImage                       * downloadImage;
    UIImage                       * downloadImageHighlighted;
    UIImage                       * downloadImageDisabled;
    
}

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------

//  for UIimage.

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype)init NS_UNAVAILABLE;

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) customization;


//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




