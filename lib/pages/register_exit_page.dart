import 'package:flutter/material.dart';
import '../main.dart';
import '../models/item_model.dart';

class RegisterExitPage extends StatefulWidget {
  const RegisterExitPage({super.key});

  @override
  State<RegisterExitPage> createState() => _RegisterExitPageState();
}

class _RegisterExitPageState extends State<RegisterExitPage> {
  ItemModel? selectedItem;
  final TextEditingController quantityController =
      TextEditingController();

  void registerExit() {
    if (selectedItem == null) return;

    final quantity =
        int.tryParse(quantityController.text) ?? 0;

    if (quantity <= 0) return;

    final newQuantity =
        selectedItem!.quantity - quantity;

    itemController.updateQuantity(
      selectedItem!.id,
      newQuantity < 0 ? 0 : newQuantity,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final items = itemController.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Saída'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Dropdown de itens
            DropdownButtonFormField<ItemModel>(
              value: selectedItem,
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                          '${item.name} (Qtd: ${item.quantity})'),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Selecionar Item',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// Quantidade
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade a retirar',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            /// Botão
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: registerExit,
                child: const Text('Confirmar Saída'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
