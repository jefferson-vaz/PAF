select--Cadastro de Locais de Produção --> Ocupação Cana de Açúcar
  a.cd_safra as "Safra",
  trim(a.cd_upnivel1) || case when to_number(trim(a.cd_upnivel2)) < 10 then '0' || trim(a.cd_upnivel2) else trim(a.cd_upnivel2) end || trim(a.cd_upnivel3) as "Layer",
  trim(a.cd_upnivel1) as "Fazenda",
  c.da_upnivel1 as "Propriedade",
  d.de_fornec as "Proprietario",
  h.de_tp_propr as "Tipo Propriedade",
  trim(a.cd_upnivel2) as "Bloco",
  trim(a.cd_upnivel3) as "Talhao",
  to_char(a.dt_plantio,'dd/mm/yyyy') as "Data do Plantio",
  b.fg_ocorren as "Ocorr. Cad",
  to_char(b.dt_ocorren,'dd/mm/yyyy') as "Data Ocorr. Cad.",
  replace(a.ds_terra,'.',',') as "Dist. Terra (km)",
  replace(a.ds_asfalto,'.',',') as "Dist. Asfalto (km)",
  e.da_estagio as "Estagio de Corte",
  f.de_varied as "Variedade",
  g.de_maturac as "Ciclo de Maturacao",
  replace(a.qt_area_prod,'.',',') as "Area Cad. (ha)"
from
  pimscs.upnivel3 a 
inner join
  pimscs.safrupniv3 b on 
    a.cd_safra = b.cd_safra and
    a.cd_upnivel1 = b.cd_upnivel1 and
    a.cd_upnivel2 = b.cd_upnivel2 and
    a.cd_upnivel3 = b.cd_upnivel3
left join
  pimscs.upnivel1 c on
    a.cd_upnivel1 = c.cd_upnivel1
left join
  pimscs.fornecs d on
    c.cd_fornec = d.cd_fornec
left join
    pimscs.estagios e on
      a.cd_estagio = e.cd_estagio
left join
    pimscs.variedades f on
      a.cd_varied = f.cd_varied
left join
    pimscs.tipo_maturac g on
      f.fg_maturac = g.fg_maturac
left join
    pimscs.tipopropri h on
      a.cd_tp_propr = h.cd_tp_propr
where
  a.cd_safra = 2024 and
  a.cd_ocup = 1 and
  a.cd_empresa = 2493 and
  b.fg_ocorren <> 'I' and
  b.dt_ocorren =
    (
      select
        max(b2.dt_ocorren)
      from
        pimscs.safrupniv3 b2
      where
          b.cd_safra = b2.cd_safra and
          b.cd_upnivel1 = b2.cd_upnivel1 and
          b.cd_upnivel2 = b2.cd_upnivel2 and
          b.cd_upnivel3 = b2.cd_upnivel3
  )



