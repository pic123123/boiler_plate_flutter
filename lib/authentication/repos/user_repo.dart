import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:boiler_plate_flutter/authentication/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///사용자 프로필 정보를 관리하는 기능을 제공합니다.
class UserRepository {
  ///Firestore 데이터베이스에 접근하기 위한 인스턴스입니다.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Firebase Storage에 접근하기 위한 인스턴스입니다.
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///Firestore 데이터베이스 내 "users" 컬렉션에 새로운 문서를 생성하거나 이미 있는 문서를 업데이트합니다.
  ///문서 ID는 UserProfileModel에서 제공하는 uid 값을 사용하며,
  /// 저장할 내용은 UserProfileModel의 toJson 메소드로 변환된 JSON 형식의 데이터입니다.
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  ///주어진 uid 값으로 "users" 컬렉션에서 특정 문서를 찾아 해당 문서의 데이터를 Map 형태로 반환합니다.
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  ///Firebase Storage 내 "avatars" 경로에 파일을 업로드합니다. 업로드할 파일과 그 파일명을 입력받습니다.
  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(file);
  }

  ///주어진 uid 값으로 "users" 컬렉션에서 특정 문서를 찾아 해당 문서의 일부 또는 전체 데이터를 업데이트합니다.
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }
}

///userRepo라는 Provider가 UserRepository 인스턴스를 제공함으로써 앱 어디에서든 UserRepository의 기능들을 사용할 수 있게 합니다.
final userRepo = Provider(
  (ref) => UserRepository(),
);
