# Modelos de Dados e Entidades

Assim como os widgets, os modelos de dados (data models) usados para passar informações entre componentes devem seguir padrões rigorosos de nomenclatura e organização.

### Convenção de Nomenclatura:
- **Sufixo Obrigatório**: Todas as classes de modelo de dados devem terminar com o sufixo `Model`. 
- **Exemplo**: Use `EquipamentoKpiModel` em vez de `EquipamentoKpiData`.

### Organização de Arquivos:
1. **Modelos de Feature (Locais)**:
   - Devem residir na pasta `lib/features/<feature_name>/models/`.
   - Exemplo: `lib/features/equipamentos/models/equipamento_kpi_model.dart`.

2. **Modelos Globais (Shared)**:
   - Devem residir na pasta `lib/shared/models/`.
   - Exemplo: `lib/shared/models/user_model.dart`.
