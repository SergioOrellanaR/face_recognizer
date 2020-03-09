import 'dart:convert';
import 'dart:io';
import 'package:facial_recognizer/src/REST/HttpsRequest.dart';
import 'package:facial_recognizer/utils/NetworkSSLImage.dart';
import 'package:flutter/material.dart';
import 'package:facial_recognizer/src/REST/RESTCalls.dart' as rest;
import 'package:http/http.dart';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
    String id;
    String imagePath;
    String name;
    String email;
    String profession;
    String hobby;

    Person({
        this.id,
        this.imagePath,
        this.name,
        this.email,
        this.profession,
        this.hobby,
    });

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        imagePath: json["imagePath"],
        name: json["name"],
        email: json["email"],
        profession: json["profession"],
        hobby: json["hobby"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imagePath": imagePath,
        "name": name,
        "email": email,
        "profession": profession,
        "hobby": hobby,
    };

    Image getImage()
    {
      return Image.file(File(imagePath),
              fit: BoxFit.fill);
    }

    Image getNetworkImage()
    {
      String server = rest.serverURL;
      String subPath = '${rest.prefixRestURL}/$imagePath';
      Uri path = Uri.https(server, subPath);
      
      return Image(image: NetworkImageSSL(path.toString()), fit: BoxFit.cover);
    }
}
