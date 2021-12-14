class Weather {
  String product;
  String init;
  List<Dataseries> dataseries;

  Weather({this.product, this.init, this.dataseries});

  Weather.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    init = json['init'];
    if (json['dataseries'] != null) {
      dataseries = [];
      json['dataseries'].forEach((v) {
        dataseries.add(new Dataseries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['init'] = this.init;
    if (this.dataseries != null) {
      data['dataseries'] = this.dataseries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dataseries {
  int timepoint;
  int cloudcover;
  int seeing;
  int transparency;
  int liftedIndex;
  int rh2m;
  Wind10m wind10m;
  int temp2m;
  String precType;

  Dataseries({this.timepoint, this.cloudcover, this.seeing, this.transparency, this.liftedIndex, this.rh2m, this.wind10m, this.temp2m, this.precType});

  Dataseries.fromJson(Map<String, dynamic> json) {
    timepoint = json['timepoint'];
    cloudcover = json['cloudcover'];
    seeing = json['seeing'];
    transparency = json['transparency'];
    liftedIndex = json['lifted_index'];
    rh2m = json['rh2m'];
    wind10m = json['wind10m'] != null ? new Wind10m.fromJson(json['wind10m']) : null;
    temp2m = json['temp2m'];
    precType = json['prec_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timepoint'] = this.timepoint;
    data['cloudcover'] = this.cloudcover;
    data['seeing'] = this.seeing;
    data['transparency'] = this.transparency;
    data['lifted_index'] = this.liftedIndex;
    data['rh2m'] = this.rh2m;
    if (this.wind10m != null) {
      data['wind10m'] = this.wind10m.toJson();
    }
    data['temp2m'] = this.temp2m;
    data['prec_type'] = this.precType;
    return data;
  }

  getCloudCover() {
    return _cloudMap[cloudcover];
  }

  Map<int, String> _cloudMap = {
    1: '0%-6%',
    2: '6%-19%',
    3: '19%-31%',
    4: '31%-44%',
    5: '44%-56%',
    6: '56%-69%',
    7: '69%-81%',
    8: '81%-94%',
    9: '94%-100%',
  };

  getSeeing() {
    return _seeingMap[seeing];
  }

  Map<int, String> _seeingMap = {
    1: '< 0.5',
    2: ' 0.5-0.75',
    3: '0.75-1',
    4: '1-1.25',
    5: '1.25-1.5',
    6: '1.5-2',
    7: ' 2-2.5',
    8: '> 2.5',
  };

  getHumidity() {
    return _humidityMap[rh2m];
  }

  Map<int, String> _humidityMap = {
    -4: '0%-5%',
    -3: '5%-10%',
    -2: '10%-15%',
    -1: '15%-20%',
    0: '20%-25%',
    1: '25%-30%',
    2: '30%-35%',
    3: '35%-40%',
    4: '40%-45%',
    5: '45%-50%',
    6: '50%-55%',
    7: '55%-60%',
    8: '60%-65%',
    9: '65%-70%',
    10: '70%-75%',
    11: '75%-80%',
    12: '80%-85%',
    13: '85%-90%',
    14: '90%-95%',
    15: '95%-99%',
    16: '100%',
  };

  getTransparency() {
    return _transparencyMap[transparency];
  }

  Map<int, String> _transparencyMap = {
    1: '<0.3',
    2: '0.3-0.4',
    3: '0.4-0.5',
    4: '0.5-0.6',
    5: '0.6-0.7',
    6: '0.7-0.85',
    7: '0.85-1',
    8: '>1',
  };

  getLiftedIndex() {
    return _liftedIndexMap[liftedIndex];
  }

  Map<int, String> _liftedIndexMap = {
    -10: 'Below -7',
    -6: '-7 to -5',
    -4: '-5 to -3',
    -1: '-3 to 0',
    2: '0 to 4',
    6: '4 to 8',
    10: '8 to 11',
    15: 'Over 11',
  };

  getWindSpeed() {
    return _windSpeedMap[wind10m.speed];
  }

  Map<int, String> _windSpeedMap = {
    1: 'Below 0.3m/s (calm)',
    2: '0.3-3.4m/s (light)',
    3: '3.4-8.0m/s (moderate)',
    4: '8.0-10.8m/s (fresh)',
    5: '10.8-17.2m/s (strong)',
    6: '17.2-24.5m/s (gale)',
    7: '24.5-32.6m/s (storm)',
    8: 'Over 32.6m/s (hurricane)',
  };
}

class Wind10m {
  String direction;
  int speed;

  Wind10m({this.direction, this.speed});

  Wind10m.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = this.direction;
    data['speed'] = this.speed;
    return data;
  }
}
