import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallpapers/src/models/image_model.dart';

class ImageState extends Equatable {
  final ImageModel image;
  final bool fetching;
  final bool fetchingFinalized;
  final bool lock;
  final bool home;
  final bool both;
  final bool downloading;
  final bool success;
  final bool error;
  final double progressDownload;
  final bool providerError;
  final bool internetError;
  final bool progressChanged;
  final String url;

  ImageState({
    @required this.image,
    @required this.fetching,
    @required this.fetchingFinalized,
    @required this.home,
    @required this.both,
    @required this.lock,
    @required this.progressDownload,
    @required this.downloading,
    @required this.internetError,
    @required this.providerError,
    @required this.error,
    @required this.success,
    @required this.progressChanged,
    @required this.url,
  });

  factory ImageState.initial() {
    return ImageState(
      image: ImageModel(
        (i) => i
          ..url = ""
          ..category = ""
          ..name = "",
      ),
      fetching: true,
      fetchingFinalized: false,
      home: true,
      lock: false,
      both: false,
      progressDownload: 0.0,
      downloading: false,
      success: false,
      error: false,
      internetError: false,
      providerError: false,
      progressChanged: false,
      url: "",
    );
  }

  ImageState copyWith({
    ImageModel image,
    bool fetching,
    bool fetchingFinalize,
    bool lock,
    bool home,
    bool both,
    double progress,
    bool downloading,
    bool success,
    bool error,
    bool providerError,
    bool internetError,
    String url,
    bool progressChanged,
  }) {
    return ImageState(
      image: image ?? this.image,
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalize ?? this.fetchingFinalized,
      lock: lock ?? this.lock,
      home: home ?? this.home,
      both: both ?? this.both,
      progressDownload: progress ?? this.progressDownload,
      downloading: downloading ?? this.downloading,
      success: success ?? this.success,
      error: error ?? this.error,
      providerError: providerError ?? this.providerError,
      internetError: internetError ?? this.internetError,
      progressChanged: progressChanged ?? this.progressChanged,
      url: url ?? this.url,
    );
  }

  @override
  List<Object> get props => [
        image,
        fetching,
        fetchingFinalized,
        home,
        lock,
        both,
        progressDownload,
        downloading,
        success,
        error,
        providerError,
        internetError,
        progressChanged,
        url
      ];
}
