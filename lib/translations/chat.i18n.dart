import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Chat with ",
        "fr": "Parler avec ",
        "es": "Chatear con ",
        "de": "Plaudern mit ",
        "pt": "Conversar com ",
        "ar": "الدردشة مع ",
        "ko": "채팅 "
      } +
      {
        "en": "Driver",
        "fr": "Chauffeur",
        "es": "Conductor",
        "de": "Treiber",
        "pt": "Condutor",
        "ar": "سائق",
        "ko": "운전사"
      } +
      {
        "en": "Vendor",
        "fr": "Vendeur",
        "es": "Vendedor",
        "de": "Verkäufer",
        "pt": "Fornecedor",
        "ar": "بائع",
        "ko": "공급 업체"
      } +
      {
        "en": "Me",
        "fr": "Moi",
        "es": "Yo",
        "de": "Mich",
        "pt": "Mim",
        "ar": "أنا",
        "ko": "나를"
      } +
      {
        "en": "Send",
        "fr": "Envoyer",
        "es": "Enviar",
        "de": "Senden",
        "pt": "Mandar",
        "ar": "إرسال",
        "ko": "보내다"
      } +
      {
        "en": "Message",
        "fr": "Un message",
        "es": "Mensaje",
        "de": "Botschaft",
        "pt": "Mensagem",
        "ar": "رسالة",
        "ko": "메시지"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
