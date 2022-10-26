import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:quran_app/helpers/apis.dart';
import 'package:quran_app/models/surah_arabic_model.dart';
import 'package:quran_app/models/surah_english_model.dart';
import 'package:quran_app/models/surah_title_model.dart';

final surahsFutureProvider = FutureProvider<List<SurahTitleModel>>((ref) async {
  final response = await get(Uri.parse(surahs));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final surahs = data['data'] as List;

    return surahs.map((surah) => SurahTitleModel.fromJson(surah)).toList();
  } else {
    throw Exception('Failed to load surahs');
  }
});

final surahEnglishProvider =
    FutureProvider.family<SurahEnglishModel, int>((ref, surahNumber) async {
  final response = await get(Uri.parse(getSurahInEnglish(surahNumber)));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final surah = data['data'];

    return SurahEnglishModel.fromJson(surah);
  } else {
    throw Exception('Failed to load surahs');
  }
});

//surahAraProvider
final surahAraProvider =
    FutureProvider.family<SurahArabicModel, int>((ref, surahNumber) async {
  final response = await get(Uri.parse(getSurahInAra(surahNumber)));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final surah = data['data'];

    return SurahArabicModel.fromJson(surah);
  } else {
    throw Exception('Failed to load surahs');
  }
});
