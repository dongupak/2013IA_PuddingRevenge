//
//  selectScene.h
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "CCLayer.h"
#import "SceneManager.h"
#import "SimpleAudioEngine.h"

@interface selectScene : CCLayerColor
{
    CCSprite *flame;
    CCSprite *electric;
    CCMenuItem *selecFlame;
    CCMenuItem *selecElectric;
    CCMenu *select;
    CCSprite *pudding;
    SimpleAudioEngine *gsound;

}

@end
