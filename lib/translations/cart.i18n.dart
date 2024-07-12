import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "My Cart",
        "fr": "Mon panier",
        "es": "Mi carrito",
        "de": "Mein Warenkorb",
        "pt": "Meu carrinho",
        "ar": "عربة التسوق الخاصة بي",
        "ko": "내 카트"
      } +
      {
        "en": "Oops! Your cart is empty",
        "fr": "Oops! Votre panier est vide",
        "es": "¡UPS! Tu carrito esta vacío",
        "de": "Hoppla! Ihr Warenkorb ist leer",
        "pt": "Ups! Seu carrinho está vazio",
        "ar": "وجه الفتاة! عربة التسوق فارغة",
        "ko": "이런! 장바구니가 비어 있습니다"
      } +
      {
        "en": "Looks like you haven't added anything to your cart yet",
        "fr": "Il semble que vous n’avez encore rien ajouté à votre panier",
        "es": "Parece que aún no ha agregado nada a su carrito",
        "de":
            "Sieht so aus, als hätten Sie noch nichts in Ihren Warenkorb gelegt",
        "pt": "Parece que você ainda não adicionou nada ao carrinho",
        "ar": "يبدو أنك لم تقم بإضافة أي شيء إلى سلة التسوق الخاصة بك حتى الآن",
        "ko": "장바구니에 아직 아무것도 추가하지 않은 것 같습니다."
      } +
      {
        "en": "Check out",
        "fr": "Vérifier",
        "es": "Revisa",
        "de": "Überprüfen",
        "pt": "Verificação de saída",
        "ar": "الدفع",
        "ko": "체크 아웃"
      } +
      {
        "en": "Remove",
        "fr": "Supprimer",
        "es": "Eliminar",
        "de": "Entfernen",
        "pt": "Remover",
        "ar": "يزيل",
        "ko": "없애다"
      } +
      {
        "en": "Subtotal",
        "fr": "Total",
        "es": "Total parcial",
        "de": "Zwischensumme",
        "pt": "Subtotal",
        "ar": "المجموع الفرعي",
        "ko": "소계"
      } +
      {
        "en": "Delivery Fee",
        "fr": "Frais de livraison",
        "es": "Tarifa de entrega",
        "de": "Liefergebühr",
        "pt": "Taxa de Delivery",
        "ar": "رسوم التسليم",
        "ko": "배송비"
      } +
      {
        "en": "Discount",
        "fr": "Remise",
        "es": "Descuento",
        "de": "Rabatt",
        "pt": "Desconto",
        "ar": "خصم",
        "ko": "할인"
      } +
      {
        "en": "Total",
        "fr": "Le total",
        "es": "Total",
        "de": "Gesamt",
        "pt": "Total",
        "ar": "مجموع",
        "ko": "합계"
      } +
      {
        "en": "Coupon Code",
        "fr": "Code de coupon",
        "es": "Código promocional",
        "de": "Gutscheincode",
        "pt": "Código do cupom",
        "ar": "رمز الكوبون",
        "ko": "쿠폰 코드"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
