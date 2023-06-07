import 'package:asthma_monitor/data/model/response/language_model.dart';
import 'package:asthma_monitor/utill/images.dart';

class AppConstants {
  static const String BASE_URL = 'https://asthmamonitor.online/api/';

  static const String REGISTER_URI = 'auth/register';
  static const String LOGIN_URI = 'auth/login';

  static const String PROFILE = 'profile';
  static const String GLUECOSE_MONITORING = 'gluecose_monitoring';
  static const String ANALYZE = 'analize';
  static const String BODY_ANALYZE = 'analize/body';
  static const String ENVI_ANALYZE = 'analize/envi';
  static const String MIND_ANALYZE = 'analize/mind';
  static const String RESULT = 'result';

  // Shared Key
  static const String ID_USER = 'id_user';
  static const String EMAIL = 'email';
  static const String NAME = 'name';
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.united_kindom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Indonesian',
        countryCode: 'ID',
        languageCode: 'id'),
  ];
}
