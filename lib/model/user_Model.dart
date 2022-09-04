class UserModel {
  var id;
  var user;
  var name;
  var password;
  var chooseType;
  var nameShop;
  var address;
  var phone;
  var urlPicture;
  var lat;
  var lng;
  var token;

  UserModel(
      {this.id,
      this.user,
      this.name,
      this.password,
      this.chooseType,
      this.nameShop,
      this.address,
      this.phone,
      this.urlPicture,
      this.lat,
      this.lng,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['User'];
    name = json['Name'];
    password = json['Password'];
    chooseType = json['ChooseType'];
    nameShop = json['NameShop'];
    address = json['Address'];
    phone = json['Phone'];
    urlPicture = json['UrlPicture'];
    lat = json['Lat'];
    lng = json['Lng'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['User'] = this.user;
    data['Name'] = this.name;
    data['Password'] = this.password;
    data['ChooseType'] = this.chooseType;
    data['NameShop'] = this.nameShop;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['UrlPicture'] = this.urlPicture;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['Token'] = this.token;
    return data;
  }
}
