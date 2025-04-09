import 'package:equatable/equatable.dart';

class ShippingMethodModel extends Equatable{
  final int? id;
  final int? governorateId;
  final String? creatorType;
  final String? title;
  final double? cost;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;

  const ShippingMethodModel(
      {this.id,
      this.governorateId,
      this.creatorType,
      this.title,
      this.cost,
      this.duration,
      this.createdAt,
      this.updatedAt});

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    double? cost;
    if (json['cost'] != null) {
      try {
        cost = json['cost'].toDouble();
      } catch (e) {
        cost = double.parse(json['cost'].toString());
      }
    }
    return ShippingMethodModel(
      id : json['id'],
      governorateId : int.tryParse("${json['zip_id']}"),
      creatorType : json['creator_type'],
      title : json['title'],
      cost: cost,
      duration : json['duration'],
      createdAt : json['created_at'],
      updatedAt : json['updated_at'],
    );
  }

  ShippingMethodModel copyWith({
    int? id,
    int? governorateId,
    String? creatorType,
    String? title,
    double? cost,
    String? duration,
    String? createdAt,
    String? updatedAt,
  }){
    return ShippingMethodModel(
      id: id ?? this.id,
      governorateId: governorateId ?? this.governorateId,
      creatorType: creatorType ?? this.creatorType,
      title: title ?? this.title,
      cost: cost ?? this.cost,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

   
  @override
  List<Object?> get props => [id,governorateId,creatorType,title,cost,duration,createdAt,updatedAt];
}
