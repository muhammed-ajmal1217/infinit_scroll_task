class DataModel {
  int? id;
  int? languageId;
  String? title;
  String? titleSlug;
  String? keyWord;
  String? summary;
  String? content;
  int? categoryId;
  String? imageBig;
  String? imageDefault;
  String? imageSlider;
  String? imageMid;
  String? imageSmall;
  int? pageviews;
  String? imageDescription;

  DataModel({
    this.id,
    this.languageId,
    this.title,
    this.titleSlug,
    this.keyWord,
    this.summary,
    this.content,
    this.categoryId,
    this.imageBig,
    this.imageDefault,
    this.imageSlider,
    this.imageMid,
    this.imageSmall,
    this.pageviews,
    this.imageDescription,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      languageId: json['lang_id'],
      title: json['title'],
      titleSlug: json['title_slug'],
      keyWord: json['keywords'],
      summary: json['summary'],
      content: json['content'],
      categoryId: json['category_id'],
      imageBig: json['image_big'],
      imageDefault: json['image_default'],
      imageSlider: json['image_slider'],
      imageMid: json['image_mid'],
      imageSmall: json['image_small'],
      pageviews: json['pageviews'],
      imageDescription: json['image_description'],
    );
  }
}
