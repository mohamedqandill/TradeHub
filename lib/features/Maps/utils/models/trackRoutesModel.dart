class TrackRoutesModel {
  TrackRoutesModel({
    this.type,
    this.bbox,
    this.features,
    this.metadata,
  });

  TrackRoutesModel.fromJson(dynamic json) {
    type = json['type'];
    bbox = json['bbox'] != null ? json['bbox'].cast<double>() : [];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(FeaturesRoutes.fromJson(v));
      });
    }
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  String? type;
  List<double>? bbox;
  List<FeaturesRoutes>? features;
  Metadata? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['bbox'] = bbox;
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    return map;
  }
}

class Metadata {
  Metadata({
    this.attribution,
    this.service,
    this.timestamp,
    this.query,
    this.engine,
  });

  Metadata.fromJson(dynamic json) {
    attribution = json['attribution'];
    service = json['service'];
    timestamp = json['timestamp'];
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
    engine = json['engine'] != null ? Engine.fromJson(json['engine']) : null;
  }
  String? attribution;
  String? service;
  int? timestamp;
  Query? query;
  Engine? engine;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribution'] = attribution;
    map['service'] = service;
    map['timestamp'] = timestamp;
    if (query != null) {
      map['query'] = query?.toJson();
    }
    if (engine != null) {
      map['engine'] = engine?.toJson();
    }
    return map;
  }
}

class Engine {
  Engine({
    this.version,
    this.buildDate,
    this.graphDate,
    this.osmDate,
  });

  Engine.fromJson(dynamic json) {
    version = json['version'];
    buildDate = json['build_date'];
    graphDate = json['graph_date'];
    osmDate = json['osm_date'];
  }
  String? version;
  String? buildDate;
  String? graphDate;
  String? osmDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['build_date'] = buildDate;
    map['graph_date'] = graphDate;
    map['osm_date'] = osmDate;
    return map;
  }
}

class Query {
  Query({
    this.coordinates,
    this.profile,
    this.profileName,
    this.format,
  });

  Query.fromJson(dynamic json) {
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    profile = json['profile'];
    profileName = json['profileName'];
    format = json['format'];
  }
  List<List<double>>? coordinates;
  String? profile;
  String? profileName;
  String? format;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['profile'] = profile;
    map['profileName'] = profileName;
    map['format'] = format;
    return map;
  }
}

class FeaturesRoutes {
  FeaturesRoutes({
    this.bbox,
    this.type,
    this.properties,
    this.geometry,
  });

  FeaturesRoutes.fromJson(dynamic json) {
    bbox = json['bbox'] != null ? json['bbox'].cast<double>() : [];
    type = json['type'];
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }
  List<double>? bbox;
  String? type;
  Properties? properties;
  Geometry? geometry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bbox'] = bbox;
    map['type'] = type;
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }
}

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  Geometry.fromJson(dynamic json) {
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    type = json['type'];
  }
  List<List<double>>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }
}

class Properties {
  Properties({
    this.segments,
    this.wayPoints,
    this.summary,
  });

  Properties.fromJson(dynamic json) {
    if (json['segments'] != null) {
      segments = [];
      json['segments'].forEach((v) {
        segments?.add(Segments.fromJson(v));
      });
    }
    wayPoints =
        json['way_points'] != null ? json['way_points'].cast<int>() : [];
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }
  List<Segments>? segments;
  List<int>? wayPoints;
  Summary? summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (segments != null) {
      map['segments'] = segments?.map((v) => v.toJson()).toList();
    }
    map['way_points'] = wayPoints;
    if (summary != null) {
      map['summary'] = summary?.toJson();
    }
    return map;
  }
}

class Summary {
  Summary({
    this.distance,
    this.duration,
  });

  Summary.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
  }
  double? distance;
  double? duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    return map;
  }
}

class Segments {
  Segments({
    this.distance,
    this.duration,
    this.steps,
  });

  Segments.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
    if (json['steps'] != null) {
      steps = [];
      json['steps'].forEach((v) {
        steps?.add(Steps.fromJson(v));
      });
    }
  }
  double? distance;
  double? duration;
  List<Steps>? steps;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    if (steps != null) {
      map['steps'] = steps?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Steps {
  Steps({
    this.distance,
    this.duration,
    this.type,
    this.instruction,
    this.name,
    this.wayPoints,
  });

  Steps.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
    type = json['type'];
    instruction = json['instruction'];
    name = json['name'];
    wayPoints =
        json['way_points'] != null ? json['way_points'].cast<int>() : [];
  }
  double? distance;
  double? duration;
  int? type;
  String? instruction;
  String? name;
  List<int>? wayPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    map['type'] = type;
    map['instruction'] = instruction;
    map['name'] = name;
    map['way_points'] = wayPoints;
    return map;
  }
}
