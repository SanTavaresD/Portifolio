
# Projeto: Faturometro

## 💡 Objetivo
Análise comparativa entre o direito de faturar ou seja, aquilo que está em contrato com o que foi faturado

## 🛠️ Ferramentas Utilizadas
- SQL
- Power BI
- Python

## 📊 Descrição
- Foi analisado junto com o setor de gestão de contratos os itens com os preços que eram passados para os clientes e isso compõe o que chamamos de carteira. O que eram faturado era analisado junto com o setor de faturamento com base na emissão das notas fiscais e distribuido pela data de competencia
- Foi identificado alguns gaps onde alguns itens não eram lançados no sistema, foi criado relatórios diários com base no contrato.

## 📁 Estrutura do Projeto
- `formula_dax_para_calculo.txt`: Algumas fórmulas para criação dos copos
- `job_fotografia_carteira_tt.sql`: Job que cria os relatórios para gestão de contratos
- `query_rm`: Consulta que permite ter acesso a base que extrai as informações do que foi faturado
- `query_tt`: Consulta que leva aquilo que está em contrato para o painel
- `robo_carteira.ipynb`: Robo que cria o relatório com base no contrato e disponibiliza em uma pasta
- `faturometro.png`: imagem do dashboard

## 🔍 Resultados 
- Visibilidade aumentada para o time de Stackholders, Faturamento e Gestão de Contratos
- Correção de processo
- Insights segmentados por mes de competencia
