import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boiler_plate_flutter/common/constants/sizes.dart';
import 'package:boiler_plate_flutter/common/utils/util.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final controller = PageController();

  ///Tutorial 완료시 Home 화면으로 이동
  void _onEnterAppTap() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          bool isLastPage = controller.hasClients &&
              controller.page != null &&
              controller.page! >= 2.0;
          return Container(
            color: isDarkMode(context) ? Colors.black : Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
                left: Sizes.size24,
                right: Sizes.size24,
              ),
              child: AnimatedOpacity(
                opacity: isLastPage ? 1.0 : 0.0,
                duration: const Duration(microseconds: 300),
                child: CupertinoButton(
                  onPressed: isLastPage ? _onEnterAppTap : null,
                  color: Theme.of(context).primaryColor,
                  child: const Text('Enter the app!'),
                ),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                children: const <Widget>[
                  // 첫 번째 페이지 내용...
                  Center(
                    child: Text(
                      "First Page",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  // 두 번째 페이지 내용...
                  Center(
                    child: Text(
                      "Second Page",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  // 세 번째 페이지 내용...
                  Center(
                    child: Text(
                      "Third Page",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
