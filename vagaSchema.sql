drop schema vagas;
drop table tab_vaga_curriculum_id;
create schema vagas;
use vagas;

create table tab_user(
	id integer primary key auto_increment,
    admin boolean,
	cv integer,
	email varchar(100),
	password varchar(100),
	token varchar(255)
);

create table tab_curriculum (
	curriculum_id integer primary key auto_increment,
	emailcontatocv varchar(50),
	nome varchar(50),
	semestre varchar(20),
	sobre varchar(1200),
	telefone varchar(20),
	user_id integer,
    constraint fk_tab_curriculum_tab_user foreign key(user_id) references tab_user(id)
);

create table tab_vaga (
	vaga_id integer primary key auto_increment,
	cargo varchar(100),
	data_postada date,
	descricao varchar(1000),
	horario varchar(50),
	local varchar(50),
	remuneracao double,
	user_id integer,
	constraint fk_tab_vaga_user_id foreign key(user_id) references tab_user(id)
);

create table tab_curriculum_experiencias (
	curriculum_id integer not null,
	experiencias varchar(1000),
	constraint fk_tab_curriculum_experiencias_tab_curriculum foreign key(curriculum_id) references tab_curriculum(curriculum_id)
);

create table tab_curriculum_qualificacoes (
	curriculum_id integer not null,
	qualificacoes varchar(255),
	constraint fk_tab_curriculum_qualificacoe_tab_curriculum foreign key(curriculum_id) references tab_curriculum(curriculum_id)
);

create table tab_user_candidaturas (
	user_id integer not null,
	candidaturas integer,
	constraint fk_tab_user_candidaturas_tab_user foreign key(user_id) references tab_user(id)
);

create table tab_vaga_curriculum_id (
	vaga_id integer not null,
	curriculum_id integer,
	constraint fk_tab_vaga_curriculum_id_vaga_id foreign key(vaga_id) references tab_vaga(vaga_id)
);

create table tab_vaga_requisitos (
	vaga_id integer not null,
	requisitos varchar(255),
    constraint fk_tab_vaga_requisitos_vaga_id foreign key(vaga_id) references tab_vaga(vaga_id)
);