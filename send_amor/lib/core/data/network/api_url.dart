class ApiUrl {
  String get baseURL =>
      'http://ec2-52-201-227-228.compute-1.amazonaws.com:8080/api';

  //String get baseURL => 'http://localhost:8080/api';
  String get authService => '$baseURL/users';
  String get connectService => '$baseURL/connections';
  //Authentication
  String get loginURL => '$authService/login';
  String get registerURL => '$authService/register';


  String get setUserNameURL => '$authService/update-username';
  String get fetchUserDetailsURL => '$authService/fetchUserDetails';

// search
  String get searchURL => '$authService/search';
  String get sendConnectionURL => '$connectService/send';
  String get pendingConnectionURL => '$connectService/pending';
  String get acceptedConnectionURL => '$connectService/accepted';
  String get receivedConnectionURL => '$connectService/received/pending';
  String get updateConnectionStatusURL => '$connectService/status';
}
