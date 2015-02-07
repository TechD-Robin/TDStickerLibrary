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

- ( BOOL ) updateImagesCountOfStateData:(NSInteger)count;

- ( BOOL ) updatePreviewImageSizeOfStateData:(CGSize)size;


//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfSections;

- ( NSInteger ) numberOfImagesInSection:(NSInteger)section;

- ( BOOL ) updateNumberOfImages:(NSInteger)count inSection:(NSInteger)section;

- ( NSInteger ) numberOfTotalImagesInSection:(NSInteger)section;

- (CGSize) sizeOfPreviewImageInSection:(NSInteger)section;
//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





