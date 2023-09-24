import 'dart:async';

import 'package:boiler_plate_flutter/common/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:boiler_plate_flutter/authentication/repos/authentication_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );
    if (state.hasError) {
      final error = state.error
          as FirebaseException; // Cast the error to a FirebaseException
      final message = error.code; // Get the error message
      ///Firebase에서 사용자가 존재하지 않거나 비밀번호가 잘못된 경우 모두 이 에러를 발생시킨다.
      ///보안상의 이유로 악의적인 사용자가 오류 메시지를 통해 시스템 정보를 얻는 것을 방지하기 위함.
      if (message == 'INVALID_LOGIN_CREDENTIALS') {
        CustomSnackBar.show(context, SnackBarType.error,
            '로그인에 실패했습니다. 이메일 주소와 비밀번호를 확인하고 다시 시도해주세요.');
      } else {
        CustomSnackBar.show(context, SnackBarType.error, '로그인 실패. 에러코드: 9999');
      }
    } else {
      context.go("/home");
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
