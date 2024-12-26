import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:study_over_flow/core/class/request_state.dart';

import '../utils/helper_functions/internet_connect.dart';

import 'dart:convert';

class Curd {
  // Shared logic for handling HTTP responses
  Either<RequestState, Map<String, dynamic>> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201 ) {
      try {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } catch (e) {
        return const Left(RequestState.error); 
      }
    }else if(response.statusCode == 401){
      if(response.body == "Invalid Usern Name or Password !"){
        return const Left(RequestState.emailAlreadyExist);
      }else if(response.body == "Please confirm your email !"){
        return const Left(RequestState.userNotConfirm);
      }
      else {
        return const Left(RequestState.unauthorised);
      }
    } else {
      return const Left(RequestState.serverFailure);
    }
  }

  // POST method
  Future<Either<RequestState, Map<String, dynamic>>> post(
      String url, Map<String, dynamic> data) async {
    try {
      if (await interConnect()) {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
        return _handleResponse(response);
      } else {
        return const Left(RequestState.internetFailure);
      }
    } catch (e) {
      return const Left(RequestState.error);
    }
  }

  // GET method
  Future<Either<RequestState, Map<String, dynamic>>> get(String url,[String? token]) async {
    try {
      if (await interConnect()) {
        final response = await http.get(
          Uri.parse(url),
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        );
        return _handleResponse(response); 
      } else {
        return const Left(RequestState.internetFailure);
      }
    } catch (e) {
      print("GET Error: $e");
      return const Left(RequestState.error);
    }
  }
}

