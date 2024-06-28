import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../model/virus_total_model.dart';
import 'package:http/http.dart' as http;

class VirusTotalApiService {
  final List<String> virusTotalEndpoints = [
    'https://www.virustotal.com/api/v3/urls',
  ];

  Future<String> scanUrl(String link) async {
    Uri uri = Uri.parse(virusTotalEndpoints[0]);

    try {
      final response = await http.post(uri, body: {
        'url': link
      }, headers: {
        'x-apikey': dotenv.env['API_KEY_VIRUS_TOTAL'] ?? '',
        'Content-Type': 'application/x-www-form-urlencoded',
        "Host": "www.virustotal.com",
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data']['id'];
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getReport(String id) async {
    Uri uri = Uri.parse('${virusTotalEndpoints[0]}/$id');

    try {
      final response = await http.get(uri, headers: {
        'x-apikey': dotenv.env['API_KEY_VIRUS_TOTAL_2'] ?? '',
        'Content-Type': 'application/x-www-form-urlencoded',
        "Host": "www.virustotal.com",
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        print('1');
        var data = VirusTotalModel.fromJson(jsonDecode(response.body));
        return {
          'data': data,
          'status': true,
        };
      } else {
        print('2');
        return {
          'data': VirusTotalModel.fromJson(jsonDecode(response.body)),
          'status': false,
        };
      }
    } catch (e) {
      print('3');
      return {
        'data': e,
        'status': false,
      };
    }
  }
}
