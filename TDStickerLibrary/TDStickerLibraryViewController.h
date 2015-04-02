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
 *  @param customization            a customization configure for the Sticker Library View Controller.
 *
 *  @return object|nil              the Sticker Library View Controller or nil.
 */
+ ( instancetype ) stickerLibarayWithCustomization:(TDStickerLibraryCustomization *)customization;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief pre-update (the Sticker Library View Controller) configure data from internet
 *  pre-update (the Sticker Library View Controller) configure data from internet, that will check and download configure data latest from internet.
 *
 *  @param systemUpdateURL          the URL of configure data at internet.
 *  @param keylist                  keys of configure data
 *  @param customization            a customization configure for the Sticker Library View Controller (support this method on here).
 *  @param completionBlock          a block section be executed when pre-update procedure completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) preUpdateProcedure:(NSString *)systemUpdateURL forSearch:(NSArray *)keylist with:(TDStickerLibraryCustomization *)customization
                   completion:( void(^)(BOOL finished))completionBlock;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





