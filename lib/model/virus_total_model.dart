class VirusTotalModel {
  VirusTotalModel({
    required this.data,
  });

  final Data? data;

  VirusTotalModel copyWith({
    Data? data,
  }) {
    return VirusTotalModel(
      data: data ?? this.data,
    );
  }

  factory VirusTotalModel.fromJson(Map<String, dynamic> json) {
    return VirusTotalModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
  });

  final String? id;
  final String? type;
  final Links? links;
  final Attributes? attributes;

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
      id: json["id"] as String?,
      type: json["type"] as String?,
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
}

class Attributes {
  Attributes({
    required this.tld,
    required this.threatNames,
    required this.timesSubmitted,
    required this.url,
    required this.lastModificationDate,
    required this.lastAnalysisResults,
    required this.lastSubmissionDate,
    required this.title,
    required this.reputation,
    required this.totalVotes,
    required this.lastAnalysisDate,
    required this.lastAnalysisStats,
    required this.firstSubmissionDate,
    required this.categories,
    required this.tags,
    required this.lastFinalUrl,
  });

  final String? tld;
  final List<dynamic> threatNames;
  final int? timesSubmitted;
  final String? url;
  final int? lastModificationDate;
  final Map<String, LastAnalysisResult> lastAnalysisResults;
  final int? lastSubmissionDate;
  final String? title;
  final int? reputation;
  final TotalVotes? totalVotes;
  final int? lastAnalysisDate;
  final LastAnalysisStats? lastAnalysisStats;
  final int? firstSubmissionDate;
  final Categories? categories;
  final List<dynamic> tags;
  final String? lastFinalUrl;

  Attributes copyWith({
    String? tld,
    List<dynamic>? threatNames,
    int? timesSubmitted,
    String? url,
    int? lastModificationDate,
    Map<String, LastAnalysisResult>? lastAnalysisResults,
    int? lastSubmissionDate,
    String? title,
    int? reputation,
    TotalVotes? totalVotes,
    int? lastAnalysisDate,
    LastAnalysisStats? lastAnalysisStats,
    int? firstSubmissionDate,
    Categories? categories,
    List<dynamic>? tags,
    String? lastFinalUrl,
  }) {
    return Attributes(
      tld: tld ?? this.tld,
      threatNames: threatNames ?? this.threatNames,
      timesSubmitted: timesSubmitted ?? this.timesSubmitted,
      url: url ?? this.url,
      lastModificationDate: lastModificationDate ?? this.lastModificationDate,
      lastAnalysisResults: lastAnalysisResults ?? this.lastAnalysisResults,
      lastSubmissionDate: lastSubmissionDate ?? this.lastSubmissionDate,
      title: title ?? this.title,
      reputation: reputation ?? this.reputation,
      totalVotes: totalVotes ?? this.totalVotes,
      lastAnalysisDate: lastAnalysisDate ?? this.lastAnalysisDate,
      lastAnalysisStats: lastAnalysisStats ?? this.lastAnalysisStats,
      firstSubmissionDate: firstSubmissionDate ?? this.firstSubmissionDate,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      lastFinalUrl: lastFinalUrl ?? this.lastFinalUrl,
    );
  }

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      tld: json["tld"] as String?,
      threatNames: json["threat_names"] == null
          ? []
          : List<dynamic>.from(json["threat_names"] as List),
      timesSubmitted: json["times_submitted"] as int?,
      url: json["url"] as String?,
      lastModificationDate: json["last_modification_date"] as int?,
      lastAnalysisResults:
          (json['last_analysis_results'] as Map<String, dynamic>).map(
        (k, v) => MapEntry(k, LastAnalysisResult.fromJson(v)),
      ),
      lastSubmissionDate: json["last_submission_date"] as int?,
      title: json["title"] as String?,
      reputation: json["reputation"] as int?,
      totalVotes: json["total_votes"] == null
          ? null
          : TotalVotes.fromJson(json["total_votes"]),
      lastAnalysisDate: json["last_analysis_date"] as int?,
      lastAnalysisStats: json["last_analysis_stats"] == null
          ? null
          : LastAnalysisStats.fromJson(json["last_analysis_stats"]),
      firstSubmissionDate: json["first_submission_date"] as int?,
      categories: json["categories"] == null
          ? null
          : Categories.fromJson(json["categories"]),
      tags:
          json["tags"] == null ? [] : List<dynamic>.from(json["tags"] as List),
      lastFinalUrl: json["last_final_url"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "tld": tld,
        "threat_names": threatNames.map((x) => x).toList(),
        "times_submitted": timesSubmitted,
        "url": url,
        "last_modification_date": lastModificationDate,
        "last_analysis_results": Map.from(lastAnalysisResults)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "last_submission_date": lastSubmissionDate,
        "title": title,
        "reputation": reputation,
        "total_votes": totalVotes?.toJson(),
        "last_analysis_date": lastAnalysisDate,
        "last_analysis_stats": lastAnalysisStats?.toJson(),
        "first_submission_date": firstSubmissionDate,
        "categories": categories?.toJson(),
        "tags": tags.map((x) => x).toList(),
        "last_final_url": lastFinalUrl,
      };
}

class Categories {
  Categories({required this.json});
  final Map<String, dynamic> json;

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(json: json);
  }

  Map<String, dynamic> toJson() => {};
}

class LastAnalysisResult {
  LastAnalysisResult({
    required this.method,
    required this.engineName,
    required this.category,
    required this.result,
  });

  final String? method;
  final String? engineName;
  final String? category;
  final String? result;

  LastAnalysisResult copyWith({
    String? method,
    String? engineName,
    String? category,
    String? result,
  }) {
    return LastAnalysisResult(
      method: method ?? this.method,
      engineName: engineName ?? this.engineName,
      category: category ?? this.category,
      result: result ?? this.result,
    );
  }

  factory LastAnalysisResult.fromJson(Map<String, dynamic> json) {
    return LastAnalysisResult(
      method: json["method"] as String?,
      engineName: json["engine_name"] as String?,
      category: json["category"] as String?,
      result: json["result"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "method": method,
        "engine_name": engineName,
        "category": category,
        "result": result,
      };
}

class LastAnalysisStats {
  LastAnalysisStats({
    required this.malicious,
    required this.suspicious,
    required this.undetected,
    required this.harmless,
    required this.timeout,
  });

  final int? malicious;
  final int? suspicious;
  final int? undetected;
  final int? harmless;
  final int? timeout;

  LastAnalysisStats copyWith({
    int? malicious,
    int? suspicious,
    int? undetected,
    int? harmless,
    int? timeout,
  }) {
    return LastAnalysisStats(
      malicious: malicious ?? this.malicious,
      suspicious: suspicious ?? this.suspicious,
      undetected: undetected ?? this.undetected,
      harmless: harmless ?? this.harmless,
      timeout: timeout ?? this.timeout,
    );
  }

  factory LastAnalysisStats.fromJson(Map<String, dynamic> json) {
    return LastAnalysisStats(
      malicious: json["malicious"] as int?,
      suspicious: json["suspicious"] as int?,
      undetected: json["undetected"] as int?,
      harmless: json["harmless"] as int?,
      timeout: json["timeout"] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "malicious": malicious,
        "suspicious": suspicious,
        "undetected": undetected,
        "harmless": harmless,
        "timeout": timeout,
      };

  @override
  String toString() {
    return "$malicious, $suspicious, $undetected, $harmless, $timeout, ";
  }
}

class TotalVotes {
  TotalVotes({
    required this.harmless,
    required this.malicious,
  });

  final int? harmless;
  final int? malicious;

  TotalVotes copyWith({
    int? harmless,
    int? malicious,
  }) {
    return TotalVotes(
      harmless: harmless ?? this.harmless,
      malicious: malicious ?? this.malicious,
    );
  }

  factory TotalVotes.fromJson(Map<String, dynamic> json) {
    return TotalVotes(
      harmless: json["harmless"] as int?,
      malicious: json["malicious"] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "harmless": harmless,
        "malicious": malicious,
      };
}

class Links {
  Links({
    required this.self,
  });

  final String? self;

  Links copyWith({
    String? self,
  }) {
    return Links(
      self: self ?? this.self,
    );
  }

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json["self"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}
