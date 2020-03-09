import 'dart:convert';
import 'dart:io';
import 'package:facial_recognizer/src/REST/EmotionResponse.dart';
import 'package:facial_recognizer/src/REST/HttpsRequest.dart';
import 'package:facial_recognizer/src/REST/RegisterResponse.dart';
import 'package:facial_recognizer/src/REST/SearchByImageResponse.dart';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

final String serverURL = "serorellanar.com";
final String prefixRestURL = "/rest/recognizerApi";
http.IOClient ioClient;

Future httpsClientWithCertificate() async
{
  SecurityContext context = new SecurityContext();
  final ByteData crtData = await rootBundle.load('assets/certificate.crt');
  context.setTrustedCertificatesBytes(crtData.buffer.asUint8List());
  HttpClient _client = new HttpClient(context: context);
  ioClient = http.IOClient(_client);
}

Future<EmotionResponse> emotionResponse(File image) async {
  
  var uri = new Uri.https(serverURL, prefixRestURL + '/emotion');

  await httpsClientWithCertificate();

  final mimeType = mime(image.path).split("/");

  HttpsRequest imageUploadRequest = HttpsRequest("POST", uri, ioClient);

  final file = await http.MultipartFile.fromPath("image", image.path,
      contentType: MediaType(mimeType[0], mimeType[1]));

  imageUploadRequest.files.add(file);
  
  final streamResponse = await imageUploadRequest.send();

  final response = await http.Response.fromStream(streamResponse);
  final responseData = json.decode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return EmotionResponse(
        ok: true,
        results: null,
        emocion: responseData["emocion"],
        message: null);
  } else {
    return EmotionResponse(
        ok: false,
        results: null,
        emocion: null,
        message: responseData["results"]);
  }
}

Future<RegisterResponse> registerResponse(
    String imagePath, Person person) async {
  var uri = new Uri.https(serverURL, prefixRestURL + '/person');

  await httpsClientWithCertificate();

  final mimeType = mime(imagePath).split("/");

  final request = HttpsRequest("POST", uri, ioClient);

  final file = await http.MultipartFile.fromPath("image", imagePath,
      contentType: MediaType(mimeType[0], mimeType[1]));

  Map<String, String> requestFields = {
    "name": person.name,
    "email": person.email,
    "profession": person.profession,
    "hobby": person.hobby
  };

  request.files.add(file);
  request.fields.addAll(requestFields);

  final streamResponse = await request.send();

  final response = await http.Response.fromStream(streamResponse);
  final responseData = json.decode(response.body);

  if (response.statusCode == 200) {
    return RegisterResponse(
        ok: true,
        imageData: null,
        person: PersonData.fromJson(responseData["person"]),
        message: null);
  } else {
    return RegisterResponse(
        ok: false,
        imageData: null,
        person: null,
        message: responseData["results"]);
  }
}

Future<SearchByImage> searchByImageResponse(File image) async {
  var uri = new Uri.https(serverURL, prefixRestURL + '/searchPersonByImage');

  await httpsClientWithCertificate();

  final mimeType = mime(image.path).split("/");

  final imageUploadRequest = HttpsRequest("POST", uri, ioClient);

  final file = await http.MultipartFile.fromPath("image", image.path,
      contentType: MediaType(mimeType[0], mimeType[1]));

  imageUploadRequest.files.add(file);

  final streamResponse = await imageUploadRequest.send();

  final response = await http.Response.fromStream(streamResponse);
  final responseData = json.decode(response.body);

  if (response.statusCode == 200) {
    return searchByImageFromJson(response.body);
  } else {
    return SearchByImage(ok: false, results: responseData["results"]);
  }
}

Future<bool> deleteById(String id) async {
  var uri = new Uri.https(serverURL, prefixRestURL + '/person/$id');

  await httpsClientWithCertificate();
  final response = await http.delete(uri);
  return response.statusCode == 200 ? true : false;
}
