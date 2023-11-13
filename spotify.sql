CREATE DATABASE spotify;
USE spotify;

CREATE TABLE album (
id_album INT auto_increment,
titulo VARCHAR(60),
año INT,
primary key (id_album)
);

create table cancion(
id_cancion INT auto_increment, 
titulo varchar(60),
duracion int, 
primary key (id_cancion) ,
id_album int,
foreign key (id_album) references album (id_album)
);

CREATE TABLE usuario (
id_usuario int auto_increment,
nombre varchar(60),
correo varchar(70) not null unique,
primary key (id_usuario)
);

CREATE TABLE playlist ( 
id_playlist int auto_increment,
nombre varchar (60),
primary key (id_playlist),
id_usuario int, 
foreign key (id_usuario) references usuario (id_usuario)
);

CREATE TABLE cancionplaylist (
id_playlist int, 
id_cancion int ,
foreign key (id_playlist) references playlist (id_playlist),
foreign key (id_cancion) references cancion (id_cancion),
primary key (id_cancion, id_playlist)
);

-- ingreso de datos

insert into album (titulo, año)
values ("Random Access Memories", 2013),
("Lost in the Dream", 2014),
("Revolver", 1966),
("Rumours", 1977),
("Electric Echoes", 2020);


insert into cancion (titulo, duracion, id_album)
values ("Instant Crush", 234 , 1),
("Red Eyes", 310, 2),
("Eleanor Rigby", 210, 3),
("Go Your Own Way", 150,4),
("Dreams", 200, 4),
("The Chain", 214, 5);

insert into usuario (nombre, correo)
values ("juan_toro" , "juancho@gmail.com"),
("tomas_perino", "tomi@yahoo.com.ar"),
("terri_blaster", "blas1223@gmail.com"),
("hernan_coronel" ,"herni_208@gmail.com"),
("julieta_perez", "juli_kpa@gmail.com");


insert into playlist (nombre, id_usuario)
values ("rock",1),
("chill", 2),
("estudiar", 3),
("loffy",4),
("casa",5);

insert into cancionplaylist (id_playlist, id_cancion)
values (1,1), (1,2),(1,3),(1,4),(1,5),
(2,2),(2,4),(2,5),
(3,4),
(4,1),(4,3),(4,5),
(5,5);

-- Query 
-- 1. Seleccionar la canción que tenga el año de lanzamiento más antiguo.
use spotify ;

select cancion.titulo as titulo_cancion, album.titulo as titulo_album, año from  album inner join cancion on album.id_album = cancion.id_album order by 3 asc, 1 asc limit 1 ;

-- 2. Seleccionar los nombres de las canciones y el nombre del álbum al cual
--     pertenecen si la duración de la canción es mayor a 2 minutos.
select cancion.titulo as titulo_cancion, album.titulo as titulo_album, duracion from  album inner join cancion on album.id_album = cancion.id_album where duracion > 120 ;

-- 3. Seleccionar el nombre de la playlist que tenga la mayor duración (suma de
--  duración de las canciones que contiene) y al nombre usuario que pertenece.
select playlist.nombre as nombre_playlist, sum(cancion.duracion), usuario.nombre as nombre_usuario from usuario 
inner join playlist on playlist.id_usuario = usuario.id_usuario
inner join cancionplaylist on cancionplaylist.id_playlist = playlist.id_playlist
inner join cancion on cancionplaylist.id_cancion = cancion.id_cancion
group by playlist.id_playlist order by playlist.id_playlist asc limit 1 ;


-- 4. Seleccionar el nombre del álbum que posea la mayor cantidad de canciones.
select album.id_album, count(id_cancion), album.titulo as titulo_album from  album inner join cancion on album.id_album = cancion.id_album group by  album.id_album order by 2 desc limit 1;

-- 5. Obtener el promedio de duración de cada álbum, teniendo en cuenta únicamente
--  las canciones con duración mayor a 2 minutos.

select avg(cancion.duracion) 'promedio', album.titulo from cancion inner join album on album.id_album = cancion.id_album  where cancion.duracion > 120 group by album.titulo order by 1 desc ;