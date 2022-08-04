class SubMenu {
  int? menuId;
  String? menuName;

  SubMenu({this.menuId, this.menuName});

  @override
  int get hashCode => menuName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubMenu &&
          runtimeType == other.runtimeType &&
          menuName == other.menuName;
}
