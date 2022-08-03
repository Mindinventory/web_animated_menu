class HeaderModel {
  int? headerId;
  String? headerName;

  HeaderModel({this.headerId, this.headerName});

  @override
  int get hashCode => headerName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeaderModel &&
          runtimeType == other.runtimeType &&
          headerName == other.headerName;
}
