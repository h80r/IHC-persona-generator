// Packages
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Components
import 'package:persona_generator/components/persona_card.dart';
import 'package:persona_generator/components/footer.dart';

// Models
import 'package:persona_generator/models/page_data.dart';

// Services
import 'package:persona_generator/services/services.dart';

// Notifiers
import 'package:persona_generator/notifiers/page_notifier.dart';

// Providers
final _pageProvider = StateNotifierProvider<PageNotifier, PageData>((ref) {
  return PageNotifier(
    ref.watch(dataServiceProvider),
    ref.watch(imageServiceProvider),
  );
});

class PersonaPage extends ConsumerWidget {
  const PersonaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final pageData = watch(_pageProvider);
    final pageNotifier = watch(_pageProvider.notifier);

    return pageData.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Persona Generator'),
            ),
            body: Center(
              child: PersonaCard(
                personaData: pageData.personaData!,
                personaImage: pageData.personaImage!,
                personaDescription: pageData.personaDescription!,
              ),
            ),
            bottomSheet: const Footer(),
            floatingActionButton: CircularMenu(
              alignment: Alignment.bottomRight,
              items: [
                CircularMenuItem(
                  onTap: pageNotifier.generatePersona,
                  icon: Icons.refresh,
                ),
                CircularMenuItem(
                  onTap: () {},
                  icon: Icons.save,
                ),
              ],
            ),
          );
  }
}
