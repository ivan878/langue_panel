// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:panel_langues/commons/constances.dart';
import 'package:panel_langues/models/langues.dart';
import 'package:panel_langues/models/module.dart';

import '../commons/fonctions.dart';

class ModuleController {
  ///
  ///Create Module
  ///

  Future<Map<String, dynamic>> createModule(Module module) async {
    final dio = Dio();
    try {
      return await dio
          .post(
        '$base_url/module',
        queryParameters: module.toAPI(),
        options: Options(
          headers: authorization(),
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      )
          .then(
        (value) {
          printer(value.data);
          printer(module.toAPI());
          if (value.statusCode == 200) {
            final data = value.data;
            return {'statu': true, 'code': value.statusCode, 'result': data};
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

  Future<Module?> getModule(context, idModule) async {
    final dio = Dio();
    printer(authorization());
    try {
      return await dio
          .get(
        '$base_url/module/show/$idModule',
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
            final user = Module.fromMap(data['result']);
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

  Future<List<Module>?> getAllModules(context, Langue langue) async {
    final dio = Dio();
    try {
      return await dio
          .get('$base_url/module/index',
              queryParameters: {'langue_id': langue.langue_id},
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
            // printer(user_list);
            return (user_list as Iterable)
                .map((e) => Module.fromMap(e))
                .toList();
          } else {
            return null;
          }
        },
      );
    } on DioException catch (error) {
      printer(error.response?.data['error'] ??
          error.response?.data['message'] ??
          error.message ??
          'Erreur de connection au serveur');
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
