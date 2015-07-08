//
//  TDBaseTabMenuItem.h
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@class TDBaseTabMenuItem;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare protocol for TDBaseTabMenuItemDelegate.
//  ------------------------------------------------------------------------------------------------
/**
 *  delegate of item of base tab menu. (option)
 */
@protocol TDBaseTabMenuItemDelegate <NSObject>
@optional

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when the menu item is tap, call the delegate method.
 *  when the menu item is tap, call the delegate method. ( for extension design )
 *
 *  @param menuItem                 the menu item.
 *  @param tag                      item's tag.
 */
- ( void ) menuItem:(TDBaseTabMenuItem *)menuItem didSelected:(NSInteger)tag;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief define type of block method pointer for relation object need to be created.
 *
 *  @param tag                      index key for the object and relation object.
 *
 *  @return void                    nothing.
 */
typedef   void(^CreateRelationBlock)(NSInteger tag);
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the base tab menu item will group the same class objects, when tap it will show relation view at the same time.
 */
@interface TDBaseTabMenuItem : UIImageView

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
/**
 *  assign a view pointer for a relation view.
 */
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) UIView                      * relationView;

/**
 *  delegate for TDBaseTabMenuItemDelegate.
 */
@property ( nonatomic, SAFE_ARC_PROP_RETAIN ) id<TDBaseTabMenuItemDelegate> idDelegate;

//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a base Tab Menu Item  Object with frame & a image.
 *  create a base Tab Menu Item  Object with frame & a image.
 *
 *  @param frame                    item's frame.
 *  @param image                    a image attach to the item object for show.
 *
 *  @return object|nil              the base Tab Menu Item Object or nil.
 */
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image;

//  ------------------------------------------------------------------------------------------------
/**
 *  @create a base Tab Menu Item  Object with frame & a image and high lighted image.
 *  create a base Tab Menu Item  Object with frame & a image and high lighted image.
 *
 *  @param frame                    item's frame.
 *  @param image                    a image attach to the item object for show.
 *  @param highlightedImage         a image attach to the item object for object set to high lighted.
 *
 *  @return object|nil              the base Tab Menu Item Object or nil.
 */
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a base Tab Menu Item  Object with frame & a image, and a block method.
 *  create a base Tab Menu Item  Object with frame & a image, and a block method.
 *
 *  @param frame                    item's frame.
 *  @param image                    a image attach to the item object for show.
 *  @param relation                 a block method(callback) for relation object need to be created.
 *
 *  @return object|nil              the base Tab Menu Item Object or nil.
 */

+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image
                                 create:(CreateRelationBlock)relation;

//  ------------------------------------------------------------------------------------------------
/**
 *  @create a base Tab Menu Item  Object with frame & a image, high lighted image and a block method.
 *  create a base Tab Menu Item  Object with frame & a image, high lighted image and a block method.
 *
 *  @param frame                    item's frame.
 *  @param image                    a image attach to the item object for show.
 *  @param highlightedImage         a image attach to the item object for object set to high lighted.
 *  @param relation                 a block method(callback) for relation object need to be created.
 *
 *  @return object|nil              the base Tab Menu Item Object or nil.
 */
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
                                 create:(CreateRelationBlock)relation;


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




