class InsurancePolicyEntity{
  final String id;
  final String type; // 'auto', 'health', 'home', etc.
  final String insurerName;
  final DateTime expiryDate;
  final String userId;

  InsurancePolicyEntity(
      {required this.id, required this.type, required this.insurerName, required this.expiryDate, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'insurerName': insurerName,
      'expiryDate': expiryDate,
      'userId': userId,
    };
  }

  // Sobrescreve o operador == para comparar entidades por ID
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsurancePolicyEntity && other.id == id;
  }

  // Sobrescreve hashCode para consistência com o operador ==
  @override
  int get hashCode => id.hashCode;

  // Método toString para debug
  @override
  String toString() {
    return 'InsurancePolicyEntity(id: $id, type: $type, insurer: $insurerName, expiry: $expiryDate)';
  }
}
