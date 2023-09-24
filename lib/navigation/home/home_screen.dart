import 'package:flutter/material.dart';
import 'package:boiler_plate_flutter/common/widgets/custom_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Text("asd"),
          ElevatedButton(
            child: const Text('Show Success SnackBar'),
            onPressed: () {
              CustomSnackBar.show(
                  context, SnackBarType.success, '회원가입에 성공하였습니다.');
            },
          ),
          ElevatedButton(
            child: const Text('Show Error SnackBar'),
            onPressed: () {
              CustomSnackBar.show(
                  context, SnackBarType.error, '회원가입에 실패하였습니다.');
            },
          ),
        ],
      )),
    );
  }
}
