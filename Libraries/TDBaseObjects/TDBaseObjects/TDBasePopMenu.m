//
//  TDBasePopMenu.m
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/6/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

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
 *  @return object|nil              a blur image object or ni.
 */
- ( UIImage * ) _CreateBlurImage;

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
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a un-pop out button with image.
 *  create a un-pop out button with image.
 *
 *  @param image                    un-pop out's image.
 *  @param highlighted              un-pop out's highlighted image.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted;

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
 *
 *  @return button|nil              a action item or nil.
 */
- ( UIButton * ) _CreateActionItem:(UIImage *)image highlighted:(UIImage *)highlighted;

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
    popOutButton                    = nil;
    unPopOutButton                  = nil;

    actionsMenu                     = nil;
    
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
                frame.size.width            += [actionsMenu bounds].size.width;
                frame.size.width            -= positionOffset.x;
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
        frame.origin                = CGPointMake( -( frame.size.width / 2.0f ), 0.0f );
        frame.size.width            = ( frame.size.width * 2.0f );
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
    
    CGPoint                         centerOffset;
    CGRect                          offsetRect;
    
    centerOffset                    = CGPointZero;
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
    contentSize.width               += ( newItemSize.width + 2.0f );
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
    
    newOrigin.x                     = ( [idObject frame].origin.x + [idObject frame].size.width + 2.0f );
    return newOrigin;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _CreateBlurImage
{
    CGRect                          mainRect;
    UIImage                       * image;
    CGContextRef                    context;
    
    image                           = nil;
    mainRect                        = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext( mainRect.size );
    context                         = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor( context, [[[UIColor darkGrayColor] colorWithAlphaComponent: 0.66f] CGColor] );
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
    
    UIImage                       * blurImage;
    
    blurImage                       = [self _CreateBlurImage];
    if ( nil == blurImage )
    {
        return NO;
    }
    
    blurImageView                   = [[UIImageView alloc] initWithImage: blurImage];
    if ( nil == blurImage )
    {
        return NO;
    }
    
    [blurImageView                  setAlpha: 0.0f];
    [self                           addSubview: blurImageView];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    buttonRect                      = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    popOutButton                    = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == popOutButton )
    {
        return NO;
    }
    
    [popOutButton                   setFrame: buttonRect];
    [popOutButton                   addTarget: self action: @selector( _PopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    [self                           addSubview: popOutButton];
//    [self                           setBackgroundColor: [UIColor orangeColor]];
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
    
    [UIView                         animateWithDuration: 0.33f animations: ^
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
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted
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
    
    unPopOutButton                  = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == unPopOutButton )
    {
        return NO;
    }
    
    [unPopOutButton                 setFrame: buttonRect];
    [unPopOutButton                 addTarget: self action: @selector( _UnPopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    [unPopOutButton                 setHidden: YES];
    
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
    [UIView                         animateWithDuration: 0.33f animations: ^
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
- ( UIButton * ) _CreateActionItem:(UIImage *)image highlighted:(UIImage *)highlighted
{
    if ( ( nil == image ) || ( nil == highlighted ) || ( nil == actionsMenu ) )
    {
        return nil;
    }
    
    CGPoint                         scrollOffset;
    CGRect                          buttonRect;
    CGRect                          menuRect;
    CGSize                          contentSize;
    CGFloat                         screenWidth;
    UIButton                      * actionButton;
    
    scrollOffset                    = CGPointZero;
    buttonRect                      = CGRectZero;
    menuRect                        = [actionsMenu frame];
    contentSize                     = [actionsMenu bounds].size;
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    actionButton                    = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
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
    
    //  reset menu's frame.
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
    [actionsMenu                    setContentOffset: scrollOffset];
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
//- ( void ) dealloc
//{
//}

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype ) initWithPosition:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
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
    [self                           _CreatePopOutView: image highlighted: highlighted];
    [self                           _CreateActionsMenu];
    
    [self                           _SetFrame];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) popMenu:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    return [[[self class] alloc] initWithPosition: menuPosition popOut: image highlighted: highlighted origin: offset];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) setUnPopOut:(UIImage *)image highlighted:(UIImage *)highlighted
{
    return [self _CreateUnPopOutView: image highlighted: highlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) AddAction:(UIImage *)image highlighted:(UIImage *)highlighted
              target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton                      * actionButton;
    
    actionButton                    = [self _CreateActionItem: image highlighted: highlighted];
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



@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
































