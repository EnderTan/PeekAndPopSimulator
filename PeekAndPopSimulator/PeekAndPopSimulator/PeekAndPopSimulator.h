//
//  PeekAndPopSimulator.h
//  PeekAndPopSimulator
//
//  Created by Bing on 15/10/16.
//  Copyright © 2015年 tanyunbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define timeGap 0.3

@interface UIViewController (Previewing)

@property (nonatomic, strong) id<UIViewControllerPreviewing> previewer;

@end





#pragma mark - Private API


@interface UIPreviewForceInteractionProgress : NSObject

- (void)endInteraction:(BOOL)arg1;
- (void)setPercentComplete:(float)arg1;

@end



@interface UIInteractionProgress : NSObject

@property (nonatomic, readonly) float percentComplete;
@property (nonatomic, readonly) float velocity;

@end



@interface UIPreviewPresentationController : UIPresentationController

@property (nonatomic, retain) UIImageView *actionSheetAvailableImageView;
@property (nonatomic, retain) UIView *actionSheetContainerView;
@property (nonatomic, retain) UIView *previewActionSheet;
@property (nonatomic, retain) UIScrollView *containerScrollView;

@end



@interface UIPreviewInteractionController : NSObject

@property (nonatomic, readonly) UIPreviewForceInteractionProgress *interactionProgressForPresentation;
@property (nonatomic, readonly) UIGestureRecognizer *beginPreviewGestureRecognizer;
@property (nonatomic, readonly) UIGestureRecognizer *presentationGestureRecognizer;
@property (nonatomic, retain) UIGestureRecognizer *previewGestureRecognizer;
@property (nonatomic, retain) UIGestureRecognizer *revealGestureRecognizer;
@property (nonatomic, retain) UIGestureRecognizer *touchObservingGestureRecognizer;
@property (nonatomic) CGPoint location;
@property (nonatomic, retain) UIPreviewForceInteractionProgress *interactionProgressForCommit;
@property (nonatomic, retain) UIPreviewPresentationController *currentPresentationController;

- (BOOL)startInteractivePreviewWithGestureRecognizer:(id)arg1;
- (BOOL)startInteractivePreviewAtPosition:(CGPoint)point inView:(UIView *)view;
- (void)cancelInteractivePreview;
- (void)commitInteractivePreview;

@end





@interface _UIViewControllerPreviewSourceViewRecord : NSObject <UIViewControllerPreviewing>

@property (nonatomic, readonly) UIPreviewInteractionController *previewInteractionController;

@end
