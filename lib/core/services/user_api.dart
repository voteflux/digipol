import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

const PUBLIC_KEY = "pubkey";
const PARAMS = "params";
const METHOD = "method";
const BASE_URL = "";
const METHOD_SIGNUP = "signup";

// The service responsible for networking requests
class UserApi {
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
    body[PARAMS][PUBLIC_KEY] = ethereumAddress;
    var bodyText = jsonEncode(body);
    print(bodyText);

    http.Response response = await client.put(endpoint,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: bodyText);
    return response.body;
  }
}
