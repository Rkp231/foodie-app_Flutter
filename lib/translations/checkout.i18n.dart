import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Checkout",
        "fr": "Vérifier",
        "es": "Revisa",
        "de": "Überprüfen",
        "pt": "Confira",
        "ar": "الدفع",
        "ko": "점검"
      } +
      {
        "en": "Deliver To",
        "fr": "Livrer à",
        "es": "Entregar a",
        "de": "Liefern an",
        "pt": "Entregar para",
        "ar": "يسلم إلى",
        "ko": "배달"
      } +
      {
        "en": "Select your preferred delivery address",
        "fr": "Sélectionnez votre adresse de livraison préférée",
        "es": "Seleccione su dirección de entrega preferida",
        "de": "Wählen Sie Ihre bevorzugte Lieferadresse",
        "pt": "Selecione seu endereço de entrega preferido",
        "ar": "حدد عنوان التسليم المفضل لديك",
        "ko": "선호하는 배송지 선택"
      } +
      {
        "en": "Change",
        "fr": "Changement",
        "es": "Cambio",
        "de": "Veränderung",
        "pt": "Mudar",
        "ar": "يتغيرون",
        "ko": "변화"
      } +
      {
        "en": "Payment Options",
        "fr": "Options de paiement",
        "es": "Opciones de pago",
        "de": "Zahlungsmöglichkeiten",
        "pt": "Opções de pagamento",
        "ar": "خيارات الدفع",
        "ko": "지불 옵션"
      } +
      {
        "en": "Select your preferred payment option",
        "fr": "Sélectionnez votre option de paiement préférée",
        "es": "Seleccione su opción de pago preferida",
        "de": "Wählen Sie Ihre bevorzugte Zahlungsoption",
        "pt": "Selecione sua opção de pagamento preferida",
        "ar": "حدد خيار الدفع المفضل لديك",
        "ko": "선호하는 지불 옵션을 선택하십시오"
      } +
      {
        "en": "Payment Option",
        "fr": "Modalité de paiement",
        "es": "Opcion de pago",
        "de": "Bezahlmöglichkeit",
        "pt": "Opção de pagamento",
        "ar": "خيار الدفع",
        "ko": "지불 옵션"
      } +
      {
        "en":
            "There are no available payment method. please try again later or contact support",
        "fr":
            "Il n'y a pas de méthode de paiement disponible. veuillez réessayer plus tard ou contacter l'assistance",
        "es":
            "No hay ningún método de pago disponible. Inténtelo de nuevo más tarde o póngase en contacto con el servicio de asistencia.",
        "de":
            "Es gibt keine verfügbaren Zahlungsmethoden. Bitte versuchen Sie es später erneut oder wenden Sie sich an den Support",
        "pt":
            "Não há método de pagamento disponível. por favor tente novamente mais tarde ou contate o suporte",
        "ar":
            "لا توجد طريقة دفع متاحة. يرجى المحاولة مرة أخرى لاحقًا أو الاتصال بالدعم",
        "ko": "사용할 수있는 결제 수단이 없습니다. 나중에 다시 시도하거나 지원팀에 문의하세요."
      } +
      {
        "en": "Delivery Addres",
        "fr": "Adresses de livraison",
        "es": "Direcciones de entrega",
        "de": "Lieferadressen",
        "pt": "Endereço de entrega",
        "ar": "عناوين التسليم",
        "ko": "배달 주소"
      } +
      {
        "en": "Please select a delivery addres for your order",
        "fr":
            "Veuillez sélectionner une adresse de livraison pour votre commande",
        "es": "Seleccione una dirección de entrega para su pedido",
        "de": "Bitte wählen Sie eine Lieferadresse für Ihre Bestellung",
        "pt": "Selecione um endereço de entrega para o seu pedido",
        "ar": "الرجاء تحديد عنوان التسليم لطلبك",
        "ko": "주문할 배송 주소를 선택하세요."
      } +
      {
        "en": "Please wait while we process your order...",
        "fr": "Veuillez patienter pendant que nous traitons votre commande ...",
        "es": "Por favor espere mientras procesamos su orden...",
        "de": "Bitte warten Sie, während wir Ihre Bestellung bearbeiten ...",
        "pt": "Aguarde enquanto processamos seu pedido ...",
        "ar": "يرجى الانتظار بينما نعالج طلبك...",
        "ko": "주문을 처리하는 동안 잠시 기다려주십시오 ..."
      } +
      {
        "en": "Order Placed Successfully!",
        "fr": "Commande passée avec succès!",
        "es": "¡Pedido realizado correctamente!",
        "de": "Bestellung erfolgreich aufgegeben!",
        "pt": "Pedido feito com sucesso!",
        "ar": "تم تقديم الطلب بنجاح!",
        "ko": "주문이 성공적으로 완료되었습니다!"
      } +
      {
        "en": "Order Failed!",
        "fr": "La commande a échoué!",
        "es": "¡Pedido fallido!",
        "de": "Bestellung fehlgeschlagen!",
        "pt": "O pedido falhou!",
        "ar": "فشل الطلب!",
        "ko": "주문 실패!"
      } +
      {
        "en":
            "Order Paymennt Complete. Your order would be updated shortly. Thank you",
        "fr":
            "Commandez Paymennt Complete. Votre commande sera mise à jour sous peu. Merci",
        "es":
            "Order Paymennt Complete. Su pedido se actualizará en breve. Gracias",
        "de":
            "Bestellung Paymennt abgeschlossen. Ihre Bestellung wird in Kürze aktualisiert. Vielen Dank",
        "pt":
            "Pedido Paymennt concluído. Seu pedido será atualizado em breve. obrigada",
        "ar": "اكتمل طلب Paymennt. سيتم تحديث طلبك قريبا. شكرا لك",
        "ko": "주문 Paymennt 완료. 주문이 곧 업데이트됩니다. 감사합니다"
      } +
      {
        "en": "Pickup",
        "fr": "Ramasser",
        "es": "Levantar",
        "de": "Abholen",
        "pt": "Pegar",
        "ar": "يلتقط",
        "ko": "픽업"
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
        "en": "Pickup your item from the vendor. Delivery fee will be excluded",
        "fr":
            "Récupérez votre article chez le vendeur. Les frais de livraison seront exclus",
        "es":
            "Recoja su artículo del proveedor. Se excluirá la tarifa de envío.",
        "de":
            "Holen Sie Ihren Artikel beim Verkäufer ab. Versandkosten sind ausgeschlossen",
        "pt": "Retire seu item do vendedor. A taxa de entrega será excluída",
        "ar": "احصل على البند الخاص بك من البائع. سيتم استبعاد رسوم التوصيل",
        "ko": "공급 업체로부터 물품을 수령하십시오. 배송비는 제외됩니다."
      } +
      {
        "en": "Sorry vendor can't deliver to selected address",
        "fr":
            "Désolé, le fournisseur ne peut pas livrer à l'adresse sélectionnée",
        "es":
            "Lo sentimos, el proveedor no puede entregar a la dirección seleccionada",
        "de":
            "Der Anbieter kann leider nicht an die ausgewählte Adresse liefern",
        "pt":
            "Desculpe, o fornecedor não pode entregar no endereço selecionado",
        "ar": "عذرا البائع لا يمكن أن يسلم إلى العنوان المحدد",
        "ko": "공급 업체가 선택한 주소로 배송 할 수 없습니다."
      } +
      {
        "en":
            "For extra description you can add them here e.g house number, less spice",
        "fr":
            "Pour une description supplémentaire, vous pouvez les ajouter ici, par exemple le numéro de maison, moins d'épices",
        "es":
            "Para obtener una descripción adicional, puede agregarlos aquí, por ejemplo, número de casa, menos especias",
        "de":
            "Für eine zusätzliche Beschreibung können Sie sie hier hinzufügen, z. B. Hausnummer, weniger Würze",
        "pt":
            "Para uma descrição extra, você pode adicioná-los aqui, por exemplo, número da casa, menos especiarias",
        "ar":
            "للحصول على وصف إضافي ، يمكنك إضافتها هنا ، على سبيل المثال رقم المنزل ، والتوابل الأقل",
        "ko": "추가 설명을 위해 여기에 추가 할 수 있습니다."
      } +
      {
        "en": "Note",
        "fr": "Noter",
        "es": "Nota",
        "de": "Hinweis",
        "pt": "Observação",
        "ar": "ملحوظة",
        "ko": "노트"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
