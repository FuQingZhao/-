//
//  UIView+Draggable.h
//  UIView+Draggable
//
//  Created by Andrea on 13/03/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//
//  https://github.com/andreamazz/UIView-draggable
//  UIView category that adds dragging capabilities


@import UIKit;

/**
 * @name UIView+draggable
 * Adds the ability to drag a UIView
 */
@interface UIView (Draggable)

/**
 *  The pan gestures that handles the view dragging
 */
@property (nonatomic) UIPanGestureRecognizer *panGesture;

/**
 A caging area such that the view can not be moved outside
 of this frame.
 If @c cagingArea is not @c CGRectZero, and @c cagingArea does not contain the
 view's frame then this does nothing (ie. if the bounds of the view extend the
 bounds of @c cagingArea).
 Optional. If not set, defaults to @c CGRectZero, which will result
 in no caging behavior.
 */
@property (nonatomic) CGRect cagingArea;

/**
 Restricts the area of the view where the drag action starts.
 Optional. If not set, defaults to self.view.
 */
@property (nonatomic) CGRect handle;

/**
 Restricts the movement along the X axis
 */
@property (nonatomic) BOOL shouldMoveAlongX;

/**
 Restricts the movement along the Y axis
 */
@property (nonatomic) BOOL shouldMoveAlongY;

/**
 Notifies when dragging started. Passes a reference to the view.
 */
@property (nonatomic, copy) void (^draggingStartedBlock)(UIView *);

/**
 Notifies when dragging has moved. Passes a reference to the view.
 */
@property (nonatomic, copy) void (^draggingMovedBlock)(UIView *);

/**
 Notifies when dragging ended. Passes a reference to the view.
 */
@property (nonatomic, copy) void (^draggingEndedBlock)(UIView *);

/** Enables the dragging
 *
 * Enables the dragging state of the view
 */
- (void)enableDragging;

/** Disable or enable the view dragging
 *
 * @param draggable The boolean that enables or disables the draggable state
 */
- (void)setDraggable:(BOOL)draggable;

@end
