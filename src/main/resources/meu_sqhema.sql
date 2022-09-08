
create table tab_curriculum
(
    id             integer primary key auto_increment,
    emailcontatocv varchar(255),
    nome           varchar(255),
    semestre       varchar(255),
    sobre          varchar(255),
    telefone       varchar(255),
    user_id        integer,
    vaga_id        integer,
    constraint fk_tab_curriculum_tab_user foreign key(user_id) references tab_user(id),
    constraint fk_tab_curriculum_tab_vaga foreign key(vaga_id) references tab_vaga(id)
);

create table tab_user
(
    id integer primary key auto_increment not null,
    admin boolean,
    cv integer,
    email varchar(100),
    password varchar(100),
    token varchar(255)
);

create table tab_vaga
(
    id integer primary key auto_increment,
    cargo varchar(255),
    data_postada date,
    descricao varchar(255),
    horario varchar(255),
    local varchar(255),
    remuneracao double,
    user_id integer,
    constraint fk_tab_vaga_tab_user foreign key(user_id) references tab_user(id)
);

create table tab_candidaturas
(
    tab_user     integer,
    candidaturas integer,
    constraint fk_tab_candidaturas_tab_user foreign key (tab_user) references tab_user(id)
);

create table tab_experiencias
(
    tab_curriculum integer,
    experiencias   varchar(255),
    constraint fk_tab_experiencias_tab_curriculum foreign key (tab_curriculum) references tab_curriculum(id)
);

create table tab_qualificacoes
(
    tab_curriculum integer,
    qualificacoes  varchar(255),
    constraint fk_tab_qualificacoes_tab_curriculum foreign key (tab_curriculum) references tab_curriculum(id)
);

create table tab_requisitos
(
    tab_vaga   integer,
    requisitos varchar(255),
    constraint fk_tab_requisitos_tab_vaga foreign key (tab_vaga) references tab_vaga(id)
);
