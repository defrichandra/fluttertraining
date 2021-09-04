class Course {
  //null harus diganti dynamic
  //int merah di swagger harus berubah double di dart
  String createBy;
  String createOn;
  dynamic updateBy;
  dynamic updateOn;
  String activeFlag;

  int id;
  String courseCode;
  String courseName;
  int credits;
  String courseDesc;

  Course(
      {this.createBy,
      this.createOn,
      this.updateBy,
      this.updateOn,
      this.id,
      this.activeFlag,
      this.courseCode,
      this.courseName,
      this.credits,
      this.courseDesc});

  Course.fromJson(Map<String, dynamic> json) {
    activeFlag = json['activeFlag'];
    createBy = json['createBy'];
    createOn = json['createOn'];
    updateBy = json['updateBy'];
    updateOn = json['updateOn'];
    id = json['id'];
    courseCode = json['courseCode'];
    courseName = json['courseName'];
    credits = json['credits'];
    courseDesc = json['courseDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['activeFlag'] = this.activeFlag;
    // data['createBy'] = this.createBy;
    // data['createOn'] = this.createOn;
    // data['updateBy'] = this.updateBy;
    // data['updateOn'] = this.updateOn;
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['courseCode'] = this.courseCode;
    data['courseName'] = this.courseName;
    data['credits'] = this.credits;
    data['courseDesc'] = this.courseDesc;
    return data;
  }
}
