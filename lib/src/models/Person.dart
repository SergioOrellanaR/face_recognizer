import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
    int id;
    String imagePath;
    String name;
    String profession;
    String hobby;

    Person({
        this.id,
        this.imagePath,
        this.name,
        this.profession,
        this.hobby,
    });

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        imagePath: json["imagePath"],
        name: json["name"],
        profession: json["profession"],
        hobby: json["hobby"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imagePath": imagePath,
        "name": name,
        "profession": profession,
        "hobby": hobby,
    };

    Image getImage()
    {
      return Image.file(File(imagePath),
              fit: BoxFit.fill);
    }
}
