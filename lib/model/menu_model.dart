class MenuModel {
  int? menuId;
  String? menuName;

  MenuModel({this.menuId, this.menuName});

  @override
  int get hashCode => menuName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModel &&
          runtimeType == other.runtimeType &&
          menuName == other.menuName;
}
