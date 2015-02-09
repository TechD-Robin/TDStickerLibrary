//
//  TDStickerLibrarySectionPreviewCell.h
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
@protocol TDSectionPreviewCellDelegate <NSObject>
@required

/**
 *  @brief when header in section of collection view is tap, call the delegate method.
 *  when header in section of collection view is tap, and get a current sprite data, call the delegate method.
 *
 *  @param collectionView           the collection view( header's super view).
 *  @param section                  section index.
 */

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when cell in section of collection view is tap, call the delegate method.
 *  when cell in section of collection view is tap, and can get a current sprite data, call the delegate method.
 *
 *  @param collectionView           the collection view( cell's super view).
 *  @param cell                     the cell.
 *  @param imageName                the preview image name.
 *  @param spriteName               a sprite name (is pack into the preview image)
 *  @param stickerFrame             a sprite original frame in pack image.
 *  @param nowFrame                 a sprite now frame on screen.
 */
- ( void ) collectionView:(UICollectionView *)collectionView didSelectCell:(UICollectionViewCell *)cell preview:(NSString *)imageName
                  sticker:(NSString *)spriteName original:(CGRect)stickerFrame onScreen:(CGRect)nowFrame;

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibrarySectionPreviewCell : UICollectionViewCell

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) id<TDSectionPreviewCellDelegate>  idDelegate;

//  ------------------------------------------------------------------------------------------------
/**
 *  the state for object's content view is minimum or normal.
 */
@property( nonatomic, assign ) BOOL                             miniState;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) loadFrames:(NSData *)confgureData;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

