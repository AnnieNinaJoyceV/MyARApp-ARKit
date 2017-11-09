//
//  ARSceneBaseViewController.h
//  MyARApp
//
//  Created by Joyce on 09/11/17.
//  Copyright © 2017 Quentin Fasquel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ARKit/ARKit.h>

@interface ARSceneBaseViewController : UIViewController
    
@property (nonnull, strong, nonatomic) ARSCNView *sceneView;
@property (nonnull, strong, nonatomic) NSMutableArray<SCNNode *> *trackableNodes;

- (nonnull ARSCNView *)createSceneView;
- (void)setupAR;
- (void)setupTrackables;
- (void)addTrackable:(NSString *_Nonnull)imagePath width:(CGFloat)width height:(CGFloat)height;
- (void)draw3DRelevantOf:(NSInteger)trackableID;

@end
