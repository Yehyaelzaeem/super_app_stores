class BankAccountBody{
  final String? holderName;
  final String? bankName;
  final String? accountNumber;
  final String? bankBranch;
  final String? iban;

  BankAccountBody(
      {required this.holderName,
        required this.bankName,
        required this.accountNumber,
        required this.bankBranch,
        required this.iban});

  Map<String, dynamic> toJson() {
    return {
      "holder_name": holderName,
      "bank_name": bankName,
      "account_number": accountNumber,
      "bank_branch": bankBranch,
      "iban": iban,
    };
  }
}