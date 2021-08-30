class MemberModel {
  String id = '';
  String jobId = '';
  String memberName = '';
  String orderId = '';
  String quantity = '';
  String reoSize = '';
  String treatment = '';

  MemberModel(
      {this.id = '',
        this.jobId = '',
        this.memberName = '',
        this.orderId = '',
        this.quantity = '',
        this.reoSize = '',
        this.treatment = ''});

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    memberName = json['memberName'];
    orderId = json['orderId'];
    quantity = json['quantity'];
    reoSize = json['reoSize'];
    treatment = json['treatment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['memberName'] = this.memberName;
    data['orderId'] = this.orderId;
    data['quantity'] = this.quantity;
    data['reoSize'] = this.reoSize;
    data['treatment'] = this.treatment;
    return data;
  }
}