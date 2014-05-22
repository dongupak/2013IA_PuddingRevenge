//
//  gameScene2.h
//  PudingRevenge
//
//  Created by apple02 on 13. 6. 1..
//
//

#import "CCLayer.h"
#import "SceneManager.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"


@interface game2 : CCLayerColor
{
    NSTimer *_timer;
	NSMutableArray *_targets;
	NSMutableArray *_projectiles;
    NSInteger gold;
    NSString *goldstring;
    NSString *monstring;
	int _projectilesDestroyed;
    float timecount;
    int monstercount;
    float monspeed;
    float atSpeed;
    CCLabelTTF *timeLabel;
    CCLabelTTF *goldLabel;
    CCLabelTTF *monsterLabel;
    CCSprite *player;
    SimpleAudioEngine *gsound;
    
}
@property (nonatomic, retain) CCLabelTTF *timeLabel;

- (void)pauseGame;

@end

@interface gameScene2 : CCScene
{
    game2 *_layer;
}
@property (nonatomic, retain) game2 *layer;
@end