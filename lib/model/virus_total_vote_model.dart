class VirusTotalVoteModel {
  VirusTotalVoteModel({
    required this.data,
  });

  final Data? data;
  static const String dataKey = "data";

  VirusTotalVoteModel copyWith({
    Data? data,
  }) {
    return VirusTotalVoteModel(
      data: data ?? this.data,
    );
  }

  factory VirusTotalVoteModel.fromJson(Map<String, dynamic> json) {
    return VirusTotalVoteModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$data, ";
  }
}

class Data {
  Data({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
  });

  final String? id;
  static const String idKey = "id";

  final String? type;
  static const String typeKey = "type";

  final Links? links;
  static const String linksKey = "links";

  final Attributes? attributes;
  static const String attributesKey = "attributes";

  Data copyWith({
    String? id,
    String? type,
    Links? links,
    Attributes? attributes,
  }) {
    return Data(
      id: id ?? this.id,
      type: type ?? this.type,
      links: links ?? this.links,
      attributes: attributes ?? this.attributes,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      type: json["type"],
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      attributes: json["attributes"] == null
          ? null
          : Attributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "links": links?.toJson(),
        "attributes": attributes?.toJson(),
      };

  @override
  String toString() {
    return "$id, $type, $links, $attributes, ";
  }
}

class Attributes {
  Attributes({
    required this.value,
    required this.date,
    required this.verdict,
  });

  final int? value;
  static const String valueKey = "value";

  final int? date;
  static const String dateKey = "date";

  final String? verdict;
  static const String verdictKey = "verdict";

  Attributes copyWith({
    int? value,
    int? date,
    String? verdict,
  }) {
    return Attributes(
      value: value ?? this.value,
      date: date ?? this.date,
      verdict: verdict ?? this.verdict,
    );
  }

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      value: json["value"],
      date: json["date"],
      verdict: json["verdict"],
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "date": date,
        "verdict": verdict,
      };

  @override
  String toString() {
    return "$value, $date, $verdict, ";
  }
}

class Links {
  Links({
    required this.self,
  });

  final String? self;
  static const String selfKey = "self";

  Links copyWith({
    String? self,
  }) {
    return Links(
      self: self ?? this.self,
    );
  }

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json["self"],
    );
  }

  Map<String, dynamic> toJson() => {
        "self": self,
      };

  @override
  String toString() {
    return "$self, ";
  }
}
