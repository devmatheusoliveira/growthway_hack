---
name: flutter_widget_best_practices
description: Define padrões de modularização para widgets Flutter, proibindo o uso de métodos auxiliares que retornam widgets em favor de classes separadas e arquivos individuais para cada componente.
---

# Flutter Widget Best Practices - Visão Geral

Este documento define as regras fundamentais e pontos de entrada para estruturação de código no projeto Flutter, focando em performance, legibilidade e manutenção.

As regras estão divididas em documentações específicas dentro da pasta `docs/`. Você **OBRIGATORIAMENTE DEVE** ler cada um deles quando aplicável ao seu desafio. 

## Índice de Documentações

1. **[01_modularization.md](docs/01_modularization.md)**
   * Como criar e nomear arquivos de widgets sem cometer o anti-padrão de métodos auxiliares.
   * Quando extrair widgets para pastas específicas ou compartilhadas (`features/` vs `shared/`).
   * Como lidar com separação de arquivos para `CustomPainter`.
2. **[02_helpers_utils.md](docs/02_helpers_utils.md)**
   * Boas práticas para arquivos de lógica, validadores, constantes e helpers.
3. **[03_data_models.md](docs/03_data_models.md)**
   * Como organizar e nomear classes de Modelo/Entidades de dados no app.
4. **[04_summary.md](docs/04_summary.md)**
   * Checklist final do que é **proibido** e do que é **obrigatório** em qualquer modificação ou criação de código. (Inclui a regra de **Proibido usar comentários**).

🚀 **Use a referência exata nos arquivos `docs/` se tiver dúvidas sobre algum dos cenários acima.**
