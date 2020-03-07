// To parse this JSON data, do
//
//     final emotionResponse = emotionResponseFromJson(jsonString);

import 'dart:convert';

EmotionResponse emotionResponseFromJson(String str) => EmotionResponse.fromJson(json.decode(str));
String emotionResponseToJson(EmotionResponse data) => json.encode(data.toJson());

class EmotionResponse {
    bool ok;
    String emocion;
    Results results;
    String message;

    EmotionResponse({
        this.ok,
        this.emocion,
        this.results,
        this.message
    });

    factory EmotionResponse.fromJson(Map<String, dynamic> json) => EmotionResponse(
        ok: json["ok"],
        emocion: json["emocion"],
        results: Results.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "emocion": emocion,
        "results": results.toJson(),
    };
}

class Results {
    BoundingBox boundingBox;
    AgeRange ageRange;
    Beard smile;
    Beard eyeglasses;
    Beard sunglasses;
    Gender gender;
    Beard beard;
    Beard mustache;
    Beard eyesOpen;
    Beard mouthOpen;
    List<Emotion> emotions;
    List<Landmark> landmarks;
    Pose pose;
    Quality quality;
    double confidence;

    Results({
        this.boundingBox,
        this.ageRange,
        this.smile,
        this.eyeglasses,
        this.sunglasses,
        this.gender,
        this.beard,
        this.mustache,
        this.eyesOpen,
        this.mouthOpen,
        this.emotions,
        this.landmarks,
        this.pose,
        this.quality,
        this.confidence,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        boundingBox: BoundingBox.fromJson(json["BoundingBox"]),
        ageRange: AgeRange.fromJson(json["AgeRange"]),
        smile: Beard.fromJson(json["Smile"]),
        eyeglasses: Beard.fromJson(json["Eyeglasses"]),
        sunglasses: Beard.fromJson(json["Sunglasses"]),
        gender: Gender.fromJson(json["Gender"]),
        beard: Beard.fromJson(json["Beard"]),
        mustache: Beard.fromJson(json["Mustache"]),
        eyesOpen: Beard.fromJson(json["EyesOpen"]),
        mouthOpen: Beard.fromJson(json["MouthOpen"]),
        emotions: List<Emotion>.from(json["Emotions"].map((x) => Emotion.fromJson(x))),
        landmarks: List<Landmark>.from(json["Landmarks"].map((x) => Landmark.fromJson(x))),
        pose: Pose.fromJson(json["Pose"]),
        quality: Quality.fromJson(json["Quality"]),
        confidence: json["Confidence"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "BoundingBox": boundingBox.toJson(),
        "AgeRange": ageRange.toJson(),
        "Smile": smile.toJson(),
        "Eyeglasses": eyeglasses.toJson(),
        "Sunglasses": sunglasses.toJson(),
        "Gender": gender.toJson(),
        "Beard": beard.toJson(),
        "Mustache": mustache.toJson(),
        "EyesOpen": eyesOpen.toJson(),
        "MouthOpen": mouthOpen.toJson(),
        "Emotions": List<dynamic>.from(emotions.map((x) => x.toJson())),
        "Landmarks": List<dynamic>.from(landmarks.map((x) => x.toJson())),
        "Pose": pose.toJson(),
        "Quality": quality.toJson(),
        "Confidence": confidence,
    };
}

class AgeRange {
    int low;
    int high;

    AgeRange({
        this.low,
        this.high,
    });

    factory AgeRange.fromJson(Map<String, dynamic> json) => AgeRange(
        low: json["Low"],
        high: json["High"],
    );

    Map<String, dynamic> toJson() => {
        "Low": low,
        "High": high,
    };
}

class Beard {
    bool value;
    double confidence;

    Beard({
        this.value,
        this.confidence,
    });

    factory Beard.fromJson(Map<String, dynamic> json) => Beard(
        value: json["Value"],
        confidence: json["Confidence"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Value": value,
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

class Emotion {
    String type;
    double confidence;

    Emotion({
        this.type,
        this.confidence,
    });

    factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
        type: json["Type"],
        confidence: json["Confidence"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Type": type,
        "Confidence": confidence,
    };
}

class Gender {
    String value;
    double confidence;

    Gender({
        this.value,
        this.confidence,
    });

    factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        value: json["Value"],
        confidence: json["Confidence"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Value": value,
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
