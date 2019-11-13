class CategoryBigModel {
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDtoModel> bxMallSubDto;
  Null comments;
  String image;

  CategoryBigModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comments,
      this.image});

  CategoryBigModel.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDtoModel>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDtoModel.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class BxMallSubDtoModel {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDtoModel(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDtoModel.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;

  CategoryBigListModel(this.data);

  factory CategoryBigListModel.fromJson(List json) {
    return CategoryBigListModel(
      json.map((i)=>CategoryBigModel.fromJson(i)).toList()
    );
  }
}