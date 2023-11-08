create database VENDAS3;
use VENDAS3; -- Corrigi para usar o banco de dados correto

create table CLIENTES3 (
    id_cliente integer,
    nome_cliente varchar(45),
    dt_nasc date,
    primary key (id_cliente)
);

create table PRODUTOS3 (
    id_produto integer,
    nome_produto varchar(45),
    preco double, -- Corrigi para usar o tipo "decimal" para o preço
    primary key (id_produto)
);

create table PEDIDOS3 (
    id_pedidos int primary key,
    id_cliente integer,
    id_produto integer,
    dt_produto date,
    quantidade int
);

insert into CLIENTES3 (id_cliente, nome_cliente, dt_nasc)
values (1, 'Zeca Pagodinho', '2000-10-11'),
       (2, 'Chico Science', '1963-07-27');

insert into PRODUTOS3 (id_produto, nome_produto, preco)
values (2, 'cigarro', '2.00'),
       (3, 'Celular Samsung', '110.00');

insert into PEDIDOS3 (id_pedidos, id_cliente, id_produto, dt_produto, quantidade)
values (1, 1, 3, '2023-11-08', 1);

SELECT id_cliente, nome_cliente, dt_nasc,
       YEAR(NOW()) - YEAR(dt_nasc) AS idade
FROM CLIENTES3
WHERE YEAR(NOW()) - YEAR(dt_nasc) > 30
ORDER BY dt_nasc ASC;

SELECT id_produto, nome_produto, preco
FROM PRODUTOS3
WHERE preco > 100;

SELECT COUNT(*) AS total_pedidos_acima_de_500
FROM (
    SELECT P.id_pedidos, P.id_cliente, P.id_produto, P.dt_produto, P.quantidade,
           PR.preco * P.quantidade AS valor_total
    FROM PEDIDOS3 P
    INNER JOIN PRODUTOS3 PR ON P.id_produto = PR.id_produto
) AS pedidos
WHERE pedidos.valor_total > 500;

SELECT C.nome_cliente
FROM CLIENTES3 C
JOIN PEDIDOS3 P ON C.id_cliente = P.id_cliente
WHERE P.dt_produto = (SELECT MAX(dt_produto) FROM PEDIDOS3);


SELECT C.nome_cliente
FROM CLIENTES3 C
LEFT JOIN PEDIDOS3 P ON C.id_cliente = P.id_cliente
WHERE P.id_cliente IS NULL;
