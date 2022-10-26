import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/providers/surahs_providers.dart';
import 'package:quran_app/views/surah_details_page.dart';

class SurahsPage extends ConsumerWidget {
  const SurahsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsRef = ref.watch(surahsFutureProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('The Noble Quran'), centerTitle: true),
      body: SafeArea(
        child: surahsRef.when(
          data: (surahs) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                final surah = surahs[index];
                return ListTile(
                  title: Text(surah.name),
                  subtitle: Row(
                    children: [
                      Text(
                          '${surah.englishName} | ${surah.englishNameTranslation}'),
                    ],
                  ),
                  trailing: Text(surah.numberOfAyahs.toString()),
                  leading: Text(surah.number.toString()),
                  minLeadingWidth: 16,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SurahDetailsPage(
                        surahNumber: surah.number,
                        surahName: surah.name,
                        surahEnglishName: surah.englishName,
                      );
                    }));
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 0),
            );
          },
          error: (error, stack) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}
