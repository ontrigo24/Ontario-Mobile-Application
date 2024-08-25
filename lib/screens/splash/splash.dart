import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ontrigo/components/primary_btn.dart';
import 'package:ontrigo/screens/auth/auth_page.dart';
import 'package:ontrigo/utils/global_variables.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;
  late AutoCarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = AutoCarouselController(
      itemCount: 3,
      interval: const Duration(seconds: 3),
      onPageChanged: (int page) {
        setState(() {});
      },
    );

    checkAuth();
  }

  void checkAuth() {
    Timer(
      const Duration(seconds: 3),
      () {
        setState(() {
          loading = false;
          _carouselController.start();
        });
      },
    );
  }

  final List<Map<String, String>> carouselData = [
    {
      'img': 'assets/images/carousel_1.webp',
      'title': 'Budget-Friendly\nJourneys.',
      'desc': 'Save while you explore.'
    },
    {
      'img': 'assets/images/carousel_2.jpg',
      'title': 'Personalized\nTravel Plans.',
      'desc': 'Tailored to you.'
    },
    {
      'img': 'assets/images/carousel_3.webp',
      'title': 'Effortless\nTrip Planning.',
      'desc': 'Stress-free travel awaits.'
    },
  ];

  void handleNextBtn() {
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalVariables.colors.background,
      body: loading
          ? Center(
              child: Image.asset(
                'assets/icons/full_logo.png',
                fit: BoxFit.contain,
              ),
            )
          : Stack(
              children: [
                CarouselView(
                  pageController: _carouselController.pageController,
                  children: carouselData.map((data) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          data['img'] ?? 'assets/images/carousel_1.webp',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: size.height,
                          width: size.width,
                          color: const Color.fromARGB(54, 0, 0, 0),
                        ),
                        Positioned(
                          bottom: size.height * 0.2,
                          left: size.width * 0.08,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (data['title'] ?? 'Default Text')
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: GlobalVariables.colors.textAltPrimary,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['desc'] ?? 'Default Desc',
                                style: TextStyle(
                                  color: GlobalVariables.colors.textAltPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: size.height * 0.15,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        double progress = _carouselController.progressValue;
                        bool isActive =
                            _carouselController.currentPage == index;
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            height: 3,
                            child: LinearProgressIndicator(
                              value: isActive ? progress : 0.0,
                              backgroundColor:
                                  const Color.fromARGB(123, 224, 224, 224),
                              color: isActive
                                  ? GlobalVariables.colors.background
                                  : Colors.transparent,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: size.width,
                    child: PrimaryButton(
                      title: 'Next',
                      titleStyle:
                          TextStyle(color: GlobalVariables.colors.textPrimary),
                      showBorder: false,
                      fillColor: GlobalVariables.colors.background,
                      onPressed: handleNextBtn,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CarouselView extends StatelessWidget {
  final List<Widget> children;
  final PageController pageController;

  const CarouselView({
    required this.children,
    required this.pageController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: children,
      pageSnapping: true,
      physics: const BouncingScrollPhysics(),
    );
  }
}

class AutoCarouselController {
  final PageController pageController;
  final int itemCount;
  final Duration interval;
  late Timer _timer;
  int _currentPage = 0;
  double progressValue = 0.0;
  final Function(int)? onPageChanged;

  AutoCarouselController({
    required this.itemCount,
    this.interval = const Duration(seconds: 3),
    this.onPageChanged,
  }) : pageController = PageController(initialPage: 0) {
    pageController.addListener(_handlePageChange);
  }

  int get currentPage => _currentPage;

  void _handlePageChange() {
    int newPage = pageController.page?.round() ?? 0;
    if (newPage != _currentPage) {
      _currentPage = newPage;
      resetTimer();
      if (onPageChanged != null) {
        onPageChanged!(_currentPage);
      }
    }
  }

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      progressValue += 100 / interval.inMilliseconds;
      if (progressValue >= 1.0) {
        _currentPage++;
        if (_currentPage >= itemCount) {
          _currentPage = 0;
        }
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        progressValue = 0.0;
        if (onPageChanged != null) {
          onPageChanged!(_currentPage);
        }
      }
      progressValue = (progressValue < 1.0) ? progressValue : 1.0;
      if (onPageChanged != null) {
        onPageChanged!(_currentPage);
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    progressValue = 0.0;
    start();
  }

  void dispose() {
    _timer.cancel();
    pageController.removeListener(_handlePageChange);
    pageController.dispose();
  }
}
