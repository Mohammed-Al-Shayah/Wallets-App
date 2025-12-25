import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';

class CreateWalletBottomSheet extends StatefulWidget {
  const CreateWalletBottomSheet({super.key});

  @override
  State<CreateWalletBottomSheet> createState() =>
      _CreateWalletBottomSheetState();
}

class _CreateWalletBottomSheetState extends State<CreateWalletBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'main';
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Create Wallet', style: TextStyles.blue20Bold),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Choose a type and currency to spin up a new wallet.',
              style: TextStyles.gray14,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Wallet Type', style: TextStyles.black16Medium),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: [
                          _TypeChip(
                            label: 'Main',
                            value: 'main',
                            selectedValue: _type,
                            onSelect: (v) => setState(() => _type = v),
                          ),
                          _TypeChip(
                            label: 'Saving',
                            value: 'saving',
                            selectedValue: _type,
                            onSelect: (v) => setState(() => _type = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      DropdownButtonFormField<String>(
                        value: _currency,
                        items: const [
                          DropdownMenuItem(value: 'USD', child: Text('USD')),
                          DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                          DropdownMenuItem(value: 'SAR', child: Text('SAR')),
                          DropdownMenuItem(value: 'QAR', child: Text('QAR')),
                          DropdownMenuItem(value: 'EGP', child: Text('EGP')),
                          DropdownMenuItem(value: 'ILS', child: Text('ILS')),
                        ],
                        onChanged: (v) => setState(() => _currency = v!),
                        decoration: InputDecoration(
                          labelText: 'Currency',
                          prefixIcon: const Icon(Icons.public),
                          filled: true,
                          fillColor: ColorsManager.grayBackGround,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => _submit(context),
                child: const Text('Create Wallet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<HomeCubit>()
          .createWallets(type: _type, currency: _currency);
    }
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelect,
  });

  final String label;
  final String value;
  final String selectedValue;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == selectedValue;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(value),
      labelStyle: isSelected ? TextStyles.white16Medium : TextStyles.black14Medium,
      selectedColor: ColorsManager.mainBlue,
      backgroundColor: ColorsManager.grayBackGround,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? ColorsManager.mainBlue : Colors.transparent,
        ),
      ),
    );
  }
}
