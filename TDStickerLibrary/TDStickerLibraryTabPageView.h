//
//  TDStickerLibraryTabPageView.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "TDStickerLibrary.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a tab page view(collection view) for sticker library view controller.
 */
@interface TDStickerLibraryTabPageView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Tab Page View.
 *  create a Tab Page View (collection view).
 *
 *  @param frame                    the frame of tab page view.
 *  @param customization            the customization object for the Sticker Library.
 *  @param configure                a configure name for collection view.
 *  @param dataLink                 a data link relation to configure name for update.
 *  @param timestamp                a timestamp relation to configure name for update.
 *  @param aKey                     a key for collection view.
 *
 *  @return object|nil              the tab page view or nil.
 */
+ ( instancetype ) tabPageWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)customization
                               data:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp forKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




