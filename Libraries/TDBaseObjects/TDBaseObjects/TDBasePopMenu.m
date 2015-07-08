//
//  TDBasePopMenu.m
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/6/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "UIKit+TechD.h"
#import "TDBasePopMenu.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDBasePopMenu

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDBasePopMenu ()
{
    /**
     *  enumeration of position.
     */
    TDBasePopMenuPosition           popMenuPosition;
    
    /**
     *  position offset between pop out's item and actions contents.
     */
    CGPoint                         positionOffset;
    
    /**
     *  a blur image view.
     */
    UIImageView                   * blurImageView;
    
    /**
     *  blur color of blur image. ( blur image's background color. )
     */
    UIColor                       * blurLayerColor;
    
    /**
     *  blur layer's width scale from the object's width.
     */
    CGFloat                         blurLayerWidthScale;
    
    /**
     *  a pop out button.
     */
    UIButton                      * popOutButton;
    
    /**
     *  a un-pop out button.
     */
    UIButton                      * unPopOutButton;
    
    /**
     *  action's menu;  content of action's item.
     */
    UIScrollView                  * actionsMenu;
    
    /**
     *  actions menu's inter item spacing.
     */
    CGFloat                         actionsMenuInteritemSpacing;
    
    /**
     *  the object's pop out & un-pop out animate duration.
     */
    CGFloat                         transformPopOutDuration;
    
    /**
     *  the object center before transform.
     */
    CGPoint                         transformBeforeCenter;
    
    /**
     *  set a status when this object is popped out or un-pop out. 
     *  ( just use the property when unPopOutButton is nil. )
     */
    BOOL                            isPoppedOut;
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDBasePopMenu (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set this object's frame.
 *  set this object's frame.
 */
- ( void ) _SetFrame;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set the pop out's & un-pop out's object's frame.
 *  set the pop out's & un-pop out's object's frame.
 */
- ( void ) _SetPopOutFrame;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set the actions menu object's frame.
 *  set the actions menu object's frame.
 */
- ( void ) _SetActionsMenuFrame;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for calculate.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate actions menu's content size after add a action's item.
 *  calculate actions menu's content size after add a action's item.
 *
 *  @param newItemSize              a new action's item size.
 *
 *  @return size|ZeroSize           the result size or ZeroSize.
 */
- ( CGSize ) _CalculateActionsMenuContentSize:(CGSize)newItemSize;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate a new action's item's origin position at actions menu.
 *  calculate a new action's item's origin position at actions menu.
 *
 *  @return point|ZeroPoint         the result point or ZeroPoint.
 */
- ( CGPoint) _CalculateNewActionItemOrigin;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a blur image by core graphic method.
 *  create a blur image by core graphic method.
 *
 *  @param blurColor                a blur's color.
 *
 *  @return object|nil              a blur image object or ni.
 */
- ( UIImage * ) _CreateBlurImage:(UIColor *)blurColor;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a blur image.
 *  create a blur image.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateBlurImageView;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a pop out button with image.
 *  create a pop out button with image.
 *
 *  @param image                    pop out's normal image.
 *  @param highlighted              pop out's highlighted image.
 *  @param disabled                 pop out's disabled image.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a un-pop out button with image.
 *  create a un-pop out button with image.
 *
 *  @param image                    un-pop out's image.
 *  @param highlighted              un-pop out's highlighted image.
 *  @param disabled                 un-pop out's disabled image.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a actions menu.
 *  create a actions menu, for be added by action's item
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateActionsMenu;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a action item with image.
 *
 *  @param image                    action item's normal image.
 *  @param highlighted              action item's highlighted image.
 *  @param disabled                 action item's disabled image.
 *
 *  @return button|nil              a action item or nil.
 */
- ( UIButton * ) _CreateActionItem:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDBasePopMenu (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    positionOffset                  = CGPointZero;
    
    blurImageView                   = nil;
    blurLayerColor                  = nil;
    blurLayerWidthScale             = 2.0f;
    popOutButton                    = nil;
    unPopOutButton                  = nil;

    actionsMenu                     = nil;
    actionsMenuInteritemSpacing     = 0.0f;
    
    transformPopOutDuration         = 0.33f;
    transformBeforeCenter           = CGPointZero;
    isPoppedOut                     = NO;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetFrame
{
    CGFloat                         screenWidth;
    CGRect                          frame;
    
    frame                           = CGRectMake( 0.0f, 0.0f, 0.0f, 0.0f );
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    
    frame.origin.x                  = screenWidth;
    if ( nil != popOutButton )
    {
        frame.size                  = [popOutButton bounds].size;
    }

    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            frame.origin.x          = 0;
            if ( nil != actionsMenu )
            {
                frame.origin.x      = -( [actionsMenu bounds].size.width + positionOffset.x );
                frame.size.width    += [actionsMenu bounds].size.width;
                frame.size.width    += positionOffset.x;
            }
            
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            if ( nil != popOutButton )
            {
                frame.origin.x      -= frame.size.width;
            }
            if ( nil != actionsMenu )
            {
                frame.size.width    += [actionsMenu bounds].size.width;
                frame.size.width    -= positionOffset.x;
            }
            
            break;
        }
        default:
            break;
    }
    

    frame.origin.x                  += positionOffset.x;
    frame.origin.y                  += positionOffset.y;
    [self                           setFrame: frame];
    if ( nil != blurImageView )
    {
        frame.size.width            = ( frame.size.width * blurLayerWidthScale );
        frame.origin                = CGPointMake( -( ( frame.size.width - [self frame].size.width ) / 2.0f ), 0.0f );
        
        [blurImageView              setFrame: frame];
    }
    [self                           _SetPopOutFrame];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetPopOutFrame
{
    if ( nil == popOutButton )
    {
        return;
    }
    
    CGRect                          offsetRect;
    
    offsetRect                      = [popOutButton frame];
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            if ( ( nil != popOutButton ) && ( nil != actionsMenu ) )
            {
                offsetRect.origin.x = ( [actionsMenu bounds].size.width + positionOffset.x );
                [popOutButton       setFrame: offsetRect];
            }
            if ( nil != unPopOutButton )
            {
                [unPopOutButton     setFrame: offsetRect];
            }
            
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            break;
        }
        default:
            break;
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetActionsMenuFrame
{
    if ( ( nil == actionsMenu ) || ( [[actionsMenu subviews] count] <= 1 ) )
    {
        return;
    }
    
    CGSize                          contentSize;
    CGRect                          menuRect;
    CGRect                          objectRect;
    CGPoint                         nextObjectPoint;
    CGPoint                         scrollOffset;
    CGFloat                         screenWidth;
    
    objectRect                      = CGRectZero;
    nextObjectPoint                 = CGPointZero;
    scrollOffset                    = CGPointZero;
    contentSize                     = [actionsMenu contentSize];
    menuRect                        = [actionsMenu frame];
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    for ( id idObject in [actionsMenu subviews] )
    {
        if ( ( nil == idObject ) || ( [idObject isKindOfClass: [UIButton class]] == NO ) )
        {
            continue;
        }
        
        objectRect                  = [idObject frame];
        objectRect.origin.x         = nextObjectPoint.x;
        [idObject                   setFrame: objectRect];
//        [idObject                   setBackgroundColor: [UIColor orangeColor]];
        
        nextObjectPoint.x           += ( [idObject bounds].size.width + actionsMenuInteritemSpacing );
    }
    contentSize.width               = ( nextObjectPoint.x - actionsMenuInteritemSpacing );
    
    menuRect.size.width             = contentSize.width;
    if ( ( ( screenWidth / 2.0f ) - [popOutButton bounds].size.width ) < contentSize.width )
    {
        menuRect.size.width         = ( ( screenWidth / 2.0f ) - [popOutButton bounds].size.width );
    }
    
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            menuRect.origin.x       = 0;
            scrollOffset.x          = ( ( contentSize.width > menuRect.size.width ) ? ( contentSize.width - menuRect.size.width ) : 0.0f );
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            break;
        }
        default:
            break;
    }
    
    [actionsMenu                    setFrame: menuRect];
    [actionsMenu                    setContentSize: contentSize];
    [actionsMenu                    setContentOffset: scrollOffset];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for calculate.
//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _CalculateActionsMenuContentSize:(CGSize)newItemSize
{
    if ( CGSizeEqualToSize( newItemSize, CGSizeZero ) == true )
    {
        return CGSizeZero;
    }
    
    if ( ( nil == actionsMenu ) || ( [[actionsMenu subviews] count] == 0 ) )
    {
        return newItemSize;
    }
    
    CGSize                          contentSize;
    
    contentSize                     = [actionsMenu contentSize];
    contentSize.width               += ( newItemSize.width + actionsMenuInteritemSpacing );
    contentSize.height              = MAX( contentSize.height, newItemSize.height );
    return contentSize;
}

//  ------------------------------------------------------------------------------------------------
- ( CGPoint) _CalculateNewActionItemOrigin
{
    if ( ( nil == actionsMenu ) || ( [[actionsMenu subviews] count] == 0 ) )
    {
        return CGPointZero;
    }
    
    CGPoint                         newOrigin;
    id                              idObject;
    
    newOrigin                       = CGPointZero;
    idObject                        = [[actionsMenu subviews] lastObject];
    if ( nil == idObject )
    {
        return CGPointZero;
    }
    
    newOrigin.x                     = ( [idObject frame].origin.x + [idObject frame].size.width + actionsMenuInteritemSpacing );
    return newOrigin;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _CreateBlurImage:(UIColor *)blurColor
{
    if ( nil == blurColor )
    {
        return nil;
    }
    
    CGRect                          mainRect;
    UIImage                       * image;
    CGContextRef                    context;
    
    image                           = nil;
    mainRect                        = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext( mainRect.size );
    context                         = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor( context, [blurLayerColor CGColor] );
    CGContextFillRect( context, mainRect );
    CGContextStrokePath( context );
    
    image                           = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateBlurImageView
{
    if ( nil != blurImageView )
    {
        return YES;
    }
    
//    UIImage                       * blurImage;
//    
//    blurImage                       = [self _CreateBlurImage: blurLayerColor];
//    if ( nil == blurImage )
//    {
//        return NO;
//    }
//    blurImageView                   = [[UIImageView alloc] initWithImage: blurImage];
    
    blurImageView                   = [[UIImageView alloc] init];
    if ( nil == blurImageView )
    {
        return NO;
    }
    
    if ( nil != blurLayerColor )
    {
        [blurImageView              setBackgroundColor: blurLayerColor];
    }
    
    [blurImageView                  setAlpha: 0.0f];
    [self                           addSubview: blurImageView];
    [self                           sendSubviewToBack: blurImageView];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    buttonRect                      = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    popOutButton                    = [UIButton buttonWithImage: image highlighted: highlighted disabled: disabled selected: nil origin: CGPointZero];
    if ( nil == popOutButton )
    {
        return NO;
    }
    
    [popOutButton                   setFrame: buttonRect];
    [popOutButton                   addTarget: self action: @selector( _PopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
//    [popOutButton                   setBackgroundColor: [UIColor greenColor]];
    
    [self                           addSubview: popOutButton];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _PopOutAction:(id) sender
{
    //  when un-pop out button is nil.
    if ( ( nil == unPopOutButton ) && ( YES == isPoppedOut ) )
    {
        //  change this touch action.
        [self                       _UnPopOutAction: sender];
        return;
    }
    
    CGPoint                         transformCenter;

    transformBeforeCenter           = [self center];
    transformCenter                 = transformBeforeCenter;
    
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            transformCenter.x       += ( ( nil != actionsMenu ) ? [actionsMenu bounds].size.width : 0.0f );
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            transformCenter.x       -= ( ( nil != actionsMenu ) ? [actionsMenu bounds].size.width : 0.0f );
            break;
        }
        default:
            break;
    }
    
    [UIView                         animateWithDuration: transformPopOutDuration animations: ^
    {
        [self                       setCenter: transformCenter];
        if ( nil != blurImageView )
        {
            [blurImageView          setAlpha: 1.0f];
        }
        
    } completion: ^ ( BOOL finished )
    {
        if ( nil != unPopOutButton )
        {
            [popOutButton           setHidden: YES];
            [unPopOutButton         setHidden: NO];
        }
        else
        {
            isPoppedOut             = YES;
        }
    }];
    
    
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled;
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    if ( nil != popOutButton )
    {
        buttonRect                  = [popOutButton frame];
    }
    else
    {
        buttonRect                  = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    }
    
    unPopOutButton                  = [UIButton buttonWithImage: image highlighted: highlighted disabled: disabled selected: nil origin: CGPointZero];
    if ( nil == unPopOutButton )
    {
        return NO;
    }
    
    [unPopOutButton                 setFrame: buttonRect];
    [unPopOutButton                 addTarget: self action: @selector( _UnPopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    [unPopOutButton                 setHidden: YES];
//    [unPopOutButton                 setBackgroundColor: [UIColor greenColor]];
    
    [self                           addSubview: unPopOutButton];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _UnPopOutAction:(id) sender
{
    CGPoint                         transformCenter;
    
    transformCenter                 = transformBeforeCenter;
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            break;
        }
        default:
            break;
    }
    [UIView                         animateWithDuration: transformPopOutDuration animations: ^
    {
        [self                       setCenter: transformCenter];
        if ( nil != blurImageView )
        {
            [blurImageView          setAlpha: 0.0f];
        }
        
    } completion: ^ ( BOOL finished )
    {
        if ( nil != popOutButton )
        {
            [popOutButton           setHidden: NO];
            [unPopOutButton         setHidden: YES];
        }
        transformBeforeCenter       = CGPointZero;
        isPoppedOut                 = NO;
    }];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateActionsMenu
{
    CGRect                          actionsMenuRect;
    CGPoint                         offset;
    CGSize                          baseSize;
    
    offset                          = CGPointZero;
    baseSize                        = CGSizeZero;
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            if ( nil != popOutButton )
            {
                baseSize            = [popOutButton bounds].size;
            }
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            if ( nil != popOutButton )
            {
                offset.x            += [popOutButton bounds].size.width;
                baseSize            = [popOutButton bounds].size;
            }
            
            break;
        }
        default:
            break;
    }
    
    offset.x                        -= positionOffset.x;    //  reset special offset from superview & superview's supverview's.
    actionsMenuRect                 = CGRectMake( offset.x, offset.y, baseSize.width, baseSize.height );
    actionsMenu                     = [[UIScrollView alloc] initWithFrame: actionsMenuRect];
    if ( nil == actionsMenu )
    {
        return NO;
    }
    
//    [actionsMenu                    setBackgroundColor: [UIColor yellowColor]];
    [self                           addSubview: actionsMenu];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( UIButton * ) _CreateActionItem:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled
{
    if ( ( nil == image ) || ( nil == highlighted ) || ( nil == actionsMenu ) )
    {
        return nil;
    }
    
    CGRect                          buttonRect;
    CGSize                          contentSize;
    UIButton                      * actionButton;
    
    buttonRect                      = CGRectZero;
    contentSize                     = [actionsMenu bounds].size;
    actionButton                    = [UIButton buttonWithImage: image highlighted: highlighted disabled: disabled selected: nil origin: CGPointZero];
    if ( nil == actionButton )
    {
        return nil;
    }
    
    buttonRect.size                 = [actionButton bounds].size;
    buttonRect.origin               = [self _CalculateNewActionItemOrigin];
    contentSize                     = [self _CalculateActionsMenuContentSize: buttonRect.size];
    
    [actionButton                   setFrame: buttonRect];
    [actionsMenu                    addSubview: actionButton];
    [actionsMenu                    setContentSize: contentSize];
    
    //  reset actions menu's frame.
    [self                           _SetActionsMenuFrame];
    [self                           _SetFrame];
    return actionButton;
}


//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDBasePopMenu

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.

////  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != blurImageView )
    {
        SAFE_ARC_RELEASE( blurImageView );
        blurImageView               = nil;
    }
    
    if ( nil != popOutButton )
    {
        SAFE_ARC_RELEASE( popOutButton );
        popOutButton                = nil;
    }
    
    if ( nil != unPopOutButton )
    {
        SAFE_ARC_RELEASE( unPopOutButton );
        unPopOutButton              = nil;
    }
    
    if ( nil != actionsMenu )
    {
        SAFE_ARC_RELEASE( actionsMenu );
        actionsMenu                 = nil;
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype ) initWithPosition:(TDBasePopMenuPosition)menuPosition
                            popOut:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled origin:(CGPoint)offset
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  assign variables.
    popMenuPosition                 = menuPosition;
    positionOffset                  = offset;
    
    [self                           _CreateBlurImageView];
    [self                           _CreatePopOutView: image highlighted: highlighted disabled: disabled];
    [self                           _CreateActionsMenu];
    
    [self                           _SetFrame];
//    [self                           setBackgroundColor: [UIColor purpleColor]];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) popMenu:(TDBasePopMenuPosition)menuPosition
                    popOut:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled origin:(CGPoint)offset
{
    return [[[self class] alloc] initWithPosition: menuPosition popOut: image highlighted: highlighted disabled: disabled origin: offset];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) setUnPopOut:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled
{
    return [self _CreateUnPopOutView: image highlighted: highlighted disabled: disabled];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) AddAction:(UIImage *)image highlighted:(UIImage *)highlighted disabled:(UIImage *)disabled
              target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton                      * actionButton;
    
    actionButton                    = [self _CreateActionItem: image highlighted: highlighted disabled: disabled];
    if ( nil == actionButton )
    {
        return NO;
    }

    if ( ( nil == target ) || ( nil == action ) )
    {
        return YES;
    }
    [actionButton                   addTarget: target action: action forControlEvents: controlEvents];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get properties of object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) setInteritemSpacing:(CGFloat)interitemSpacing
{
    actionsMenuInteritemSpacing     = interitemSpacing;
    
    //  re-calculate object's frame.
    [self                           _SetActionsMenuFrame];
    [self                           _SetFrame];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setPopOutAnimateDuration:(CGFloat)duration
{
    duration                        = ( ( 0.1f > duration  ) ? 0.1f : duration );
    transformPopOutDuration         = duration;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setBlurLayer:(UIColor *)layerColor scale:(CGFloat)widthScale
{
    if ( nil == layerColor )
    {
        layerColor                  = [UIColor clearColor];
    }
    blurLayerColor                  = layerColor;
    
    if ( 0 > widthScale )
    {
        widthScale                  = 0;
    }
    blurLayerWidthScale             = widthScale;

    if ( nil == blurImageView )
    {
        [self                       _CreateBlurImageView];
    }
    [blurImageView                  setBackgroundColor: layerColor];
    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setEnabled:(BOOL)enabled
{
    if ( nil != popOutButton )
    {
        [popOutButton               setEnabled: enabled];
    }
    
    if ( nil != unPopOutButton )
    {
        [unPopOutButton             setEnabled: enabled];
    }
    
    if ( ( nil != actionsMenu ) && ( [[actionsMenu subviews] count] > 0 ) )
    {
        for ( id idObject in [actionsMenu subviews] )
        {
            if ( ( nil == idObject ) || ( [idObject isKindOfClass: [UIButton class]] == NO ) )
            {
                continue;
            }
            [idObject               setEnabled: enabled];
        }
    }
}

//  ------------------------------------------------------------------------------------------------



@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
































