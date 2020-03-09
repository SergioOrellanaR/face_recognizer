import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:facial_recognizer/src/REST/RESTCalls.dart' as rest;

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
      Uri path = Uri.https(server, imagePath);

      return Image.network(path.toString(), fit: BoxFit.fill);
    }
}
