class VideoModel {
  late String videoName;
  late String videoSubject;
  late String videoType;
  late String videoUrl;

  VideoModel({required this.videoName, required this.videoUrl});

  factory VideoModel.fromJson(dynamic json) {
    VideoModel videoModel = VideoModel.emptyConstructor();
    videoModel.videoName = json['videoName'];
    videoModel.videoSubject = json['videoSubject'];
    videoModel.videoType = json['videoType'];
    videoModel.videoUrl = json['videoUrl'];
    return videoModel;
  }

  VideoModel.emptyConstructor();
}
