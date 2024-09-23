class ProductsTotalResponse {
  List<ProductModel>? products;
  int? offset;
  int? number;
  int? totalResults;

  ProductsTotalResponse(
      {this.products, this.offset, this.number, this.totalResults});

  ProductsTotalResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      products = <ProductModel>[];
      json['results'].forEach((v) {
        products?.add(new ProductModel.fromJson(v));
      });
    }
    offset = json['offset'];
    number = json['number'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.products != null) {
      data['results'] = this.products?.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['number'] = this.number;
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class ProductModel {
  int? id;
  String? title;
  String? image;
  String? imageType;

  ProductModel({this.id, this.title, this.image, this.imageType,});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['imageType'] = this.imageType;
    return data;
  }
}
