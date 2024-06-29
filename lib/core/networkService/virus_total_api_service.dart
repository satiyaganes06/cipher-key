import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../model/virus_total_model.dart';
import 'package:http/http.dart' as http;

import '../../model/virus_total_vote_model.dart';

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

  Future<String> reScanUrl(String id) async {
    Uri uri = Uri.parse('${virusTotalEndpoints[0]}/$id/analyse');

    try {
      final response = await http.post(uri, headers: {
        'x-apikey': dotenv.env['API_KEY_VIRUS_TOTAL'] ?? '',
        'Content-Type': 'application/x-www-form-urlencoded',
        "Host": "www.virustotal.com",
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return 'Send for rescanning. We will notify you when the re-analyze is complete';
      } else {
        throw Exception('Failed to rescan the url');
      }
    } catch (e) {
      throw Exception('Something went wrong. Please try again later');
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
      debugPrint(e.toString());
      return {
        'data': 'Something went wrong',
        'status': false,
      };
    }
  }

  Future<Map<String, dynamic>> castVoteForURL(
      String id, bool isHarmless) async {
    Uri uri = Uri.parse('${virusTotalEndpoints[0]}/$id/votes');

    try {
      final response = await http.post(uri, body: {
        'type': 'vote',
        "attributes": {"verdict": isHarmless ? "harmless" : "malicious"}
      }, headers: {
        'x-apikey': dotenv.env['API_KEY_VIRUS_TOTAL_2'] ?? '',
        'Content-Type': 'application/x-www-form-urlencoded',
        "Host": "www.virustotal.com",
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        print(response);
        var data = VirusTotalVoteModel.fromJson(jsonDecode(response.body));

        return {
          'data': data,
          'status': true,
        };
      } else {
        return {
          'data': VirusTotalVoteModel.fromJson(jsonDecode(response.body)),
          'status': false,
        };
      }
    } catch (e) {
      debugPrint(e.toString());
      return {
        'data': 'Something went wrong',
        'status': false,
      };
    }
  }
}
