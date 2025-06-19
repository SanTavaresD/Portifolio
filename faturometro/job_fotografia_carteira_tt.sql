-- Esse job trabalha para manter atualizada as informações da carteira vindo do sistema TT

with cte_1 as (
	select  
		CTR_NRO,
		CTR_DTA,
		RAI_DSC,
		FIL_DSC,
		EMP_IDE,
		EMP_APE,
		EMP_NOM_COM,
		OGA_NOT,
		OGA_DIU,
		FCT_DSC,
		cast(CTR_VAL_TOT as money) as 'contrato',
		cast(CPR_VAL_TOT as money) as 'produto',
		LTR_DSC,
		PRD_NOM,
		CPR_DTA_INI,
		CPR_DTA_INI_FAT,
		CPR_DTA_FIN_FAT,
		CPR_FLG_ENC,
		case when CPR_FLG_EXT = 1 or CME_IDE = 17 or PRD_NOM like('%Serviço Extra%') then 'Sim' else 'Não' end as 'servico_extra'
	FROM [GR2DB\PRODUCAO].[SM].dbo.v_com_contratos_detalhado
	where 
		CPR_FLG_ENC = 0 and -- 0 é porque está ativo  and--and ctr_nro = '255/2022' and
		FCT_DSC <> 'Elaboração' and --and
		case when CPR_DTA_fin_FAT is null then 'ok' 
			 when year(CPR_DTA_FIN_FAT) = year(getdate()) and month(CPR_DTA_FIN_FAT) = month(getdate()) then 'ok'
			 else 'não ok' end = 'ok'
		--and CTR_NRO = '360/2018'
),
cte_2 as (
	select  
		CTR_NRO,
		CTR_DTA,
		RAI_DSC,
		FIL_DSC,
		EMP_IDE,
		EMP_APE,
		EMP_NOM_COM,
		OGA_NOT,
		OGA_DIU,
		FCT_DSC,
		cast(CTR_VAL_TOT as money) as 'contrato',
		cast(CPR_VAL_TOT as money) as 'produto',
		LTR_DSC,
		PRD_NOM,
		CPR_DTA_INI,
		CPR_DTA_INI_FAT,
		CPR_DTA_FIN_FAT,
		CPR_FLG_ENC,
		case when CPR_FLG_EXT = 1 or CME_IDE = 17 or PRD_NOM like('%Serviço Extra%') then 'Sim' else 'Não' end as 'servico_extra'
	FROM [GR2DB\PRODUCAO].[SM].dbo.v_com_contratos_detalhado
	where 
		CPR_FLG_ENC = 1 and -- 1 É porque está encerrado
		FCT_DSC <> 'Elaboração' and 
		year(CPR_DTA_FIN) = year(getdate()) and
		month(CPR_DTA_FIN) = month(getdate()) 
		--and CTR_NRO = '360/2018'
),
cte_3 as (
	select * from cte_1
	union 
	select * from cte_2 
	--where ctr_nro = '255/2022'
)
,
cte_4 as (
	select 
		CTR_NRO,
		CTR_DTA,
		CPR_DTA_INI,
		CPR_DTA_INI_FAT,
		CPR_DTA_FIN_FAT,
		contrato,
		produto,
		fct_dsc,
		prd_nom,
		servico_extra,
		CPR_FLG_ENC,
		case when fct_dsc = 'Em Vigência' and year(CPR_DTA_INI_FAT) = year(getdate()) and month(CPR_DTA_INI_FAT) = month(getdate()) and CPR_DTA_FIN_FAT is null then
				cast(round(produto * (day(eomonth(CPR_DTA_INI_FAT)) - day(CPR_DTA_INI_FAT)) / day(eomonth(CPR_DTA_INI_FAT)), 2) as money)
			 when fct_dsc = 'Em Vigência' and year(CPR_DTA_FIN_FAT) = year(getdate()) and month(CPR_DTA_FIN_FAT) = month(getdate()) and day(CPR_DTA_FIN_FAT) - day(CPR_DTA_INI_FAT) <> 0 then
				cast(round(produto * day(CPR_DTA_FIN_FAT) / day(eomonth(CPR_DTA_FIN_FAT)), 2) as money)
			 when fct_dsc = 'Encerrado' and year(CPR_DTA_FIN_FAT) = year(getdate()) and month(CPR_DTA_FIN_FAT) = month(getdate()) then 
		 		cast(round(produto * (day(eomonth(CPR_DTA_FIN_FAT)) - day(CPR_DTA_FIN_FAT)) / day(eomonth(CPR_DTA_FIN_FAT)), 2) as money)
			 when year(CPR_DTA_INI_FAT) > year(getdate()) or
				  year(CPR_DTA_INI_FAT) = year(getdate()) and month(CPR_DTA_INI_FAT) > month(getdate()) then
				0
			 when fct_dsc = 'Encerrado' and CPR_DTA_FIN_FAT is null then 
		 		produto 
			 when fct_dsc = 'Em Vigência' then produto 
	    end as 'valor_total_contrato_recalculado'
	from cte_3
	--where 
		--year(CPR_DTA_FIN_FAT) = 2023  --month(CPR_DTA_FIN_FAT) >= 1 --and 
		----year(CPR_DTA_ini_FAT) = 2023 and month(CPR_DTA_ini_FAT) = 12 and
		--servico_extra = 'não' and
		--fct_dsc = 'Encerrado'
	--order by
	--	--CPR_DTA_INI, 
	--	CPR_DTA_fin_FAT desc
)

insert into sm.dbo.t_faturometro_fotografia_carteira (data_dados, valor_carteira, servico_extra)

select top 1
	format(dateadd(day, -1, getdate()), 'yyyy-MM-dd 00:00:0000')	as 'data_dados',
	sum(valor_total_contrato_recalculado)							as 'valor_total_contrato_recalculado',
	servico_extra
from cte_4
group by
	servico_extra
