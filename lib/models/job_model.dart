class JobModel {
  String address = '';
  String jobName = '';
  String siteContactName = '';
  String siteContactNumber = '';
  String siteNote = '';
  String id = '';

  JobModel(
      {this.address = '',
        this.jobName = '',
        this.siteContactName = '',
        this.siteContactNumber = '',
        this.siteNote = '',
        this.id = ''});

  JobModel.fromJson(Map<String, dynamic> json) {
    address = json['address'] ?? '';
    jobName = json['jobName'] ?? '';
    siteContactName = json['siteContactName'] ?? '';
    siteContactNumber = json['siteContactNumber'] ?? '';
    siteNote = json['siteNote'] ?? '';
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['jobName'] = this.jobName;
    data['siteContactName'] = this.siteContactName;
    data['siteContactNumber'] = this.siteContactNumber;
    data['siteNote'] = this.siteNote;
    data['id'] = this.id;
    return data;
  }
}