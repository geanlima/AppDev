import 'package:meta/meta.dart';

import '../http/http.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

  // Criando intancia dele mesmo apartir da class do dominio "AuthenticationParams"
  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
