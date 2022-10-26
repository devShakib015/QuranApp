const String _baseUrl = 'https://api.alquran.cloud/v1/';

const String surahs = '${_baseUrl}surah';
String getSurahInEnglish(int surahNumber) =>
    "${_baseUrl}surah/$surahNumber/en.asad";

String getSurahInAra(int surahNumber) => "${_baseUrl}surah/$surahNumber";
