-- Select 01 - Objetivo: Subconsulta

select * from loc_cliente c
         where not cd_cliente IN (select cd_cliente
                                         from loc_cli_fisica)
         and	   not cd_cliente IN (select cd_cliente
                                         from loc_cli_juridica);

-- Select 02 - Objetivo: Subconsulta

select c.cd_cliente "CÓDIGO",
       c.nm_cliente "NOME",
       count(l.nr_pedido) "QUANTIDADE LOCAÇÕES",
       sum(l.vl_total) "VALOR TOTAL"
       from loc_cliente c, loc_pedido_locacao l
       where l.cd_cliente = c.cd_cliente
       and   c.cd_cliente 
IN (select cli.cd_cliente
                     from loc_pedido_locacao loc, loc_cliente cli
                     where loc.cd_cliente = cli.cd_cliente
   having sum(loc.vl_total) > (select avg(vl_total)
from loc_pedido_locacao)
                     group by cli.cd_cliente)
       	 group by c.cd_cliente, c.nm_cliente
       order by "VALOR TOTAL";

-- Select 03 - Objetivo: Subconsulta

select d.cd_depto "CÓDIGO",
       d.nm_depto "NOME",
       avg(f.vl_salario) "SALÁRIO MÉDIO",
       min(f.vl_salario) "MENOR SALÁRIO",
       max(f.vl_salario) "MAIOR SALÁRIO",
       sum(f.vl_salario) "VALOR TOTAL GASTO"
       from loc_depto d, loc_funcionario f
       where   d.cd_depto = f.cd_depto
       having  sum(f.vl_salario) > 
                     (select avg(B.A)
                       from (select sum(vl_salario) A
                             from loc_depto, loc_funcionario
                             where loc_depto.cd_depto = loc_funcionario.cd_depto
                             group by loc_depto.cd_depto) B)
             group by d.cd_depto, d.nm_depto;

-- Select 04 - Objetivo: Join

select d.cd_depto "CÓDIGO",
       d.nm_depto "NOME",
       avg(f.vl_salario) "SALÁRIO MÉDIO",
       min(f.vl_salario) "MENOR SALÁRIO",
       max(f.vl_salario) "MAIOR SALÁRIO",
       sum(f.vl_salario) "VALOR TOTAL GASTO"
       from loc_depto d, loc_funcionario f
       where   d.cd_depto = f.cd_depto
       having sum(f.vl_salario) = 
(select max(B.A)
                   from (select sum(vl_salario) A
                         from loc_depto, loc_funcionario
                         where loc_depto.cd_depto = loc_funcionario.cd_depto
                         group by loc_depto.cd_depto) B)
       group by d.cd_depto, d.nm_depto;

-- Select 05 - Objetivo: Join

select d.cd_depto "CÓDIGO",
       d.nm_depto "NOME",
       avg(f.vl_salario) "SALÁRIO MÉDIO",
       min(f.vl_salario) "MENOR SALÁRIO",
       max(f.vl_salario) "MAIOR SALÁRIO",
       sum(f.vl_salario) "VALOR TOTAL GASTO"
       from loc_depto d, loc_funcionario f
       where   d.cd_depto = f.cd_depto
       having sum(f.vl_salario) = 
(select min(B.A)
                         from (select sum(vl_salario) A
                         from loc_depto, loc_funcionario
                         where loc_depto.cd_depto = loc_funcionario.cd_depto
                         group by loc_depto.cd_depto) B)
       group by d.cd_depto, d.nm_depto;

-- Select 06 - Objetivo: Join

select d.cd_depto "CÓDIGO",
       d.nm_depto "NOME",
       avg(f.vl_salario) "SALÁRIO MÉDIO",
       min(f.vl_salario) "MENOR SALÁRIO",
       max(f.vl_salario) "MAIOR SALÁRIO",
       sum(f.vl_salario) "VALOR TOTAL GASTO"
       from loc_depto d, loc_funcionario f
       where   d.cd_depto = f.cd_depto
       having sum(f.vl_salario) = 
(select max(B.A)
                   from (select sum(vl_salario) A
                         from loc_depto, loc_funcionario
                         where loc_depto.cd_depto = loc_funcionario.cd_depto
                         group by loc_depto.cd_depto) B)
       group by d.cd_depto, d.nm_depto;

-- Select 07 - Objetivo: Subconsulta

select cd_func, nm_func, vl_salario
       from loc_funcionario
       where vl_salario in (select vl_salario 
                                  from loc_funcionario);
                                  
-- Select 08 - Objetivo: Trabalhar com Subconsulta: Top N

select *
       from (select f.nm_func "Funcionario",
                    rank() over(order by sum(p.vl_total) desc) "Rank"
                    from loc_funcionario f, loc_pedido_locacao p
                    where f.cd_func = p.cd_func
                    and   p.vl_total > (select avg(vl_total) 
from loc_pedido_locacao)
                    group by f.nm_func)
       where rownum <= 4;

-- Select 09 - Objetivo: Trabalhar com Subconsulta: Top N

select *
       from (select p.nome_proprietario "Nome",
                    count(i.nr_item) "Locações",
                    rank() over(order by count(i.nr_item) desc) "Rank"
                    from loc_proprietario p, loc_veiculo v, loc_item_locacao i
                    where p.cd_proprietario = v.cd_proprietario
                    and   v.nr_placa = i.nr_placa
                    group by p.nome_proprietario)
       where rownum <= 4;

-- Select 10 - Objetivo: Trabalhar com Subconsulta

select f.nm_func "Nome",
       f.vl_salario "Salario",
       d.nm_depto "Departamento"
       from loc_funcionario f, loc_depto d
       where f.cd_depto = d.cd_depto
       and   d.cd_depto = (select cd_depto
                                  from loc_funcionario
                                  where nm_func = 'Helio Gomes');

-- Select 11 - Objetivo: Trabalhar com Subconsulta

select cd_func "Código",
       nm_func "Nome"
       from loc_funcionario
       where vl_salario > (select avg(vl_salario)
                                  from loc_funcionario)
       order by vl_salario desc;

-- Select 12 - Objetivo: Trabalhar com Subconsulta

select cd_func "Código",
       nm_func "Nome"
       from loc_funcionario
       where vl_salario > (select avg(vl_salario)
                                  from loc_funcionario
                                  where cd_depto = 42)
       order by vl_salario desc;

-- Select 13 - Objetivo: Trabalhar com Subconsulta

select f.cd_func "Código",
       f.nm_func "Nome"
       from loc_funcionario f
       where f.vl_salario > (select avg(g.vl_salario)
                                    from loc_funcionario g
                                    where f.cd_depto = g.cd_depto)
       order by f.vl_salario desc;

-- Select 14 - Objetivo: Trabalhar com Subconsulta

select * from loc_veiculo
         where not nr_placa in (select nr_placa
                                       from loc_item_locacao);

-- Select 15 - Objetivo: Trabalhar com Subconsulta

select * from loc_depto
         where not cd_depto in (select cd_depto
                                       from loc_funcionario);

-- Select 16 - Objetivo: Subconsulta

select * from loc_depto
         where not loc_depto.cd_depto IN 
                                         (select loc_funcionario.cd_depto 
                                         from loc_funcionario);

-- Select 17 - Objetivo: SubConsulta

select * from loc_proprietario
         where not loc_proprietario.cd_proprietario IN 
                                         (select loc_veiculo.cd_proprietario 
                                         from loc_veiculo);

-- Select 18 - Objetivo: SubConsulta

select * from loc_proprietario
         where not loc_proprietario.cd_proprietario IN 
                              (select loc_endereco_proprietario.cd_proprietario 
                         from loc_endereco_proprietario);

-- Select 19 - Objetivo: SubConsulta

select * from loc_veiculo
         where loc_veiculo.nr_placa IN
               (select loc_item_locacao.nr_placa
                       from loc_item_locacao
                       where not loc_item_locacao.nr_pedido IN
                                 (select loc_pedido_locacao.nr_pedido
                                  from loc_pedido_locacao));  

-- Select 20 - Objetivo: SubConsulta

select * from loc_grupo
         where not loc_grupo.cd_grupo IN (select loc_veiculo.cd_grupo 
                                           from loc_veiculo);
