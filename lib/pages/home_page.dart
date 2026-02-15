import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/dashboard_card.dart';
import 'add_item_page.dart';
import 'items_page.dart';
import 'register_exit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        itemController,
        themeController,
      ]),
      builder: (context, _) {
        final isDark =
            Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Stocks'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  themeController.isDark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  themeController.toggleTheme();
                },
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddItemPage(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            child: ListView(
              children: [

                /// TÍTULO
                Text(
                  'Visão Geral',
                  style:
                      Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 14),

                /// GRID PRINCIPAL
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.9,
                  children: [

                    /// TOTAL
                    DashboardCard(
                      title: 'Total',
                      value: itemController.items.length
                          .toString(),
                      icon: Icons.inventory_2,
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ItemsPage(),
                          ),
                        );
                      },
                    ),

                    /// ESTOQUE BAIXO
                    DashboardCard(
                      title: 'Baixo',
                      value: itemController.lowStock.length
                          .toString(),
                      icon:
                          Icons.warning_amber_rounded,
                      color: Colors.red,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ItemsPage(),
                          ),
                        );
                      },
                    ),

                    /// VENCIMENTO
                    DashboardCard(
                      title: 'Vencimento',
                      value: itemController.nearExpiry
                          .length
                          .toString(),
                      icon: Icons.access_time,
                      color: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ItemsPage(),
                          ),
                        );
                      },
                    ),

                    /// SAÍDA
                    DashboardCard(
                      title: 'Saída',
                      value: 'Registrar',
                      icon:
                          Icons.remove_circle_outline,
                      color: Colors.deepOrange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RegisterExitPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                /// GERENCIAR
                Text(
                  'Gerenciar',
                  style:
                      Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 12),

                DashboardCard(
                  title: 'Estoque',
                  value:
                      '${itemController.items.length} itens',
                  icon: Icons.list_alt,
                  color: isDark
                      ? Colors.grey.shade800
                      : Colors.grey.shade700,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ItemsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
