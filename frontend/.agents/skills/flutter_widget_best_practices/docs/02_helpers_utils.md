# Helpers de Lógica (Utils)

Para funções utilitárias, extensões ou classes que encapsulam lógica de negócio sem estado de UI, siga estas convenções:

### Convenção de Nomenclatura:
- **Sufixo Obrigatório**: Classes ou arquivos de utilitários devem terminar com o sufixo `_util.dart` ou `_helper.dart` para arquivos, e a classe correspondente pode ter `Util` ou `Helper` no nome.
- **Exemplo**: `date_formatter_util.dart`, `string_helper.dart`.

### Organização de Arquivos:
1. **Helpers de Feature (Locais)**:
   - Devem residir na pasta `lib/features/<feature_name>/utils/`.
   - Exemplo: `lib/features/auth/utils/auth_validator_util.dart`.

2. **Helpers Globais (Shared)**:
   - Devem residir na pasta `lib/shared/utils/`.
   - Exemplo: `lib/shared/utils/app_constants.dart`, `lib/shared/utils/date_formatter_util.dart`.
