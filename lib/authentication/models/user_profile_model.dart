class UserProfileModel {
  ///사용자의 고유 ID
  final String uid;

  ///사용자의 이메일 주소
  final String email;

  ///사용자의 이름
  final String name;

  ///사용자의 자기 소개 또는 설명
  final String bio;

  ///사용자가 제공하는 웹사이트 링크 또는 소셜 링크 등
  final String link;

  ///아바타 이미지가 있는지 여부
  final bool hasAvatar;

  ///객체를 생성할 때 필요한 모든 필드를 입력받아 새로운 인스턴스를 생성합니다.
  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.hasAvatar,
  });

  ///모든 필드가 비어있는 새로운 인스턴스를 생성합니다. 주로 초기 상태 설정이나 오류 상황에서 활용됩니다.
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        hasAvatar = false;

  ///JSON 형식으로 저장된 데이터에서 UserProfileModel 인스턴스를 생성합니다.
  ///Firebase와 같은 클라우드 서비스에서 데이터를 가져올 때 유용하게 활용됩니다.
  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        name = json["name"],
        bio = json["bio"],
        hasAvatar = json["hasAvatar"] ?? false,
        link = json["link"];

  ///UserProfileModel 인스턴스 내용을 JSON 형식으로 변환하여 반환합니다.
  /// 이 메서드로 변환된 결과값은 서버에 데이터를 저장할 때 활용됩니다.
  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
    };
  }

  ///기존 UserProfileModel 인스턴수에 대해 일부만 변경한 새로운 복사본을 만듭니다.
  ///예: 기존 프로필 정보에서 이름만 바꾸고 싶을 때,
  ///copyWith(name: 'new name') 처럼 활용할 수 있습니다.
  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
