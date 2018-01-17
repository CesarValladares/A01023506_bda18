--Ejercicio 1 buscar en linea de productos
delimiter $$ 
create procedure show_products(
    In linea_producto varchar(50))
BEGIN 
    declare line varchar(50);

    set line = concat(linea_producto, "%");
    select * from products where productLine like line;

    select linea_producto;
END $$ 
delimiter ; 


--Ejercicio 2 Clientes que empiecen con tal letra
delimiter $$
create procedure show_customers(
    In letra varchar(1))
BEGIN
    declare l varchar(2);
    declare count int default 0;

    set l = concat(letra, "%");
    select count(*) INTO count from customers where contactFirstName like l; 

    select count; 
END $$
delimiter ;

--Ejercicio 3 primer y ultimo productos por precio 

