#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// --- KHAI BÁO GIAO DIỆN (Yên Mod View) ---

@interface YenCyberView : UIView
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblLog;
@property (nonatomic, strong) UIButton *btnAction;
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) NSTimer *typingTimer;
@property (nonatomic, assign) NSInteger typingIndex;
@property (nonatomic, strong) NSString *fullTitleText;
@end

@implementation YenCyberView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCyberUI];
    }
    return self;
}

- (void)setupCyberUI {
    // 1. Background style Hacker
    self.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.95]; // Đen mờ
    self.layer.borderColor = [UIColor greenColor].CGColor; // Viền xanh Neon
    self.layer.borderWidth = 1.5;
    self.layer.cornerRadius = 10;
    self.layer.shadowColor = [UIColor greenColor].CGColor;
    self.layer.shadowRadius = 8;
    self.layer.shadowOpacity = 0.8;
    self.clipsToBounds = NO;

    // 2. Title Label (Để chạy hiệu ứng gõ chữ)
    _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 25)];
    _lblTitle.textColor = [UIColor greenColor];
    _lblTitle.font = [UIFont fontWithName:@"Courier-Bold" size:14]; // Font kiểu code
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.text = @""; // Để trống để chạy effect
    [self addSubview:_lblTitle];

    // 3. Log Label (Hiện text Loading...)
    _lblLog = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, self.frame.size.width - 10, 40)];
    _lblLog.textColor = [UIColor cyanColor];
    _lblLog.font = [UIFont fontWithName:@"Courier" size:10];
    _lblLog.numberOfLines = 3;
    _lblLog.text = @"[SYSTEM] Ready...\n[STATUS] Safe\nWaiting for input...";
    [self addSubview:_lblLog];

    // 4. Progress Bar (Thanh Loading ảo)
    _progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    _progressBar.frame = CGRectMake(10, 80, self.frame.size.width - 20, 5);
    _progressBar.progressTintColor = [UIColor redColor];
    _progressBar.trackTintColor = [UIColor darkGrayColor];
    _progressBar.progress = 0.0;
    [self addSubview:_progressBar];

    // 5. Button "Bật Antiban"
    _btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAction.frame = CGRectMake(10, 95, self.frame.size.width - 20, 30);
    [_btnAction setTitle:@"KÍCH HOẠT ANTIBAN" forState:UIControlStateNormal];
    _btnAction.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:12];
    [_btnAction setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnAction.backgroundColor = [UIColor greenColor];
    _btnAction.layer.cornerRadius = 5;
    
    // Hiệu ứng bấm nút
    [_btnAction addTarget:self action:@selector(startHackingSequence) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnAction];

    // Bắt đầu chạy chữ "Yên MOD IOS"
    _fullTitleText = @"_Yên MOD IOS_";
    _typingIndex = 0;
    _typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(typeCharacter) userInfo:nil repeats:YES];
}

// Hàm chạy chữ từng ký tự
- (void)typeCharacter {
    if (_typingIndex < _fullTitleText.length) {
        NSString *subString = [_fullTitleText substringToIndex:_typingIndex + 1];
        _lblTitle.text = [subString stringByAppendingString:@"█"]; // Thêm con trỏ nhấp nháy
        _typingIndex++;
    } else {
        [_typingTimer invalidate];
        _lblTitle.text = _fullTitleText; // Xóa con trỏ khi xong
        
        // Hiệu ứng nhấp nháy border sau khi load xong tên
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (id)[UIColor greenColor].CGColor;
        animation.toValue = (id)[UIColor clearColor].CGColor;
        animation.autoreverses = YES;
        animation.duration = 0.5;
        animation.repeatCount = HUGE_VALF;
        [self.layer addAnimation:animation forKey:@"glowBorder"];
    }
}

// Hàm fake loading "Hacker lỏ"
- (void)startHackingSequence {
    _btnAction.enabled = NO;
    [_btnAction setTitle:@"ĐANG XÂM NHẬP..." forState:UIControlStateNormal];
    _btnAction.backgroundColor = [UIColor grayColor];
    
    // Tạo luồng background giả lập
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Bước 1: Kết nối server ảo
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblLog.text = @"> Connecting to Server...\n> Bypass Garena Security...";
            self.progressBar.progress = 0.2;
        });
        [NSThread sleepForTimeInterval:1.0];

        // Bước 2: Inject code ảo
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblLog.text = @"> Injecting Memory...\n> Address: 0xDEADBEEF\n> Anticheat: DISABLED";
            self.progressBar.progress = 0.6;
            self.progressBar.progressTintColor = [UIColor yellowColor];
        });
        [NSThread sleepForTimeInterval:1.5];

        // Bước 3: Hoàn tất
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblLog.text = @"> SUCCESS!\n> Antiban: ACTIVE\n> Safe Mode: ON";
            self.progressBar.progress = 1.0;
            self.progressBar.progressTintColor = [UIColor greenColor];
            
            [self.btnAction setTitle:@"ĐÃ BẬT ANTIBAN" forState:UIControlStateNormal];
            self.btnAction.backgroundColor = [UIColor cyanColor];
            
            // Rung nhẹ máy báo hiệu thành công
            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
            [generator impactOccurred];
        });
    });
}
@end


// --- HOOK VÀO GAME (UnityFramework hoặc Application) ---

// Hook vào UIWindow để hiện thị view đè lên tất cả
%hook UIWindow

- (void)makeKeyAndVisible {
    %orig;
    
    // Kiểm tra để tránh add view nhiều lần
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // Kích thước UI nhỏ xinh góc trái dưới
        CGFloat width = 180;
        CGFloat height = 140;
        // Màn hình ngang nên tính toán tọa độ
        CGRect screenRect = [UIScreen mainScreen].bounds;
        CGFloat screenHeight = screenRect.size.height;
        // Cách cạnh trái 20, cách đáy 20
        CGRect frame = CGRectMake(40, screenHeight - height - 20, width, height);

        YenCyberView *hackView = [[YenCyberView alloc] initWithFrame:frame];
        
        // Thêm vào window cao nhất để luôn nổi
        [self addSubview:hackView];
    });
}

%end
