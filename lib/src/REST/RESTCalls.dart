import 'dart:convert';
import 'dart:io';
import 'package:facial_recognizer/src/REST/EmotionResponse.dart';
import 'package:facial_recognizer/src/REST/RegisterResponse.dart';
import 'package:facial_recognizer/src/models/Person.dart';
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
    return EmotionResponse(ok: true, results: null, emocion: responseData["emocion"], message: null);
  } else {
    return EmotionResponse(ok: false, results: null, emocion: null, message: responseData["results"]);
  }
}

Future<RegisterResponse> registerResponse(String imagePath, Person person) async {
  var uri = new Uri.http(serverURL, '/person');

  final mimeType = mime(imagePath).split("/");
  final request = http.MultipartRequest("POST", uri);

  final file = await http.MultipartFile.fromPath("image", imagePath,
      contentType: MediaType(mimeType[0], mimeType[1]));
  
  Map<String,String> requestFields = {
    "name": person.name,
    "email" : person.email,
    "profession" : person.profession,
    "hobby" : person.hobby
  };

  request.files.add(file);
  request.fields.addAll(requestFields);
  
  final streamResponse = await request.send();

  final response = await http.Response.fromStream(streamResponse);
  final responseData = json.decode(response.body);

  if (response.statusCode == 200) {
    return RegisterResponse(ok: true, imageData: null, person: PersonData.fromJson(responseData["person"]), message: null); 
  } else {
    return RegisterResponse(ok: false, imageData: null, person: null, message: responseData["results"]);
  }
}
