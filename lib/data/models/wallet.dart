import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    Wallet({
        this.id,
        this.balance,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.formattedUpdatedAt,
    });

    int id;
    double balance;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    String formattedUpdatedAt;

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        balance: json["balance"].toDouble(),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formattedUpdatedAt: json["formatted_updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_updated_at": formattedUpdatedAt,
    };
}
