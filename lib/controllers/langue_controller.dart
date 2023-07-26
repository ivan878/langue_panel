// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:panel_langues/commons/constances.dart';
import 'package:panel_langues/commons/fonctions.dart';
import 'package:panel_langues/models/langues.dart';

class LangueController {
  final base = '$base_url/langue';
  Future<bool> createLangue(context, Langue langue) async {
    final dio = Dio();
    try {
      return await dio
          .post(
        '$base/create',
        options: Options(
          headers: authorization(),
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
        queryParameters: langue.toAPI(),
      )
          .then(
        // printer(authorization());
        (value) {
          printer(authorization());
          if (value.statusCode == 200) {
            return true;
          } else {
            toasterError(
                context,
                value.data?['error']?.toString() ??
                    value.data?['message']?.toString() ??
                    'Impossible de se connecter au serveur');
            return false;
          }
        },
      );

      // await Future.delayed(Duration(seconds: 2));
      // return true;
    } on DioException catch (error) {
      printer(error);
      toasterError(
        context,
        error.response?.data['error']?.toString() ??
            error.response?.data['message']?.toString() ??
            error.message ??
            'Erreur de connection au serveur',
      );
      return false;
    } on WebSocketException catch (e) {
      toasterError(context, e.message);
      return false;
    } on HttpException catch (e) {
      toasterError(context, e.message);
      return false;
    } catch (e) {
      printer(e);
      toasterError(context, e.toString());
      return false;
    }
  }

  // Get All Langage

  Future<List<Langue>?> getAllLangages(context) async {
    final dio = Dio();
    try {
      return await dio
          .get(
        '$base/all',
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
            final user_list = data['result'];
            printer(user_list);
            return (user_list as Iterable).map((e) {
              printer(Langue.fromMap(e));
              return Langue.fromMap(e);
            }).toList();
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
      printer(error.response?.data['message'] ??
          error.message ??
          'Erreur de connection au serveur');
      return null;
    } on WebSocketException catch (e) {
      printer(e.message);
      toasterError(context, e.message);
      return null;
    } on HttpException catch (e) {
      printer(e.message);
      toasterError(context, e.message);
      return null;
    } catch (e) {
      printer(e);
      toasterError(context, e.toString());
      return null;
    }
  }
}
