import 'dart:convert';

import 'package:http/http.dart' as http;

Future textPostApiRequest(String prompt) async {
  final url = Uri.parse('https://api.meshy.ai/v2/text-to-3d');

  final header = {
    "Authorization": "Bearer msy_p1I7L0HvXCzAOoa1xhyR64AH3KVIqsz1C3xs",
    "Content-Type": "application/json"
  };

  final body = {
    'mode': 'preview',
    'prompt': prompt,
    'ai_model': 'meshy-3-turbo',
  };

  try {
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));

    final result = jsonDecode(response.body);

    return result['result'];
  } catch (e) {
    print(e.toString());
  }
}

Future textGetApiRequest(String id) async {
  final url = Uri.parse(
    'https://api.meshy.ai/v2/text-to-3d/$id',
  );

  final header = {
    "Authorization": "Bearer msy_p1I7L0HvXCzAOoa1xhyR64AH3KVIqsz1C3xs",
  };

  try {
    dynamic result;

    for (var i = 0;; i++) {
      final response = await http.get(url, headers: header);

      result = jsonDecode(response.body);

      if (result['progress'] == 100) {
        return result;
      }

      print(result['progress']);
    }
  } catch (e) {
    print(e.toString());
  }
}

Future imagePostApiRequest(String imageUrl) async {
  final url = Uri.parse('https://api.meshy.ai/v1/image-to-3d');

  final header = {
    "Authorization": "Bearer msy_p1I7L0HvXCzAOoa1xhyR64AH3KVIqsz1C3xs",
    "Content-Type": "application/json"
  };

  final body = {"image_url": imageUrl};

  try {
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));

    final result = jsonDecode(response.body);

    return result['result'];
  } catch (e) {
    print(e.toString());
  }
}

Future imageGetApiRequest(String id) async {
  final url = Uri.parse(
    'https://api.meshy.ai/v1/image-to-3d/$id',
  );

  final header = {
    "Authorization": "Bearer msy_p1I7L0HvXCzAOoa1xhyR64AH3KVIqsz1C3xs",
  };

  try {
    dynamic result;

    for (var i = 0;; i++) {
      final response = await http.get(url, headers: header);

      result = jsonDecode(response.body);

      if (result['progress'] == 100) {
        return result;
      }

      print(result['progress']);
    }
  } catch (e) {
    print(e.toString());
  }
}
