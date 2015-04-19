//
//  TDStickerLibraryStickerIntroDLVC.h
//  StickerLibrary
//
//  Created by Robin Hsu on 2015/4/19.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>
#import "TDStickerLibraryCustomization.h"
#import "TDStickerLibraryTabPageInfo.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the Sticker Library Sticker IntroDLVC(Introducton & Download View Controller) is a functional view controller,
 *  that for sticker preview or download.
 */
@interface TDStickerLibraryStickerIntroDLVC : UIViewController

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library Sticker IntroDLVC.
 *  create a Sticker Library Sticker IntroDLVC(Introducton & Download View Controller).
 *
 *  @param custom                   the customization object for the Sticker Library.
 *  @param pageInfo                 the page information object.
 *  @param index                    section index.
 *  @param stickerID                identifier of sticker's data.
 *
 *  @return object|nil              the Sticker Library Sticker IntroDLVC or nil.
 */
+ ( instancetype ) introductionDL:(TDStickerLibraryCustomization *)custom configure:(TDStickerLibraryTabPageInfo *)pageInfo
                       forSection:(NSInteger)index identifier:(NSString *)stickerID;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





