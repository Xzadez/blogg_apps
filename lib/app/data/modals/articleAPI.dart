class ArticlesApi {
  List<Datum>? data;

  ArticlesApi({
    this.data,
  });

  factory ArticlesApi.fromJson(Map<String, dynamic> json) => ArticlesApi(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  int? id;
  String? apiModel;
  String? apiLink;
  String? title;
  int? dateStart;
  int? dateEnd;
  String? dateDisplay;
  String? artistDisplay;
  String? placeOfOrigin;
  String? description;
  String? shortDescription;
  String? mediumDisplay;
  String? creditLine;
  int? artistId;
  String? artistTitle;
  String? imageId;

  Datum({
    this.id,
    this.title,
    this.dateStart,
    this.dateEnd,
    this.dateDisplay,
    this.artistDisplay,
    this.placeOfOrigin,
    this.description,
    this.shortDescription,
    this.mediumDisplay,
    this.creditLine,
    this.artistId,
    this.imageId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        dateDisplay: json["date_display"],
        artistDisplay: json["artist_display"],
        placeOfOrigin: json["place_of_origin"],
        description: json["description"],
        shortDescription: json["short_description"],
        mediumDisplay: json["medium_display"],
        creditLine: json["credit_line"],
        artistId: json["artist_id"],
        imageId: json["image_id"],
      );

  String getImageUrl() {
    if (imageId == null) {
      return '';
    }
    return 'https://www.artic.edu/iiif/2/$imageId/full/200,/0/default.jpg';
  }

  String getWebUrl() {
    return 'https://www.artic.edu/artworks/$id';
  }
}
