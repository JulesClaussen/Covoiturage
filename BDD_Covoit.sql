/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  16/02/2018 17:00:47                      */
/*==============================================================*/


drop table if exists ami;

drop table if exists appartient;

drop table if exists groupe;

drop table if exists participe;

drop table if exists realise;

drop table if exists trajet;

drop table if exists traverse;

drop table if exists utilisateur;

drop table if exists ville;

drop table if exists voiture;

/*==============================================================*/
/* Table : ami                                                  */
/*==============================================================*/
create table ami
(
   id_groupe            int not null,
   id_user              int not null,
   primary key (id_groupe)
);

/*==============================================================*/
/* Table : appartient                                           */
/*==============================================================*/
create table appartient
(
   id_user              int not null,
   id_groupe            int not null,
   primary key (id_user, id_groupe)
);

/*==============================================================*/
/* Table : groupe                                               */
/*==============================================================*/
create table groupe
(
   id_groupe            int not null,
   nombre_personnes     int,
   nom                  varchar(20) not null,
   type                 varchar(20),
   primary key (id_groupe)
);

/*==============================================================*/
/* Table : participe                                            */
/*==============================================================*/
create table participe
(
   id_user              int not null,
   id_trajet            int not null,
   primary key (id_user, id_trajet)
);

/*==============================================================*/
/* Table : realise                                              */
/*==============================================================*/
create table realise
(
   id_groupe            int not null,
   id_trajet            int not null,
   primary key (id_groupe, id_trajet)
);

/*==============================================================*/
/* Table : trajet                                               */
/*==============================================================*/
create table trajet
(
   id_trajet            int not null,
   id_user              int,
   id_voiture           int not null,
   uti_id_user          int not null,
   lieu_depart          varchar(30) not null,
   lieu_arrivee         varchar(30) not null,
   heure_depart         datetime not null,
   nombre_places        int not null,
   heure_arrivee        datetime not null,
   commentaire          varchar(500),
   primary key (id_trajet)
);

/*==============================================================*/
/* Table : traverse                                             */
/*==============================================================*/
create table traverse
(
   id_trajet            int not null,
   nom_ville            varchar(30) not null,
   primary key (id_trajet, nom_ville)
);

/*==============================================================*/
/* Table : utilisateur                                          */
/*==============================================================*/
create table utilisateur
(
   id_user              int not null,
   uti_id_user          int,
   nom_user             varchar(30) not null,
   prenom_user          varchar(30) not null,
   est_admin            bool not null,
   telephone            char(10) not null,
   email                varchar(70) not null,
   nombre_trajets_realises int,
   site                 varchar(20) not null,
   type                 varchar(20),
   fonction             varchar(20),
   primary key (id_user)
);

/*==============================================================*/
/* Table : ville                                                */
/*==============================================================*/
create table ville
(
   nom_ville            varchar(30) not null,
   primary key (nom_ville)
);

/*==============================================================*/
/* Table : voiture                                              */
/*==============================================================*/
create table voiture
(
   id_voiture           int not null,
   id_user              int not null,
   modele               varchar(20) not null,
   couleur              varchar(20),
   nombre_places        int not null,
   taille_bagage        varchar(10),
   primary key (id_voiture)
);

alter table ami add constraint FK_gerer foreign key (id_user)
      references utilisateur (id_user) on delete cascade on update cascade;

alter table ami add constraint FK_heritage_2 foreign key (id_groupe)
      references groupe (id_groupe) on delete cascade on update cascade;

alter table appartient add constraint FK_appartient foreign key (id_user)
      references utilisateur (id_user) on delete cascade on update cascade;

alter table appartient add constraint FK_appartient2 foreign key (id_groupe)
      references groupe (id_groupe) on delete cascade on update cascade;

alter table participe add constraint FK_participe foreign key (id_user)
      references utilisateur (id_user) on delete cascade on update cascade;

alter table participe add constraint FK_participe2 foreign key (id_trajet)
      references trajet (id_trajet) on delete cascade on update cascade;

alter table realise add constraint FK_realise foreign key (id_groupe)
      references groupe (id_groupe) on delete cascade on update cascade;

alter table realise add constraint FK_realise2 foreign key (id_trajet)
      references trajet (id_trajet) on delete cascade on update cascade;

alter table trajet add constraint FK_effacer foreign key (id_user)
      references utilisateur (id_user) on delete cascade on update cascade;

alter table trajet add constraint FK_fait foreign key (id_voiture)
      references voiture (id_voiture) on delete restrict on update cascade;

alter table trajet add constraint FK_propose foreign key (uti_id_user)
      references utilisateur (id_user) on delete cascade on update cascade;

alter table traverse add constraint FK_traverse foreign key (id_trajet)
      references trajet (id_trajet) on delete cascade on update cascade;

alter table traverse add constraint FK_traverse2 foreign key (nom_ville)
      references ville (nom_ville) on delete restrict on update cascade;

alter table utilisateur add constraint FK_bloquer foreign key (uti_id_user)
      references utilisateur (id_user) on delete restrict on update cascade;

alter table voiture add constraint FK_possede foreign key (id_user)
      references utilisateur (id_user) on delete cascade on update cascade;

