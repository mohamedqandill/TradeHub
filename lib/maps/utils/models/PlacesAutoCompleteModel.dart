class PlacesAutoCompleteModel {
  PlacesAutoCompleteModel({
    this.geocoding,
    this.type,
    this.features,
    this.bbox,
  });

  PlacesAutoCompleteModel.fromJson(dynamic json) {
    geocoding = json['geocoding'] != null
        ? Geocoding.fromJson(json['geocoding'])
        : null;
    type = json['type'];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(Features.fromJson(v));
      });
    }
    bbox = json['bbox'] != null ? json['bbox'].cast<double>() : [];
  }
  Geocoding? geocoding;
  String? type;
  List<Features>? features;
  List<double>? bbox;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (geocoding != null) {
      map['geocoding'] = geocoding?.toJson();
    }
    map['type'] = type;
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    map['bbox'] = bbox;
    return map;
  }
}

class Features {
  Features({
    this.type,
    this.geometry,
    this.properties,
  });

  Features.fromJson(dynamic json) {
    type = json['type'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }
  String? type;
  Geometry? geometry;
  Properties? properties;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    return map;
  }
}

class Properties {
  Properties({
    this.id,
    this.gid,
    this.layer,
    this.source,
    this.sourceId,
    this.name,
    this.accuracy,
    this.country,
    this.countryGid,
    this.countryA,
    this.continent,
    this.continentGid,
    this.label,
    this.addendum,
  });

  Properties.fromJson(dynamic json) {
    id = json['id'];
    gid = json['gid'];
    layer = json['layer'];
    source = json['source'];
    sourceId = json['source_id'];
    name = json['name'];
    accuracy = json['accuracy'];
    country = json['country'];
    countryGid = json['country_gid'];
    countryA = json['country_a'];
    continent = json['continent'];
    continentGid = json['continent_gid'];
    label = json['label'];
    addendum =
        json['addendum'] != null ? Addendum.fromJson(json['addendum']) : null;
  }
  String? id;
  String? gid;
  String? layer;
  String? source;
  String? sourceId;
  String? name;
  String? accuracy;
  String? country;
  String? countryGid;
  String? countryA;
  String? continent;
  String? continentGid;
  String? label;
  Addendum? addendum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gid'] = gid;
    map['layer'] = layer;
    map['source'] = source;
    map['source_id'] = sourceId;
    map['name'] = name;
    map['accuracy'] = accuracy;
    map['country'] = country;
    map['country_gid'] = countryGid;
    map['country_a'] = countryA;
    map['continent'] = continent;
    map['continent_gid'] = continentGid;
    map['label'] = label;
    if (addendum != null) {
      map['addendum'] = addendum?.toJson();
    }
    return map;
  }
}

class Addendum {
  Addendum({
    this.geonames,
  });

  Addendum.fromJson(dynamic json) {
    geonames =
        json['geonames'] != null ? Geonames.fromJson(json['geonames']) : null;
  }
  Geonames? geonames;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (geonames != null) {
      map['geonames'] = geonames?.toJson();
    }
    return map;
  }
}

class Geonames {
  Geonames({
    this.featureCode,
  });

  Geonames.fromJson(dynamic json) {
    featureCode = json['feature_code'];
  }
  String? featureCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feature_code'] = featureCode;
    return map;
  }
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  Geometry.fromJson(dynamic json) {
    type = json['type'];
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
  }
  String? type;
  List<double>? coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['coordinates'] = coordinates;
    return map;
  }
}

class Geocoding {
  Geocoding({
    this.version,
    this.attribution,
    this.query,
    this.warnings,
    this.engine,
    this.timestamp,
  });

  Geocoding.fromJson(dynamic json) {
    version = json['version'];
    attribution = json['attribution'];
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
    warnings = json['warnings'] != null ? json['warnings'].cast<String>() : [];
    engine = json['engine'] != null ? Engine.fromJson(json['engine']) : null;
    timestamp = json['timestamp'];
  }
  String? version;
  String? attribution;
  Query? query;
  List<String>? warnings;
  Engine? engine;
  int? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['attribution'] = attribution;
    if (query != null) {
      map['query'] = query?.toJson();
    }
    map['warnings'] = warnings;
    if (engine != null) {
      map['engine'] = engine?.toJson();
    }
    map['timestamp'] = timestamp;
    return map;
  }
}

class Engine {
  Engine({
    this.name,
    this.author,
    this.version,
  });

  Engine.fromJson(dynamic json) {
    name = json['name'];
    author = json['author'];
    version = json['version'];
  }
  String? name;
  String? author;
  String? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['author'] = author;
    map['version'] = version;
    return map;
  }
}

class Query {
  Query({
    this.text,
    this.parser,
    this.parsedText,
    this.size,
    this.layers,
    this.private,
    this.lang,
    this.querySize,
  });

  Query.fromJson(dynamic json) {
    text = json['text'];
    parser = json['parser'];
    parsedText = json['parsed_text'] != null
        ? ParsedText.fromJson(json['parsed_text'])
        : null;
    size = json['size'];
    layers = json['layers'] != null ? json['layers'].cast<String>() : [];
    private = json['private'];
    lang = json['lang'] != null ? Lang.fromJson(json['lang']) : null;
    querySize = json['querySize'];
  }
  String? text;
  String? parser;
  ParsedText? parsedText;
  int? size;
  List<String>? layers;
  bool? private;
  Lang? lang;
  int? querySize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['parser'] = parser;
    if (parsedText != null) {
      map['parsed_text'] = parsedText?.toJson();
    }
    map['size'] = size;
    map['layers'] = layers;
    map['private'] = private;
    if (lang != null) {
      map['lang'] = lang?.toJson();
    }
    map['querySize'] = querySize;
    return map;
  }
}

class Lang {
  Lang({
    this.name,
    this.iso6391,
    this.iso6393,
    this.via,
    this.defaulted,
  });

  Lang.fromJson(dynamic json) {
    name = json['name'];
    iso6391 = json['iso6391'];
    iso6393 = json['iso6393'];
    via = json['via'];
    defaulted = json['defaulted'];
  }
  String? name;
  String? iso6391;
  String? iso6393;
  String? via;
  bool? defaulted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['iso6391'] = iso6391;
    map['iso6393'] = iso6393;
    map['via'] = via;
    map['defaulted'] = defaulted;
    return map;
  }
}

class ParsedText {
  ParsedText({
    this.subject,
    this.locality,
  });

  ParsedText.fromJson(dynamic json) {
    subject = json['subject'];
    locality = json['locality'];
  }
  String? subject;
  String? locality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject'] = subject;
    map['locality'] = locality;
    return map;
  }
}
