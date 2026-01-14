#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// --- KHAI BÁO GIAO DIỆN HACKER --- //

@interface YenHackerView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *logView;
@property (nonatomic, strong) UIButton *btnAntiban;
@property (nonatomic, strong) NSTimer *typingTimer;
@property (nonatomic, strong) NSString *fullLogText;
@property (nonatomic, assign) NSInteger typingIndex;
@end

@implementation YenHackerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1. Style nền đen mờ ảo, viền xanh hacker
        self.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.9];
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 1.5;
        self.layer.cornerRadius = 8.0;
        self.layer.shadowColor = [UIColor greenColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 5.0;

        // 2. Tiêu đề "YÊN MOD IOS"
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, 20)];
        _titleLabel.text = @"[ YÊN MOD IOS ]";
        _titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:14];
        _titleLabel.textColor = [UIColor greenColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];

        // 3. Khu vực Log chạy chữ (Hiệu ứng Loading Lỏ)
        _logView = [[UITextView alloc] initWithFrame:CGRectMake(5, 30, frame.size.width - 10, 60)];
        _logView.backgroundColor = [UIColor clearColor];
        _logView.textColor = [UIColor cyanColor];
        _logView.font = [UIFont fontWithName:@"Courier" size:10];
        _logView.editable = NO;
        _logView.userInteractionEnabled = NO;
        [self addSubview:_logView];

        // 4. Nút Bật Antiban
        _btnAntiban = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnAntiban.frame = CGRectMake(10, 100, frame.size.width - 20, 30);
        [_btnAntiban setTitle:@"[ BẬT ANTIBAN ]" forState:UIControlStateNormal];
        [_btnAntiban setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _btnAntiban.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:12];
        _btnAntiban.layer.borderWidth = 1.0;
        _btnAntiban.layer.borderColor = [UIColor redColor].CGColor;
        _btnAntiban.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        [_btnAntiban addTarget:self action:@selector(handleAntiban) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnAntiban];

        // 5. Bắt đầu hiệu ứng chữ chạy
        [self startHackerEffect];
    }
    return self;
}

- (void)startHackerEffect {
    // Nội dung log cho ngầu
    _fullLogText = @"> Init UnityFramework...\n> Bypass Security...\n> Loading Yen Mod...\n> Ready to hack!";
    _typingIndex = 0;
    _logView.text = @"";
    
    // Timer gõ từng chữ
    _typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(typeCharacter) userInfo:nil repeats:YES];
}

- (void)typeCharacter {
    if (_typingIndex < _fullLogText.length) {
        NSString *charToAdd = [_fullLogText substringWithRange:NSMakeRange(_typingIndex, 1)];
        _logView.text = [_logView.text stringByAppendingString:charToAdd];
        _typingIndex++;
        
        // Tự động cuộn xuống dưới cùng
        [_logView scrollRangeToVisible:NSMakeRange(_logView.text.length, 0)];
    } else {
        [_typingTimer invalidate];
        _typingTimer = nil;
        
        // Hiệu ứng nhấp nháy cho text log xong
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
            self->_logView.alpha = 0.5;
        } completion:nil];
    }
}

- (void)handleAntiban {
    // Hiệu ứng khi bấm nút
    _btnAntiban.backgroundColor = [UIColor greenColor];
    [_btnAntiban setTitle:@"[ ANTIBAN ACTIVE ]" forState:UIControlStateNormal];
    [_btnAntiban setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnAntiban.layer.borderColor = [UIColor greenColor].CGColor;
    _btnAntiban.enabled = NO; // Chỉ bật 1 lần

    // Hiển thị Alert thông báo xịn xò
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"YÊN MOD IOS"
                                                                   message:@"Đã kích hoạt Antiban VIP!\nBypass SafetyNet: OK\nAnti-Report: OK"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Chiến Thôi" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    // Tìm Root View Controller để present alert
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:alert animated:YES completion:nil];
}

@end

// --- PHẦN HOOK VÀO GAME --- //

// Hook vào UnityAppController (Class chính quản lý app Unity trên iOS)
%hook UnityAppController

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    %orig; // Gọi hàm gốc để game load bình thường

    // Tạo delay nhỏ để đảm bảo Window đã load xong rồi mới hiện UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        if (!mainWindow) return;

        // Kích thước nhỏ xinh góc trái (x=10, y=50)
        YenHackerView *hackerView = [[YenHackerView alloc] initWithFrame:CGRectMake(10, 50, 160, 140)];
        
        // Thêm vào màn hình
        [mainWindow addSubview:hackerView];
        [mainWindow bringSubviewToFront:hackerView];
    });
}

%end
