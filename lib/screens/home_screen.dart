import 'package:flutter/material.dart';
import 'results_container_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final Map<int, String> _userAnswers = {};

  final List<String> _questions = [
    "Você costuma ter muita dificuldade para manter o foco em tarefas longas?",
    "Sons altos, luzes fortes ou muito movimento te incomodam facilmente?",
    "Você troca letras, lê palavras erradas ou tem dificuldade frequente para escrever?",
    "Você esquece compromissos, objetos ou tarefas com frequência?",
    "Você prefere seguir rotinas e fica desconfortável quando algo muda de repente?",
    "Ler textos longos parece mais difícil para você do que para outras pessoas?",
    "Você sente necessidade de se mexer bastante ou fica inquieto facilmente?",
    "Você tem dificuldade para entender expressões sociais, ironias ou conversas?",
    "Você confunde a ordem de letras, números ou palavras mesmo prestando atenção?",
    "Você começa várias coisas ao mesmo tempo e acaba não terminando?",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeModal(context);
    });
  }

  void _showWelcomeModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2B5CE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: const Text(
            'Aviso Importante',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          content: const Text(
            'Agora você irá realizar um pequeno questionário para direcionar você a uma suposta resposta da sua possível Neurodivergência.\n\nLembrete: Esse quiz não é uma Avaliação Neuropsicológica, apenas um guia para possível dúvida!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2B5CE6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Entendi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'NeuroQuest Quiz',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2B5CE6),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          _buildQuizBlock([0, 1, 2]),
          _buildQuizBlock([3, 4, 5]),
          _buildQuizBlock([6, 7, 8]),
          _buildQuizBlock([9]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6BAAF7),
        onPressed: () {
          if (_currentPage < 3) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResultsScreenContainer(),
              ),
            );
          }
        },
        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildQuizBlock(List<int> indices) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: indices.map((index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 30.0,
            ), // <-- Corrigido aqui (era o erro do Ln 791)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Colors.black26, thickness: 1),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: Colors.black26, thickness: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  _questions[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOptionButton(index, 'Sim'),
                    _buildOptionButton(index, 'Não'),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionButton(int questionIndex, String optionText) {
    bool isSelected = _userAnswers[questionIndex] == optionText;

    return SizedBox(
      width: 140,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFE0E0E0),
          side: BorderSide(
            color: isSelected ? const Color(0xFFF2A65A) : Colors.transparent,
            width: 3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          setState(() {
            _userAnswers[questionIndex] = optionText;
          });
        },
        child: Text(
          optionText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}