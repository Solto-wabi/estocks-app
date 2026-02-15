import 'package:flutter/material.dart';
import '../controllers/donation_controller.dart';
import '../controllers/item_controller.dart';

class RegisterDonationPage extends StatefulWidget {
  const RegisterDonationPage({super.key});

  @override
  State<RegisterDonationPage> createState() =>
      _RegisterDonationPageState();
}

class _RegisterDonationPageState
    extends State<RegisterDonationPage> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _partnerController = TextEditingController();

  final DonationController _donationController =
      DonationController();
  final ItemController _itemController = ItemController();

  String? _selectedItem;
  bool _isReceiving = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Doação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// Tipo de operação
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isReceiving ? Colors.green : null,
                      ),
                      onPressed: () {
                        setState(() {
                          _isReceiving = true;
                        });
                      },
                      child: const Text("Receber"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !_isReceiving ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          _isReceiving = false;
                        });
                      },
                      child: const Text("Doar"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Seleção de item
              DropdownButtonFormField<String>(
                value: _selectedItem,
                decoration:
                    const InputDecoration(labelText: 'Item'),
                items: _itemController.items
                    .map(
                      (item) => DropdownMenuItem(
                        value: item.name,
                        child: Text(item.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Selecione um item' : null,
              ),

              const SizedBox(height: 16),

              /// Quantidade
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Quantidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantidade';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Digite um número válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Parceiro
              TextFormField(
                controller: _partnerController,
                decoration: InputDecoration(
                  labelText: _isReceiving
                      ? 'Recebido de (opcional)'
                      : 'Doado para (opcional)',
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _save,
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final quantity =
          int.parse(_quantityController.text);

      if (_isReceiving) {
        _donationController.registerReceived(
          itemName: _selectedItem!,
          quantity: quantity,
          from: _partnerController.text.isEmpty
              ? null
              : _partnerController.text,
        );
      } else {
        _donationController.registerGiven(
          itemName: _selectedItem!,
          quantity: quantity,
          to: _partnerController.text.isEmpty
              ? null
              : _partnerController.text,
        );
      }

      Navigator.pop(context);
    }
  }
}
