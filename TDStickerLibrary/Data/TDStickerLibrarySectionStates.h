//
//  TDStickerLibrarySectionStates.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/5.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibrarySectionStates : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) sectionStates;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) insertStateDataForKey:(NSString *)aKey;

- ( BOOL ) updateImagesCountOfStateData:(NSInteger)count with:(NSInteger)miniCount;

- ( BOOL ) updatePreviewImageSizeOfStateData:(CGSize)size with:(CGSize)miniSize;

- ( BOOL ) updateMiniStateOfStateData:(BOOL)miniState;


//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfSections;

- ( BOOL ) miniState:(BOOL *)miniState inSection:(NSInteger)section;

- ( BOOL ) updateMiniState:(BOOL)miniState inSection:(NSInteger)section;

- ( NSInteger ) numberOfImagesInSection:(NSInteger)section;

- ( BOOL ) updateNumberOfImages:(NSInteger)count inSection:(NSInteger)section;

- ( NSInteger ) numberOfTotalImagesInSection:(NSInteger)section;

- ( CGSize ) normalSizeOfPreviewImageInSection:(NSInteger)section;

- ( BOOL ) updateNowSizeOfPreviewImage:(CGSize)size inSection:(NSInteger)section;

- ( CGSize ) nowSizeOfPreviewImageInSection:(NSInteger)section;
//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





