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
/**
 *  a data object for i/o section states of collection view(StickerLibraryTabPageView).
 *  include section's mini state, images count, preview image size.
 */
@interface TDStickerLibrarySectionStates : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a section states's data object.
 *  create a section states's data object.
 *
 *  @return object|nil              the data object or nil.
 */
+ ( instancetype ) sectionStates;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for i/o a state data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief insert a new state data.
 *  insert a new state data.
 *
 *  @param aKey                     a key of data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) insertStateDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update image's count of the state data.
 *  update image's count of the state data.
 *
 *  @param count                    image's count at normal state.
 *  @param miniCount                image's count at mini state.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateImagesCountOfStateData:(NSInteger)count with:(NSInteger)miniCount;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update preview image's size of the state data.
 *  update preview image's size of the state data.
 *
 *  @param size                     preview image's size at normal state.
 *  @param miniSize                 preview image's size at mini state.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updatePreviewImageSizeOfStateData:(CGSize)size with:(CGSize)miniSize;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update mini state of the state data.
 *  update mini state of the state data.
 *
 *  @param miniState                mini state. (mini or normal state).
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateMiniStateOfStateData:(BOOL)miniState;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update download state  of the state data.
 *  update download state  of the state data.
 *
 *  @param mustDownload             download's flag (need or need not).
 *  @param isDownloaded             download's flag (is downloaded or not).
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateStickerDownloadState:(BOOL)mustDownload with:(BOOL)isDownloaded;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief count of section.
 *  count of section.
 *
 *  @return count| 0                the section's count or 0.
 */
- ( NSInteger ) numberOfSections;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for i/o the state data in section.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the ID in section.
 *  get the ID in section.
 *
 *  @param section                  index of section.
 *
 *  @return ID|nil                  the ID or nil.
 */
- ( NSString * ) idInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
//  mini state.
/**
 *  @brief get the mini state in section.
 *  get the mini state in Section.
 *
 *  @param miniState                pointer of the mini state to get result.
 *  @param section                  index of section.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) miniState:(BOOL *)miniState inSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update the mini state in section.
 *  update the mini state in section.
 *
 *  @param miniState                mini state. (mini or normal state).
 *  @param section                  index of section.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateMiniState:(BOOL)miniState inSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
//  image's count.
/**
 *  @brief get the count of images in section.
 *  get the count of images in section. (for now)
 *
 *  @param section                  index of section.
 *
 *  @return count| 0                the images's count or 0.
 */
- ( NSInteger ) numberOfImagesInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update the count of images in section.
 *  update the count of images in section. (for now)
 *
 *  @param count                    the image's count.
 *  @param section                  index of section.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateNumberOfImages:(NSInteger)count inSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the total count of images in section.
 *  get the total count of images in section. (initial)
 *
 *  @param section                  index of section.
 *
 *  @return count| 0                the images's total count or 0.
 */
- ( NSInteger ) numberOfTotalImagesInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
//  preview image's size.
/**
 *  @brief get the preview image's normal size in section.
 *  get the preview image's normal size in section. (initial)
 *
 *  @param section                  index of section.
 *
 *  @return size|ZeroSize           the size or ZeroSize.
 */
- ( CGSize ) normalSizeOfPreviewImageInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update the preview image's size in section.
 *  update the preview image's size in section. (for now)
 *
 *  @param size                     the preview image's size.
 *  @param section                  index of section.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateNowSizeOfPreviewImage:(CGSize)size inSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the preview image's size in section.
 *  get the preview image's size in section. (for now)
 *
 *  @param section                  index of section.
 *
 *  @return size|ZeroSize           the size or ZeroSize.
 */
- ( CGSize ) nowSizeOfPreviewImageInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
// download state
/**
 *  @brief get the download state in section.
 *  get the download state in section.
 *
 *  @param downloadState            pointer of the download state to get result.
 *  @param section                  index of section.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) downloadState:(BOOL *)downloadState inSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update the download state in section
 *  update the download state in section
 *
 *  @param downloadState            download state (is downloaded or not).
 *  @param section                  index of section.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateDownloadState:(BOOL)downloadState  inSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





