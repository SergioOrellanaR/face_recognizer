import 'dart:convert';

import 'package:facial_recognizer/src/REST/RegisterResponse.dart';

SearchByImage searchByImageFromJson(String str) => SearchByImage.fromJson(json.decode(str));

String searchByImageToJson(SearchByImage data) => json.encode(data.toJson());

class SearchByImage {
    bool ok;
    String results;
    PersonData person;
    Data data;

    SearchByImage({
        this.ok,
        this.results,
        this.person,
        this.data,
    });

    factory SearchByImage.fromJson(Map<String, dynamic> json) => SearchByImage(
        ok: json["ok"],
        results: json["results"],
        person: PersonData.fromJson(json["person"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "results": results,
        "person": person.toJson(),
        "data": data.toJson(),
    };
}

class Data {
    BoundingBox searchedFaceBoundingBox;
    double searchedFaceConfidence;
    List<FaceMatch> faceMatches;
    String faceModelVersion;

    Data({
        this.searchedFaceBoundingBox,
        this.searchedFaceConfidence,
        this.faceMatches,
        this.faceModelVersion,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        searchedFaceBoundingBox: BoundingBox.fromJson(json["SearchedFaceBoundingBox"]),
        searchedFaceConfidence: json["SearchedFaceConfidence"].toDouble(),
        faceMatches: List<FaceMatch>.from(json["FaceMatches"].map((x) => FaceMatch.fromJson(x))),
        faceModelVersion: json["FaceModelVersion"],
    );

    Map<String, dynamic> toJson() => {
        "SearchedFaceBoundingBox": searchedFaceBoundingBox.toJson(),
        "SearchedFaceConfidence": searchedFaceConfidence,
        "FaceMatches": List<dynamic>.from(faceMatches.map((x) => x.toJson())),
        "FaceModelVersion": faceModelVersion,
    };
}

class FaceMatch {
    double similarity;
    Face face;

    FaceMatch({
        this.similarity,
        this.face,
    });

    factory FaceMatch.fromJson(Map<String, dynamic> json) => FaceMatch(
        similarity: json["Similarity"].toDouble(),
        face: Face.fromJson(json["Face"]),
    );

    Map<String, dynamic> toJson() => {
        "Similarity": similarity,
        "Face": face.toJson(),
    };
}

class Face {
    String faceId;
    BoundingBox boundingBox;
    String imageId;
    String externalImageId;
    double confidence;

    Face({
        this.faceId,
        this.boundingBox,
        this.imageId,
        this.externalImageId,
        this.confidence,
    });

    factory Face.fromJson(Map<String, dynamic> json) => Face(
        faceId: json["FaceId"],
        boundingBox: BoundingBox.fromJson(json["BoundingBox"]),
        imageId: json["ImageId"],
        externalImageId: json["ExternalImageId"],
        confidence: json["Confidence"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "FaceId": faceId,
        "BoundingBox": boundingBox.toJson(),
        "ImageId": imageId,
        "ExternalImageId": externalImageId,
        "Confidence": confidence,
    };
}

class BoundingBox {
    double width;
    double height;
    double left;
    double top;

    BoundingBox({
        this.width,
        this.height,
        this.left,
        this.top,
    });

    factory BoundingBox.fromJson(Map<String, dynamic> json) => BoundingBox(
        width: json["Width"].toDouble(),
        height: json["Height"].toDouble(),
        left: json["Left"].toDouble(),
        top: json["Top"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Width": width,
        "Height": height,
        "Left": left,
        "Top": top,
    };
}