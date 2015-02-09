//
//  TDStickerLibraryTabPageLayout.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/26.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryTabPageLayout : UICollectionViewFlowLayout

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
/**
 *  delegate for UICollectionViewDelegateFlowLayout.
 */
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) id<UICollectionViewDelegateFlowLayout>        idDelegate;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare update status of layout attributes.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when collection view's layout attributes need update, call the method.
 *  when collection view's layout attributes need update, call the method; when has item's amount change, set the flag on.
 *
 *  @param amountChanging           the flag for item's amount change or not.
 */
- ( void ) needUpdateLayoutAttributes:(BOOL)amountChanging;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare calculate capacity for a row.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate capacity(not empty) of first row for section at index.
 *  calculate capacity of first row for section.
 *
 *  @param section                  section index.
 *
 *  @return value| -1               calculated value for capacity or -1.
 */
- ( NSInteger ) calculateFirstRowCapacityForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

