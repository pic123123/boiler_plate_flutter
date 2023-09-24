import 'dart:async';

import 'package:boiler_plate_flutter/common/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:boiler_plate_flutter/authentication/repos/authentication_repo.dart';
import 'package:boiler_plate_flutter/authentication/view_models/users_view_model.dart';
import 'package:boiler_plate_flutter/common/utils/util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(userCredential);
    });
    if (state.hasError) {
      final error = state.error
          as FirebaseException; // Cast the error to a FirebaseException
      final message = error.code; // Get the error message
      if (message == 'INVALID_LOGIN_CREDENTIALS') {
        CustomSnackBar.show(
            context, SnackBarType.error, '회원가입 실패. 존재하지 않는 유저정보 입니다.');
      } else {
        CustomSnackBar.show(context, SnackBarType.error, '회원가입 실패. 에러코드: 9999');
      }

      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go("/tutorial");
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
