import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/providers/surahs_providers.dart';

class SurahDetailsPage extends ConsumerWidget {
  final int surahNumber;
  final String surahName;
  final String surahEnglishName;
  const SurahDetailsPage({
    super.key,
    required this.surahNumber,
    required this.surahName,
    required this.surahEnglishName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahEnglishRef = ref.watch(surahEnglishProvider(surahNumber));
    final surahAraRef = ref.watch(surahAraProvider(surahNumber));

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Text(surahEnglishName),
            const Spacer(),
            Text(surahName),
          ],
        ),
      ),
      body: SafeArea(
        child: surahAraRef.when(
            data: (ara) {
              return surahEnglishRef.when(
                data: (eng) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: ara.ayahs.length,
                    itemBuilder: (context, index) {
                      final ayahAra = ara.ayahs[index];
                      final ayahEng = eng.ayahs[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          ayahAra.text,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(ayahEng.text),
                        leading: CircleAvatar(
                          child: Text(
                            ayahAra.numberInSurah.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        minLeadingWidth: 24,
                        isThreeLine: true,
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                },
                error: (error, stack) {
                  print(stack);
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                loading: () {
                  return const Center(child: CupertinoActivityIndicator());
                },
              );
            },
            error: (error, stackTrace) {
              print(stackTrace);
              return Center(child: Text(error.toString()));
            },
            loading: () => const Center(child: CupertinoActivityIndicator())),
      ),
    );
  }
}
