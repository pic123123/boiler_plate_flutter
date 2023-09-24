import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:boiler_plate_flutter/authentication/models/user_profile_model.dart';
import 'package:boiler_plate_flutter/authentication/repos/authentication_repo.dart';
import 'package:boiler_plate_flutter/authentication/repos/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  ///초기 UserProfileModel 인스턴스를 구성합니다.
  ///이미 로그인한 상태라면 Firestore에서 해당 사용자의 프로필 정보를 가져옵니다.
  ///아니라면, 빈 UserProfileModel 인스턴스를 반환합니다.
  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  ///새로운 UserProfileModel 인스턴스를 생성하고 Firestore에 저장합니다.
  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anon@anon.com",
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? "Anon",
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  ///아바타 이미지가 업로드되었다는 사실을 반영하여 UserProfileModel 인스턴수 및 Firestore 문서를 업데이트 합니다.
  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

///usersProvider라는 AsyncNotifierProvider가 UsersViewModel 인스턴스를 제공함으로써 앱 어디에서든 UsersViewModel의 기능들을 사용할 수 있게 합니다.
final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
