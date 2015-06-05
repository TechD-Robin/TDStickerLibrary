//
//  TDStickerLibraryDefaultResources.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/5/28.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TDResourceManager.h"

//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDStickerLibraryDefaultResourcesBundle       = @"StickerLibraryDefault.bundle";
static  NSString  * const kTDStickerLibraryDefaultImagesInDirectory     = @"Images";

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a object of default's resources of sticker library.
 *  when create a sticker library can use this object to get default data.
 *  developer can adjust these contents to project's environment.
 */
@interface TDStickerLibraryDefaultResources : TDResourceManager

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init NS_UNAVAILABLE;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get default's assets bundle image
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a default image is not image.
 *  get a default image is not image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) defaultNoImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information image.
 *  get the section header's information image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderInforImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information highlighted image.
 *  get the section header's information highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderInforImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information disabled image.
 *  get the section header's information disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderInforImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow down image.
 *  get the section header's information arrow down image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowDownImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow down highlighted image.
 *  get the section header's information arrow down highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowDownImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow down disabled image.
 *  get the section header's information arrow down disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowDownImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow up image.
 *  get the section header's information arrow up image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowUpImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow up highlighted image.
 *  get the section header's information arrow up highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowUpImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow up disabled image.
 *  get the section header's information arrow up disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowUpImageDisabled;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------










