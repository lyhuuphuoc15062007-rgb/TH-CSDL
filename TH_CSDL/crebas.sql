/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     20/11/2026 2:41:00 CH                        */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NHANVIEN') and o.name = 'FK_NHANVIEN_QUANLY_NHANVIEN')
alter table NHANVIEN
   drop constraint FK_NHANVIEN_QUANLY_NHANVIEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NHANVIEN') and o.name = 'FK_NHANVIEN_THUOC_PHONGBAN')
alter table NHANVIEN
   drop constraint FK_NHANVIEN_THUOC_PHONGBAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PHANCONG') and o.name = 'FK_PHANCONG_PHANCONG_NHANVIEN')
alter table PHANCONG
   drop constraint FK_PHANCONG_PHANCONG_NHANVIEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PHANCONG') and o.name = 'FK_PHANCONG_PHANCONG2_DEAN')
alter table PHANCONG
   drop constraint FK_PHANCONG_PHANCONG2_DEAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THANHNHAN') and o.name = 'FK_THANHNHA_CO_NHANVIEN')
alter table THANHNHAN
   drop constraint FK_THANHNHA_CO_NHANVIEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THENHANVIEN') and o.name = 'FK_THENHANV_CAP_NHANVIEN')
alter table THENHANVIEN
   drop constraint FK_THENHANV_CAP_NHANVIEN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DEAN')
            and   type = 'U')
   drop table DEAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('NHANVIEN')
            and   name  = 'THUOC_FK'
            and   indid > 0
            and   indid < 255)
   drop index NHANVIEN.THUOC_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('NHANVIEN')
            and   name  = 'QUANLY_FK'
            and   indid > 0
            and   indid < 255)
   drop index NHANVIEN.QUANLY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NHANVIEN')
            and   type = 'U')
   drop table NHANVIEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PHANCONG')
            and   name  = 'PHANCONG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PHANCONG.PHANCONG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PHANCONG')
            and   name  = 'PHANCONG_FK'
            and   indid > 0
            and   indid < 255)
   drop index PHANCONG.PHANCONG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PHANCONG')
            and   type = 'U')
   drop table PHANCONG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PHONGBAN')
            and   type = 'U')
   drop table PHONGBAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('THANHNHAN')
            and   name  = 'CO_FK'
            and   indid > 0
            and   indid < 255)
   drop index THANHNHAN.CO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('THANHNHAN')
            and   type = 'U')
   drop table THANHNHAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('THENHANVIEN')
            and   name  = 'CAP_FK'
            and   indid > 0
            and   indid < 255)
   drop index THENHANVIEN.CAP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('THENHANVIEN')
            and   type = 'U')
   drop table THENHANVIEN
go

/*==============================================================*/
/* Table: DEAN                                                  */
/*==============================================================*/
create table DEAN (
   MADA                 char(5)              not null,
   TENDA                char(50)             not null,
   DIADIEMDA            char(30)             not null,
   NGAYBD               datetime             not null,
   NGAYKT               datetime             not null,
   constraint PK_DEAN primary key (MADA)
)
go

/*==============================================================*/
/* Table: NHANVIEN                                              */
/*==============================================================*/
create table NHANVIEN (
   MANV                 char(10)             not null,
   NHA_MANV             char(10)             null,
   MAPHONG              char(10)             null,
   HOTEN                char(40)             not null,
   NGAYSINH             datetime             not null,
   PHAII_NV             char(5)              not null,
   DIACHIA              char(40)             not null,
   LUONG                money                not null,
   constraint PK_NHANVIEN primary key (MANV)
)
go

/*==============================================================*/
/* Index: QUANLY_FK                                             */
/*==============================================================*/




create nonclustered index QUANLY_FK on NHANVIEN (NHA_MANV ASC)
go

/*==============================================================*/
/* Index: THUOC_FK                                              */
/*==============================================================*/




create nonclustered index THUOC_FK on NHANVIEN (MAPHONG ASC)
go

/*==============================================================*/
/* Table: PHANCONG                                              */
/*==============================================================*/
create table PHANCONG (
   MANV                 char(10)             not null,
   MADA                 char(5)              not null,
   SONGAYTG             int                  null,
   constraint PK_PHANCONG primary key (MANV, MADA)
)
go

/*==============================================================*/
/* Index: PHANCONG_FK                                           */
/*==============================================================*/




create nonclustered index PHANCONG_FK on PHANCONG (MANV ASC)
go

/*==============================================================*/
/* Index: PHANCONG2_FK                                          */
/*==============================================================*/




create nonclustered index PHANCONG2_FK on PHANCONG (MADA ASC)
go

/*==============================================================*/
/* Table: PHONGBAN                                              */
/*==============================================================*/
create table PHONGBAN (
   MAPHONG              char(10)             not null,
   TENPHONG             char(30)             not null,
   DIAIDEMPB            char(40)             not null,
   constraint PK_PHONGBAN primary key (MAPHONG)
)
go

/*==============================================================*/
/* Table: THANHNHAN                                             */
/*==============================================================*/
create table THANHNHAN (
   TENTH                char(40)             not null,
   MANV                 char(10)             not null,
   PHAI_TN              char(5)              not null,
   NGAYSINH             datetime             not null,
   QUANHE               char(15)             not null,
   constraint PK_THANHNHAN primary key (TENTH)
)
go

/*==============================================================*/
/* Index: CO_FK                                                 */
/*==============================================================*/




create nonclustered index CO_FK on THANHNHAN (MANV ASC)
go

/*==============================================================*/
/* Table: THENHANVIEN                                           */
/*==============================================================*/
create table THENHANVIEN (
   MANV                 char(10)             null,
   MATHE                char(10)             not null,
   NGAYCAP              datetime             not null
)
go

/*==============================================================*/
/* Index: CAP_FK                                                */
/*==============================================================*/




create nonclustered index CAP_FK on THENHANVIEN (MANV ASC)
go

alter table NHANVIEN
   add constraint FK_NHANVIEN_QUANLY_NHANVIEN foreign key (NHA_MANV)
      references NHANVIEN (MANV)
go

alter table NHANVIEN
   add constraint FK_NHANVIEN_THUOC_PHONGBAN foreign key (MAPHONG)
      references PHONGBAN (MAPHONG)
go

alter table PHANCONG
   add constraint FK_PHANCONG_PHANCONG_NHANVIEN foreign key (MANV)
      references NHANVIEN (MANV)
go

alter table PHANCONG
   add constraint FK_PHANCONG_PHANCONG2_DEAN foreign key (MADA)
      references DEAN (MADA)
go

alter table THANHNHAN
   add constraint FK_THANHNHA_CO_NHANVIEN foreign key (MANV)
      references NHANVIEN (MANV)
go

alter table THENHANVIEN
   add constraint FK_THENHANV_CAP_NHANVIEN foreign key (MANV)
      references NHANVIEN (MANV)
go

