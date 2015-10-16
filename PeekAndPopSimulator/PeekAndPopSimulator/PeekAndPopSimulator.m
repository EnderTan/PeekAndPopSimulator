//
//  PeekAndPopSimulator.m
//  PeekAndPopSimulator
//
//  Created by Bing on 15/10/16.
//  Copyright © 2015年 tanyunbing. All rights reserved.
//

#import "PeekAndPopSimulator.h"

@implementation UIViewController (Previewing)

- (id<UIViewControllerPreviewing>)previewer{
    return objc_getAssociatedObject(self, @selector(previewer));
}

- (void)setPreviewer:(id<UIViewControllerPreviewing>)previewer{
    objc_setAssociatedObject(self, @selector(previewer), previewer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    _UIViewControllerPreviewSourceViewRecord *record = (_UIViewControllerPreviewSourceViewRecord *)previewer;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
    [record.sourceView addGestureRecognizer:longPress];
}


- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self simulate3DTouchPreviewWithPreviewer:self.previewer];
    }
    
}

- (void)simulate3DTouchPreviewWithPreviewer:(id<UIViewControllerPreviewing>)previewer{
    _UIViewControllerPreviewSourceViewRecord *record = (_UIViewControllerPreviewSourceViewRecord *)previewer;
    UIPreviewInteractionController *interactionController = record.previewInteractionController;
    
    //Start
    [interactionController startInteractivePreviewWithGestureRecognizer:interactionController.touchObservingGestureRecognizer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeGap * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //Blur except sourceRect
        [interactionController.interactionProgressForPresentation setPercentComplete:1.0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeGap * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //Peek action
            [interactionController.interactionProgressForPresentation endInteraction:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeGap * 3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //Simulate ActionSheet animation
                [UIView animateWithDuration:0.5 animations:^{
                    UIView *previewActionSheet = interactionController.currentPresentationController.previewActionSheet;
                    
                    interactionController.currentPresentationController.actionSheetContainerView.transform = CGAffineTransformMakeTranslation(0, -previewActionSheet.frame.size.height);
                    
                    interactionController.currentPresentationController.containerScrollView.contentOffset = CGPointMake(0, previewActionSheet.frame.size.height);
                    
                }];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeGap * 4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    //Simulate ActionSheet animation back
                    [UIView animateWithDuration:0.5 animations:^{
                        interactionController.currentPresentationController.actionSheetContainerView.transform = CGAffineTransformIdentity;
                        
                        interactionController.currentPresentationController.containerScrollView.contentOffset = CGPointMake(0, 0);
                    }];
                    
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeGap * 5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //Simulate Pop action
                        [interactionController commitInteractivePreview];
                        //[interactionController cancelInteractivePreview]; //cancle peek
                        
                    });
                    
                });
                
                
            });
            
        });
    });
    
    
}

@end
