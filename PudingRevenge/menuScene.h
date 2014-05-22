//
//  HelloWorldLayer.h
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>

#import "cocos2d.h"
#import "SceneManager.h"
#import "SimpleAudioEngine.h"


@interface menuSceneLayer : CCLayerColor <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite *flame;
    CCSprite *electric;
   SimpleAudioEngine *gsound;

}


+(CCScene *) scene;


@end
