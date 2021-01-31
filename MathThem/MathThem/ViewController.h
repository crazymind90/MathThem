//
//  ViewController.h
//  CounterGame
//
//  Created by CrazyMind90 on 30/01/2021.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    UIImageView *StartImage;
    UIButton *StartButton;
    UIImageView *YESImage;
    UIImageView *NOImage;
    UIButton *YESButton;
    UIButton *NOButton;
    NSInteger FirstNum;
    NSInteger SecondNum;
    NSUInteger Result;
    UILabel *Math;
    UILabel *AnswerResultLabel;
    UILabel *BestScoreLabel;
    NSString *AnswerResultText;
    NSString *BestScoreString;
    UILabel *CurrentScoreLabel;
    NSUInteger CurrentScore;
    NSString *CalculationResult;
    UISegmentedControl *SegamentControl;
    NSUInteger SelectedSega;
    BOOL DidAlloc_InitCurrentScoreLabel;
    BOOL DidAlloc;


}


@end

