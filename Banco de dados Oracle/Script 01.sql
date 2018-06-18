-- Select 01 - Objetivo: Select Básico
select cd_func, nm_func, vl_salario 
       from loc_funcionario;

-- Select 02 - Objetivo: Select Básico
select nm_func, cd_depto, vl_perc_comissao, dt_inicio 
       from loc_funcionario
       order by nm_func;

-- Select 03 - Objetivo: Select Básico – Operador Resto
select nm_func "NOME",
      	 cd_depto "DEPARTAMENTO",
      	 vl_salario "SALARIO",
      	 vl_perc_comissao "COMISSÃO",
      	 dt_inicio "INICIO"
      	 from loc_funcionario
      	 where mod(cd_func, 2) = 0
       order by cd_func desc;

-- Select 04 - Objetivo: Select Básico – Operador Resto 
select nm_func "NOME",
      	 cd_depto "DEPARTAMENTO",
       vl_salario "SALARIO",
       vl_perc_comissao "COMISSÃO",
       dt_inicio "INICIO"
       from loc_funcionario
       where mod(cd_func, 2) = 1
       order by vl_salario desc;

-- Select 05 - Objetivo: Select Básico
select nm_cargo "CARGO",
      	 vl_salario "SALARIO"
       from loc_funcionario
       order by CARGO;

-- Select 06 - Objetivo: Select Básico com variáveis de substituição
select nm_cliente "NOME",
       tp_cliente "TIPO",
       nr_estrelas "Nº ESTRELAS",
       telefone "TELEFONE",
       fax "FAX" 
       from loc_cliente
       where nr_estrelas >= &num_estrelas;

-- Select 07 - Objetivo: Select Básico com variáveis de substituição
select nm_cliente "NOME",
       tp_cliente "TIPO",
       nr_estrelas "Nº ESTRELAS",
       telefone "TELEFONE",
       fax "FAX" 
       from loc_cliente
       where nm_cliente like '%&letra%'
       order by nm_cliente;

-- Select 08 - Objetivo: Select Básico com variáveis de substituição
select  cd_condicao "CODIGO",
        desc_condicao "DESCRICAO"
        from loc_cond_pagto
        where cd_condicao = &cd1
        or    cd_condicao = &cd2;

-- Select 09 - Objetivo: Select Básico com variáveis de substituição
select  cd_func "CODIGO FUNCIONARIO",
        nm_func "NOME",
        vl_salario "SALARIO",
        cd_depto "CODIGO DEPARTAMENTO"
        from loc_funcionario
        where cd_depto = &cd1
        or    cd_depto = &cd2;

-- Select 10 - Objetivo: Select Básico com variáveis de substituição
select  cd_func "CODIGO FUNCIONARIO",
        nm_func "NOME",
        vl_salario "SALARIO",
        vl_salario*6 "SALARIO SEMESTRAL",
        vl_salario*12 "SALARIO ANUAL",
        cd_depto "CODIGO DEPARTAMENTO"
        from loc_funcionario
        where cd_depto = &cd1;

-- Select 11 - Objetivo: Select Básico com união
select min(MENOR.Valor) "MENOR VALOR"
      from (select &num1 as Valor
            from dual
            union
            select &num2 as Valor
            from dual
            union
            select &num3 as Valor 
      from dual) MENOR;

-- Select 12 - Objetivo: Select Básico com variáveis de substituição
select concat('&nome', ' &sobrenome') "NOME COMPLETO"
       from dual;

-- Select 13 - Objetivo: Select Básico com variáveis de substituição
select TO_CHAR(TO_DATE('&hoje'), 'fmMONTH') TESTE_DATA
       from dual;

-- Select 14 - Objetivo: Select Básico com variáveis de substituição
select ('Quem nasceu no dia '||TO_CHAR(TO_DATE('01/12/1978'), 'fmDD Month YYYY')||' têm '||TO_CHAR(sysdate-TO_DATE('01/12/1978'), 99999)||' dias de vida') TESTE_DATA
       from dual;

-- Select 15 - Objetivo: Select Básico
select nr_pedido "NÚMERO PEDIDO",
       cd_cliente "CÓDIGO CLIENTE" 
       from loc_pedido_locacao
       where dt_retirada > dt_entrega;

-- Select 16 - Objetivo: Join
select nr_item "NÚMERO ITEM",
       nr_pedido "NÚMERO PEDIDO"
       from loc_item_locacao
       where dt_retirada > dt_entrega;

-- Select 17 - Objetivo: Join
select loc_cliente.nm_cliente
       from loc_cliente 
       inner join loc_cli_fisica
       on loc_cliente.cd_cliente = loc_cli_fisica.cd_cliente
       where dt_nascimento > sysdate;

-- Select 18 - Objetivo: Join
select loc_cliente.nm_cliente, loc_cliente.cd_cliente
       from loc_cliente 
       inner join loc_cli_fisica
       on loc_cliente.cd_cliente = loc_cli_fisica.cd_cliente
       where (sysdate - dt_nascimento)/365 < 18;

-- Select 19 - Objetivo: Simples
select nr_pedido "NÚMERO PEDIDO",
       cd_cliente "CÓDIGO CLIENTE"
       from loc_pedido_locacao
       where dt_locacao > dt_entrega
       or    dt_locacao > dt_retirada;

-- Select 20 - Objetivo: Simples
select nr_pedido "NÚMERO PEDIDO",
       cd_cliente "CÓDIGO CLIENTE"
       from loc_pedido_locacao
       where dt_locacao > dt_entrega
       or    dt_locacao > dt_retirada
       or    vl_total <= 0;

-- Select 21 - Objetivo: Simples
select nr_pedido "NÚMERO PEDIDO",
       cd_cliente "CÓDIGO CLIENTE"
       from loc_pedido_locacao
       where dt_locacao > dt_entrega
       or    dt_locacao > dt_retirada
       or    vl_total <= 0;

-- Select 22 - Objetivo: Simples
select * from loc_cliente
         where nm_cliente like '__A%';

-- Select 23 - Objetivo: Simples
select * from loc_cliente
         where nm_cliente like '%A';

-- Select 24 - Objetivo: Simples
select * from loc_cliente
         where nm_cliente like '%O';

-- Select 25 - Objetivo: Simples
select * from loc_cliente
         where (nm_cliente like '%I%'
         or    nm_cliente like '%i%')
         and nr_estrelas < 4;


