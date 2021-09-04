class Rddp {
  DateTime asaRcvDueDt;
  DateTime dcsRcvDueDt;
  String designerName;
  String eciNo;
  int id;
  String rddpDocName;
  DateTime rddpDt;
  List<RddpList> rddpList;
  String rddpNo;
  DateTime supRcvDt;
  DateTime suppSendDt;

  //tabel appSetting
  String threeD;
  String issuedBy;
  String dcsDoc;
  String rdddpType;
  String docFormat;

  //tabel lain
  // int carFamilyId;
  // int supplierId;
  // int designId;
  // int projectId;

  String carFamilyId;
  String supplierId;
  String designId;
  String projectId;
  String projectCode;

  Rddp(
      {this.asaRcvDueDt,
      this.carFamilyId,
      this.dcsDoc,
      this.dcsRcvDueDt,
      this.designId,
      this.designerName,
      this.docFormat,
      this.eciNo,
      this.id,
      this.issuedBy,
      this.projectCode,
      this.projectId,
      this.rdddpType,
      this.rddpDocName,
      this.rddpDt,
      this.rddpList,
      this.rddpNo,
      this.supRcvDt,
      this.suppSendDt,
      this.supplierId,
      this.threeD});

  Rddp.fromJson(Map<String, dynamic> json) {
    asaRcvDueDt = json['asaRcvDueDt'];
    carFamilyId = json['carFamilyId'];
    dcsDoc = json['dcsDoc'];
    dcsRcvDueDt = json['dcsRcvDueDt'];
    designId = json['designId'];
    designerName = json['designerName'];
    docFormat = json['docFormat'];
    eciNo = json['eciNo'];
    id = json['id'];
    issuedBy = json['issuedBy'];
    projectCode = json['projectCode'];
    projectId = json['projectId'];
    rdddpType = json['rdddpType'];
    rddpDocName = json['rddpDocName'];
    rddpDt = json['rddpDt'];
    if (json['rddpList'] != null) {
      rddpList = new List<RddpList>();
      json['rddpList'].forEach((v) {
        rddpList.add(new RddpList.fromJson(v));
      });
    }
    rddpNo = json['rddpNo'];
    supRcvDt = json['supRcvDt'];
    suppSendDt = json['suppSendDt'];
    supplierId = json['supplierId'];
    threeD = json['threeD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asaRcvDueDt'] = this.asaRcvDueDt;
    data['carFamilyId'] = this.carFamilyId;
    data['dcsDoc'] = this.dcsDoc;
    data['dcsRcvDueDt'] = this.dcsRcvDueDt;
    data['designId'] = this.designId;
    data['designerName'] = this.designerName;
    data['docFormat'] = this.docFormat;
    data['eciNo'] = this.eciNo;
    data['id'] = this.id;
    data['issuedBy'] = this.issuedBy;
    data['projectCode'] = this.projectCode;
    data['projectId'] = this.projectId;
    data['rdddpType'] = this.rdddpType;
    data['rddpDocName'] = this.rddpDocName;
    data['rddpDt'] = this.rddpDt;
    if (this.rddpList != null) {
      data['rddpList'] = this.rddpList.map((v) => v.toJson()).toList();
    }
    data['rddpNo'] = this.rddpNo;
    data['supRcvDt'] = this.supRcvDt;
    data['suppSendDt'] = this.suppSendDt;
    data['supplierId'] = this.supplierId;
    data['threeD'] = this.threeD;
    return data;
  }
}

class RddpList {
  RddpList.fromJson(Map<String, dynamic> json); //{}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
