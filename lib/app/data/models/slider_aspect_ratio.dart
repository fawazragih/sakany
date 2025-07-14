class SliderAspectRatio {
  SliderAspectRatio({
    this.aspectRatio,
    this.urlHash,
  });

  double? aspectRatio;
  String? urlHash;

  SliderAspectRatio copyWith({
    double? aspectRatio,
    String? widgetZone,
    String? urlHash,
  }) =>
      SliderAspectRatio(
        aspectRatio: aspectRatio ?? this.aspectRatio,
        urlHash: urlHash ?? this.urlHash,
      );

  factory SliderAspectRatio.defaultData() {
    //TODO byMy set default data.
    return SliderAspectRatio();
  }

  factory SliderAspectRatio.fromJson(Map<String, dynamic> json) =>
      SliderAspectRatio(
        aspectRatio: json["aspectRatio"]?.toDouble(),
        urlHash: json["urlHash"],
      );

  Map<String, dynamic> toJson() => {
        "aspectRatio": aspectRatio,
        "urlHash": urlHash,
      };

  @override
  bool operator ==(Object other) {
    return other is SliderAspectRatio && urlHash == other.urlHash;
  }

  @override
  int get hashCode {
    super.hashCode;
    return (urlHash?.length ?? 0) * 21 + (urlHash?.length ?? 0);
  }
}
