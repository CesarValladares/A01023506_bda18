create table Usuarios(
ID int PRIMARY KEY not null,
Nombre varchar(20) not null,
direccion varchar(50) not null,
Correo varchar(40), 
año int,
modelo varchar(15),
marca varchar(15),
precio int,
num_serie int,
SYS_START TIMESTAMP(12) GENERATED ALWAYS AS ROW BEGIN NOT NULL,
SYS_END TIMESTAMP(12) GENERATED ALWAYS AS ROW END NOT NULL,
TRANS_START TIMESTAMP(12) GENERATED ALWAYS AS TRANSACTION START ID IMPLICITLY HIDDEN, 
PERIOD SYSTEM_TIME(SYS_START,SYS_END)
)

create table Polizas(
ID int PRIMARY KEY not null, 
ID_Usuario int,
FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID),
fecha_inicio date not null, 
fecha_fin date not null,
cobertura smallint not null,
costo int not null,
SYS_START TIMESTAMP(12) GENERATED ALWAYS AS ROW BEGIN NOT NULL,
SYS_END TIMESTAMP(12) GENERATED ALWAYS AS ROW END NOT NULL,
TRANS_START TIMESTAMP(12) GENERATED ALWAYS AS TRANSACTION START ID IMPLICITLY HIDDEN, 
PERIOD SYSTEM_TIME(SYS_START,SYS_END)
)

create table Usuarios_hist like Usuarios

alter table Usuarios add versioning use HISTORY table Usuarios_hist 

create table Polizas_hist like Polizas

alter table Polizas add versioning use HISTORY table Polizas_hist

Create TRIGGER Cancelacion
AFTER update on POLIZAS
referencing old as old_values new as new_values
for each row mode db2sql
when (new_values.fecha_fin < old_values.fecha_fin) 
begin atomic 
	declare meses int
	declare meses2 int
	declare diferencia int
	declare costmes int
	declare nmeses int
	declare diferencia2 int
	declare valorfin int
	SET @meses = MONTH(old_values.fecha_inicio)
	SET meses2 = MONTH(old_values.fecha_fin)
	diferencia = meses2 - meses	
	costmes = old_values.costo / diferencia
	SET nmeses = MONTH(new_values.fecha_fin)
	diferencia2 = nmeses - meses
	valorfin = diferencia2 * costmes
	new_value.cost = valorfin;end



	


