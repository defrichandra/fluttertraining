class Project {
  String createBy;
  String createOn;
  dynamic updateBy;
  dynamic updateOn;
  int id;
  String projectCd;
  String projectName;

  Project(
      {this.createBy,
      this.createOn,
      this.updateBy,
      this.updateOn,
      this.id,
      this.projectCd,
      this.projectName});

  Project.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];
    createOn = json['createOn'];
    updateBy = json['updateBy'];
    updateOn = json['updateOn'];
    id = json['id'];
    projectCd = json['projectCd'];
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy;
    data['createOn'] = this.createOn;
    data['updateBy'] = this.updateBy;
    data['updateOn'] = this.updateOn;
    data['id'] = this.id;
    data['projectCd'] = this.projectCd;
    data['projectName'] = this.projectName;
    return data;
  }
}
