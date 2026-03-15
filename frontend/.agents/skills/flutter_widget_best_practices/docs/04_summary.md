# O que fazer agora? (Resumo geral das regras)

- **Proibido**: Usar `_buildSomething()` ou classes privadas (`_MyWidget`) no mesmo arquivo da View/Page.
- **Proibido**: Comentários no código. O código deve ser limpo e autoexplicativo, dispensando qualquer comentário de documentação ou explicação.
- **Proibido**: Definir classes de dados/modelos dentro de arquivos de widgets.
- **Obrigatório**: Criar um arquivo `.dart` para cada widget extraído com sufixo `_widget.dart`.
- **Obrigatório**: Criar um arquivo `.dart` para cada modelo com sufixo `_model.dart` e classe terminando em `Model`.
- **Decisão de Pasta**:
  - Uso único na feature? -> `lib/features/<feature>/widgets/` ou `lib/features/<feature>/models/`
  - Uso em múltiplas telas/features? -> `lib/shared/widgets/` ou `lib/shared/models/`
