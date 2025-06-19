-- Essa query é que a está sendo utilizada para o painel Faturometro com as informações vindas do sistema RM

SELECT   
    t1.CODCOLIGADA                                             as 'Coligada',
    t2.NOME                                                    as 'Nome_Coligada',
    t1.CODFILIAL					                           as 'Filial',
    t3.NOMEFANTASIA                                            as 'Nome_Filial',
    t1.CODCFO,
    t4.NOMEFANTASIA                                            as 'Nome_Fantasia',
    t4.NOME                                                    as 'Razao_Social',
    t1.NUMEROMOV						                       as 'Numero_Mov',
    t1.IDMOV,
    t1.CODTMV							                       as 'Cod_Mov',
    t5.NOME                                                    as 'Movimento',
    t1.CODTB1FLX							                   as 'CodDesp_Rec',
    t6.DESCRICAO                                               as 'Desp_Rec',
	t1.dataextra2											   as 'competencia',
    format(t1.DATAEMISSAO, 'dd/MM/yyyy')                       as 'Data_Emissao',
    format(t1.DATAEXTRA1, 'dd/MM/yyyy')                        as 'Vencimento',
    CASE t1.status WHEN 'Q' THEN 'QUITADO'
                   WHEN 'F' THEN 'A PAGAR'  
                   WHEN 'P' THEN 'QUITADO PARCIAL' END         as 'SITUAÇÃO',
    cast(t1.VALORBRUTO as money)                               as 'Valor_Bruto',
	cast(t7.valor as money)									   as 'Receita_extra',
	case when cast(t7.valor as money) is not null then 'Sim' 
		 else 'Não' end										   as 'Receita_Extra',
    cast(t1.VALORLIQUIDO as money)                             as 'Valor_Liquido', 
    t1.OBSERVACAO                                              as 'Observacao',
    t1.USUARIOCRIACAO                                          as 'Usuario' 
         
FROM corporerm.dbo.TMOV           as t1 
left join corporerm.dbo.GCOLIGADA as t2 on t2.CODCOLIGADA    = t1.CODCOLIGADA
left join corporerm.dbo.GFILIAL   as t3 on t3.CODCOLIGADA	 = t1.CODCOLIGADA AND 
                                           t3.CODFILIAL		 = t1.CODFILIAL       
left join corporerm.dbo.FCFO      as t4 on t4.CODCOLIGADA	 = t1.CODCOLCFO   AND 
                                           t4.CODCFO		 = t1.CODCFO
left join corporerm.dbo.TTMV      as t5 on t5.CODCOLIGADA	 = t1.CODCOLIGADA AND 
                                           t5.CODTMV		 = t1.CODTMV
left join corporerm.dbo.FTB1      as t6 on t6.CODCOLIGADA	 = t1.CODCOLIGADA AND 
                                           t6.CODTB1FLX		 = t1.CODTB1FLX
left join corporerm.dbo.cpartida  as t7 on isnumeric(t7.INTEGRACHAVE) > 0						and
										   t7.CREDITO in ('3.1.03.01.01.13', '3.1.03.01.01.14') and
										   t7.INTEGRACHAVE	 = t1.IDMOV							and
										   t7.CODCOLIGADA	 = t1.CODCOLIGADA 
										   
WHERE 
	year(t1.DATAEXTRA2) >= 2023 and
    t1.CODTMV LIKE '2.2%' and
    t1.STATUS <> 'C' and
    T1.CODCOLIGADA IN (1,2)


