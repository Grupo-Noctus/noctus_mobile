import 'package:flutter/foundation.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';

final class VideoEntity {
  final int id;
  final String name;
  final String description;
  final int duration;
  final int? idProgressVideo;
  final int? viewed;
  final String? videoUrl;

  const VideoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    this.videoUrl,
    this.idProgressVideo,
    this.viewed,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyDescription = 'description';
  static const String kKeyDuration = 'duration';
  static const String kKeyIdProgressVideo = 'idProgressVideo';
  static const String kKeyViewed = 'viewed';
  static const String kKeyVideoUrl = 'videoUrl';

  static const String defaultVideoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  factory VideoEntity.fromMap(Map<String, dynamic> map) {
    return VideoEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      description: map[kKeyDescription] as String,
      duration: map[kKeyDuration] as int,
      videoUrl: map[kKeyVideoUrl] as String?,
      idProgressVideo: map[kKeyIdProgressVideo] as int?,
      viewed: map[kKeyViewed] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyDescription: description,
      kKeyDuration: duration,
      kKeyVideoUrl: videoUrl,
      kKeyIdProgressVideo: idProgressVideo,
      kKeyViewed: viewed,
    };
  }

  String get url {
    if (videoUrl == null || videoUrl!.isEmpty) return '';
    const env = EnvironmentHelper();
    return '${env.urlUploadVideo}$videoUrl';
  }
}
