class CartModel {
  Data? data;
  String? message;
  int? status;

  CartModel({this.data, this.message, this.status});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = Data.fromJson(json['data'] as Map<String, dynamic>);
    } else {
      data = null;
    }
    message = json['message']?.toString();
    status = int.tryParse(json['status']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data!.toJson();
    }
    json['message'] = message;
    json['status'] = status;
    return json;
  }
}

class Data {
  int? id;
  User? user;
  String? total;
  List<CartItems>? cartItems;

  Data({this.id, this.user, this.total, this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    if (json['user'] != null && json['user'] is Map<String, dynamic>) {
      user = User.fromJson(json['user'] as Map<String, dynamic>);
    } else {
      user = null;
    }
    total = json['total']?.toString();
    if (json['cart_items'] != null && json['cart_items'] is List) {
      cartItems = <CartItems>[];
      for (final item in (json['cart_items'] as List)) {
        if (item is Map<String, dynamic>) {
          cartItems!.add(CartItems.fromJson(item));
        }
      }
    } else {
      cartItems = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    if (user != null) {
      json['user'] = user!.toJson();
    }
    json['total'] = total;
    if (cartItems != null) {
      json['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class User {
  int? userId;
  String? userName;

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    userId = int.tryParse(json['user_id']?.toString() ?? '');
    userName = json['user_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user_id'] = userId;
    json['user_name'] = userName;
    return json;
  }
}

class CartItems {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItems({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  CartItems.fromJson(Map<String, dynamic> json) {
    itemId = int.tryParse(json['item_id']?.toString() ?? '');
    itemProductId = int.tryParse(json['item_product_id']?.toString() ?? '');
    itemProductName = json['item_product_name']?.toString();
    itemProductImage = json['item_product_image']?.toString();
    itemProductPrice = json['item_product_price']?.toString();
    itemProductDiscount =
        int.tryParse(json['item_product_discount']?.toString() ?? '');
    itemProductPriceAfterDiscount = double.tryParse(
      json['item_product_price_after_discount']?.toString() ?? '',
    );
    itemProductStock =
        int.tryParse(json['item_product_stock']?.toString() ?? '');
    itemQuantity = int.tryParse(json['item_quantity']?.toString() ?? '');
    itemTotal = double.tryParse(json['item_total']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['item_id'] = itemId;
    json['item_product_id'] = itemProductId;
    json['item_product_name'] = itemProductName;
    json['item_product_image'] = itemProductImage;
    json['item_product_price'] = itemProductPrice;
    json['item_product_discount'] = itemProductDiscount;
    json['item_product_price_after_discount'] = itemProductPriceAfterDiscount;
    json['item_product_stock'] = itemProductStock;
    json['item_quantity'] = itemQuantity;
    json['item_total'] = itemTotal;
    return json;
  }
}
