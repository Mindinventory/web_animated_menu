class Menu {
  int? headerId;
  String? headerName;

  Menu({this.headerId, this.headerName});

  @override
  int get hashCode => headerName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Menu &&
          runtimeType == other.runtimeType &&
          headerName == other.headerName;
}
