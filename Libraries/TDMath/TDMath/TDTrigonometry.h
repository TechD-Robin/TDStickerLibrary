//
//  TDTrigonometry.h
//  TDMath
//
//  Created by Robin Hsu on 2014/12/4.
//  Copyright (c) 2014年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef TDMath_TDTrigonometry_h
#define TDMath_TDTrigonometry_h

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate hypotenuse side length of triangle.
 *  use adjacent side and opposite site to calculate typotenuse side of triangle.
 *
 *  @param sideAdjacent             adjacent side of triangle.
 *  @param sideOpposite             opposite side of triangle.
 *
 *  @return                         hypotenuse side length of triangle.
 */
CGFloat calculateTriangleHypotenuse( CGFloat sideAdjacent , CGFloat sideOpposite );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate adjacent side length of triangle.
 *  use hypotenuse side and tanθ to calculate adjacent side of triangle.
 *
 *  @param sideHypotenuse           hypotenuse side of triangle.
 *  @param tanTheta                 tanθ of triangle.
 *
 *  @return                         adjacent side length of triangle.
 */
CGFloat calculateTriangleAdjacentWithHypotenuse( CGFloat sideHypotenuse, CGFloat tanTheta );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate opposite side length of triangle.
 *  use hypotenuse side and tanθ to calculate opposite side of triangle.
 *
 *  @param sideHypotenuse           hypotenuse side of triangle.
 *  @param tanTheta                 tanθ of triangle.
 *
 *  @return                         opposite side length of triangle.
 */
CGFloat calculateTriangleOppositeWithHypotenuse( CGFloat sideHypotenuse, CGFloat tanTheta );

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------


#endif

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
