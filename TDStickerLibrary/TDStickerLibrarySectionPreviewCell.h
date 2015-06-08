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
#pragma mark declare protocol for TDSectionPreviewCellDelegate.
//  ------------------------------------------------------------------------------------------------
/**
 *  delegate of preview cell of tab page of the Sticker Library.
 */
@protocol TDSectionPreviewCellDelegate <NSObject>
@required

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
/**
 *  a preview cell of collection view for sticker library view controller.
 */
@interface TDStickerLibrarySectionPreviewCell : UICollectionViewCell

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
/**
 *  delegate for TDSectionPreviewCellDelegate.
 */
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) id<TDSectionPreviewCellDelegate>  idDelegate;

//  ------------------------------------------------------------------------------------------------
/**
 *  the state for object's content view is minimum or normal.
 */
@property( nonatomic, assign ) BOOL                             miniState;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load the preview cell's image frames from configure data.
 *  load the preview cell's image frames from configure data.
 *
 *  @param confgureData             the preview cell's image frames data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) loadFrames:(NSData *)confgureData;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get intro DLVC related data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a preview image's texture name.
 *  get a preview image's texture name
 *
 *  @return name|nil                a texture name or nil.
 */
- ( NSString *) previewTextureName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a original's sprite frame at index.
 *  get a original's sprite frame at index.
 *
 *  @param index                    a index of sprite frame.
 *
 *  @return rect|ZeroRect           the result rect or ZeroRect. 
 */
- ( CGRect ) originalSpriteFrameAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a original's sprite frame for key.
 *  get a original's sprite frame for key.
 *
 *  @param aKey                     a key of frame.
 *
 *  @return rect|ZeroRect           the result rect or ZeroRect.
 */
- ( CGRect ) originalSpriteFrameForKey:(NSString *)aKey;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

