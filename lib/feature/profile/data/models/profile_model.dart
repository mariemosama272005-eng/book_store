class ProfileModel {
  Data? data;
  String? message;
  
  int? status;

  ProfileModel({this.data, this.message,  this.status});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
   
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
   
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  Null? address;
  Null? city;
  Null? phone;
  bool? emailVerified;
  String? image;

  Data(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.city,
      this.phone,
      this.emailVerified,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email_verified'] = this.emailVerified;
    data['image'] = this.image;
    return data;
  }
}