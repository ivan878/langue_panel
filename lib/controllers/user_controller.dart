// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_catch_error

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:panel_langues/commons/constances.dart';
import 'package:panel_langues/commons/fonctions.dart';
import 'package:panel_langues/models/app_user.dart';

import '../providers/user_provider.dart';

class UserController {
  // Register user
  Future<Map<String, dynamic>> registerUser(
    UserApp userApp,
  ) async {
    final dio = Dio();
    try {
      return await dio
          .post('$base_url/user/register', data: userApp.toMap())
          .then(
        (value) async {
          printer(value.statusCode);
          if (value.statusCode == 200) {
            final data = value.data;
            final token = data['result']['token'];
            final user_provider = UserProvider.user;
            user_provider.setToken(token);
            await user_provider.saveToken(token);
            return {'statu': true, 'code': value.statusCode, 'token': token};
          } else {
            return {
              'statu': false,
              'code': value.statusCode,
              'message':
                  value.data?['message'] ?? "Impossible de joindre le serveur"
            };
          }
        },
      );
    } on DioException catch (error) {
      return {
        'statu': false,
        'message': error.response?.data['error'] ??
            error.response?.data['message'] ??
            error.message ??
            'Erreur de connection au serveur'
      };
    } on HttpException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    } on SocketException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    } catch (error) {
      return {
        'statu': false,
        'message': error.toString(),
      };
    }
  }

  // Login user

  Future<Map<String, dynamic>> loginUser(
      String user_email, String user_password) async {
    final dio = Dio();
    final data = {
      'email': user_email,
      'password': user_password,
    };
    try {
      return await dio.post('$base_url/user/login', data: data).then(
        (value) async {
          // printer(value.statusCode);
          if (value.statusCode == 200) {
            final datat = value.data;
            final token = datat['result']['token'];
            final user_provider = UserProvider.user;
            user_provider.setToken(token);
            await user_provider.saveToken(token);
            return {'statu': true, 'code': value.statusCode, 'token': token};
          } else {
            return {
              'statu': false,
              'code': value.statusCode,
              'message': value.data?['error'] ??
                  value.data?['message'] ??
                  'Impossible de se connecter au serveur'
            };
          }
        },
      );
    } on DioException catch (error) {
      return {
        'statu': false,
        'message': error.response?.data['error'] ??
            error.response?.data['message'] ??
            error.message ??
            'Erreur de connection au serveur'
      };
    } on HttpException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    } on SocketException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    } catch (error) {
      return {
        'statu': false,
        'message': error.toString(),
      };
    }
  }

  // Get User

  Future<UserApp?> getUser(context) async {
    final dio = Dio();
    final user_provider = UserProvider.user;
    await user_provider.getToken();
    printer(authorization());
    try {
      return await dio
          .get(
        '$base_url/user/show',
        options: Options(
          headers: authorization(),
        ),
      )
          .then(
        (value) {
          if (value.statusCode == 200) {
            final data = value.data;
            final user = UserApp.fromMap(data['result']);
            printer(user.toMap());
            return user;
          } else {
            return null;
          }
        },
      );
    } on DioException catch (error) {
      toasterError(
          context,
          error.response?.data['error'] ??
              error.response?.data['message'] ??
              error.message ??
              'Erreur de connection au serveur');
      return null;
    } on WebSocketException catch (e) {
      toasterError(context, e.message);
      return null;
    } on HttpException catch (e) {
      toasterError(context, e.message);
      return null;
    } catch (e) {
      toasterError(context, e.toString());
      return null;
    }
  }

// GetAllUser

  Future<List<UserApp>?> getAllUser(context) async {
    final dio = Dio();
    try {
      return await dio
          .get(
        '$base_url/user/all',
      )
          .then(
        (value) {
          if (value.statusCode == 200) {
            final data = value.data;
            final user_list = data['result'];
            return (user_list as Iterable)
                .map((e) => UserApp.fromMap(e))
                .toList();
          } else {
            return null;
          }
        },
      );
    } on DioException catch (error) {
      toasterError(
          context,
          error.response?.data['error'] ??
              error.response?.data['message'] ??
              error.message ??
              'Erreur de connection au serveur');
      return null;
    } on WebSocketException catch (e) {
      toasterError(context, e.message);
      return null;
    } on HttpException catch (e) {
      toasterError(context, e.message);
      return null;
    } catch (e) {
      toasterError(context, e.toString());
      return null;
    }
  }

  //Get All professor

  Future<List<UserApp>?> getAllProfessor(context) async {
    final dio = Dio();
    try {
      return await dio
          .get(
        '$base_url/admin/professeur/all',
        options: Options(
          headers: authorization(),
        ),
      )
          .then(
        (value) {
          if (value.statusCode == 200) {
            final data = value.data;
            final user_list = data['result'];
            return (user_list as Iterable)
                .map((e) => UserApp.fromMap(e))
                .toList();
          } else {
            return null;
          }
        },
      );
    } on DioException catch (error) {
      toasterError(
          context,
          error.response?.data['error'] ??
              error.response?.data['message'] ??
              error.message ??
              'Erreur de connection au serveur');
      return null;
    } on WebSocketException catch (e) {
      toasterError(context, e.message);
      return null;
    } on HttpException catch (e) {
      toasterError(context, e.message);
      return null;
    } catch (e) {
      toasterError(context, e.toString());
      return null;
    }
  }

  // end
}
