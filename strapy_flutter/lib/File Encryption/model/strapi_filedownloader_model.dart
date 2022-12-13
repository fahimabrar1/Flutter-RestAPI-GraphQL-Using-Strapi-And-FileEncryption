import 'dart:convert';

///
/// File Model of any type which is fetched from server strapi
///

StrapiFileDownloaderModel strapiFileDownloaderModelFromJson(String str) =>
    StrapiFileDownloaderModel.fromJson(json.decode(str));

String strapiFileDownloaderModelToJson(StrapiFileDownloaderModel data) =>
    json.encode(data.toJson());

class StrapiFileDownloaderModel {
  StrapiFileDownloaderModel({
    required this.data,
  });

  final StrapiFileDownloaderModelData data;

  factory StrapiFileDownloaderModel.fromJson(Map<String, dynamic> json) =>
      StrapiFileDownloaderModel(
        data: StrapiFileDownloaderModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class StrapiFileDownloaderModelData {
  StrapiFileDownloaderModelData({
    required this.attributes,
  });

  final FirstAttributes attributes;

  factory StrapiFileDownloaderModelData.fromJson(Map<String, dynamic> json) =>
      StrapiFileDownloaderModelData(
        attributes: FirstAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes.toJson(),
      };
}

class FirstAttributes {
  FirstAttributes({
    required this.image,
  });

  final Image image;

  factory FirstAttributes.fromJson(Map<String, dynamic> json) =>
      FirstAttributes(
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
      };
}

class Image {
  Image({
    required this.data,
  });

  final ImageData data;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        data: ImageData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.attributes,
  });

  final int id;
  final SecondAttributes attributes;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        attributes: SecondAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class SecondAttributes {
  SecondAttributes({
    required this.name,
    required this.width,
    required this.height,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  final String name;
  final int width;
  final int height;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final dynamic previewUrl;
  final String provider;
  final dynamic providerMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory SecondAttributes.fromJson(Map<String, dynamic> json) =>
      SecondAttributes(
        name: json["name"],
        width: json["width"],
        height: json["height"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "width": width,
        "height": height,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
