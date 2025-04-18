class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  String? userId;

  void setUser({required String id}) {
    userId = id;
  }

  void clear() {
    userId = null;
  }

  bool get isLoggedIn => userId != null;
}
