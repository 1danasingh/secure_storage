import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.id,
    this.createdBy,
    this.name,
    this.code,
    this.isoCode,
    this.flag,
    this.phoneNumberMinLength,
    this.phoneNumberMaxLength,
    this.nationality,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.updatedBy,
  });

  String? id;
  String? createdBy;
  String? name;
  String? code;
  String? isoCode;
  String? flag;
  int? phoneNumberMinLength;
  int? phoneNumberMaxLength;
  String? nationality;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? updatedBy;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["_id"],
    createdBy: json["createdBy"],
    name: json["name"],
    code: json["code"],
    isoCode: json["isoCode"],
    flag: json["flag"],
    phoneNumberMinLength: json["phoneNumberMinLength"],
    phoneNumberMaxLength: json["phoneNumberMaxLength"],
    nationality: json["nationality"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdBy": createdBy,
    "name": name,
    "code": code,
    "isoCode": isoCode,
    "flag": flag,
    "phoneNumberMinLength": phoneNumberMinLength,
    "phoneNumberMaxLength": phoneNumberMaxLength,
    "nationality": nationality,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
    "updatedBy": updatedBy,
  };
}
