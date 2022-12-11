class PhotoDTOs {
  final String path;
  final int photoId;

  PhotoDTOs({
    required this.path,
    required this.photoId,
  });

  factory PhotoDTOs.fromJson({
    required Map<String, dynamic> json,
  }) {
    return PhotoDTOs(
      path: json['path'],
      photoId: json['photoId'],
    );
  }
}