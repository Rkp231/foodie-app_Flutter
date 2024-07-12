import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "Edit Profile",
        "fr": "Editer le profil",
        "es": "Editar perfil",
        "de": "Profil bearbeiten",
        "pt": "Editar Perfil",
        "ar": "تعديل الملف الشخصي",
        "ko": "프로필 수정"
      } +
      {
        "en": "Change Photo",
        "fr": "Changer la photo",
        "es": "Cambiar foto",
        "de": "Foto ändern",
        "pt": "Mudar foto",
        "ar": "غير الصوره",
        "ko": "사진 변경"
      } +
      {
        "en": "Change Password",
        "fr": "Changer le mot de passe",
        "es": "Cambia la contraseña",
        "de": "Passwort ändern",
        "pt": "Mudar senha",
        "ar": "تغيير كلمة المرور",
        "ko": "비밀번호 변경"
      } +
      {
        "en": "Current Password",
        "fr": "Mot de passe actuel",
        "es": "contraseña actual",
        "de": "Aktuelles Passwort",
        "pt": "Senha atual",
        "ar": "كلمة المرور الحالي",
        "ko": "현재 비밀번호"
      } +
      {
        "en": "New Password",
        "fr": "nouveau mot de passe",
        "es": "Nueva contraseña",
        "de": "Neues Kennwort",
        "pt": "Nova Senha",
        "ar": "كلمة مرور جديدة",
        "ko": "새 비밀번호"
      } +
      {
        "en": "Confirm New Password",
        "fr": "Confirmer le nouveau mot de passe",
        "es": "Confirmar nueva contraseña",
        "de": "Bestätige neues Passwort",
        "pt": "Confirme a nova senha",
        "ar": "تأكيد كلمة المرور الجديدة",
        "ko": "새 암호를 확인합니다"
      } +
      {
        "en": "Notifications",
        "fr": "Notifications",
        "es": "Notificaciones",
        "de": "Benachrichtigungen",
        "pt": "Notificações",
        "ar": "إشعارات",
        "ko": "알림"
      } +
      {
        "en": "Oops! No notifications",
        "fr": "Oops! Aucune notification",
        "es": "¡UPS! No Notificaciones",
        "de": "Hoppla! Keine Benachrichtigungen",
        "pt": "Ups! Nenhuma notificação",
        "ar": "وجه الفتاة! لا إشعارات",
        "ko": "이런! 알림 없음"
      } +
      {
        "en": "When you get notifications, they will show up here.",
        "fr": "Lorsque vous recevez des notifications, elles s'affichent ici.",
        "es": "Cuando reciba notificaciones, aparecerán aquí.",
        "de":
            "Wenn Sie Benachrichtigungen erhalten, werden diese hier angezeigt.",
        "pt": "Quando você receber notificações, elas aparecerão aqui.",
        "ar": "عندما تتلقى إشعارات ، ستظهر هنا.",
        "ko": "알림을 받으면 여기에 표시됩니다."
      } +
      {
        "en": "Update Details",
        "fr": "Mettre à jour les détails",
        "es": "Detalles de actualización",
        "de": "Details aktualisieren",
        "pt": "Detalhes de atualização",
        "ar": "تحديث التفاصيل",
        "ko": "세부 정보 업데이트"
      } +
      {
        "en": "Change Password",
        "fr": "Changer le mot de passe",
        "es": "Cambia la contraseña",
        "de": "Passwort ändern",
        "pt": "Mudar senha",
        "ar": "تغيير كلمة المرور",
        "ko": "비밀번호 변경"
      } +
      {
        "en": "Wallet",
        "fr": "Portefeuille",
        "es": "Cartera",
        "de": "Brieftasche",
        "pt": "Carteira",
        "ar": "محفظة",
        "ko": "지갑"
      } +
      {
        "en": "Delivery Addresses",
        "fr": "Adresses de livraison",
        "es": "Direcciones de entrega",
        "de": "Lieferadressen",
        "pt": "Endereços de entrega",
        "ar": "عناوين التسليم",
        "ko": "배송 주소"
      } +
      {
        "en": "Notifications",
        "fr": "Notifications",
        "es": "Notificaciones",
        "de": "Benachrichtigungen",
        "pt": "Notificações",
        "ar": "إشعارات",
        "ko": "알림"
      } +
      {
        "en": "FAQ's & Support",
        "fr": "FAQ et assistance",
        "es": "Preguntas frecuentes y soporte",
        "de": "FAQs & Support",
        "pt": "Perguntas frequentes e suporte",
        "ar": "التعليمات والدعم",
        "ko": "FAQ 및 지원"
      } +
      {
        "en": "Language",
        "fr": "Langue",
        "es": "Idioma",
        "de": "Sprache",
        "pt": "Língua",
        "ar": "لغة",
        "ko": "언어"
      } +
      {
        "en": "Logout",
        "fr": "Se déconnecter",
        "es": "Cerrar sesión",
        "de": "Ausloggen",
        "pt": "Sair",
        "ar": "تسجيل خروج",
        "ko": "로그 아웃"
      } +
      {
        "en": "Unauthorized",
        "fr": "Non autorisé",
        "es": "No autorizado",
        "de": "Nicht autorisiert",
        "pt": "Não autorizado",
        "ar": "غير مصرح",
        "ko": "승인되지 않음"
      } +
      {
        "en": "You must sign-in to access this section",
        "fr": "Vous devez vous connecter pour accéder à cette section",
        "es": "Debes iniciar sesión para acceder a esta sección",
        "de":
            "Sie müssen sich anmelden, um auf diesen Abschnitt zugreifen zu können",
        "pt": "Você deve entrar para acessar esta seção",
        "ar": "يجب عليك تسجيل الدخول للوصول إلى هذا القسم",
        "ko": "이 섹션에 액세스하려면 로그인해야합니다."
      } +
      {
        "en": "Login",
        "fr": "Connexion",
        "es": "Acceso",
        "de": "Anmeldung",
        "pt": "Conecte-se",
        "ar": "تسجيل الدخول",
        "ko": "로그인"
      } +
      {
        "en": "Forgot Password",
        "fr": "Mot de passe oublié",
        "es": "Has olvidado tu contraseña",
        "de": "Passwort vergessen",
        "pt": "Esqueceu sua senha",
        "ar": "هل نسيت كلمة السر",
        "ko": "비밀번호를 잊으 셨나요"
      } +
      {
        "en": "Authenticating",
        "fr": "Authentification",
        "es": "Autenticando",
        "de": "Authentifizierung",
        "pt": "Autenticando",
        "ar": "المصادقة",
        "ko": "인증 중"
      } +
      {
        "en": "Password Update",
        "fr": "Mise à jour du mot de passe",
        "es": "Actualización de contraseña",
        "de": "Passwort aktualisieren",
        "pt": "Atualização de senha",
        "ar": "تحديث كلمة المرور",
        "ko": "비밀번호 업데이트"
      } +
      {
        "en": "Password Update Failed!",
        "fr": "La mise à jour du mot de passe a échoué!",
        "es": "¡Error al actualizar la contraseña!",
        "de": "Passwort-Update fehlgeschlagen!",
        "pt": "Falha na atualização da senha!",
        "ar": "فشل تحديث كلمة المرور!",
        "ko": "비밀번호 업데이트 실패!"
      } +
      {
        "en": "Forgot Password",
        "fr": "Mot de passe oublié",
        "es": "Has olvidado tu contraseña",
        "de": "Passwort vergessen",
        "pt": "Esqueceu sua senha",
        "ar": "هل نسيت كلمة السر",
        "ko": "비밀번호를 잊으 셨나요"
      } +
      {
        "en":
            "Please enter your email address below to receive an email instruction for resetting your password.",
        "fr":
            "Veuillez saisir votre adresse e-mail ci-dessous pour recevoir une instruction par e-mail pour réinitialiser votre mot de passe.",
        "es":
            "Ingrese su dirección de correo electrónico a continuación para recibir instrucciones por correo electrónico para restablecer su contraseña.",
        "de":
            "Bitte geben Sie unten Ihre E-Mail-Adresse ein, um eine E-Mail-Anweisung zum Zurücksetzen Ihres Passworts zu erhalten.",
        "pt":
            "Por favor, digite seu endereço de e-mail abaixo para receber instruções por e-mail para redefinir sua senha.",
        "ar":
            "الرجاء إدخال عنوان بريدك الإلكتروني أدناه لتلقي تعليمات عبر البريد الإلكتروني لإعادة تعيين كلمة المرور الخاصة بك.",
        "ko": "비밀번호 재설정에 대한 이메일 지침을 받으려면 아래에 이메일 주소를 입력하십시오."
      } +
      {
        "en": "Submit",
        "fr": "Nous faire parvenir",
        "es": "Entregar",
        "de": "einreichen",
        "pt": "Enviar",
        "ar": "يقدم",
        "ko": "제출"
      } +
      {
        "en": "Authenticating",
        "fr": "Authentification",
        "es": "Autenticando",
        "de": "Authentifizierung",
        "pt": "Autenticando",
        "ar": "المصادقة",
        "ko": "인증 중"
      } +
      {
        "en": "Profile Update",
        "fr": "Mise à jour du profil",
        "es": "Actualización de perfil",
        "de": "Profilaktualisierung",
        "pt": "Atualização de Perfil",
        "ar": "تحديث الملف الشخصي",
        "ko": "프로필 업데이트"
      } +
      {
        "en": "Profile Update Failed!",
        "fr": "La mise à jour du profil a échoué!",
        "es": "¡Error al actualizar el perfil!",
        "de": "Profilaktualisierung fehlgeschlagen!",
        "pt": "A atualização do perfil falhou!",
        "ar": "فشل تحديث الملف الشخصي!",
        "ko": "프로필 업데이트 실패!"
      } +
      {
        "en": "Select your preferred language",
        "fr": "Sélectionnez votre langue préférée",
        "es": "Seleccione su idioma preferido",
        "de": "Wählen Sie Ihre bevorzugte Sprache",
        "pt": "Selecione seu idioma preferido",
        "ar": "اختر لغتك المفضلة",
        "ko": "선호하는 언어 선택"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
