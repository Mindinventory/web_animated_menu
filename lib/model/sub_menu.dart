class SubMenu {
  int? id;
  String? name;

  SubMenu({this.id, this.name});

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubMenu &&
          runtimeType == other.runtimeType &&
          name == other.name;
}
