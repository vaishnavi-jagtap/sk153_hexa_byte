class StateModel {
  String state;
  List<String> district;

  StateModel({this.state, this.district});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    district = json['district'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['district'] = this.district;
    return data;
  }
}
