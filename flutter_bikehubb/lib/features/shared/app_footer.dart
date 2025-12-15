import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0f1419),
        border: Border(
          top: BorderSide(
            color: Color(0xFF0f1419),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          // Logo e descrição
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bikehubb_logo.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'BikeHubb',
                      style: TextStyle(
                        color: Color(0xFF22c55e),
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'A maior plataforma de compra e venda de bicicletas do Brasil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Divider(
            color: Colors.white24,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(height: 30),
          // Links rápidos
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 16,
              children: [
                _buildFooterLink('Sobre Nós'),
                _buildFooterLink('Política de Privacidade'),
                _buildFooterLink('Termos de Uso'),
                _buildFooterLink('Contato'),
                _buildFooterLink('FAQ'),
                _buildFooterLink('Como Funciona'),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Redes sociais
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook),
              SizedBox(width: 16),
              _buildSocialIcon(Icons.language),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.camera_alt),
                color: Colors.white70,
                iconSize: 28,
                onPressed: () {},
              ),
              SizedBox(width: 16),
              _buildSocialIcon(Icons.phone),
            ],
          ),
          SizedBox(height: 30),
          Divider(
            color: Colors.white24,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(height: 20),
          // Copyright
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  '© ${DateTime.now().year} BikeHubb. Todos os direitos reservados.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Desenvolvido por ',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'LegacyCorp',
                      style: TextStyle(
                        color: Color(0xFF22c55e),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'CNPJ: 00.000.000/0001-00',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return InkWell(
      onTap: () {
        print('Clicou em: $text');
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 13,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.white70,
      iconSize: 28,
      onPressed: () {
        print('Clicou no ícone social');
      },
    );
  }
}
