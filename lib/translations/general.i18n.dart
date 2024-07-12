import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Full name",
        "fr": "Nom et prénom",
        "es": "Nombre completo",
        "de": "Vollständiger Name",
        "pt": "Nome completo",
        "ar": "الاسم الكامل",
        "ko": "성명"
      } +
      {
        "en": "Name",
        "fr": "Nom",
        "es": "Nombre",
        "de": "Name",
        "pt": "Nome",
        "ar": "اسم",
        "ko": "이름"
      } +
      {
        "en": "Email",
        "fr": "E-mail",
        "es": "Correo electrónico",
        "de": "Email",
        "pt": "O email",
        "ar": "بريد إلكتروني",
        "ko": "이메일"
      } +
      {
        "en": "Phone number",
        "fr": "Numéro de téléphone",
        "es": "Número de teléfono",
        "de": "Telefonnummer",
        "pt": "Número de telefone",
        "ar": "رقم الهاتف",
        "ko": "전화 번호"
      } +
      {
        "en": "Password",
        "fr": "Mot de passe",
        "es": "Contraseña",
        "de": "Passwort",
        "pt": "Senha",
        "ar": "كلمة المرور",
        "ko": "암호"
      } +
      {
        "en": "e.g Office, Home, Mum's house",
        "fr": "Par exemple, bureau, maison, maison de maman",
        "es": "p. ej., oficina, hogar, casa de mamá",
        "de": "z.B. Büro, Zuhause, Mamas Haus",
        "pt": "por exemplo, escritório, casa, casa da mãe",
        "ar": "على سبيل المثال المكتب ، المنزل ، منزل الأم",
        "ko": "예 : 사무실, 집, 엄마의 집"
      } +
      {
        "en": "Location Permission is not available",
        "fr": "L'autorisation de localisation n'est pas disponible",
        "es": "El permiso de ubicación no está disponible",
        "de": "Standortberechtigung ist nicht verfügbar",
        "pt": "A permissão de localização não está disponível",
        "ar": "إذن الموقع غير متوفر",
        "ko": "위치 권한을 사용할 수 없습니다."
      } +
      {
        "en":
            "Please enable location permission to get nearby vendors using your current location",
        "fr":
            "Veuillez activer l'autorisation de localisation pour que les fournisseurs à proximité utilisent votre position actuelle",
        "es":
            "Habilite el permiso de ubicación para que los proveedores cercanos utilicen su ubicación actual",
        "de":
            "Bitte aktivieren Sie die Standortberechtigung, um Anbieter in der Nähe zu erhalten, die Ihren aktuellen Standort verwenden",
        "pt":
            "Ative a permissão de localização para obter fornecedores próximos usando sua localização atual",
        "ar":
            "الرجاء تمكين إذن الموقع للحصول على البائعين القريبين باستخدام موقعك الحالي",
        "ko": "현재 위치를 사용하여 주변 공급 업체를 얻으려면 위치 권한을 활성화하세요."
      } +
      {
        "en": "Enable Location",
        "fr": "Location disponible",
        "es": "Habilitar ubicación",
        "de": "Aktiviere Standort",
        "pt": "Habilitar localização",
        "ar": "تمكن موقع",
        "ko": "위치 활성화"
      } +
      {
        "en": "Save",
        "fr": "Sauvegarder",
        "es": "Ahorrar",
        "de": "sparen",
        "pt": "Salvar",
        "ar": "يحفظ",
        "ko": "저장"
      } +
      {
        "en": "Start",
        "fr": "Début",
        "es": "Comienzo",
        "de": "Anfang",
        "pt": "Começar",
        "ar": "يبدأ",
        "ko": "스타트"
      } +
      {
        "en": "Skip",
        "fr": "Sauter",
        "es": "Saltar",
        "de": "Überspringen",
        "pt": "Pular",
        "ar": "يتخطى",
        "ko": "건너 뛰기"
      } +
      {
        "en": "Next",
        "fr": "Suivant",
        "es": "próximo",
        "de": "Nächster",
        "pt": "Próximo",
        "ar": "التالي",
        "ko": "다음"
      } +
      {
        "en": "Update",
        "fr": "Mettre à jour",
        "es": "Actualizar",
        "de": "Aktualisieren",
        "pt": "Atualizar",
        "ar": "تحديث",
        "ko": "최신 정보"
      } +
      {
        "en": "Cancel",
        "fr": "Annuler",
        "es": "Cancelar",
        "de": "Stornieren",
        "pt": "Cancelar",
        "ar": "يلغي",
        "ko": "취소"
      } +
      {
        "en": "Yes, Clear",
        "fr": "Oui, c'est clair",
        "es": "Sí, claro",
        "de": "Ja klar",
        "pt": "Sim claro",
        "ar": "نعم واضح",
        "ko": "예, 삭제합니다"
      } +
      {
        "en": "No",
        "fr": "Non",
        "es": "No",
        "de": "Nein",
        "pt": "Não",
        "ar": "لا",
        "ko": "아니"
      } +
      {
        "en": "Yes",
        "fr": "Oui",
        "es": "sí",
        "de": "Ja",
        "pt": "sim",
        "ar": "نعم",
        "ko": "예"
      } +
      {
        "en": "Please Wait...",
        "fr": "S'il vous plaît, attendez...",
        "es": "Espere por favor...",
        "de": "Warten Sie mal...",
        "pt": "Por favor, aguarde...",
        "ar": "انتظر من فضلك...",
        "ko": "기다려주십시오 ..."
      } +
      {
        "en": "Successful",
        "fr": "Réussi",
        "es": "Exitoso",
        "de": "Erfolgreich",
        "pt": "Bem sucedido",
        "ar": "ناجح",
        "ko": "성공한"
      } +
      {
        "en": "Failed",
        "fr": "Échoué",
        "es": "Ha fallado",
        "de": "Gescheitert",
        "pt": "Fracassado",
        "ar": "فشل",
        "ko": "실패한"
      } +
      {
        "en": "Result",
        "fr": "Résultat",
        "es": "Resultado",
        "de": "Ergebnis",
        "pt": "Resultado",
        "ar": "نتيجة",
        "ko": "결과"
      } +
      {
        "en": "...show more",
        "fr": "...montre plus",
        "es": "...mostrar más",
        "de": "...Zeig mehr",
        "pt": "...mostre mais",
        "ar": "...أظهر المزيد",
        "ko": "...자세히보기"
      } +
      {
        "en": " show less",
        "fr": " Montrer moins",
        "es": " Muestra menos",
        "de": " zeige weniger",
        "pt": " mostre menos",
        "ar": " تظهر أقل",
        "ko": " 덜 보여"
      } +
      {
        "en": "New",
        "fr": "Nouveau",
        "es": "Nuevo",
        "de": "Neu",
        "pt": "Novo",
        "ar": "جديد",
        "ko": "새로운"
      } +
      {
        "en": "Sort by",
        "fr": "Trier par",
        "es": "Ordenar por",
        "de": "Sortiere nach",
        "pt": "Ordenar por",
        "ar": "صنف حسب",
        "ko": "정렬 기준"
      } +
      {
        "en": "Price",
        "fr": "Prix",
        "es": "Precio",
        "de": "Preis",
        "pt": "Preço",
        "ar": "سعر",
        "ko": "가격"
      } +
      {
        "en": "Search",
        "fr": "Chercher",
        "es": "Búsqueda",
        "de": "Suche",
        "pt": "Procurar",
        "ar": "بحث",
        "ko": "검색"
      } +
      {
        "en": "Result",
        "fr": "Résultat",
        "es": "Resultado",
        "de": "Ergebnis",
        "pt": "Resultado",
        "ar": "نتيجة",
        "ko": "결과"
      } +
      {
        "en": "Oops! No Vendor found",
        "fr": "Oops! Aucun fournisseur trouvé",
        "es": "¡UPS! No se encontró ningún proveedor",
        "de": "Hoppla! Kein Anbieter gefunden",
        "pt": "Ups! Nenhum vendedor encontrado",
        "ar": "وجه الفتاة! لم يتم العثور على بائع",
        "ko": "이런! 공급 업체가 없습니다."
      } +
      {
        "en": "Please try again with another filter or keyword",
        "fr": "Veuillez réessayer avec un autre filtre ou mot-clé",
        "es": "Vuelva a intentarlo con otro filtro o palabra clave.",
        "de":
            "Bitte versuchen Sie es erneut mit einem anderen Filter oder Schlüsselwort",
        "pt": "Tente novamente com outro filtro ou palavra-chave",
        "ar": "يرجى المحاولة مرة أخرى مع مرشح آخر أو كلمة رئيسية",
        "ko": "다른 필터 또는 키워드로 다시 시도하십시오"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
