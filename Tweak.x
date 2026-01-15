#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// --- Khai báo giao diện Hacker View ---
@interface YenHackerView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *consoleLabel;
@property (nonatomic, strong) UIView *loadingBar;
@property (nonatomic, strong) UIView *loadingFill;
@property (nonatomic, strong) UIButton *activateBtn;
@end

@implementation YenHackerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1. Setup nền đen mờ ảo + Viền Neon
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 1.5;
        self.layer.borderColor = [UIColor greenColor].CGColor; // Màu xanh Hacker
        self.layer.shadowColor = [UIColor greenColor].CGColor;
        self.layer.shadowRadius = 8;
        self.layer.shadowOpacity = 0.8;
        self.clipsToBounds = YES;

        // 2. Tiêu đề "Yên MOD IOS"
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, 20)];
        _titleLabel.text = @"[ YÊN MOD IOS ]";
        _titleLabel.textColor = [UIColor cyanColor];
        _titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];

        // 3. Console hiển thị text chạy
        _consoleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, frame.size.width - 20, 40)];
        _consoleLabel.textColor = [UIColor greenColor];
        _consoleLabel.font = [UIFont fontWithName:@"Courier-New" size:11];
        _consoleLabel.numberOfLines = 2;
        _consoleLabel.text = @"";
        [self addSubview:_consoleLabel];

        // 4. Thanh Loading Bar
        _loadingBar = [[UIView alloc] initWithFrame:CGRectMake(10, 80, frame.size.width - 20, 6)];
        _loadingBar.backgroundColor = [UIColor darkGrayColor];
        _loadingBar.layer.cornerRadius = 3;
        [self addSubview:_loadingBar];

        _loadingFill = [[UIView alloc] initWithFrame:CGRectMake(10, 80, 0, 6)]; // Bắt đầu từ 0
        _loadingFill.backgroundColor = [UIColor greenColor];
        _loadingFill.layer.cornerRadius = 3;
        [self addSubview:_loadingFill];

        // 5. Nút Bật Antiban (Ban đầu ẩn đi)
        _activateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _activateBtn.frame = CGRectMake(10, 80, frame.size.width - 20, 30); // Đè lên chỗ loading sau khi xong
        [_activateBtn setTitle:@"[ BẬT ANTIBAN ]" forState:UIControlStateNormal];
        [_activateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _activateBtn.backgroundColor = [UIColor greenColor];
        _activateBtn.layer.cornerRadius = 5;
        _activateBtn.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:13];
        _activateBtn.hidden = YES; // Ẩn nút đi chờ loading
        [_activateBtn addTarget:self action:@selector(handleButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_activateBtn];

        // Bắt đầu hiệu ứng
        [self startHackingEffect];
    }
    return self;
}

// --- Hiệu ứng đánh máy (Typewriter Effect) ---
- (void)typeText:(NSString *)text toLabel:(UILabel *)label atIndex:(NSInteger)index {
    if (index < text.length) {
        NSString *charStr = [text substringWithRange:NSMakeRange(index, 1)];
        label.text = [label.text stringByAppendingString:charStr];
        
        // Tốc độ gõ phím ngẫu nhiên cho giống người thật
        double delayInSeconds = 0.05 + (arc4random_uniform(5) / 100.0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self typeText:text toLabel:label atIndex:index + 1];
        });
    }
}

// --- Logic Loading 5 giây ---
- (void)startHackingEffect {
    // 1. Chạy chữ ngầu lòi
    NSString *logText = @"Connecting to Server...\nBypassing Security...";
    [self typeText:logText toLabel:_consoleLabel atIndex:0];

    // 2. Chạy thanh Loading trong 5s
    [UIView animateWithDuration:5.0 animations:^{
        CGRect frame = self.loadingFill.frame;
        frame.size.width = self.frame.size.width - 20;
        self.loadingFill.frame = frame;
    } completion:^(BOOL finished) {
        // Sau khi load xong 5s
        [self loadingFinished];
    }];
}

- (void)loadingFinished {
    // Rung nhẹ haptic báo hiệu xong (nếu thích)
    UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
    [generator notificationOccurred:UINotificationFeedbackTypeSuccess];

    // Cập nhật giao diện: Ẩn loading, hiện nút
    _consoleLabel.text = @"SYSTEM: READY\nSTATUS: UNDETECTED";
    _loadingBar.hidden = YES;
    _loadingFill.hidden = YES;
    _activateBtn.hidden = NO;
    
    // Hiệu ứng nút nhấp nháy
    _activateBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.activateBtn.alpha = 1;
    }];
}

- (void)handleButtonPress {
    // Hiệu ứng khi bấm nút
    [_activateBtn setTitle:@"ACTIVATED!" forState:UIControlStateNormal];
    _activateBtn.backgroundColor = [UIColor cyanColor];
    
    // Delay 0.5s cho người dùng nhìn thấy chữ Activated rồi mới biến mất
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0; // Fade out
            self.transform = CGAffineTransformMakeScale(0.1, 0.1); // Thu nhỏ lại
        } completion:^(BOOL finished) {
            [self removeFromSuperview]; // Xoá khỏi màn hình
            
            // TODO: Chèn code Antiban thật của bạn vào đây
            NSLog(@"[Yên MOD] Antiban Enabled!"); 
        }];
    });
}

@end

// --- Phần Hook vào Game ---

// Tạo cửa sổ tĩnh để giữ View
static UIWindow *alertWindow = nil;

void showCyberAlert() {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Tạo Window mới nằm trên cùng
        alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.backgroundColor = [UIColor clearColor];
        alertWindow.rootViewController = [UIViewController new]; // Dummy VC
        alertWindow.hidden = NO;
        alertWindow.userInteractionEnabled = YES; // Để bấm được nút xuyên qua chỗ trống

        // Tính toán vị trí góc trái dưới (Cách lề trái 20, cách đáy 100)
        CGFloat width = 220;
        CGFloat height = 120;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        YenHackerView *hackerView = [[YenHackerView alloc] initWithFrame:CGRectMake(20, screenHeight - height - 80, width, height)];
        
        // Pass touches through window areas that aren't the hacker view
        // (Đây là trick để chỉ chặn cảm ứng ở cái khung hack, còn lại vẫn bấm game được nếu muốn)
        // Nhưng ở đây ta để đơn giản là hiện đè lên.
        
        [alertWindow addSubview:hackerView];
    });
}

// Hook vào lúc App khởi chạy xong
%ctor {
    // Lắng nghe sự kiện app khởi động xong để hiện UI
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        // Delay 2 giây để game load logo xong mới hiện UI cho ngầu
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            showCyberAlert();
        });
    }];
}
