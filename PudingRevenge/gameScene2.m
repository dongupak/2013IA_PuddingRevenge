//
//  gameScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "gameScene2.h"
#import "victoryScene.h"
#import "gameoverScene.h"


@implementation gameScene2
@synthesize layer = _layer;

- (id)init {
    if ((self = [super init])) {
        self.layer = [game2 node];
        [self addChild:_layer];
    }
	
	return self;
}

- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}

@end


@implementation game2

-(void)spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	
	if (sprite.tag == 1) { // target
		[_targets removeObject:sprite];
	} else if (sprite.tag == 2) { // projectile
		[_projectiles removeObject:sprite];
	}
}

-(void)addTarget {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    id stageMenuUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0, 5)];
    id stageMenuDown = [stageMenuUp reverse];
    id stageMenuAction = [CCSequence actions:stageMenuUp,stageMenuDown, nil];
    
    
    // 각 timecount 별로 스테이지가 바뀜
    if (timecount > 0 && timecount < 30) {
        CCSprite *menuStage = [CCSprite spriteWithFile:@"game_menu_stage1.png"];
        menuStage.position = ccp(winSize.width - 80, winSize.height/2 + 20);
        [self addChild:menuStage z:0 tag:0];
        [menuStage runAction:stageMenuAction];
        if (timecount > 29.8 && timecount < 30) {
            [self removeChild:menuStage cleanup:YES];
        }
    }
    
    
    if (timecount > 30 && timecount < 60) {
        CCSprite *menuStage = [CCSprite spriteWithFile:@"game_menu_stage2.png"];
        menuStage.position = ccp(winSize.width - 80, winSize.height/2 + 20);
        [self addChild:menuStage z:0 tag:0];
        [menuStage runAction:stageMenuAction];
        if (timecount > 59.8 && timecount < 60) {
            [self removeChild:menuStage cleanup:YES];
        }
    }
    
    if (timecount > 60 && timecount < 90) {
        CCSprite *menuStage = [CCSprite spriteWithFile:@"game_menu_stage3.png"];
        menuStage.position = ccp(winSize.width - 80, winSize.height/2 + 20);
        [self addChild:menuStage z:0 tag:0];
        [menuStage runAction:stageMenuAction];
        if (timecount > 89.8 && timecount < 90) {
            [self removeChild:menuStage cleanup:YES];
        }
    }
    
    if (timecount > 90 && timecount < 120) {
        CCSprite *menuStage = [CCSprite spriteWithFile:@"game_menu_stage4.png"];
        menuStage.position = ccp(winSize.width - 80, winSize.height/2 + 20);
        [self addChild:menuStage z:0 tag:0];
        [menuStage runAction:stageMenuAction];
        if (timecount > 119.8 && timecount < 120) {
            [self removeChild:menuStage cleanup:YES];
        }
    }
    
    if (timecount > 120) {
        CCSprite *menuStage = [CCSprite spriteWithFile:@"game_menu_stage5.png"];
        menuStage.position = ccp(winSize.width - 80, winSize.height/2 + 20);
        [menuStage runAction:stageMenuAction];
        [self addChild:menuStage z:0 tag:0];
    }
    
    
    
    
    // 155초가 되었을 때 몬스터 수가 1마리 이상이면 GameOver, 하나도 없으면 Victory
    
    if (timecount > 154.9)
    {
        if (monstercount < 1) {
            [sceneManager goVictory];
        }
        
        if (monstercount >= 1) {
            [sceneManager goGameOver];
        }
    }
    
    
    
    // 1스테이지 몬스터의 스피드
    if (timecount < 29) {
        monspeed = 4;
    }
    
    // 몬스터의 이동 액션
    id downMove1 = [CCMoveBy actionWithDuration:monspeed position:ccp(0, -260)];
    id rightMove1 = [CCMoveBy actionWithDuration:monspeed position:ccp(270, 0)];
    id upMove1 = [CCMoveBy actionWithDuration:monspeed position:ccp(0, 260)];
    id leftMove1 = [CCMoveBy actionWithDuration:monspeed position:ccp(-260, 0)];
    id downMove2 = [CCMoveBy actionWithDuration:monspeed position:ccp(0, -240)];
    id rightMove2 = [CCMoveBy actionWithDuration:monspeed position:ccp(270, 0)];
    id upMove2 = [CCMoveBy actionWithDuration:monspeed position:ccp(0, 260)];
    id leftMove2 = [CCMoveBy actionWithDuration:monspeed position:ccp(-270, 0)];
    id downMove3 = [CCMoveBy actionWithDuration:monspeed position:ccp(0, -260)];
    id rightMove3 = [CCMoveBy actionWithDuration:monspeed position:ccp(260, 0)];
    id upMove3 = [CCMoveBy actionWithDuration:monspeed position:ccp(0, 240)];
    id leftMove3 = [CCMoveBy actionWithDuration:monspeed position:ccp(-270, 0)];
    
    id actionMove = [CCSequence actions:downMove1,rightMove1,upMove1,leftMove1,downMove2,rightMove2,upMove2,leftMove2,downMove3,rightMove3,upMove3,leftMove3, nil];
    id actionForever = [CCRepeatForever actionWithAction:actionMove];
    
    // target 1
    
	CCSprite *target = [CCSprite spriteWithFile:@"monster1.png"];
    CCSprite *health = [CCSprite spriteWithFile:@"box.png" rect:CGRectMake(0, 0, 40, 5)];
    health.color = ccRED;
    CGSize targetSize;
    targetSize = target.contentSize;
    health.position = ccp(targetSize.width/2.0, targetSize.height+10);
    [target addChild:health];
	
    int actualX = 20;
	int actualY = 300;
	
	target.position = ccp(actualX,actualY);
    
    if (timecount < 29) {
        [self addChild:target];
        [self monplus];
    }
	
    id scale = [CCScaleBy actionWithDuration:0.2 scale:1.2];
    id rescale = [scale reverse];
    id alsca = [CCSequence actions:scale,rescale, nil];
    id alrep = [CCRepeatForever actionWithAction:alsca];
    [target runAction:alrep];
	[target runAction:actionForever];
	
	// Add to targets array
	target.tag = 50001;
	[_targets addObject:target];
    
    
    // target 2
    
    if (timecount > 30 && timecount < 59) {
        monspeed = 3;
    }
	CCSprite *target2 = [CCSprite spriteWithFile:@"monster2.png"];
    CCSprite *health2 = [CCSprite spriteWithFile:@"box.png" rect:CGRectMake(0, 0, 40, 5)];
    health2.color = ccRED;
    CGSize targetSize2;
    targetSize2 = target2.contentSize;
    health2.position = ccp(targetSize2.width/2.0, targetSize2.height+10);
    [target2 addChild:health2];
    
	target2.position = ccp(actualX,actualY);
    if (timecount > 31 && timecount < 59) {
        [self addChild:target2];
        [self monplus];
    }
	
    [target2 runAction:[alrep copy]];
	[target2 runAction:[actionForever copy]];
	
	// Add to targets array
	target2.tag = 51001;
	[_targets addObject:target2];
    
    
    // target 3
    if (timecount > 60 && timecount < 89) {
        monspeed = 2;
    }
    
	CCSprite *target3 = [CCSprite spriteWithFile:@"monster3.png"];
    CCSprite *health3 = [CCSprite spriteWithFile:@"box.png" rect:CGRectMake(0, 0, 40, 5)];
    health3.color = ccRED;
    CGSize targetSize3;
    targetSize3 = target3.contentSize;
    health3.position = ccp(targetSize3.width/2.0, targetSize3.height+10);
    [target3 addChild:health3];
	
	target3.position = ccp(actualX,actualY);
    
    if (timecount > 61 && timecount < 89) {
        [self addChild:target3];
        [self monplus];
    }
	
    
    [target3 runAction:[alrep copy]];
    
	[target3 runAction:[actionForever copy]];
	
	// Add to targets array
	target3.tag = 52001;
	[_targets addObject:target3];
    
    // target 4
    
    if (timecount > 90 && timecount < 119) {
        monspeed = 1;
    }
    
	CCSprite *target4 = [CCSprite spriteWithFile:@"monster4.png"];
    CCSprite *health4 = [CCSprite spriteWithFile:@"box.png" rect:CGRectMake(0, 0, 40, 5)];
    health4.color = ccRED;
    CGSize targetSize4;
    targetSize4 = target4.contentSize;
    health4.position = ccp(targetSize4.width/2.0, targetSize4.height+10);
    [target4 addChild:health4];
	
	target4.position = ccp(actualX,actualY);
    
    if (timecount > 91 && timecount < 119) {
        [self addChild:target4];
        [self monplus];
    }
	
    
    [target4 runAction:[alrep copy]];
    
	[target4 runAction:[actionForever copy]];
	
	// Add to targets array
	target4.tag = 53001;
	[_targets addObject:target4];
    
    // target 5
    
    if (timecount > 120) {
        monspeed = 0.7;
    }
    
	CCSprite *target5 = [CCSprite spriteWithFile:@"monster5.png"];
    CCSprite *health5 = [CCSprite spriteWithFile:@"box.png" rect:CGRectMake(0, 0, 40, 5)];
    health5.color = ccRED;
    CGSize targetSize5;
    targetSize5 = target5.contentSize;
    health5.position = ccp(targetSize5.width/2.0, targetSize5.height+10);
    [target5 addChild:health5];
    
	target5.position = ccp(actualX,actualY);
    
    if (timecount > 120 && timecount < 149) {
        [self addChild:target5];
        [self monplus];
    }
	
    
    [target5 runAction:[alrep copy]];
    
	[target5 runAction:[actionForever copy]];
	
	// Add to targets array
	target5.tag = 54001;
	[_targets addObject:target5];
    
	
}


// 매초마다 타겟(몬스터) 생성
-(void)gameLogic:(ccTime)dt {
    
    [self addTarget];
    
}

-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"map.png"];
		[bgSprite setAnchorPoint:CGPointZero];
		[bgSprite setPosition:CGPointZero];
		[self addChild:bgSprite z:0 tag:0];
        
        CCSprite *menuBackg = [CCSprite spriteWithFile:@"game_menu_background.png"];
        menuBackg.position = ccp(winSize.width - 80, winSize.height/2);
		[self addChild:menuBackg z:0 tag:0];
        
        // Menu Items
        CCMenuItem *Lottery = [CCMenuItemImage itemWithNormalImage:@"game_menu_lottery.png"
                                                     selectedImage:@"game_menu_lottery_sel.png"
                                                            target:self
                                                          selector:@selector(Lotto)];
        CCMenuItem *Asup = [CCMenuItemImage itemWithNormalImage:@"game_menu_asup.png"
                                                  selectedImage:@"game_menu_asup_sel.png"
                                                         target:self
                                                       selector:@selector(AttackSpeedUp)];
		CCMenu *menu1 = [CCMenu menuWithItems:Lottery, nil];
        menu1.position = ccp(winSize.width - 80, winSize.height/2 - 40);
		[self addChild:menu1 z:3 tag:100];
        
        CCMenu *menu2 = [CCMenu menuWithItems:Asup, nil];
        menu2.position = ccp(winSize.width - 80, winSize.height/8);
		[self addChild:menu2 z:3 tag:100];
        
		// Enable touch events
		self.isTouchEnabled = YES;
		
		// Initialize arrays
		_targets = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		
		player = [CCSprite spriteWithFile:@"electric_player.png"];
		player.position = ccp(winSize.width/4 + 40, winSize.height/2 + 20);
        [self addChild:player];
        
        
        CCLabelTTF *timeL = [CCLabelTTF labelWithString:@"Time : " fontName:@"Times New Roman" fontSize:22];
        timeL.position = ccp(winSize.width*3/4 + 10, winSize.height - 30);
        timeL.color = ccWHITE;
        [self addChild:timeL z:0 tag:2000];
        
        CCLabelTTF *label = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"Times New Roman" fontSize:22];
        label = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"Times New Roman" fontSize:22];
        self.timeLabel= label;
        self.timeLabel.color = ccWHITE;
        self.timeLabel.position = ccp(winSize.width - 40, winSize.height - 30);
        [self addChild:self.timeLabel z:2001];
        
        gold = 0;
        
        CCLabelTTF *goldL = [CCLabelTTF labelWithString:@"gold : " fontName:@"Times New Roman" fontSize:22];
        goldL.position = ccp(winSize.width*3/4 + 10, winSize.height - 60);
        goldL.color = ccWHITE;
        [self addChild:goldL z:0 tag:2000];
        
        goldLabel = [[CCLabelTTF alloc] initWithString:@" 0" fontName:@"Times New Roman" fontSize:22];
        goldLabel.position = ccp(winSize.width - 40, winSize.height - 60);
        [self addChild:goldLabel];
        
        //몬스터 수 초기화
        monstercount = 0;
        
        CCLabelTTF *monL = [CCLabelTTF labelWithString:@"monster : " fontName:@"Times New Roman" fontSize:22];
        monL.position = ccp(winSize.width*3/4 + 20, winSize.height - 90);
        monL.color = ccWHITE;
        [self addChild:monL z:0 tag:1000];
        
        monsterLabel = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"Times New Roman" fontSize:22];
        monsterLabel.position = ccp(winSize.width - 40, winSize.height - 90);
        [self addChild:monsterLabel];
        
        
		//공격속도 초기화
        atSpeed = 0; // 40pixels/1sec
        
        
		// 게임로직(에드타겟), 업데이트, 타임카운터 스케줄 실행
		[self schedule:@selector(gameLogic:) interval:1.0];
		[self schedule:@selector(update:)];
        [self schedule:@selector(timecounter) interval:0.1];
        
		// 각종 효과음
        gsound = [SimpleAudioEngine sharedEngine];
        [gsound preloadBackgroundMusic:@"sel_bgm.mp3"];
        [gsound playBackgroundMusic:@"sel_bgm.mp3" loop:YES];
        [gsound preloadEffect:@"electric_shot.mp3"];
        [gsound preloadEffect:@"die.mp3"];
	}
	return self;
}


-(void) Lotto{
    if (gold < 100) {
        return;
    }
    gold = gold - 100;
    int mingold = -200;
    int maxgold = 500;
    int randomgold = (arc4random() % maxgold) + mingold;
    gold = gold + randomgold;
    if (gold < 0){
        gold = 0;
    }
    goldstring = [[NSString alloc] initWithFormat:@" %d",gold];
    [goldLabel setString:goldstring];
}

-(void) AttackSpeedUp{
    if (gold < 100) {
        return;
    }
    gold = gold - 100;
    atSpeed = atSpeed + 50;
    goldstring = [[NSString alloc] initWithFormat:@" %d",gold];
    [goldLabel setString:goldstring];
}

-(void)goldplus{
    gold = gold + 10;
    goldstring = [[NSString alloc] initWithFormat:@" %d",gold];
    [goldLabel setString:goldstring];
}

-(void)monplus{
    monstercount = monstercount + 1;
    monstring = [[NSString alloc] initWithFormat:@"%d",monstercount];
    [monsterLabel setString:monstring];
    
    // 몬스터 수가 15마리 이상이면 게임 오버
    if (monstercount > 15) {
        [sceneManager goGameOver];
    }
}

-(void)monminus{
    monstercount = monstercount - 1;
    monstring = [[NSString alloc] initWithFormat:@"%d",monstercount];
    [monsterLabel setString:monstring];
}


-(void)timecounter{
    timecount += 0.1;
    NSString *timestring = [[NSString alloc] initWithFormat:@"%.01f", timecount];
    [self.timeLabel setString:timestring];
    
}

- (void)update:(ccTime)dt {
    
	NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
	for (CCSprite *projectile in _projectiles) {
		CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2),
										   projectile.position.y - (projectile.contentSize.height/2),
										   projectile.contentSize.width,
										   projectile.contentSize.height);
        
		NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
		for (CCSprite *target in _targets) {
			CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2),
										   target.position.y - (target.contentSize.height/2),
										   target.contentSize.width,
										   target.contentSize.height);
            
			if (CGRectIntersectsRect(projectileRect, targetRect)) {
				[targetsToDelete addObject:target];
                [self goldplus];
                [self monminus];
                [gsound playEffect:@"die.mp3"];
			}
		}
		
		for (CCSprite *target in targetsToDelete) {
			[_targets removeObject:target];
			[self removeChild:target cleanup:YES];
		}
		
		if (targetsToDelete.count > 0) {
			[projectilesToDelete addObject:projectile];
            
		}
		[targetsToDelete release];
	}
	
	for (CCSprite *projectile in projectilesToDelete) {
		[_projectiles removeObject:projectile];
		[self removeChild:projectile cleanup:YES];
	}
	[projectilesToDelete release];
}

- (void)pauseGame {
    NSLog(@"Paused!");
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    // Choose one of the touches to work with 터치 된 곳 정보
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];

    //터치시 액션
    CCAnimation *shotanion = [[CCAnimation alloc] init];
    [shotanion setDelayPerUnit:0.05];
	for (int i = 1; i < 6; i++) {
		[shotanion addSpriteFrameWithFilename:[NSString stringWithFormat:@"electric_shot_%02d.png",i]];
	}
	
	id playerShotAction = [CCAnimate actionWithAnimation:shotanion];
    
    id yScale = [CCScaleBy actionWithDuration:0.025 scaleX:1 scaleY:1.5];
    id reyScale = [yScale reverse];
    id allyScale = [CCSequence actions:yScale, reyScale, nil];
    
	[player runAction:playerShotAction];
    [player runAction:allyScale];

	// Set up initial location of projectile
	CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    
    //프로젝타일 액션
	CCSprite *projectile = [CCSprite spriteWithFile:@"electric_projectile_01.png"];
	projectile.position = ccp(160,180);
    CCAnimation *fprojanion = [[CCAnimation alloc] init];
    [fprojanion setDelayPerUnit:0.1];
	for (int i = 1; i < 5; i++) {
		[fprojanion addSpriteFrameWithFilename:[NSString stringWithFormat:@"electric_projectile_%02d.png",i]];
	}
	id projectileAction = [CCAnimate actionWithAnimation:fprojanion];
    id proforever = [CCRepeatForever actionWithAction:projectileAction];
    [projectile runAction:proforever];
    
    
    
	
	// Determine offset of location to projectile
    if (location.x >= 180 && location.x < 320) {
        int offX = location.x - projectile.position.x;
        int offY = location.y - projectile.position.y;
        
        // Bail out if we are shooting down or backwards
        if (offX <= 0) return;
        
        // Ok to add now - we've double checked position
        [self addChild:projectile];
        
        // Determine where we wish to shoot the projectile to
        int realX = ((winSize.width * 3) / 4) + (projectile.contentSize.width/2);
        float ratio = (float) offY / (float) offX;
        int realY = (realX * ratio) + projectile.position.y;
        CGPoint realDest = ccp(realX, realY);
        
        // Determine the length of how far we're shooting
        int offRealX = realX - projectile.position.x;
        int offRealY = realY - projectile.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 80/1 + atSpeed;  // 초당 40픽셀
        float realMoveDuration = length/velocity;
        
        // Calculate the angle
        float angleRadians = atan2(location.x - player.position.x , location.y - player.position.y);
        float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
        float cocosAngle =  angleDegrees;
        
        [projectile runAction:
         [CCSequence actions:
          [CCRotateTo actionWithDuration:0 angle:cocosAngle],
          [CCCallBlock actionWithBlock:^{
             // OK to add now - rotation is finished!
         }],
          nil]];
        
        [player runAction:
         [CCSequence actions:
          [CCRotateTo actionWithDuration:0.1 angle:cocosAngle],
          [CCCallBlock actionWithBlock:^{
             // OK to add now - rotation is finished!
         }],
          nil]];
        
        
        // Move projectile to actual endpoint
        [projectile runAction:[CCSequence actions:
                               [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                               [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
        
        // Add to projectiles array
        projectile.tag = 2;
        [_projectiles addObject:projectile];
        
        //electric shot sound
        [gsound playEffect:@"electric_shot.mp3"];
    }
    
    if (location.x <= 180) {
        
        int offX = projectile.position.x - location.x;
        int offY = location.y - projectile.position.y;
        
        // Bail out if we are shooting down or backwards
        if (offX <= 0) return;
        
        // Ok to add now - we've double checked position
        [self addChild:projectile];
        
        // Determine where we wish to shoot the projectile to
        int realX = ((winSize.width * 3) / 4) + (projectile.contentSize.width/2);
        float ratio = (float) offY / (float) offX;
        int realY = (realX * ratio) + projectile.position.y;
        CGPoint realDest = ccp(-realX, realY);
        
        // Determine the length of how far we're shooting
        int offRealX = projectile.position.x - realX;
        int offRealY = projectile.position.y - realY;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        
        //속도 조절
        float velocity = 80/1 + atSpeed; // 480pixels/1sec
        float realMoveDuration = length/velocity;
        
        // Move projectile to actual endpoint
        [projectile runAction:[CCSequence actions:
                               [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                               [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
        
        // Calculate the angle
        float angleRadians = atan2(location.x - player.position.x , location.y - player.position.y);
        float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
        float cocosAngle =  angleDegrees;
        
        [projectile runAction:
         [CCSequence actions:
          [CCRotateTo actionWithDuration:0 angle:cocosAngle],
          [CCCallBlock actionWithBlock:^{
             // OK to add now - rotation is finished!
         }],
          nil]];
        
        [player runAction:
         [CCSequence actions:
          [CCRotateTo actionWithDuration:0.1 angle:cocosAngle],
          [CCCallBlock actionWithBlock:^{
             // OK to add now - rotation is finished!
         }],
          nil]];
        
        // Add to projectiles array
        projectile.tag = 2;
        [_projectiles addObject:projectile];
        
        //electric shot sound
        [gsound playEffect:@"electric_shot.mp3"];
    }
}


- (void) dealloc
{
	[_targets release];
	_targets = nil;
	[_projectiles release];
	_projectiles = nil;
	[super dealloc];
}



@end