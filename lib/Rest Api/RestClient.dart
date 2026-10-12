import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled7/Style/Style.dart';

Future<List> ProductGridViewListRequest() async {
  var URL = Uri.parse("https://dummyjson.com/products");
  var PostHeader = {"Content-Type": "application/json"};

  try {
    var response = await http.get(URL, headers: PostHeader);

    if (response.statusCode == 200) {
      var ResultBody = jsonDecode(response.body);

      ErrorToast("Data Loaded Successfully!");

      return ResultBody['products'];
    } else {
      ErrorToast("Try Again");
      return [];
    }
  } catch (e) {
    ErrorToast("Network Error: $e");
    return [];
  }
}

Future<bool> ProdductCreateRequest(Map<String, String> FormValues) async {
  var URL = Uri.parse("https://dummyjson.com/products/add");

  var PostBody = json.encode(FormValues);
  var PostHeader = {"Content-Type": "application/json"};

  var response = await http.post(URL, headers: PostHeader, body: PostBody);

  if (response.statusCode == 200 || response.statusCode == 201) {
    ErrorToast("Successfully Submitted");
    return true;
  } else {
    ErrorToast("Try Again");
    return false;
  }
}