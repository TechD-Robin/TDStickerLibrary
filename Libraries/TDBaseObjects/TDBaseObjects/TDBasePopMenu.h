//
//  TDBasePopMenu.h
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/6/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for base pop menu's position.
 */
typedef NS_ENUM( NSInteger, TDBasePopMenuPosition ){
    /**
     *  position is on left top side.
     */
    TDBasePopMenuPositionLeftTop            = 1,
    /**
     *  position is on right top side.
     */
    TDBasePopMenuPositionRightTop,
};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the base pop menu, will pop out and un-pop out actions item from edge.
 */
@interface TDBasePopMenu : UIView

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Pop Menu Object with enumeration number & pop out's image.
 *  create a Pop Menu Object with enumeration number & pop out's image.
 *
 *  @param menuPosition             enumeration of position.
 *  @param image                    pop out's normal image.
 *  @param highlighted              pop out's highlighted image.
 *  @param offset                   position offset between pop out's item and actions contents.
 *
 *  @return object|nil              the base pop menu object or nil.
 */
+ ( instancetype ) popMenu:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create & set the pop out menu's un-pop out image.
 *  create & set the pop out menu's un-pop out image.
 *
 *  @param image                    un-pop out's image.
 *  @param highlighted              un-pop out's highlighted image.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) setUnPopOut:(UIImage *)image highlighted:(UIImage *)highlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a action's item with action, and add to actions contents.
 *  create a action's item with action, and add to actions contents.
 *
 *  @param image                    action's normal image.
 *  @param highlighted              action's highlighted image.
 *  @param target                   action's target object.
 *  @param action                   action's SEL object( method of target).
 *  @param controlEvents            action's control event (trigger event).
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) AddAction:(UIImage *)image highlighted:(UIImage *)highlighted
              target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get properties of object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a inter item spacing of actions contents.
 *  set a inter item spacing of actions contents.
 *
 *  @param interitemSpacing         inter item spacing.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) setInteritemSpacing:(CGFloat)interitemSpacing;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a duration of animation of pop out and un-pop out.
 *  set a duration of animation of pop out and un-pop out.
 *
 *  @param duration                 animate duration.(sec.)
 */
- ( void ) setPopOutAnimateDuration:(CGFloat)duration;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a blur layer's properties.
 *  set a blur layer's properties.
 *
 *  @param layerColor               blur layer's color.
 *  @param widthScale               blur layer's width; scale from this object's width. ( 1.0f is equal object's width; 0.0f is equal unuse blur layer )
 */
- ( void ) setBlurLayer:(UIColor *)layerColor scale:(CGFloat)widthScale;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------











