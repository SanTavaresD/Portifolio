# Projeto: API FindMe

## 💡 Objetivo
Automatizar o relatório em tempo real das vagas que são apertas através da plataforma Pandapé

## 🛠️ Ferramentas Utilizadas
- Python
- Pandas
- API do fornecedor
- API Google Sheets
- Google Sheets

## 📊 Descrição
- Este projeto busca a automação de relatórios recorrentes que antes eram produzidos manualmente.  
São básicamente cinco scripts.
O primeiro **Request1**:
1. Pega todas as RPs de 2024 até hoje
2. Inseri essas RPs em uma planilha no Google Sheets

O segundo **Request2**:
1. Aciona a API do Google Sheets para ler as informações das RPs inseridas pelo primeiro script
2. Para fazer a atualização da planilha sem ter que ficar acionando a API do Pandapé, o robo entra na segunda ABA da planilha para ler os dados que estão lá
3. Ele verifica se as RPs sofreram algum tipo de atualização, se algo foi modificado então ele coloca essa RP em uma lista junto com as RPs que não estão nessa segunda ABA
4. O robo então aciona a API do Pandapé para buscar os detalhes de cada RP contida na lista
5. Inseri esses dados na segunda ABA

O terceiro **Request2_CustumField**:
Faz o mesmo que o segundo script, porém esse já pega os campos customizados

O quarto **dePara_CustumField1**:
São tabelas de DePara dos campos customizados

O quinto **Datasource**:
Também são tabelas de DePara mais genérica
   
## 📁 Estrutura do Projeto
- `API_Pandape_Request1`: script que pega as informações das RPs
- `API_Pandape_Request3`: script que pega as informações detalhadas das RPs
- `API_Pandape_Request2_CustumField`: script que pega as informações dos campos customizados das RPs
- `API_Pandape_dePara_CustumField1`: São tabelas de DePara dos campos customizados
- `API_Pandape_dePara_CustumField1`: Também são tabelas de DePara mais genérica


## 🔍 Resultados Esperados
- Redução de 75% no tempo de execução do processo
- Eliminação de falhas humanas em fórmulas e cópias
- Execução agendada com envio automático via agendador de tarefas do windowns
