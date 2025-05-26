import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaModel {
  int? id;
  String? name;
  String? link;
  IconData? icon;
  int? activeStatus;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  SocialMediaModel({
    this.id,
    this.name,
    this.link,
    this.icon,
    this.activeStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialMediaModel.fromMap(Map<String, dynamic> data) {
    const Map<String, IconData> iconsMap = {
      'fa fa-twitter': FontAwesomeIcons.twitter,
      'fa fa-linkedin': FontAwesomeIcons.linkedin,
      'fa fa-google-plus-square': FontAwesomeIcons.squareGooglePlus,
      'fa fa-pinterest': FontAwesomeIcons.pinterest,
      'fa-brands fa-tiktok': FontAwesomeIcons.tiktok,
      'fa fa-instagram': FontAwesomeIcons.squareInstagram,
      'fa fa-facebook': FontAwesomeIcons.facebook,
    };
    return SocialMediaModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      link: data['link'] as String?,
      icon: iconsMap[data['icon'] as String?],
      activeStatus: data['active_status'] as int?,
      status: data['status'] as int?,
      createdAt: data['created_at'] == null
          ? null
          : DateTime.parse(data['created_at'] as String),
      updatedAt: data['updated_at'] == null
          ? null
          : DateTime.parse(data['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'link': link,
        'icon': icon,
        'active_status': activeStatus,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SocialMediaModel].
  factory SocialMediaModel.fromJson(String data) {
    return SocialMediaModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SocialMediaModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
