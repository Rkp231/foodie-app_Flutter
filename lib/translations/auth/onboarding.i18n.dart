import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Order from great food vendors/restaurants near you\n🚀🚀",
        "fr":
            "Commandez auprès de grands vendeurs / restaurants près de chez vous \ n🚀🚀",
        "es":
            "Ordene de excelentes vendedores de comida / restaurantes cerca de usted \ n🚀🚀",
        "de":
            "Bestellen Sie bei großartigen Lebensmittelhändlern / Restaurants in Ihrer Nähe \ n🚀🚀",
        "pt":
            "Faça pedidos de ótimos restaurantes / vendedores de comida perto de você \ n🚀🚀",
        "ar": "اطلب من بائعي الأطعمة / المطاعم الرائعة القريبة منك \ n🚀🚀",
        "ko": "가까운 음식점 / 레스토랑에서 주문하세요 \ n🚀🚀"
      } +
      {
        "en": "Vendors/Restaurants",
        "fr": "Vendeurs / Restaurants",
        "es": "Vendedores / Restaurantes",
        "de": "Anbieter / Restaurants",
        "pt": "Vendedores / Restaurantes",
        "ar": "الباعة / المطاعم",
        "ko": "벤더 / 레스토랑"
      } +
      {
        "en": "Get a fast and safe delivery option",
        "fr": "Obtenez une option de livraison rapide et sûre",
        "es": "Obtenga una opción de entrega rápida y segura",
        "de": "Erhalten Sie eine schnelle und sichere Lieferoption",
        "pt": "Obtenha uma opção de entrega rápida e segura",
        "ar": "احصل على خيار تسليم سريع وآمن",
        "ko": "빠르고 안전한 배송 옵션을 받으세요"
      } +
      {
        "en": "Delivery",
        "fr": "Livraison",
        "es": "Entrega",
        "de": "Lieferung",
        "pt": "Entrega",
        "ar": "توصيل",
        "ko": "배달"
      } +
      {
        "en":
            "Get amazing food offers, from various vendors/restaurants near you",
        "fr":
            "Obtenez des offres alimentaires incroyables, de divers vendeurs / restaurants près de chez vous",
        "es":
            "Obtenga increíbles ofertas de comida, de varios vendedores / restaurantes cerca de usted.",
        "de":
            "Holen Sie sich tolle Essensangebote von verschiedenen Anbietern / Restaurants in Ihrer Nähe",
        "pt":
            "Obtenha ofertas incríveis de comida, de vários fornecedores / restaurantes perto de você",
        "ar":
            "احصل على عروض طعام مذهلة من مختلف البائعين / المطاعم القريبة منك",
        "ko": "가까운 다양한 공급 업체 / 레스토랑에서 놀라운 음식을 제공합니다."
      } +
      {
        "en": "Offers",
        "fr": "Des offres",
        "es": "Ofertas",
        "de": "Bietet an",
        "pt": "Ofertas",
        "ar": "عروض",
        "ko": "제안"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
