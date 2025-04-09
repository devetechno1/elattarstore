import 'package:equatable/equatable.dart';

class RestrictedZipModel extends Equatable {
  final int? id;
  final String? zipcode;
  const RestrictedZipModel({this.id, this.zipcode});

  factory RestrictedZipModel.fromJson(Map<String, dynamic> json) {
    return RestrictedZipModel(id: json['id'], zipcode: json['zipcode']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zipcode'] = zipcode;
    return data;
  }
  
  @override
  List<Object?> get props => [id, zipcode];
}
