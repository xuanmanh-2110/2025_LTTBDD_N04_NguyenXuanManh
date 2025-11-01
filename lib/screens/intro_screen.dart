import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() =>
      _IntroScreenState();
}

class _IntroScreenState
    extends State<IntroScreen> {
  final PageController _pageController =
      PageController();
  int _currentPage = 0;

  final List<IntroPage> _pages = [
    IntroPage(
      title: 'Track Your Calories',
      titleVi: 'Theo Dõi Calo',
      description:
          'Monitor your daily calorie intake and stay healthy',
      descriptionVi:
          'Theo dõi lượng calo hàng ngày và giữ sức khỏe',
      icon: Icons.restaurant_menu,
      color: Color(0xFF4CAF50),
    ),
    IntroPage(
      title: 'Stay Hydrated',
      titleVi: 'Uống Đủ Nước',
      description:
          'Track your water intake throughout the day',
      descriptionVi:
          'Theo dõi lượng nước uống trong ngày',
      icon: Icons.water_drop,
      color: Color(0xFF2196F3),
    ),
    IntroPage(
      title: 'Achieve Your Goals',
      titleVi: 'Đạt Mục Tiêu',
      description:
          'Set and reach your health and fitness goals',
      descriptionVi:
          'Đặt và đạt được mục tiêu sức khỏe của bạn',
      icon: Icons.emoji_events,
      color: Color(0xFFFF9800),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  Phát hiện ngôn ngữ hiện tại
    final isVietnamese =
        Localizations.localeOf(
          context,
        ).languageCode ==
        'vi';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //  Nút Skip ở góc trên phải
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  isVietnamese
                      ? 'Bỏ qua'
                      : 'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),

            //  PageView với 3 trang
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(
                      40.0,
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        //  Icon tròn với màu nền
                        Container(
                          width: 150,
                          height: 150,
                          decoration:
                              BoxDecoration(
                                color: page.color
                                    .withValues(
                                      alpha: 0.1,
                                    ),
                                shape: BoxShape
                                    .circle,
                              ),
                          child: Icon(
                            page.icon,
                            size: 80,
                            color: page.color,
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),

                        //  Tiêu đề
                        Text(
                          isVietnamese
                              ? page.titleVi
                              : page.title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Colors.grey[800],
                          ),
                          textAlign:
                              TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        //  Mô tả
                        Text(
                          isVietnamese
                              ? page.descriptionVi
                              : page.description,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Colors.grey[600],
                            height: 1.5,
                          ),
                          textAlign:
                              TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            //  Chấm tròn chỉ số trang (Page indicator)
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin:
                      const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                  width: _currentPage == index
                      ? 24
                      : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            //  Nút Next/Get Started
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed:
                      _currentPage ==
                          _pages.length - 1
                      ? _finish
                      : _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF4CAF50,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                            27,
                          ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage ==
                            _pages.length - 1
                        ? (isVietnamese
                              ? 'Bắt Đầu'
                              : 'Get Started')
                        : (isVietnamese
                              ? 'Tiếp Theo'
                              : 'Next'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  //  Chuyển sang trang tiếp theo
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  //  Bỏ qua và nhảy đến trang cuối
  void _skip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  //  Hoàn thành intro và chuyển sang màn hình login
  void _finish() {
    Navigator.of(
      context,
    ).pushReplacementNamed('/login');
  }
}

//  Class để lưu thông tin của mỗi trang intro
class IntroPage {
  final String title;
  final String titleVi;
  final String description;
  final String descriptionVi;
  final IconData icon;
  final Color color;

  IntroPage({
    required this.title,
    required this.titleVi,
    required this.description,
    required this.descriptionVi,
    required this.icon,
    required this.color,
  });
}
