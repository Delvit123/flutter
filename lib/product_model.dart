class ProductModel {
  int? id;
  String? Judul, Catatan, createdAt, updatedAt;

  //contructor
  ProductModel(
      {this.id, this.Judul, this.Catatan, this.createdAt, this.updatedAt});

  //fuctory json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        Judul: json['Judul'],
        Catatan: json['Catatan'],
        createdAt: json['created_At'],
        updatedAt: json['updated_At']);
  }
}
