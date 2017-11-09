//
//  ARSceneBaseViewController.m
//  MyARApp
//
//  Created by Joyce on 09/11/17.
//  Copyright © 2017 Quentin Fasquel. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ARSceneBaseViewController.h"

/*--NOTE ::: CANNOT BE IMPORTED IN .h FILE--*/
#import "ARToolkitExtensions.h"
#include "ARController.h"
/*----*/

/*---VIDEO PRESET---*/
const NSString *ARResolutionPresets[] = {
    @"-preset=high",
    @"-preset=medium",
    @"-preset=low",
    @"-preset=480p",
    @"-preset=720p",
    @"-preset=cif",
    @"-preset=1080p"
};
#define ARResolutionPresetsLength (sizeof(ARResolutionPresets)/sizeof(ARResolutionPresets[0]))
const NSString *ARCameraPositionPresets[] = {
    @"-position=back",
    @"-position=front"
};
#define ARCameraPositionPresetsLength (sizeof(ARCameraPositionPresets)/sizeof(ARCameraPositionPresets[0]))
/*-------------------*/
@interface ARSceneBaseViewController () <ARSCNViewDelegate> {
    ARController *arController;
    std::vector<int> trackableIds;
    std::vector<bool> trackableVisible;
    bool contextWasUpdated;
    int contextWidth;
    int contextHeight;
    bool contextRotate90;
    bool contextFlipH;
    bool contextFlipV;
    int32_t viewport[4];
    int ARResolutionPreset;
    int ARCameraPositionPreset;
}
@end
//-------***-------***------***--------//
@implementation ARSceneBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ARResolutionPreset = 0;
    ARCameraPositionPreset = 0;
}

- (nonnull ARSCNView *)createSceneView {
    ARSCNView *sceneView = [[ARSCNView alloc] initWithFrame: [UIScreen mainScreen].bounds];
//    sceneView.debugOptions = ARSCNDebugOptionShowWorldOrigin | ARSCNDebugOptionShowFeaturePoints | SCNDebugOptionShowPhysicsShapes;
    sceneView.delegate = self;
    sceneView.showsStatistics = YES;
    sceneView.rendersContinuously = YES;
    return sceneView;
}

- (void)setupTrackables {
    // Here you add all the trackables you want
    // to be overriden in sub class
}

- (void)setupAR {
    
    char vconf[] = "-preset=720p";
//    char vconf[] = "-preset=high -position=back -format=BGRA";
    [EAGLContext setCurrentContext:self.sceneView.eaglContext];
    //Initialise the ARController.
    arController = new ARController();
    if (!arController->initialiseBase()) {
        ARLOGe("Error initialising ARController.\n");
        return;
    }
    [self setupTrackables];
    arController->get2DTracker().setMaxSimultaneousTrackedImages(1);
    arController->startRunning(vconf, NULL, NULL, 0);
}

- (void)tearDownAR {
    if (arController) {
        arController->displayFrameFinal(0);
        arController->shutdown();
        delete arController;
    }
}

- (void)addTrackable:(NSString *)imagePath width:(CGFloat)width height:(CGFloat)height {
    const char *resourcePath = [imagePath cStringUsingEncoding:NSUTF8StringEncoding];
    char *trackableConfig;
    // TODO: find out relation between height and h
    asprintf(&trackableConfig, "2d;%s;%f", resourcePath, height);
    int trackableId = arController->addTrackable(trackableConfig);
    if (trackableId == -1) {
        ARLOGe("Error adding trackable.\n");
        return;
    }
    
    trackableIds.push_back(trackableId);
    trackableVisible.push_back(false); // not visible by default
    SCNPlane *plane = [SCNPlane planeWithWidth:width height:height];
    plane.firstMaterial.diffuse.contents = [UIColor blueColor];
    plane.firstMaterial.transparency = 0.5f;
    SCNNode *trackableNode = [SCNNode nodeWithGeometry:plane];
    trackableNode.position = SCNVector3Zero;
    trackableNode.opacity = 1;
//    SCNNode *camera = self.sceneView.pointOfView;
//    [camera addChildNode:trackableNode];
    [self.sceneView.scene.rootNode addChildNode:trackableNode];
    [self.trackableNodes addObject:trackableNode];
    free(trackableConfig);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat scale = [UIScreen mainScreen].nativeScale;
    contextWidth = (int)CGRectGetWidth([UIScreen mainScreen].bounds) * scale;
    contextHeight = (int)CGRectGetHeight([UIScreen mainScreen].bounds) * scale;
    NSLog(@"%d %d", contextWidth, contextHeight);
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            contextRotate90 = false; contextFlipH = contextFlipV = true;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            contextRotate90 = contextFlipH = contextFlipV = true;
            break;
        case UIInterfaceOrientationLandscapeRight:
            contextRotate90 = contextFlipH = contextFlipV = false;
            break;
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationUnknown:
        default:
            contextRotate90 = true; contextFlipH = contextFlipV = false;
            break;
    }
    contextWasUpdated = true;
}

-(void)dealloc {
    [self tearDownAR];
}
/*
// ARSCNViewDelegate - Methods
*/
- (void)renderer:(id<SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
    bool gotFrame = arController->capture();
    if (gotFrame) {
        if (!arController->update()) {
            ARLOGe("Error in ARController::update().\n");
            return;
        }
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer willRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time {
    
    [EAGLContext setCurrentContext:self.sceneView.eaglContext];
    if (arController->isRunning()) {
        NSLog(@"Check 2");
        if (contextWasUpdated) {
            NSLog(@"Check 3");
            arController->displayFrameInit(0);
            arController->displayFrameSettings(0, contextWidth, contextHeight, contextRotate90, contextFlipH, contextFlipV, ARView::HorizontalAlignment::H_ALIGN_CENTRE, ARView::VerticalAlignment::V_ALIGN_CENTRE, ARView::ScalingMode::SCALE_MODE_FIT, viewport);
            contextWasUpdated = false;
        }
        NSLog(@"Check 4");
        // Display the current video frame to the current OpenGL context.
        arController->displayFrame(0);
        
        // Get the projection matrix
        SCNMatrix4 projectionMatrix;
        SCNMatrix4 transformMatrix;
        ARdouble projection[16];
        arController->getProjectionMatrix(0, projection);
        projectionMatrix = SCNMatrix4Make(projection);
        
        // Flip works fine for landscapeLeft versus landscapeRight
        if (contextFlipV || contextFlipH) {
            projectionMatrix = SCNMatrix4Scale(projectionMatrix, contextFlipH ? -1 : 1, contextFlipV ? -1 : 1, 1);
        }
        
        // Rotation (SCNMatrix4Rotate takes radians)
        if (contextRotate90) {
            projectionMatrix = SCNMatrix4Rotate(projectionMatrix, (M_PI * 90)/180, 0, 0, -1);
        }
        
        // Look for trackables, and draw on each found one.
        NSLog(@"Check 5");
        size_t trackableCount = trackableIds.size();
        for (size_t i = 0; i < trackableCount; i++) {
            NSLog(@"Check 6");
            // Find the trackable for the given trackable ID.
            ARTrackable *trackable = arController->findTrackable(trackableIds[i]);
            SCNNode *camera = self.sceneView.pointOfView;
            SCNNode *trackableNode = self.trackableNodes[i];
            if (trackable->visible) {
                NSLog(@"Check 7");
                transformMatrix = SCNMatrix4Make(trackable->transformationMatrix);
                camera.transform = projectionMatrix;
                trackableNode.transform = transformMatrix;
                trackableNode.opacity = 1;
                [self draw3DRelevantOf:i];
            } else {
                NSLog(@"Check 8");
                trackableNode.opacity = 0;
            }
        }
    }
}

/*
// Custom delegate - Methods
*/
- (void)draw3DRelevantOf:(NSInteger)trackableID {
    
}

@end
