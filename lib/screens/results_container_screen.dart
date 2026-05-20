import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ResultsScreenContainer extends StatefulWidget {
  const ResultsScreenContainer({super.key});

  @override
  State<ResultsScreenContainer> createState() => _ResultsScreenContainerState();
}

class _ResultsScreenContainerState extends State<ResultsScreenContainer> {
  int _resultPageIndex = 0;

  final List<String> _titles = [
    "Seu resultado deu TDAH",
    "Seu resultado deu Dislexia",
    "Seu resultado deu Autismo",
    "Seu resultado indica que você não apresenta algum tipo de Neurodivergência",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6BAAF7),
      appBar: AppBar(
        title: const Text(
          'Resultado Informativo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2B5CE6),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B5CE6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  _titles[_resultPageIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Novamente vamos relembrar que isso é apenas um quiz, não um resultado oficial. Para ter total certeza desta resposta você pode consultar as seguintes clínicas na região de Aracaju:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Divider(height: 25, color: Colors.black26),
                        _buildClinicInfo(
                          name: "Cuidar",
                          loc:
                              "Pio Xii - R. Zaqueu Brandão, 82 - 06 - São José, Aracaju - SE, 49015-330",
                          phone: "(79) 99914-1017",
                        ),
                        _buildClinicInfo(
                          name: "Estrelli",
                          loc:
                              "R. Dr. Humberto Mourão Guimarães, 21 - Jabotiana, Aracaju - SE, 49095-080",
                          phone: "(79) 99631-6354",
                        ),
                        _buildClinicInfo(
                          name: "Equilíbrius Psicologia e Neuropsicologia",
                          loc: "Clinica Elo - Saúde Integrada",
                          phone: "(79) 3085-6878",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Visualizando: ${_resultPageIndex + 1} de 4",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B5CE6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _resultPageIndex = (_resultPageIndex + 1) % 4;
                      });
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text("Próximo Resultado"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClinicInfo({
    required String name,
    required String loc,
    required String phone,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ), // <-- Corrigido aqui (era o erro do Ln 1019)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "- $name",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B5CE6),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "  Localização: $loc",
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Text(
            "  Telefone: $phone",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
