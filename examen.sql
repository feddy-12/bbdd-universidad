create database universidad;
use universidad;
create table estudiantes(
id_estudiante int auto_increment primary key,
nomre_estudiante varchar(20),
apellidos_estudiante varchar(20),
carrerra enum("Informatica","Telecomunicaciones","Telematica"),
telefono int(12),
curso enum("primer curso","segundo curso")
);
create table empleados(
id_empleado int auto_increment primary key,
nomre_empleado varchar(20),
apellidos_empleado varchar(20),
salario float,
telefono int(12),
departamento enum("RRH","CONTABILIDAD","ADMINISTRACION")
);
CREATE TABLE departamento (
    id INT  AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE profesor (
    id_profesor INT  PRIMARY KEY,
    nombre_profesor varchar(100),
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_profesor) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);
 
 CREATE TABLE grado (
    id INT  AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE asignatura (
    id INT  AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos FLOAT  NOT NULL,
    tipo ENUM('general', 'especifica') NOT NULL,
    cuatrimestre TINYINT UNSIGNED NOT NULL,
    id_profesor INT,
    id_grado INT NOT NULL,
    FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
    FOREIGN KEY(id_grado) REFERENCES grado(id)
);

CREATE TABLE curso_escolar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    anyo_inicio YEAR NOT NULL,
    anyo_fin YEAR NOT NULL
);

CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT NOT NULL,
    id_asignatura INT  NOT NULL,
    id_curso_escolar INT  NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    FOREIGN KEY (id_alumno) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);
  /* Departamento */
INSERT INTO departamento VALUES (1, 'ASUNTOS ACADEMICOS');
INSERT INTO departamento VALUES (2, 'Matemáticas');
INSERT INTO departamento VALUES (3, 'Economía y Empresa');
INSERT INTO departamento VALUES (4, 'Educación');
INSERT INTO departamento VALUES (6, 'Química y Física');
INSERT INTO departamento VALUES (7, 'Filología');
INSERT INTO departamento VALUES (8, 'Derecho');
INSERT INTO departamento VALUES (9, 'Biología y Geología');
 /* Persona */
INSERT INTO empleados(nomre_empleado ,apellidos_empleado,salario ,telefono  ,departamento)  
 VALUES ('Salvador Angel', 'Nsue Oyana',500000,222683452, 1);
 INSERT INTO empleados(nomre_empleado ,apellidos_empleado,salario ,telefono  ,departamento)  
 VALUES ('Sergio Obama', 'Ndong Esono',530000,222583452, 1);
 INSERT INTO empleados(nomre_empleado ,apellidos_empleado,salario ,telefono  ,departamento)  
 VALUES ('Luis Ening', 'Abogo Ona',600000,222673452, 2);
  
INSERT INTO grado VALUES (1, 'Grado en Ingeniería Agrícola');
INSERT INTO grado VALUES (2, 'Grado en Ingeniería Eléctrica');
INSERT INTO grado VALUES (3, 'Grado en Ingeniería Electrónica Industrial');
INSERT INTO grado VALUES (4, 'Grado en Ingeniería Informática');
INSERT INTO grado VALUES (5, 'Grado en Ingeniería Mecánica');
INSERT INTO grado VALUES (6, 'Grado en Ingeniería Química Industrial');
 
 
/* Asignatura */
INSERT INTO asignatura  (nombre,creditos,tipo,cuatrimestre,id_profesor,id_grado)
 VALUES ( 'Álgegra lineal', 6,1, 1, 1,1);
 
 
 
 
 
 /* Curso escolar */
INSERT INTO curso_escolar VALUES (1, 2014, 2015);
INSERT INTO curso_escolar VALUES (2, 2015, 2016);
INSERT INTO curso_escolar VALUES (3, 2016, 2017);
INSERT INTO curso_escolar VALUES (4, 2017, 2018);
INSERT INTO curso_escolar VALUES (5, 2018, 2019);
INSERT INTO curso_escolar VALUES (6, 2019, 2020);
INSERT INTO curso_escolar VALUES (7, 2020, 2021);
INSERT INTO curso_escolar VALUES (8, 2021, 2022);
INSERT INTO curso_escolar VALUES (9, 2022, 2023);

 
 
 insert into estudiantes(nomre_estudiante ,apellidos_estudiante,carrerra,telefono,curso)
 value("Antonio Bindjeme","Ona Nfumi",1,222747435,1);
 insert into estudiantes(nomre_estudiante ,apellidos_estudiante,carrerra,telefono,curso)
 value("Arsenio Mariano","Obama",1,222747435,1);
 insert into estudiantes(nomre_estudiante ,apellidos_estudiante,carrerra,telefono,curso)
 value("Gregorio","Obama",1,222747435,2);
 insert into estudiantes(nomre_estudiante ,apellidos_estudiante,carrerra,telefono,curso)
 value("Francisco","Obama",1,222747435,2);

 
 
 
 /*----------------------------------------consultas------------------------------------------------*/
 -- listar los empleados de la institucion y alamcenarlos en la variable personal
 Select id_empleado,nomre_empleado ,apellidos_empleado,salario ,telefono  ,departamento, count(*) as personal from empleados group by id_empleado;
 -- el empleado que mayor salario bruto tiene
 Select id_empleado,nomre_empleado ,apellidos_empleado,salario from empleados order by salario desc;
 -- seleccionar todos los estudiantes y agruparlos por carreras
 select nomre_estudiante ,apellidos_estudiante,carrerra,telefono,curso from estudiantes order by curso asc;
 
-- Enumere los nombres de  estudiantes que  que hacen cada carrera.
Select estudiantes.nomre_estudiante,estudiantes.apellidos_estudiante,estudiantes.carrerra,grado.id,grado.nombre as alumnosGrado 
from estudiantes inner join grado on estudiantes.id_estudiante=grado.id;
 
 -- mostrar todas las asignaturas con creditos comprendidos entre 1 a 5
 select *from asignatura where creditos between 1 and 5;
 
 -- --------------vistas----------------------------------------------------
 create view todoPersonal AS SELECT nomre_empleado ,apellidos_empleado,salario ,telefono  ,departamento from empleados;
 create view todosGrados AS SELECT grados from grado;
 
 /*--------------------------procedimientos almacenados------------------------------------------------*/
 -- CREAR USUARIO
 DELIMITER //
CREATE PROCEDURE Crear_Usuario(IN usuario varchar (10), IN passe varchar (10))
BEGIN
    SET @sql = CONCAT('CREATE USER IF NOT EXISTS ', "'", usuario, "'", "@'localhost'", ' IDENTIFIED BY ', "'" , passe , "'" );
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;
END //
DELIMITER ;
call Crear_Usuario('ADMIN','12345');

GRANT ALL PRIVILEGES ON EL_PAC . * TO 'ADMIN'@'localhost';

FLUSH PRIVILEGES;
SELECT User FROM mysql.user;
 