import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  bool ok;
  PersonData person;
  ImageData imageData;
  String message;

  RegisterResponse({
    this.ok,
    this.person,
    this.imageData,
    this.message
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        ok: json["ok"],
        person: PersonData.fromJson(json["person"]),
        imageData: ImageData.fromJson(json["imageData"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "person": person.toJson(),
        "imageData": imageData.toJson(),
      };
}

class ImageData {
  List<FaceRecord> faceRecords;
  String faceModelVersion;
  List<dynamic> unindexedFaces;

  ImageData({
    this.faceRecords,
    this.faceModelVersion,
    this.unindexedFaces,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        faceRecords: List<FaceRecord>.from(
            json["FaceRecords"].map((x) => FaceRecord.fromJson(x))),
        faceModelVersion: json["FaceModelVersion"],
        unindexedFaces:
            List<dynamic>.from(json["UnindexedFaces"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "FaceRecords": List<dynamic>.from(faceRecords.map((x) => x.toJson())),
        "FaceModelVersion": faceModelVersion,
        "UnindexedFaces": List<dynamic>.from(unindexedFaces.map((x) => x)),
      };
}

class FaceRecord {
  Face face;
  FaceDetail faceDetail;

  FaceRecord({
    this.face,
    this.faceDetail,
  });

  factory FaceRecord.fromJson(Map<String, dynamic> json) => FaceRecord(
        face: Face.fromJson(json["Face"]),
        faceDetail: FaceDetail.fromJson(json["FaceDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "Face": face.toJson(),
        "FaceDetail": faceDetail.toJson(),
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

class FaceDetail {
  BoundingBox boundingBox;
  List<Landmark> landmarks;
  Pose pose;
  Quality quality;
  double confidence;

  FaceDetail({
    this.boundingBox,
    this.landmarks,
    this.pose,
    this.quality,
    this.confidence,
  });

  factory FaceDetail.fromJson(Map<String, dynamic> json) => FaceDetail(
        boundingBox: BoundingBox.fromJson(json["BoundingBox"]),
        landmarks: List<Landmark>.from(
            json["Landmarks"].map((x) => Landmark.fromJson(x))),
        pose: Pose.fromJson(json["Pose"]),
        quality: Quality.fromJson(json["Quality"]),
        confidence: json["Confidence"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "BoundingBox": boundingBox.toJson(),
        "Landmarks": List<dynamic>.from(landmarks.map((x) => x.toJson())),
        "Pose": pose.toJson(),
        "Quality": quality.toJson(),
        "Confidence": confidence,
      };
}

class Landmark {
  String type;
  double x;
  double y;

  Landmark({
    this.type,
    this.x,
    this.y,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
        type: json["Type"],
        x: json["X"].toDouble(),
        y: json["Y"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "X": x,
        "Y": y,
      };
}

class Pose {
  double roll;
  double yaw;
  double pitch;

  Pose({
    this.roll,
    this.yaw,
    this.pitch,
  });

  factory Pose.fromJson(Map<String, dynamic> json) => Pose(
        roll: json["Roll"].toDouble(),
        yaw: json["Yaw"].toDouble(),
        pitch: json["Pitch"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Roll": roll,
        "Yaw": yaw,
        "Pitch": pitch,
      };
}

class Quality {
  double brightness;
  double sharpness;

  Quality({
    this.brightness,
    this.sharpness,
  });

  factory Quality.fromJson(Map<String, dynamic> json) => Quality(
        brightness: json["Brightness"].toDouble(),
        sharpness: json["Sharpness"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Brightness": brightness,
        "Sharpness": sharpness,
      };
}

class PersonData {
  String id;
  String name;
  String email;
  String profession;
  String hobby;
  String imgName;
  String faceId;
  int v;

  PersonData({
    this.id,
    this.name,
    this.email,
    this.profession,
    this.hobby,
    this.imgName,
    this.faceId,
    this.v,
  });

  factory PersonData.fromJson(Map<String, dynamic> json) => PersonData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        profession: json["profession"],
        hobby: json["hobby"],
        imgName: json["imgName"],
        faceId: json["faceID"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profession": profession,
        "hobby": hobby,
        "imgName": imgName,
        "faceID": faceId,
        "__v": v,
      };
}
