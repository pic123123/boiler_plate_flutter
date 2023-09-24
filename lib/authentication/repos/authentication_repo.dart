import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase Authentication을 사용하여 사용자 인증을 처리하는
/// AuthenticationRepository 클래스와 이를 사용하는 두 개의 Riverpod Provider를 정의하고 있습니다.
class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///현재 사용자가 로그인되어 있는지 확인합니다.
  bool get isLoggedIn => user != null;

  ///현재 로그인된 Firebase User 객체를 반환합니다.
  User? get user => _firebaseAuth.currentUser;

  ///FirebaseAuth 인스턴스에서 auth state 변화 스트림을 반환합니다.
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  ///주어진 이메일과 비밀번호로 새로운 계정을 생성하고 자동으로 해당 계정으로 로그인합니다.
  Future<UserCredential> emailSignUp(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  ///현재 계정에서 로그아웃 합니다.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  ///주어진 이메일과 비밀번호로 이미 있는 계정으로 로그인 합니다.
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  ///Github 프로바이더로 signIn 메소드 호출하여 GitHub 계정으로 앱에로그인 합니다.
  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }
}

///AuthenticationRepository의 인스턴스를 제공합니다. 다른 곳에서 context.read(authRepo)
///또는 ref.read(authRepo)를 호출하면 AuthenticationRepository에 접근할 수 있습니다.
final authRepo = Provider(
  (ref) => AuthenticationRepository(),
);

/// StreamProvider는 Firebase Authentication의 authStateChanges 스트림을 제공합니다.
/// authStateChanges 스트림은 사용자의 로그인 상태가 변경될 때마다 업데이트되므로,
/// Provider를 통해 앱 전체에서 현재 사용자의 로그인 상태를 실시간으로 관찰할 수 있습니다.
final authState = StreamProvider(
  (ref) {
    final repo = ref.read(authRepo);
    return repo.authStateChanges();
  },
);
