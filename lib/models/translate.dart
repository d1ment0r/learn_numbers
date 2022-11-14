class Translate {
  late int id;
  late String result;

  Translate(this.id, this.result);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['result'] = result;
    return map;
  }

  Translate.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    result = map['result'];
  }
}
