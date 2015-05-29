//
//  TDStickerLibraryViewController.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>
#import "TDStickerLibrary.h"



//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the Sticker Library View Controller is a multi-page for sticker collection view.
 *  the section of tab page can set to minimun or normal state, 
 *  and can download new sticker image from URL.
 */
@interface TDStickerLibraryViewController : UIViewController

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------



//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library View Controller.
 *  create a Sticker Library View Controller; because customization is nil, system will auto create one.
 *
 *  @return object|nil              the Sticker Library View Controller or nil.
 */
+ ( instancetype ) stickerLibaray;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library View Controller with customization object.
 *  create a Sticker Library View Controller with customization object.
 *
 *  @param custom                   a customization configure for the Sticker Library View Controller.
 *
 *  @return object|nil              the Sticker Library View Controller or nil.
 */
+ ( instancetype ) stickerLibarayWithCustomization:(TDStickerLibraryCustomization *)custom;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





