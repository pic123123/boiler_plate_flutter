import 'package:flutter/material.dart';
import 'package:boiler_plate_flutter/common/constants/sizes.dart';
import 'package:boiler_plate_flutter/common/utils/util.dart';
import 'package:boiler_plate_flutter/navigation/home/home_screen.dart';
import 'package:boiler_plate_flutter/navigation/nav_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends StatefulWidget {
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  ///시작 페이지
  late int _selectedIndex = 0;

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  ///post_video_button widgets -> gogo
  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Record video')),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  // void _onMovePostScreen(BuildContext context) async {
  //   ///밑에서부터 올라오는 모달창 (모달밖은 저절로 회색으로 흐려짐)
  //   await showModalBottomSheet(
  //     context: context,

  //     /// bottom sheet의 사이즈를 바꿀 수 있게 해줌, (listView를 사용할거면 true)
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => const PostScreen(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      /// 키보드가 나타날때 기본적으로 Scaffold가 body를 조절해서 키보드가 화면을 가리지 않도로 한다.
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,

      ///같은 로직의 네비게이션을 사용하게 될 경우, 사용자가 다른 화면으로 갈 때마다
      ///index를 바꾸게 되고 이전화면은 완전히 없어진다.
      ///Home -> Profile -> Home 돌아오면 이전에 보던 영상이 없어짐
      ///Offstage : widget이 안보이게 하면서 계속 존재하게 해주는 widget
      ///Stack : 여러 widget들으 하나씩 쌓을때 사용하는 widget
      body: Stack(
        children: [
          Offstage(
            ///child의 화면을 보여줄지 말지 정할 수 있음(기본적으로 감추고있음 false)
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const HomeScreen(),
          )
        ],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
          border: const Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + Sizes.size12),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              // Gaps.h24,
              // GestureDetector(
              //   onTap: _onPostVideoButtonTap,
              //   child: PostVideoButton(inverted: _selectedIndex != 0),
              // ),
              // Gaps.h24,
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
