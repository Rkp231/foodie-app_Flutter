import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Select Delivery Address",
        "fr": "Sélectionnez l'adresse de livraison",
        "es": "Seleccionar dirección de entrega",
        "de": "Wählen Sie Lieferadresse",
        "pt": "Selecione o endereço de entrega",
        "ar": "حدد عنوان التسليم",
        "ko": "배송지 선택"
      } +
      {
        "en": "My Delivery Addresses",
        "fr": "Mes adresses de livraison",
        "es": "Mis direcciones de entrega",
        "de": "Meine Lieferadressen",
        "pt": "Meus endereços de entrega",
        "ar": "عناوين التوصيل الخاصة بي",
        "ko": "내 배송 주소"
      } +
      {
        "en": "Delivery Address",
        "fr": "Adresse de livraison",
        "es": "Dirección de entrega",
        "de": "Lieferadresse",
        "pt": "Endereço de entrega",
        "ar": "عنوان التسليم",
        "ko": "배달 주소"
      } +
      {
        "en": "Default Address",
        "fr": "Adresse par défaut",
        "es": "Dirección predeterminada",
        "de": "Standardadresse",
        "pt": "Endereço padrão",
        "ar": "العنوان الافتراضي",
        "ko": "기본 주소"
      } +
      {
        "en": "Note: Long Press to edit, swipe left/right to delete",
        "fr":
            "Remarque: appuyez longuement pour modifier, faites glisser votre doigt vers la gauche / droite pour supprimer",
        "es":
            "Nota: Mantenga presionado para editar, deslice hacia la izquierda / derecha para eliminar",
        "de":
            "Hinweis: Zum Bearbeiten lange drücken, zum Löschen nach links / rechts wischen",
        "pt":
            "Nota: Pressione e segure para editar, deslize para a esquerda / direita para excluir",
        "ar": "ملاحظة: اضغط لفترة طويلة للتحرير ، واسحب لليسار / لليمين للحذف",
        "ko": "참고 : 편집하려면 길게 누르고, 삭제하려면 왼쪽 / 오른쪽으로 스 와이프하세요."
      } +
      {
        "en": "Selected Address",
        "fr": "Adresse sélectionnée",
        "es": "Dirección seleccionada",
        "de": "Ausgewählte Adresse",
        "pt": "Endereço Selecionado",
        "ar": "العنوان المحدد",
        "ko": "선택한 주소"
      } +
      {
        "en": "Latitude",
        "fr": "Latitude",
        "es": "Latitud",
        "de": "Breite",
        "pt": "Latitude",
        "ar": "خط العرض",
        "ko": "위도"
      } +
      {
        "en": "Longitude",
        "fr": "Longitude",
        "es": "Longitud",
        "de": "Längengrad",
        "pt": "Longitude",
        "ar": "خط الطول",
        "ko": "경도"
      } +
      {
        "en": "Pick Location",
        "fr": "Choisissez un emplacement",
        "es": "Elegir ubicación",
        "de": "Standort auswählen",
        "pt": "Escolha a localização",
        "ar": "اختر الموقع",
        "ko": "위치 선택"
      } +
      {
        "en": "Oops! No delivery address",
        "fr": "Oops! Aucune adresse de livraison",
        "es": "¡UPS! Sin dirección de entrega",
        "de": "Hoppla! Keine Lieferadresse",
        "pt": "Ups! Sem endereço de entrega",
        "ar": "وجه الفتاة! لا يوجد عنوان التسليم",
        "ko": "이런! 배달 주소 없음"
      } +
      {
        "en": "Looks like you haven't added anything delivery address yet",
        "fr":
            "Il semble que vous n’avez encore rien ajouté d’adresse de livraison",
        "es": "Parece que todavía no has añadido ninguna dirección de entrega.",
        "de": "Sie haben anscheinend noch keine Lieferadresse hinzugefügt",
        "pt": "Parece que você ainda não adicionou nenhum endereço de entrega",
        "ar": "يبدو أنك لم تقم بإضافة أي عنوان تسليم حتى الآن",
        "ko": "아직 배송지 주소를 추가하지 않으신 것 같습니다."
      } +
      {
        "en":
            "You need to select a delivery address to process to confirm checkout",
        "fr":
            "Vous devez sélectionner une adresse de livraison à traiter pour confirmer le paiement",
        "es":
            "Debe seleccionar una dirección de entrega para procesar y confirmar el pago",
        "de":
            "Sie müssen eine Lieferadresse auswählen, die zur Bestätigung der Kaufabwicklung verarbeitet werden soll",
        "pt":
            "Você precisa selecionar um endereço de entrega para processar e confirmar o checkout",
        "ar": "تحتاج إلى تحديد عنوان التسليم للمعالجة لتأكيد الخروج",
        "ko": "결제를 확인하려면 처리 할 배송 주소를 선택해야합니다."
      } +
      {
        "en": "Please wait while we process your request...",
        "fr": "Veuillez patienter pendant que nous accédons à votre requête...",
        "es": "Espere mientras procesamos su solicitud ...",
        "de": "Bitte warten Sie, während wir Ihre Anfrage bearbeiten ...",
        "pt": "Aguarde enquanto processamos sua solicitação ...",
        "ar": "يرجى الانتظار بينما نعالج طلبك...",
        "ko": "요청을 처리하는 동안 잠시 기다려주십시오 ..."
      } +
      {
        "en": "Deleted Successfully!",
        "fr": "Supprimé avec succès!",
        "es": "¡Borrado exitosamente!",
        "de": "Erfolgreich gelöscht!",
        "pt": "Apagado com sucesso!",
        "ar": "حذف بنجاح!",
        "ko": "성공적으로 삭제되었습니다!"
      } +
      {
        "en": "Deletion Failed!",
        "fr": "La suppression a échoué!",
        "es": "¡Error al eliminar!",
        "de": "Löschung fehlgeschlagen!",
        "pt": "A exclusão falhou!",
        "ar": "فشل الحذف!",
        "ko": "삭제 실패!"
      } +
      {
        "en": "Edit Delivery Address",
        "fr": "Modifier l'adresse de livraison",
        "es": "Editar dirección de entrega",
        "de": "Lieferadresse bearbeiten",
        "pt": "Editar endereço de entrega",
        "ar": "تحرير عنوان التسليم",
        "ko": "배송 주소 수정"
      } +
      {
        "en":
            "Note: Please enter delivery address name and pick a location using the buttons below",
        "fr":
            "Remarque: veuillez saisir le nom de l'adresse de livraison et choisir un emplacement à l'aide des boutons ci-dessous",
        "es":
            "Nota: ingrese el nombre de la dirección de entrega y elija una ubicación usando los botones a continuación",
        "de":
            "Hinweis: Bitte geben Sie den Namen der Lieferadresse ein und wählen Sie einen Ort mit den folgenden Schaltflächen aus",
        "pt":
            "Nota: Por favor, insira o nome do endereço de entrega e escolha um local usando os botões abaixo",
        "ar":
            "ملاحظة: الرجاء إدخال اسم عنوان التسليم واختيار موقع باستخدام الأزرار أدناه",
        "ko": "참고 : 배송지 이름을 입력하고 아래 버튼을 사용하여 위치를 선택하세요."
      } +
      {
        "en": "Please wait while we process your request...",
        "fr": "Veuillez patienter pendant que nous accédons à votre requête...",
        "es": "Espere mientras procesamos su solicitud ...",
        "de": "Bitte warten Sie, während wir Ihre Anfrage bearbeiten ...",
        "pt": "Aguarde enquanto processamos sua solicitação ...",
        "ar": "يرجى الانتظار بينما نعالج طلبك...",
        "ko": "요청을 처리하는 동안 잠시 기다려주십시오 ..."
      } +
      {
        "en": "Updated Successfully!",
        "fr": "Mis à jour avec succés!",
        "es": "¡Actualizado con éxito!",
        "de": "Erfolgreich geupdated!",
        "pt": "Atualizado com sucesso!",
        "ar": "تم التحديث بنجاح!",
        "ko": "성공적으로 업데이트되었습니다!"
      } +
      {
        "en": "Updated Failed!",
        "fr": "Échec de la mise à jour!",
        "es": "¡Actualización fallida!",
        "de": "Aktualisiert fehlgeschlagen!",
        "pt": "A atualização falhou!",
        "ar": "فشل التحديث!",
        "ko": "업데이트 실패!"
      } +
      {
        "en": "New Delivery Address",
        "fr": "Nouvelle adresse de livraison",
        "es": "Nueva dirección de entrega",
        "de": "Neue Lieferadresse",
        "pt": "Novo endereço de entrega",
        "ar": "عنوان التسليم الجديد",
        "ko": "새 배달 주소"
      } +
      {
        "en":
            "Note: Please enter delivery address name and pick a location using the buttons below",
        "fr":
            "Remarque: veuillez saisir le nom de l'adresse de livraison et choisir un emplacement à l'aide des boutons ci-dessous",
        "es":
            "Nota: ingrese el nombre de la dirección de entrega y elija una ubicación usando los botones a continuación",
        "de":
            "Hinweis: Bitte geben Sie den Namen der Lieferadresse ein und wählen Sie einen Ort mit den folgenden Schaltflächen aus",
        "pt":
            "Nota: Por favor, insira o nome do endereço de entrega e escolha um local usando os botões abaixo",
        "ar":
            "ملاحظة: الرجاء إدخال اسم عنوان التسليم واختيار موقع باستخدام الأزرار أدناه",
        "ko": "참고 : 배송지 이름을 입력하고 아래 버튼을 사용하여 위치를 선택하세요."
      } +
      {
        "en": "Please wait while we process your request...",
        "fr": "Veuillez patienter pendant que nous accédons à votre requête...",
        "es": "Espere mientras procesamos su solicitud ...",
        "de": "Bitte warten Sie, während wir Ihre Anfrage bearbeiten ...",
        "pt": "Aguarde enquanto processamos sua solicitação ...",
        "ar": "يرجى الانتظار بينما نعالج طلبك...",
        "ko": "요청을 처리하는 동안 잠시 기다려주십시오 ..."
      } +
      {
        "en": "Created Successfully!",
        "fr": "Créé avec succès!",
        "es": "¡Creado con éxito!",
        "de": "Erfolgreich erstellt!",
        "pt": "Criado com sucesso!",
        "ar": "تم إنشاؤه بنجاح!",
        "ko": "성공적으로 생성되었습니다!"
      } +
      {
        "en": "Creation Failed!",
        "fr": "La création a échoué!",
        "es": "¡Creación fallida!",
        "de": "Erstellung fehlgeschlagen!",
        "pt": "A criação falhou!",
        "ar": "فشل الإنشاء!",
        "ko": "생성 실패!"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
