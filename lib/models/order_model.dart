class OrderModel {
  String orderName = '';
  String dateOrder = '';
  String dateRequiredToSite = '';
  String orderNote = '';
  String jobId = '';
  String id = '';

  OrderModel(
      {this.orderName = '',
        this.dateOrder = '',
        this.dateRequiredToSite = '',
        this.orderNote = '',
        this.jobId = '',
        this.id = ''});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderName = json['orderName'];
    dateOrder = json['dateOrder'];
    dateRequiredToSite = json['dateRequiredToSite'];
    orderNote = json['orderNote'];
    jobId = json['jobId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderName'] = this.orderName;
    data['dateOrder'] = this.dateOrder;
    data['dateRequiredToSite'] = this.dateRequiredToSite;
    data['orderNote'] = this.orderNote;
    data['jobId'] = this.jobId;
    data['id'] = this.id;
    return data;
  }
}