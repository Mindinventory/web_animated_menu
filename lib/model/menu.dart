class Menu {
  int? id;
  String? name;

  Menu({this.id, this.name});

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Menu &&
          runtimeType == other.runtimeType &&
          name == other.name;
}
