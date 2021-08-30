class SupplierModel {
  String contactNumber = '';
  String email = '';
  String id = '';
  String phoneNumber = '';
  String supplierName = '';

  SupplierModel(
      {this.contactNumber = '',
        this.email = '',
        this.id = '',
        this.phoneNumber = '',
        this.supplierName = ''});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    contactNumber = json['contactNumber'] ?? "";
    email = json['email'] ?? "";
    id = json['id'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    supplierName = json['supplierName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['supplierName'] = this.supplierName;
    return data;
  }
}