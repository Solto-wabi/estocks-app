import 'package:flutter/material.dart';
import '../pages/items_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          // TÍTULO
          const Expanded(
            child: Text(
              "Meus Estoques",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // BOTÃO PARA ABRIR A LISTA DE ITENS
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ItemsPage(), // ⚠️ NÃO pode ser const
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
