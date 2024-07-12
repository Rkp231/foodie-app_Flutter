import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "My Orders",
        "fr": "Mes commandes",
        "es": "Mis ordenes",
        "de": "meine Bestellungen",
        "pt": "minhas ordens",
        "ar": "طلباتي",
        "ko": "내 주문"
      } +
      {
        "en": "Products",
        "fr": "Des produits",
        "es": "Productos",
        "de": "Produkte",
        "pt": "Produtos",
        "ar": "منتجات",
        "ko": "제품"
      } +
      {
        "en": "Oops! No orders to see",
        "fr": "Oops! Aucune commande à voir",
        "es": "¡UPS! No hay órdenes para ver",
        "de": "Hoppla! Keine Bestellungen zu sehen",
        "pt": "Ups! Sem ordens para ver",
        "ar": "وجه الفتاة! لا توجد أوامر لرؤيتها",
        "ko": "이런! 볼 명령 없음"
      } +
      {
        "en": "Looks like you haven't placed any order yet",
        "fr": "Il semble que vous n’ayez pas encore passé de commande",
        "es": "Parece que aún no has realizado ningún pedido.",
        "de": "Sieht so aus, als hätten Sie noch keine Bestellung aufgegeben",
        "pt": "Parece que você ainda não fez nenhum pedido",
        "ar": "يبدو أنك لم تقدم أي طلب حتى الآن",
        "ko": "아직 주문하지 않은 것 같습니다."
      } +
      {
        "en": "Cancel Order",
        "fr": "annuler la commande",
        "es": "Cancelar orden",
        "de": "Bestellung stornieren",
        "pt": "Cancelar pedido",
        "ar": "الغاء الطلب",
        "ko": "주문 취소"
      } +
      {
        "en":
            "You are about to cancel a pending order. Are you sure you want to continue the cancellation?",
        "fr":
            "Vous êtes sur le point d'annuler une commande en attente. Êtes-vous sûr de vouloir continuer l'annulation?",
        "es":
            "Está a punto de cancelar un pedido pendiente. ¿Estás seguro de que deseas continuar con la cancelación?",
        "de":
            "Sie sind dabei, eine ausstehende Bestellung zu stornieren. Sind Sie sicher, dass Sie die Stornierung fortsetzen möchten?",
        "pt":
            "Você está prestes a cancelar um pedido pendente. Tem certeza de que deseja continuar o cancelamento?",
        "ar":
            "أنت على وشك إلغاء أمر معلق. هل أنت متأكد أنك تريد متابعة الإلغاء؟",
        "ko": "보류중인 주문을 취소하려고합니다. 취소를 계속 하시겠습니까?"
      } +
      {
        "en": "Track Order",
        "fr": "Suivi de commande",
        "es": "Orden de pista",
        "de": "Bestellung verfolgen",
        "pt": "Acompanhar Pedido",
        "ar": "ترتيب المسار",
        "ko": "주문을 추적하다"
      } +
      {
        "en": "Chat with Driver",
        "fr": "Discuter avec le chauffeur",
        "es": "Chatear con el conductor",
        "de": "Chatten Sie mit dem Fahrer",
        "pt": "Converse com o motorista",
        "ar": "الدردشة مع السائق",
        "ko": "드라이버와 채팅"
      } +
      {
        "en": "Chat with Vendor",
        "fr": "Discuter avec le fournisseur",
        "es": "Chatear con el vendedor",
        "de": "Chatten Sie mit dem Anbieter",
        "pt": "Converse com o fornecedor",
        "ar": "الدردشة مع البائع",
        "ko": "공급 업체와 채팅"
      } +
      {
        "en": "Pending",
        "fr": "En attente",
        "es": "Pendiente",
        "de": "steht aus",
        "pt": "Pendente",
        "ar": "قيد الانتظار",
        "ko": "보류 중"
      } +
      {
        "en": "Preparing",
        "fr": "En train de préparer",
        "es": "Preparando",
        "de": "Vorbereiten",
        "pt": "Preparando",
        "ar": "خطة",
        "ko": "준비 중"
      } +
      {
        "en": "Ready",
        "fr": "Prêt",
        "es": "Listo",
        "de": "Bereit",
        "pt": "Preparar",
        "ar": "مستعد",
        "ko": "준비된"
      } +
      {
        "en": "Enroute",
        "fr": "En route",
        "es": "En camino",
        "de": "Unterwegs",
        "pt": "A caminho",
        "ar": "في المسار",
        "ko": "도중"
      } +
      {
        "en": "Delivered",
        "fr": "Livré",
        "es": "Entregado",
        "de": "Geliefert",
        "pt": "Entregue",
        "ar": "تم التوصيل",
        "ko": "배달 됨"
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
        "en": "Cancelled",
        "fr": "Annulé",
        "es": "Cancelado",
        "de": "Abgebrochen",
        "pt": "Cancelado",
        "ar": "ألغيت",
        "ko": "취소 된"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
