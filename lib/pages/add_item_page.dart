import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/item_model.dart';
import '../main.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final uuid = const Uuid();

  String _selectedCategory = 'Alimentos';
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveItem() {
    if (_nameController.text.isEmpty ||
        _quantityController.text.isEmpty) {
      return;
    }

    final item = ItemModel(
      id: uuid.v4(),
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      category: _selectedCategory,
      expiresAt: _selectedDate,
    );

    itemController.add(item);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: const [
                DropdownMenuItem(
                    value: 'Alimentos',
                    child: Text('Alimentos')),
                DropdownMenuItem(
                    value: 'Suplementos',
                    child: Text('Suplementos')),
                DropdownMenuItem(
                    value: 'Higiene',
                    child: Text('Higiene')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              decoration:
                  const InputDecoration(labelText: 'Categoria'),
            ),

            const SizedBox(height: 16),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data de vencimento'),
              subtitle: Text(
                _selectedDate == null
                    ? 'Selecionar data'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
