// Filter options
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final filterOptions = ['Tinder', 'Hinge', 'Raya', 'Grindr'];

// Selected filter state provider
final selectedFilterProvider = StateProvider<String>((ref) => 'Tinder');

class ChipFilter extends ConsumerWidget {
  const ChipFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedFilterProvider);
    final notifier = ref.read(selectedFilterProvider.notifier);

    return Wrap(
      spacing: 8,
      children: filterOptions.map((filter) {
        final isSelected = selected == filter;
        return ChoiceChip(
          label: Text(filter),
          selected: isSelected,
          onSelected: (_) => notifier.state = filter,
          selectedColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
