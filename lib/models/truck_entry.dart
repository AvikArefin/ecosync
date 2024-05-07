class Truck {
  final int no;
  final int type;
  final String reg;
  Truck(this.no, this.type, this.reg);

  factory Truck.fromJson(dynamic json) {
    return Truck(json['id'] as int, json['vehicle_type'] as int, json['registration_number'] as String);
  }

  @override
  String toString() {
    return '{ ${no}, ${type} ${reg} }';
  }
}