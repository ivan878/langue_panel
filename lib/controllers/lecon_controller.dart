// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:panel_langues/commons/constances.dart';
import 'package:panel_langues/commons/fonctions.dart';
import 'package:panel_langues/models/lecon_model.dart';

class LeconController {
  ///
  ///Create Module
  ///

  Future<Map<String, dynamic>> createLecon(Lecon lecon) async {
    final dio = Dio();
    try {
      final form = await lecon.toAPI();
      return await dio
          .post('$base_url/lecons',
              data: form,
              options: Options(
                headers: {
                  ...authorization(),
                  'Content-Type': 'multipart/form-data',
                },
                contentType: Headers.multipartFormDataContentType,
                responseType: ResponseType.json,
                validateStatus: (_) => true,
              ))
          .then(
        (value) async {
          printer(value.statusCode);
          if (value.statusCode == 200) {
            final data = value.data;
            return {'statu': true, 'code': value.statusCode, 'result': data};
          } else {
            return {
              'statu': false,
              'code': value.statusCode,
              'message': value.data?['error'] ??
                  value.data?['message'] ??
                  "Impossible de joindre le serveur"
            };
          }
        },
      );
    } on DioException catch (error) {
      printer(error);
      return {
        'statu': false,
        'message': error.response?.data['error'] ??
            error.response?.data['message'] ??
            error.message ??
            'Erreur de connection au serveur'
      };
    } on HttpException catch (error) {
      printer(error);
      return {
        'statu': false,
        'message': error.message,
      };
    } on SocketException catch (error) {
      printer(error);
      return {
        'statu': false,
        'message': error.message,
      };
    } catch (error) {
      printer(error);
      return {
        'statu': false,
        'message': error.toString(),
      };
    }
  }

  /// Get One Module

  Future<Lecon?> getLecon(context, idLecon) async {
    final dio = Dio();
    printer(authorization());
    try {
      return await dio
          .get(
        '$base_url/lecons/show/$idLecon',
        options: Options(
          headers: authorization(),
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      )
          .then(
        (value) {
          if (value.statusCode == 200) {
            final data = value.data;
            final user = Lecon.fromMap(data['result']);
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

// Get all Modules

  Future<List<Lecon>?> getAllLecons(context, module_id) async {
    final dio = Dio();
    try {
      return await dio
          .get('$base_url/lecon/index',
              queryParameters: {'module_id': module_id},
              options: Options(
                headers: authorization(),
                responseType: ResponseType.json,
                validateStatus: (_) => true,
              ))
          .then(
        (value) {
          // printer(value.statusCode);
          if (value.statusCode == 200) {
            final data = value.data;
            final user_list = data['result'];
            printer(user_list);
            return (user_list as Iterable)
                .map((e) => Lecon.fromMap(e))
                .toList();
          } else {
            return null;
          }
        },
      );
    } on DioException catch (error) {
      // printer(error);
      toasterError(
          context,
          error.response?.data['error'] ??
              error.response?.data['message'] ??
              error.message ??
              'Erreur de connection au serveur');
      return null;
    } on WebSocketException catch (e) {
      printer(e);
      toasterError(context, e.message);
      return null;
    } on HttpException catch (e) {
      printer(e);
      toasterError(context, e.message);
      return null;
    } catch (e) {
      printer(e);
      toasterError(context, e.toString());
      return null;
    }
  }

  ///
  ///end
  ///
}
