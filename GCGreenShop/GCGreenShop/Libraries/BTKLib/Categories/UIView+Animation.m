//
//  UIView+Animation.m
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 PT Software Solutions. All rights reserved.
//

#import "UIView+Animation.h"

// Very helpful function
float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180.0;
}

@implementation UIView (Animation)

#pragma mark - Moves

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop

                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1 
                                                   delay:0.0 
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
[delegate performSelector:method];
#pragma clang diagnostic pop
                                                  
                                              }];
                         } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];        
}


#pragma mark - Transforms

- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degrees));
                     }
                     completion:^(BOOL finished) { 
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) { 
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs/4 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(90));
                     }
                     completion:^(BOOL finished) { 
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs/4 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(270));
                     }
                     completion:^(BOOL finished) { 
                         [self spinCounterClockwise:secs];
                     }];
}


#pragma mark - Transitions

- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
    self.tag = 20;
	[NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
	CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
	self.transform = trans;
	self.alpha = self.alpha * 0.98;
	self.tag = self.tag - 1;
	if (self.tag <= 0) {
		[timer invalidate];
		[self removeFromSuperview];
	}
}

#pragma mark - Effects

- (void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

- (void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) { 
                         [UIView animateWithDuration:secs/2 
                                               delay:0.0 
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) { 
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}


#pragma mark - Shakes

- (void)shake {
    [self _shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
                }
            }];
            return;
        }
        [self _shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:completionHandler];
    }];
}


#pragma mark - Adds a subview

- (void)addSubviewWithFadeAnimation:(UIView *)subview {
    
    CGFloat finalAlpha = subview.alpha;
    
    subview.alpha = 0.0;
    [self addSubview:subview];
    [UIView animateWithDuration:0.2 animations:^{
        subview.alpha = finalAlpha;
    }];
}

- (void)addSubview:(UIView *)subview withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationDuration: duration];
    [UIView setAnimationTransition: transition forView: self cache: YES];
    [self addSubview: subview];
    [UIView commitAnimations];
}

- (void)removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration {
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: duration];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
    self.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationDuration: duration];
    [UIView setAnimationTransition: transition forView: self.superview cache: YES];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

- (void)rotateByAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
          autoreverse:(BOOL)autoreverse
          repeatCount:(CGFloat)repeatCount
       timingFunction:(CAMediaTimingFunction *)timingFunction {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
    rotation.toValue = [NSNumber numberWithFloat: radiansForDegrees(angle)];
    rotation.duration = duration;
    rotation.repeatCount = repeatCount;
    rotation.autoreverses = autoreverse;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeBoth;
    rotation.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: rotation forKey: @"rotationAnimation"];
}

@end
