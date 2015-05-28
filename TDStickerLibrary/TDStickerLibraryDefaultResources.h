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
//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDStickerLibraryDefaultResourcesBundle       = @"StickerLibraryDefault.bundle";
static  NSString  * const kTDStickerLibraryDefaultImagesInDirectory     = @"Images";

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@interface TDStickerLibraryDefaultResources : TDResourceManager

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init NS_UNAVAILABLE;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//- ( UIImage * ) defaultImage:(NSString *)imageName;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImage;

- ( UIImage * ) sectionHeaderInforImageHighlighted;

- ( UIImage * ) sectionHeaderInforImageDisabled;

- ( UIImage * ) sectionHeaderArrowDownImage;

- ( UIImage * ) sectionHeaderArrowDownImageHighlighted;

- ( UIImage * ) sectionHeaderArrowDownImageDisabled;

- ( UIImage * ) sectionHeaderArrowUpImage;

- ( UIImage * ) sectionHeaderArrowUpImageHighlighted;

- ( UIImage * ) sectionHeaderArrowUpImageDisabled;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------










