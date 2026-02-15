import 'package:flutter/material.dart';
import '../main.dart';
import '../models/item_model.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final List<String> categories = [
    'Alimentos',
    'Suplementos',
    'Higiene',
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: itemController,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Estoque'),
            bottom: TabBar(
              controller: _tabController,
              tabs: categories
                  .map((c) => Tab(text: c))
                  .toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: categories.map((category) {

              final items =
                  itemController.byCategory(category);

              if (items.isEmpty) {
                return const Center(
                  child: Text('Nenhum item nessa categoria'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle:
                          Text('Qtd: ${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          /// EDITAR
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(item);
                            },
                          ),

                          /// EXCLUIR
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              itemController.remove(item.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showEditDialog(ItemModel item) {
    final controller = TextEditingController(
      text: item.quantity.toString(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Editar ${item.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Quantidade'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final newQty =
                  int.tryParse(controller.text) ?? 0;

              itemController.updateQuantity(
                  item.id, newQty);

              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
