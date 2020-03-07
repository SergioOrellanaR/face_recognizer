import 'dart:convert';
import 'dart:io';
import 'package:facial_recognizer/src/REST/EmotionResponse.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

final String serverURL = "serorellanar.com:3500";

Future<EmotionResponse> emotionResponse(File image) async {
  var uri = new Uri.http(serverURL, '/emotion');

  final mimeType = mime(image.path).split("/");

  final imageUploadRequest = http.MultipartRequest("POST", uri);

  final file = await http.MultipartFile.fromPath("image", image.path,
      contentType: MediaType(mimeType[0], mimeType[1]));

  imageUploadRequest.files.add(file);

  final streamResponse = await imageUploadRequest.send();

  final response = await http.Response.fromStream(streamResponse);
  final responseData = json.decode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return emotionResponseFromJson(responseData);
  } else {
    return EmotionResponse(ok: false, results: null, emocion: null, message: responseData["results"]);
  }
}
