import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:trip_prague/app/config/app_config.dart';
import 'package:trip_prague/app/utils/json_serializable_converter.dart';
import 'package:trip_prague/core/data/model/user.dto.dart';
import 'package:trip_prague/core/data/service/user_service.dart';
import 'package:trip_prague/features/auth/data/model/login_response.dto.dart';
import 'package:trip_prague/features/auth/data/service/auth_service.dart';
import 'package:trip_prague/features/home/data/model/post.dto.dart';
import 'package:trip_prague/features/home/data/service/post_service.dart';

class ChopperConfig {
  static Uri get baseUrl => Uri.parse(AppConfig.baseApiUrl);

  static List<ChopperService> get services => <ChopperService>[
        AuthService.create(),
        UserService.create(),
        PostService.create(),
      ];

  static JsonSerializableConverter get converter =>
      const JsonSerializableConverter(<Type,
          dynamic Function(Map<String, dynamic>)>{
        LoginResponseDTO: LoginResponseDTO.fromJson,
        UserDTO: UserDTO.fromJson,
        PostDTO: PostDTO.fromJson,
      });

  static List<dynamic> get interceptors => <dynamic>[
        (Request request) async {
          //TODO: uncomment if the API requires Authorization
          //final String? accessToken = await getIt<ILocalStorageRepository>().getAccessToken();

          final Map<String, String> headers = <String, String>{}
            ..addEntries(request.headers.entries)
            ..putIfAbsent('Accept', () => 'application/json')
            ..putIfAbsent('Content-type', () => 'application/json');
          //TODO: uncomment if the API requires Authorization
          //..putIfAbsent('Authorization', () => 'Bearer $accessToken');

          return request.copyWith(headers: headers);
        },
        if (kDebugMode) HttpLoggingInterceptor(),
        if (kDebugMode) CurlInterceptor(),
      ];

  static ChopperClient get client => ChopperClient(
        baseUrl: ChopperConfig.baseUrl,
        services: ChopperConfig.services,
        converter: ChopperConfig.converter,
        interceptors: ChopperConfig.interceptors,
        //TODO: remove once you have APIs with verified certificate
        client: !kIsWeb
            ? IOClient(
                HttpClient()
                  ..badCertificateCallback =
                      (X509Certificate cert, String host, int port) => true,
              )
            : null,
      );
}
