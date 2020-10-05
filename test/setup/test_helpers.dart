import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/services/user_api.dart';
import 'package:voting_app/locator.dart';

// see for intro: https://www.filledstacks.com/post/how-to-mock-for-unit-testing/

Logger log = Logger();

class UserApiMock extends Mock implements UserApi {
  var client = new http.Client();
  var endpoint = 'https://api.blockchain.suzuka.flux.party/members/api';

  Future<dynamic> signup(String ethereumAddress) async {
    var body = Map<String, dynamic>();

    /*{
      method: "signup",
      data: {
        pubkey: string
      }
    }*/
    body[METHOD] = METHOD_SIGNUP;
    body[PARAMS] = Map<String, dynamic>();
    body[PARAMS][ETHEREUM_ADDRESS] = ethereumAddress;
    body[PARAMS]['unsafeChecksum'] = true;
    var bodyText = jsonEncode(body);
    //print(bodyText);

    http.Response response = await client.post(endpoint,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: bodyText);
    return response.body;
  }
}

class NavigationServiceMock extends Mock implements NavigationService {}

class AuthenticationServiceMock extends Mock implements AuthenticationService {}

class ApiMock extends Mock implements Api {}

void registerServices() {
  getAndRegisterNavigationSvcMock();
  getAndRegisterAuthenticationServiceMock();
  getAndRegisterUserApiMock();
  getAndRegisterApiMock();
}

void unregisterServices() {
  locator.unregister<NavigationService>();
  locator.unregister<AuthenticationService>();
  locator.unregister<UserApi>();
  locator.unregister<Api>();
}

NavigationService getAndRegisterNavigationSvcMock() {
  _removeRegistrationIfExists<NavigationService>();
  var svc = NavigationServiceMock();
  locator.registerSingleton<NavigationService>(svc);
  return svc;
}

UserApi getAndRegisterUserApiMock() {
  _removeRegistrationIfExists<UserApi>();
  var svc = UserApiMock();
  locator.registerSingleton<UserApi>(svc);
  return svc;
}

AuthenticationService getAndRegisterAuthenticationServiceMock() {
  _removeRegistrationIfExists<AuthenticationService>();
  var svc = AuthenticationServiceMock();
  locator.registerSingleton<AuthenticationService>(svc);
  return svc;
}

Api getAndRegisterApiMock() {
  _removeRegistrationIfExists<Api>();
  var svc = ApiMock();
  locator.registerSingleton<Api>(svc);
  return svc;
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
