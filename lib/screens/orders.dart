class Orders {
  final int total;
  final int createdAt;
  Orders(this.total, this.createdAt);

  Orders.fromMap(Map<String, dynamic> map)
      : assert(map['total'] != null),
        assert(map['createdAt'] != null),
        total = map['total'],
        createdAt = map['createdAt'];

  @override
  String toString() => "Record<$total:$createdAt>";
}
