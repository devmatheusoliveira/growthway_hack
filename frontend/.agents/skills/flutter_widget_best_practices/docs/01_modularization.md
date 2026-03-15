# Modularização de Componentes e Widgets

## 🚫 Padrão Ruim: Métodos auxiliares de build

Definir widgets como métodos dentro de uma classe (ex: `Widget _buildHeader()`) ou como variáveis é considerado um anti-padrão no Flutter por vários motivos:
1. **Performance**: O Flutter não consegue otimizar a reconstrução (rebuild) de partes específicas da tela. Todo o widget pai será reconstruído se o estado mudar.
2. **Contexto**: O `BuildContext` pode se tornar confuso ou inválido se passado incorretamente entre métodos.
3. **Reutilização/Testabilidade**: Widgets em métodos não podem ser reutilizados em outras telas ou testados unitariamente de forma isolada.
4. **Poluição**: Arquivos de View tornam-se extensos e difíceis de navegar.

---

## ✅ Padrão Correto: Widgets como Classes em Arquivos Separados

Todo componente de UI deve ser extraído para sua própria classe (`StatelessWidget` ou `StatefulWidget`) e residir em um **arquivo separado**. Mesmo pequenos componentes internos devem ser isolados em arquivos próprios para manter a clareza e facilitar futuras expansões.

### 💡 Generalização vs. Especificidade

Antes de criar um novo widget específico, verifique se o comportamento pode ser **generalizado**. 
- **Proibido**: Criar múltiplos arquivos para componentes que fazem exatamente a mesma coisa mudando apenas variáveis simples (textos, ícones, cores).
- **Obrigatório**: Se vários componentes compartilham a mesma estrutura, crie um único widget parametrizado (ex: `HomePlaceholderWidget(String title)`) em vez de múltiplos widgets específicos (ex: `HomeTabAWidget`, `HomeTabBWidget`).
- **Exceção**: Widgets extremamente simples e não reutilizáveis (ex: um `SizedBox` com um `Text` servindo apenas de rótulo fixo) podem permanecer inline se não adicionarem complexidade ao método `build`.

### Convenção de Nomenclatura de Arquivos:

- **Sufixo Obrigatório**: Todos os arquivos de widgets devem terminar com o sufixo `_widget.dart`.
- **Exemplo**: `login_button_widget.dart`, `custom_card_widget.dart`.

### 🎨 Widgets com CustomPainter:

- Quando um componente utilizar desenho customizado via `CustomPainter`, a classe do widget e a classe do painter devem ser divididas em dois arquivos distintos no mesmo diretório.
- **Widget**: `nome_do_componente_widget.dart` (contém a classe do widget).
- **Painter**: `nome_do_componente_painter.dart` (contém a classe que estende `CustomPainter`).
- **Motivo**: Evita arquivos massivos e mantém a lógica de layout/estado do widget isolada da lógica matemática de pintura em `Canvas`.

### Estratégia de Organização de Arquivos:

1. **Widgets de Feature (Locais)**:
   - Se o widget é usado apenas em uma feature específica (ex: `auth`), ele deve ficar na pasta `lib/features/<feature_name>/widgets/`.
   - Exemplo: `lib/features/auth/widgets/auth_header_widget.dart`.

2. **Widgets Globais (Shared)**:
   - Se o widget é reaproveitado em mais de uma feature ou em várias telas diferentes, ele deve ser movido para a pasta `shared`.
   - Local: `lib/shared/widgets/`.
   - Exemplo: `lib/shared/widgets/app_button_widget.dart`.

### Exemplo de Refatoração Correta:

#### 1. Widget de Alto Nível (Composição)
`lib/features/auth/widgets/login_header_widget.dart`
```dart
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(gradient: AppDecorations.gradientOrange),
      child: Column(
        children: [
          Image.asset('assets/images/atvos_logo_dark.png', height: 36),
          const SizedBox(height: 12),
          const AccessTypeBadgeWidget(), // Outro widget em arquivo separado
        ],
      ),
    );
  }
}
```

#### 2. Sub-componente em Arquivo Separado
`lib/features/auth/widgets/access_type_badge_widget.dart`
```dart
class AccessTypeBadgeWidget extends StatelessWidget {
  const AccessTypeBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```


#### 3. Uso na View Principal
`lib/features/auth/views/login_page.dart`
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        const LoginHeader(), // Importado e limpo
        // ... restante dos componentes em arquivos separados
      ],
    ),
  );
}
```
