import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Add to cart",
        "fr": "Ajouter au panier",
        "es": "Añadir a la cesta",
        "de": "In den Warenkorb legen",
        "pt": "Adicionar ao Carrinho",
        "ar": "أضف إلى السلة",
        "ko": "장바구니에 담기"
      } +
      {
        "en": "Extras",
        "fr": "Suppléments",
        "es": "Extras",
        "de": "Extras",
        "pt": "Extras",
        "ar": "إضافات",
        "ko": "기타"
      } +
      {
        "en": "Quantity",
        "fr": "Quantité",
        "es": "Cantidad",
        "de": "Menge",
        "pt": "Quantidade",
        "ar": "كمية",
        "ko": "수량"
      } +
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
        "en": "No Extras available for selection",
        "fr": "Aucun extras disponible pour la sélection",
        "es": "No hay extras disponibles para seleccionar",
        "de": "Keine Extras zur Auswahl",
        "pt": "Não há extras disponíveis para seleção",
        "ar": "لا إضافات متاحة للاختيار",
        "ko": "선택 가능한 추가 항목 없음"
      } +
      {
        "en": "Reset Cart?",
        "fr": "Réinitialiser le panier?",
        "es": "¿Restablecer carrito?",
        "de": "Warenkorb zurücksetzen?",
        "pt": "Reiniciar carrinho?",
        "ar": "إعادة تعيين عربة التسوق؟",
        "ko": "장바구니를 재설정 하시겠습니까?"
      } +
      {
        "en":
            "You are about to add food from a different vendor/restaurant. Product(s) in cart will be cleard. Are you sure you want to continue?",
        "fr":
            "Vous êtes sur le point d'ajouter de la nourriture d'un autre vendeur / restaurant. Les produits dans le panier seront effacés. Es-tu sur de vouloir continuer?",
        "es":
            "Está a punto de agregar comida de un proveedor / restaurante diferente. Los productos en el carrito estarán limpios. Estás seguro de que quieres continuar?",
        "de":
            "Sie sind dabei, Lebensmittel von einem anderen Anbieter / Restaurant hinzuzufügen. Produkt (e) im Warenkorb werden gelöscht. Sind Sie sicher, dass Sie fortfahren wollen?",
        "pt":
            "Você está prestes a adicionar alimentos de um fornecedor / restaurante diferente. Os produtos no carrinho serão liberados. Você tem certeza que quer continuar?",
        "ar":
            "أنت على وشك إضافة طعام من بائع / مطعم مختلف. سيتم مسح المنتج (المنتجات) في سلة التسوق. هل أنت متأكد أنك تريد الاستمرار؟",
        "ko": "다른 공급 업체 / 레스토랑의 음식을 추가하려고합니다. 장바구니에 담긴 상품이 삭제됩니다. 너 정말 계속하고 싶니?"
      } +
      {
        "en": "Added To Cart",
        "fr": "Ajouté au panier",
        "es": "Agregado al carrito",
        "de": "In den Warenkorb gelegt",
        "pt": "Adicionado ao carrinho",
        "ar": "تمت الإضافة إلى عربة التسوق",
        "ko": "장바구니에 추가"
      } +
      {
        "en": "has been added to cart",
        "fr": "a été ajouté au panier",
        "es": "ha sido añadido al carrito",
        "de": "wurde in den Warenkorb gelegt",
        "pt": "foi adicionado ao carrinho",
        "ar": "تمت إضافته إلى عربة التسوق",
        "ko": "장바구니에 추가되었습니다"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
