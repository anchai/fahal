class UserModel {
  var id;
  var user;
  var name;
  var password;
  var chooseType;

  UserModel({this.id, this.user, this.name, this.password, this.chooseType});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['User'];
    name = json['Name'];
    password = json['Password'];
    chooseType = json['ChooseType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['User'] = this.user;
    data['Name'] = this.name;
    data['Password'] = this.password;
    data['ChooseType'] = this.chooseType;
    return data;
  }
}
