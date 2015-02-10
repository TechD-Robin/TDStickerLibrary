//
//  UIGestureRecognizer+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/2/11.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create tap gesture recognizer and assign the action method for owner object.
 *  create tap gesture recognizer and assign the action method for owner object.
 *
 *  @param ownerObject              owner object.
 *  @param target                   action's owner class.
 *  @param action                   a selector method of action.
 *
 *  @return YES|NO                  method success or failure
 */
+ ( BOOL ) tapGestureRecognizer:(id)ownerObject withTarget:(id)target action:(SEL)action;


//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
