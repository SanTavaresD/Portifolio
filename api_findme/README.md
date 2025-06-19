# Projeto: API FindMe

## 💡 Objetivo
Automatizar o relatório diário referente a eficiencia da operação

## 🛠️ Ferramentas Utilizadas
- Python
- Pandas
- API do fornecedor
- API Google Sheets
- Google Sheets
- SQL

## 📊 Descrição
Projeto fictício baseado em experiências reais. 
- Este projeto busca a automação de relatórios operacionais recorrentes que antes eram produzidos manualmente.  
O script:
1. Aciona a API do fornecedor para criar duas listas, uma de região e outra de clientes
2. Constrói a tabela de eficiência da região e cliente
3. Contrói uma tabela nula para deletar os dados contidos na planilha
4. Inseri a tabela de eficiência da região e cliente na planilha
   
## 📁 Estrutura do Projeto
- `tabelas_api_findme.ipynb`: script principal

## 🔍 Resultados Esperados
- Redução de 90% no tempo de execução do processo
- Eliminação de falhas humanas em fórmulas e cópias
- Execução agendada com envio automático via agendador de tarefas do windowns
