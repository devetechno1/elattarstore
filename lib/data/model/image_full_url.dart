class ImageFullUrl {
  String? key;
  String? path;
  int? status;

  ImageFullUrl({this.key, this.path, this.status});

  ImageFullUrl.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    path = json['path'];
    status = json['status'];
    if (status != 200) {
      path = '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['path'] = path;
    data['status'] = status;
    return data;
  }
}
class ImagePath {
  String? imageName;
  String? storage;

  ImagePath({this.imageName, this.storage});

  ImagePath.fromJson(Map<String, dynamic> json) {
    imageName = json['image_name'];
    storage = json['storage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'image_name': imageName,
      'storage': storage,
    };
  }

  @override
  String toString() => '$storage/$imageName';
}