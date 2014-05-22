//
//  sceneManager.h
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 21..
//
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>

// 게임에서 사용되는 레이어를 추가하거나 불필요한 레이어는 삭제한다

#import "menuScene.h"
#import "howtoScene.h"
#import "howtoScene2.h"
#import "creditScene.h"
#import "storyScene.h"
#import "selectScene.h"
#import "gameScene.h"
#import "gameScene2.h"
#import "gameoverScene.h"
#import "victoryScene.h"

@interface sceneManager : CCLayer
{
}


// 각 레이어로 이동하는 정적 메소드임
+(void) goIntro;
+(void) goMenu;
+(void) goStory;
+(void) goSelect;
+(void) goGame;
+(void) goGame2;
+(void) goGameOver;
+(void) goVictory;
+(void) goCredit;
+(void) goHowto;
+(void) goHowto2;

// 레이어간 이동에서 사용되는 트랜지션 효과와 효과에 사용되는 시간
+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString ofDelay:(float)t;
+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString;
+(void) go:(CCLayer *)layer;


@end
