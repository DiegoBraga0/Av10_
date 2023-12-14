class User {
  final String userName;
  final String password;

  const User({
    required this.userName,
    required this.password,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{userName: $userName, password: $password}';
  }
} // main