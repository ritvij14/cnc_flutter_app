class VideoModel {
  String videoName;
  String videoSubject;
  String videoType;
String  videoUrl;

  VideoModel({this.videoName, this.videoUrl});

  factory VideoModel.fromJson(dynamic json) {
    VideoModel videoModel = VideoModel.emptyConstructor();
    videoModel.videoName = json['videoName'];
    videoModel.videoSubject = json['videoSubject'];
    videoModel.videoType = json['videoType'];
    videoModel.videoUrl= json['videoUrl'];
    return videoModel;
  }

  VideoModel.emptyConstructor() {}
}