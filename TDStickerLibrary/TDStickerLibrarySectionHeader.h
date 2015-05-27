//
//  TDStickerLibrarySectionHeader.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare protocol for TDSectionHeaderDelegate.
//  ------------------------------------------------------------------------------------------------
@protocol TDSectionHeaderDelegate <NSObject>
@required

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when header in section of collection view is tap, call the delegate method.
 *  when header in section of collection view is tap, call the delegate method.
 *
 *  @param collectionView           the collection view( header's super view).
 *  @param section                  section index.
 */
- ( void ) collectionView:(UICollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when header's information view in section of collection view is tap, call the delegate method.
 *  when header's information view in section of collection view is tap, call the delegate method.
 *
 *  @param collectionView           the collection view( header's super view).
 *  @param section                  section index.
 */
- ( void ) collectionView:(UICollectionView *)collectionView didSelectHeaderInformationInSection:(NSInteger)section;
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@class TDStickerLibraryCustomization;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a section header of collection view for sticker library view controller.
 */
@interface TDStickerLibrarySectionHeader : UICollectionReusableView

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
/**
 *  delegate for TDSectionHeaderDelegate.
 */
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) id<TDSectionHeaderDelegate>   idDelegate;

//  ------------------------------------------------------------------------------------------------
/**
 *  section's index.
 */
@property( nonatomic, assign ) NSInteger                        sectionIndex;

/**
 *  set to assign the section's data is download or not.
 */
@property( nonatomic, assign ) BOOL                             isDownloadedData;

/**
 *  section's title.
 */
@property( nonatomic, SAFE_ARC_PROP_RETAIN ) NSString         * sectionTitle;


//  configure.
/**
 *  a pointer for the customization object, reference some properties.
 */
@property( nonatomic, assign ) TDStickerLibraryCustomization  * customization;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) assignCurrentProperties;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



