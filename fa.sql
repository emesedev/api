drop database fasystem;
create database fasystem;
use fasystem;

create table users(
    id_user int primary key,
    name varchar(50),
    father_lastname varchar(50),
    mother_lastname varchar(50),
    password varchar(50),
    role int,
    position varchar(50),
    id_area_fac varchar(50),
    id_department int,
    email varchar(50),
    id_plant int,
    status int
);

create table areasFa(
    id_area_fa int primary key,
    name varchar(50)
);

create table equipments(
    id_equipment int primary key,
    name varchar(50),
    location varchar(100),
    fa_number varchar(50),
    class int,
    id_area_fa int,
    frequency int,
    responsible int,
    id_plant int,
    status int,

	foreign key (id_area_fa) references areasFA(id_area_fa)
);

create table maintenance(
    id_maintenance int primary key,
    name varchar(100),
    columns int,
    row int,
    frequency int,
    id_area_fa int,
    created_by int,
    created_at datetime,

	foreign key (id_area_fa) references areasFA(id_area_fa),
	foreign key (created_by) references users(id_user)
);

create table epp(
    id_epp int primary key,
    id_maintenance int,
    epp varchar(100),

	foreign key (id_maintenance) references maintenance(id_maintenance)
);

create table workOrders(
    id_work_order int primary key,
    id_maintenance int,
    system varchar(50),
    description varchar(50),
    type int,
    category_result int,
    min varchar(50),
    max varchar(50),

	foreign key (id_maintenance) references maintenance(id_maintenance)
);

create table tools(
    id_tools int primary key,
    id_maintenance int,
    tools varchar(100),

	foreign key (id_maintenance) references maintenance(id_maintenance)
);

create table maintenance_equipments(
    id_maintenance_equip int primary key,
    id_maintenance int,
    id_equipment int,

	foreign key (id_maintenance) references maintenance(id_maintenance),
	foreign key (id_equipment) references equipments(id_equipment)
);

create table materials(
    id_materials int primary key,
    id_maintenance int,
    materials varchar(100),

	foreign key (id_maintenance) references maintenance(id_maintenance)
);

create table maintenance_result(
    id_maintenance_result int primary key,
    id_work_order int,
    result varchar(100),
    value1 varchar(100),
    value2 varchar(100),
    value3 varchar(100),
    comment varchar(300),
    created_date date,
    created_time time,
    status int,

	foreign key (id_work_order) references workOrders(id_work_order)
);

create table annual_plan(
    id_annual_plan int primary key,
    id_work_order int,
    id_equipment int,
    responsible int,
    planned_date date,
    real_date date,
    start_time time,
    end_time time,
    approver int,
    status int,

	foreign key (id_work_order) references workOrders(id_work_order),
	foreign key (id_equipment) references equipments(id_equipment),
	foreign key (responsible) references users(id_user),
	foreign key (approver) references users(id_user)
);

create table areas(
	id_area int primary key,
	name varchar(200)
);

create table category_equipment(
	id_category_equipment int primary key,
	category varchar(200),
	id_area_fa int,

	foreign key (id_area_fa) references areasFa(id_area_fa)
);

create table daily_activities(
    id_daily_activities int primary key,
    id_user int,
    date date,
    shift int,
    start_time time,
    end_time time,
    activity varchar(100),
    id_area int,
    id_equipment int,
    class int,
    id_area_fa int,
    id_category_equipment int,
    comment varchar(300),
    minutes int,
    hours float,
    status int,

	foreign key (id_user) references users(id_user),
	foreign key (id_area) references areas(id_area),
	foreign key (id_equipment) references equipments(id_equipment),
	foreign key (id_area_fa) references areasFa(id_area_fa),
	foreign key (id_category_equipment) references category_equipment(id_category_equipment)
);

create table abnormality_report(
    id_abnormality_report int primary key,
    id_annual_plan int,
    priority int,
    date date,
    id_area int,
    id_category_equipment int,
    id_equipment int,
    finding varchar(500),
    immediate_action varchar(500),
    final_action varchar(500),
    responsible int,
    commitment_date date,
    closing_date date,
    comments varchar(500),
    type_failure varchar(50),
    type_abnormality int,
    status int,

	foreign key(id_annual_plan) references annual_plan(id_annual_plan),
	foreign key(id_area) references areas(id_area),
	foreign key(id_category_equipment) references category_equipment(id_category_equipment),
	foreign key(id_equipment) references equipments(id_equipment),
	foreign key(responsible) references users(id_user)
);

create table failure_equipments(
    id_failure_equipments int primary key,
    id_equipment int,
    id_abnormality_report int,
    date date,
    status int,

	foreign key (id_equipment) references equipments(id_equipment),
	foreign key (id_abnormality_report) references abnormality_report(id_abnormality_report)
);

create table targets(
    id_target int primary key,
    name varchar(50),
    value int,
    date date
);

create table executive_comments(
    id_executive_comment int primary key,
    date date,
    comment1 varchar(500),
    comment2 varchar(500),
    comment3 varchar(500),
    comment4 varchar(500),
    comment5 varchar(500),
    comment6 varchar(500),
    comment7 varchar(500),
    comment8 varchar(500)
);

create table gas_consumption(
    id_gas_consumption int primary key,
    date date,
    ciudad float,
    surface float,
    radiador float,
    evaporador float,
    brazing float,
    gic float,
    gic2 float,
    cocina float,
    guarderia float
);

create table water_consumption(
    id_water_consumptionint int primary key,
    ciudad float,
    booster_potable float,
    tina_lavado float,
    entrada_suavizador float,
    salida_suavizador float,
    booster_suavizada float,
    ecopond float,
    osmosis float,
    surface float,
    cocina float,
    guarderia float,
    riego float,
    lav_1 float,
    lav_2 float,
    lav_3 float,
    lav_4 float,
    lav_5 float,
    lav_6 float,
    lav_7 float,
    lav_8 float,
    lav_9 float,
    torre_1 float,
    torre_2 float,
    torre_3 float
);

create table kyt(
    id_kyt int primary key,
    id_user int,
    date date,
    value int,

	foreign key(id_user) references users(id_user)
);

create table notify(
    id_notify int primary key,
    comment varchar(200),
    id_user int,
    created_date date,
    seen_at datetime,
    type_activity int,
    id_activity int,
    status int,

	foreign key(id_user) references users(id_user)
);

create table evaluation_5s(
    id_evaluation_5s int primary key,
    columns int,
    row int,
    name varchar(500),
    id_area_fa int,
    area varchar(200),
    responsible int,
    approver int,
    status int,

	foreign key(id_area_fa) references areasFa(id_area_fa),
	foreign key(responsible) references users(id_user),
	foreign key(approver) references users(id_user)
);

create table checklist_5s(
    id_checklist_5s int primary key,
    id_evaluation_5s int,
    description varchar(500),

	foreign key(id_evaluation_5s) references evaluation_5s(id_evaluation_5s)
);

create table results_5s(
    id_result_5s int primary key,
    id_evaluation_5s int,
    value int,
    comment varchar(200),
    date date,
    approver int,
    status int,

	foreign key(id_evaluation_5s) references evaluation_5s(id_evaluation_5s),
	foreign key(approver) references users(id_user)
);