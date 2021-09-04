class CreateUserModel {
  String name;
  String job;
  String id;
  String createdAt;
  String date;
  DateTime birthDate;

  CreateUserModel(
      {this.name,
      this.job,
      this.id,
      this.createdAt,
      this.date,
      this.birthDate});

  //method untuk menerima  data dari API ke model
  CreateUserModel.map(Map<String, dynamic> obj) {
    name = obj['name'];
    job = obj['job'];
    id = obj['id'];
    createdAt = obj['createdAt'];
    date = obj['date'];
    birthDate = obj['birthDate'];
  }

  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> data = {};
  //   data['name'] = this.name;
  //   data['job'] = this.job;
  //   data['id'] = this.id;
  //   data['createdAt'] = this.createdAt;
  //   data['date'] = this.date ?? "";
  //   data['birthDate'] = this.birthDate ?? "";
  //   return data;
  // }

  //method untuk membuat Map sebelum diencode menjadi JSON
  Map<String, String> toJson() {
    //Map<String, String> data = new Map<String, String>();
    Map<String, String> data = {};
    data['name'] = this.name ?? "";
    data['job'] = this.job ?? "";
    data['date'] = this.date ?? "";
    return data;
  }
}
