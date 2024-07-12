import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en") +
      {
        "en": "OTP Verification",
        "fr": "Vérification OTP",
        "es": "Verificación OTP",
        "de": "OTP-Überprüfung",
        "pt": "Verificação OTP",
        "ar": "التحقق من OTP",
        "ko": "OTP 확인"
      } +
      {
        "en": "Enter OTP Code sent to %s",
        "fr": "Entrez le code OTP envoyé à% s",
        "es": "Ingrese el código OTP enviado a% s",
        "de": "Geben Sie den an% s gesendeten OTP-Code ein",
        "pt": "Digite o código OTP enviado para% s",
        "ar": "أدخل رمز OTP المرسل إلى٪ s",
        "ko": "% s로 보낸 OTP 코드를 입력하세요."
      } +
      {
        "en": "Didn't receive OTP code? ",
        "fr": "Vous n'avez pas reçu de code OTP?",
        "es": "¿No recibió el código OTP?",
        "de": "Haben Sie keinen OTP-Code erhalten?",
        "pt": "Não recebeu o código OTP?",
        "ar": "لم تستلم رمز OTP؟",
        "ko": "OTP 코드를받지 못하셨습니까?"
      } +
      {
        "en": "Resend",
        "fr": "Renvoyer",
        "es": "Reenviar",
        "de": "Erneut senden",
        "pt": "Reenviar",
        "ar": "إعادة إرسال",
        "ko": "재전송"
      } +
      {
        "en": " Resend in %s",
        "fr": " Renvoyer dans %s",
        "es": " Reenviar en %s",
        "de": " In %s erneut senden",
        "pt": " Reenviar em %s",
        "ar": " إعادة الإرسال في %s",
        "ko": " %s 후에 다시 보내기"
      } +
      {
        "en": "Verify",
        "fr": "Vérifier",
        "es": "Verificar",
        "de": "Überprüfen",
        "pt": "Verificar",
        "ar": "تحقق",
        "ko": "확인"
      } +
      {
        "en": "You will receive a 6 digit code to verify next",
        "fr": "Vous recevrez un code à 6 chiffres pour vérifier ensuite",
        "es": "Recibirás un código de 6 dígitos para verificar a continuación",
        "de": "Sie erhalten einen 6-stelligen Code zur Bestätigung",
        "pt": "Você receberá um código de 6 dígitos para verificar a seguir",
        "ar": "سوف تتلقى رمزًا مكونًا من 6 أرقام للتحقق بعد ذلك",
        "ko": "다음에 확인할 6 자리 코드를 받게됩니다."
      } +
      {
        "en": "Mobile number",
        "fr": "Numéro de portable",
        "es": "Número de teléfono móvil",
        "de": "Handy Nummer",
        "pt": "Número de telemóvel",
        "ar": "رقم الهاتف المحمول",
        "ko": "휴대폰 번호"
      } +
      {
        "en": "Countinue",
        "fr": "Countinue",
        "es": "Countinue",
        "de": "Countinue",
        "pt": "Countinue",
        "ar": "كونتينو",
        "ko": "Countinue"
      } +
      {
        "en": "OR",
        "fr": "OU",
        "es": "O",
        "de": "ODER",
        "pt": "OU",
        "ar": "أو",
        "ko": "또는"
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
        "en": "Forgot Password?",
        "fr": "Mot de passe oublié?",
        "es": "¿Has olvidado tu contraseña?",
        "de": "Passwort vergessen?",
        "pt": "Esqueceu sua senha?",
        "ar": "هل نسيت كلمة السر؟",
        "ko": "비밀번호를 잊으 셨나요?"
      } +
      {
        "en": "Don't have an account? ",
        "fr": "Vous n'avez pas de compte? ",
        "es": "¿No tienes una cuenta? ",
        "de": "Sie haben noch keinen Account? ",
        "pt": "Não tem conta? ",
        "ar": "ليس لديك حساب؟ ",
        "ko": "계정이 없으십니까? "
      } +
      {
        "en": "Create new account",
        "fr": "Créer un nouveau compte",
        "es": "Crear una nueva cuenta",
        "de": "Neuen Account erstellen",
        "pt": "Criar nova conta",
        "ar": "انشاء حساب جديد",
        "ko": "새 계정을 만들"
      } +
      {
        "en": "Login with Email Address",
        "fr": "Connectez-vous avec une adresse e-mail",
        "es": "Iniciar sesión con dirección de correo electrónico",
        "de": "Melden Sie sich mit der E-Mail-Adresse an",
        "pt": "Login com endereço de e-mail",
        "ar": "تسجيل الدخول بعنوان البريد الإلكتروني",
        "ko": "이메일 주소로 로그인"
      } +
      {
        "en": "OR",
        "fr": "OU",
        "es": "O",
        "de": "ODER",
        "pt": "OU",
        "ar": "أو",
        "ko": "또는"
      } +
      {
        "en": "Google",
        "fr": "Google",
        "es": "Google",
        "de": "Google",
        "pt": "Google",
        "ar": "Google",
        "ko": "Google"
      } +
      {
        "en": "Facebook",
        "fr": "Facebook",
        "es": "Facebook",
        "de": "Facebook",
        "pt": "Facebook",
        "ar": "Facebook",
        "ko": "Facebook"
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
        "en": "Login Successful!",
        "fr": "Connexion réussie!",
        "es": "¡Inicio de sesión correcto!",
        "de": "Anmeldung erfolgreich!",
        "pt": "Login bem-sucedido!",
        "ar": "تم تسجيل الدخول بنجاح!",
        "ko": "성공적 로그인!"
      } +
      {
        "en": "Login Failed!",
        "fr": "Échec de la connexion!",
        "es": "¡Error de inicio de sesion!",
        "de": "Fehler bei der Anmeldung!",
        "pt": "Falha no login!",
        "ar": "فشل تسجيل الدخول!",
        "ko": "로그인 실패!"
      } +
      {
        "en":
            "There was an error while authenticating your account. Please try again later",
        "fr":
            "Une erreur s'est produite lors de l'authentification de votre compte. Veuillez réessayer plus tard",
        "es":
            "Hubo un error al autenticar su cuenta. Por favor, inténtelo de nuevo más tarde",
        "de":
            "Bei der Authentifizierung Ihres Kontos ist ein Fehler aufgetreten. Bitte versuchen Sie es später noch einmal",
        "pt":
            "Ocorreu um erro ao autenticar sua conta. Por favor, tente novamente mais tarde",
        "ar": "حدث خطأ أثناء مصادقة حسابك. الرجاء معاودة المحاولة في وقت لاحق",
        "ko": "계정을 인증하는 동안 오류가 발생했습니다. 나중에 다시 시도하세요"
      } +
      {
        "en": "Register",
        "fr": "S'inscrire",
        "es": "Registrarse",
        "de": "Registrieren",
        "pt": "Registro",
        "ar": "يسجل",
        "ko": "레지스터"
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
        "en": "Registration Successful!",
        "fr": "Inscription réussi!",
        "es": "¡Registro exitoso!",
        "de": "Registrierung erfolgreich!",
        "pt": "Registro bem-sucedido!",
        "ar": "تم التسجيل بنجاح!",
        "ko": "등록 성공!"
      } +
      {
        "en": "Registration Failed!",
        "fr": "Échec de l'enregistrement!",
        "es": "¡Registro fallido!",
        "de": "Registrierung fehlgeschlagen!",
        "pt": "Registração falhou!",
        "ar": "فشل في التسجيل!",
        "ko": "등록 실패!"
      } +
      {
        "en":
            "There was an error while registering your account. Please try again later",
        "fr":
            "Une erreur s'est produite lors de l'enregistrement de votre compte. Veuillez réessayer plus tard",
        "es":
            "Hubo un error al registrar su cuenta. Por favor, inténtelo de nuevo más tarde",
        "de":
            "Bei der Registrierung Ihres Kontos ist ein Fehler aufgetreten. Bitte versuchen Sie es später noch einmal",
        "pt":
            "Ocorreu um erro ao registrar sua conta. Por favor, tente novamente mais tarde",
        "ar": "حدث خطأ أثناء تسجيل حسابك. الرجاء معاودة المحاولة في وقت لاحق",
        "ko": "계정을 등록하는 동안 오류가 발생했습니다. 나중에 다시 시도하세요"
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
        "en": "Password Reset",
        "fr": "Réinitialisation du mot de passe",
        "es": "Restablecimiento de contraseña",
        "de": "Passwort zurücksetzen",
        "pt": "Redefinição de senha",
        "ar": "إعادة تعيين كلمة المرور",
        "ko": "비밀번호 초기화"
      } +
      {
        "en": "Password Reset Failed!",
        "fr": "La réinitialisation du mot de passe a échoué!",
        "es": "Error al restablecer la contraseña!",
        "de": "Zurücksetzen des Passworts fehlgeschlagen!",
        "pt": "Falha ao redefinir a senha!",
        "ar": "فشل إعادة تعيين كلمة المرور!",
        "ko": "비밀번호 재설정 실패!"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
