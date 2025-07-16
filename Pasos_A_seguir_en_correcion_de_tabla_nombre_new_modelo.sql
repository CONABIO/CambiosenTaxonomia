1.- Primero en la tabla snibdtap.si_ousp_nombre_correcciones pasamos todos las llaves nombre que vamos a trabajar( Esta tabla tiene la estructura de tabla plana de antes), en la tabla llavenombreagrupado
no se ponen las llaves del caso 
#Actualiza_CompletamenteCAT, 
#Actualiza_gruposcat, 
#Actualiza_llavenombre_verificada, 
#Actualiza_comentarioscat, 
#Actualiza_ambientenombre y 
#Actualiza_comentarioscatvalido , porque ese cambio se hace directo en el snib en la tabla nombre_taxonomia.

truncate table snibdtap.llavenombreagrupado;

insert into llavenombreagrupado(llavenombre)
select distinct llavenombre from snibdtap.`#Actualiza_CompletamenteCATVAL`
union
select llavenombre from snibdtap.`#Actualiza_CompletamenteCOL`
union
select llavenombre from snibdtap.`#Actualiza_idnombrecat&comentarioscat`
union
select llavenombre from snibdtap.`#Actualiza_idnombrecatcomentarioscat_FaltaValidarTaxon`
union
select llavenombre from snibdtap.`#Actualiza_idnombrecatvalidocomentarioscatvalido`
union
select llavenombre from snibdtap.`#Elimina_validacion`;

select distinct llavenombre from snibdtap.llavenombreagrupado;


drop table snibdtap.si_ousp_nombre_correcciones;

-- drop table if exists snibdtap.si_ousp_nombre_correcciones;


CREATE TABLE snibdtap.si_ousp_nombre_correcciones (
  `llavenombre` varchar(32) NOT NULL DEFAULT '' COMMENT 'Clave generada por la CONABIO que identifica de manera única al nombre. Se asigna en el momento en que la taxonomía original se integra al SNIB.',
  `grupo` ENUM('','Anfibios','Aves','Bacterias','Chromistas','Hongos','Invertebrados','Mamíferos','NO DISPONIBLE','Peces','Plantas','Protozoos','Reptiles','Virus','Cromistas','Protozoarios') NOT NULL COMMENT 'Nombre utilizado para agrupar taxones con características biológicas generales similares asignado por la CONABIO.',
  `subgrupo` varchar(250) NOT NULL DEFAULT '' COMMENT 'Nombre utilizado para agrupar taxones con características biológicas similares asignado por la CONABIO; pueden incluir nombres genéricos o el nombre común de la especie.',
  `reinocat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionReinocat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `divisionphylumcat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificaciondivisionphylumcat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `clasecat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionclasecat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ordencat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionordencat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `subordencat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionsubordencat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `familiacat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionfamiliacat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatusfamiliacat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `subfamiliacat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionsubfamiliacat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Estatussubfamiliacat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `tribucat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificaciontribucat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatustribucat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `generocat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificaciongenerocat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatusgenerocat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `autoraniogenerocat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `subgenerocat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `sistemaclasificacionsubgenerocat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `autoraniosubgenerocat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatussubgenerocat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `epitetoespecificocat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `catdiccespeciecat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatusespeciecat` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `autoranioespeciecat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `categoriainfraespeciecat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `epitetoinfraespecificocat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `catdiccinfraespeciecat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatusinfraespeciecat` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `autoranioinfraespeciecat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `categoriainfraespecie2cat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `epitetoinfraespecifico2cat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `catdiccinfraespecie2cat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estatusinfraespecie2cat` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `autoranioinfraespecie2cat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `idnombrecat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `cattaxcat` varchar(14) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `catalogocat` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `comentarioscat` varchar(1024) NOT NULL COMMENT 'Indica detalle de la validación del nombre en el catalogo de nombres de la CONABIO.',
  `fuentecat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `reinooriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del reino en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `divisionphylumoriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del phylum o división en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `claseoriginal` varchar(35) NOT NULL COMMENT 'Nombre científico de la clase en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `ordenoriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del orden en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `autoranioordenoriginal` varchar(200) NOT NULL COMMENT 'Autor(es) y año de publicación del sistema de clasificación que respalda el nombre del orden proporcionado en las bases de datos originales.',
  `subordenoriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del suborden en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `familiaoriginal` varchar(100) NOT NULL COMMENT 'Nombre científico de la familia en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `sistemaclasificacionfamiliaoriginal` varchar(700) NOT NULL DEFAULT '' COMMENT 'Autor(es) y año de publicación del catálogo de autoridad, listado o referencia del nombre de la familia proporcionada en las bases de datos originales.',
  `autoraniofamiliaoriginal` varchar(200) NOT NULL COMMENT 'Autor(es) y año de publicación del sistema de clasificación que respalda el nombre de la familia proporcionado en las bases de datos originales.',
  `subfamiliaoriginal` varchar(100) NOT NULL COMMENT 'Nombre científico de la subfamilia en la que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `tribuoriginal` varchar(100) NOT NULL COMMENT 'Nombre científico de la tribu en la que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `generooriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del género en el que se ubica el ejemplar, en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `catdiccgenerooriginal` varchar(700) NOT NULL DEFAULT '' COMMENT 'Autor(es) y año de publicación del catálogo de autoridad, listado o referencia del nombre del género proporcionado en las bases de datos originales.',
  `autoraniogenerooriginal` varchar(200) NOT NULL COMMENT 'Autor(es) y año de publicación del sistema de clasificación que respalda el nombre del género proporcionado en las bases de datos originales.',
  `estatusgenerooriginal` enum('','aceptado','NO APLICA','NO DISPONIBLE','no resuelto','sinónimo','válido') NOT NULL COMMENT 'Indica el estatus taxonómico del género proporcionado en las bases de datos originales.',
  `subgenerooriginal` varchar(50) NOT NULL COMMENT 'Nombre científico del subgénero en el que se ubica el ejemplar, en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `epitetoespecificooriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del epíteto específico en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `autoranioespecieoriginal` varchar(200) NOT NULL COMMENT 'Autor(es) y año de publicación del sistema de clasificación que respalda el nombre del epíteto específico proporcionado en las bases de datos originales.',
  `catdiccespecieoriginal` varchar(820) NOT NULL DEFAULT '' COMMENT 'Autor(es) y año de publicación del catálogo de autoridad, listado o referencia del nombre de la especie proporcionada en las bases de datos originales.',
  `estatusespecieoriginal` enum('','aceptado','NO APLICA','NO DISPONIBLE','no resuelto','sinónimo','válido') NOT NULL COMMENT 'Indica el estatus taxonómico del epíteto específico proporcionado en las bases de datos originales.',
  `categoriainfraespecieoriginal` varchar(20) NOT NULL COMMENT 'Nombre de la categoría taxonómica del epíteto infraespecífico proporcionado en las bases de datos originales.',
  `epitetoinfraespecificooriginal` varchar(100) NOT NULL COMMENT 'Nombre científico del epíteto infraespecífico en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `autoranioinfraespecieoriginal` varchar(200) NOT NULL COMMENT 'Autor(es) y año de publicación del sistema de clasificación que respalda el nombre del epíteto infraespecífico proporcionado en las bases de datos originales.',
  `catdiccinfraespecieoriginal` varchar(700) NOT NULL DEFAULT '' COMMENT 'Autor(es) y año de publicación del catálogo de autoridad, listado o referencia del nombre de la infraespecie proporcionada en las bases de datos originales.',
  `estatusinfraespecieoriginal` enum('','aceptado','NO APLICA','NO DISPONIBLE','no resuelto','sinónimo','válido') NOT NULL COMMENT 'Indica el estatus taxonómico del epíteto infraespecífico proporcionado en las bases de datos originales.',
  `categoriainfraespecieoriginal2` varchar(20) NOT NULL COMMENT 'Nombre de la categoría taxonómica del epíteto subinfraespecífico proporcionado en las bases de datos originales.',
  `epitetoinfraespecificooriginal2` varchar(100) NOT NULL COMMENT 'Nombre científico del epíteto subinfraespecífico en el que se ubica el ejemplar en este campo se presenta el dato proporcionado en las bases de datos originales.',
  `autoranioinfraespecieoriginal2` varchar(200) NOT NULL COMMENT 'Autor(es) y año de publicación del sistema de clasificación que respalda el nombre del epíteto subinfraespecífico proporcionado en las bases de datos originales.',
  `catdiccinfraespecieoriginal2` varchar(150) NOT NULL COMMENT 'Autor(es) y año de publicación del catálogo de autoridad, listado o referencia del nombre de la subinfraespecie proporcionada en las bases de datos originales.',
  `estatusinfraespecieoriginal2` enum('','aceptado','NO APLICA','NO DISPONIBLE','no resuelto','sinónimo','válido') NOT NULL COMMENT 'Indica el estatus taxonómico del epíteto subinfraespecífico proporcionado en las bases de datos originales.',
  `citanomenclaturaloriginal` tinytext NOT NULL COMMENT 'Referencia bibliográfica corta de la publicación original del taxón.',
  `anotaciontaxonoriginal` varchar(2000) NOT NULL DEFAULT '' COMMENT 'Comentario adicional sobre el taxón.',
  `idnombrebdmigrada` int(11) DEFAULT NULL COMMENT 'Identificador del nombre en la base de datos migrada al modelo SNIB. Clave que identifica de manera única al taxón, se asigna en el momento en que se captura en la base de datos.',
  `proyecto` varchar(50) NOT NULL COMMENT 'Referencia que identifica al proyecto.',
  `clavebasedatos` varchar(150) NOT NULL COMMENT 'Referencia que identifica la versión final de la base de datos que se integra al SNIB.',
  `identificacionarchivo` varchar(60) NOT NULL DEFAULT '' COMMENT 'Identifica las diferentes bases de datos finales de un mismo proyecto.',
  `rutabd` tinytext NOT NULL COMMENT 'Ruta de la base de datos migrada al modelo de datos del SNIB.',
  `difvalidaciontax` varchar(512) NOT NULL DEFAULT '' COMMENT 'Se utiliza para hacer la diferencia en una validación taxonómica.',
  `distribucionnom2010` enum('','endémica','no endémica') NOT NULL DEFAULT '' COMMENT 'Distribución del taxón reportada por la NOM-059-SEMARNAT.',
  `taxonextinto` enum('','SI','NO') NOT NULL COMMENT 'Indica si corresponde a un taxón (especie o grupo taxonómico superior como familia, orden, etc) cuya desaparición se ha confirmado.',
  `reinocatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionReinocatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `divisionphylumcatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificaciondivisionphylumcatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `clasecatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionclasecatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ordencatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionordencatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `subordencatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionsubordencatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `familiacatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionfamiliacatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatusfamiliacatvalido` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `subfamiliacatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionsubfamiliacatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Estatussubfamiliacatvalido` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tribucatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificaciontribucatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatustribucatvalido` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `generocatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificaciongenerocatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatusgenerocatvalido` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `autoraniogenerocatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `subgenerocatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sistemaclasificacionsubgenerocatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `autoraniosubgenerocatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatussubgenerocatvalido` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `epitetoespecificocatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `catdiccespeciecatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatusespeciecatvalido` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `autoranioespeciecatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `categoriainfraespeciecatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `epitetoinfraespecificocatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `catdiccinfraespeciecatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatusinfraespeciecatvalido` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `autoranioinfraespeciecatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `categoriainfraespecie2catvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `epitetoinfraespecifico2catvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `catdiccinfraespecie2catvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatusinfraespecie2catvalido` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `autoranioinfraespecie2catvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `idnombrecatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `cattaxcatvalido` varchar(14) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `catalogocatvalido` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `comentarioscatvalido` varchar(1024) NOT NULL COMMENT 'Indica detalle de la validación del nombre válido en el catalogo de nombres de la CONABIO.',
  `fuentecatvalido` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `homonimosfamilia` tinytext NOT NULL COMMENT 'Indica los homónimos a nivel familia del nombre válidado con los catálogos de autoridades taxonómicas de la CONABIO.',
  `homonimosgenero` varchar(512) NOT NULL DEFAULT '' COMMENT 'Indica los homónimos a nivel género del nombre válidado con los catálogos de autoridades taxonómicas de la CONABIO.',
  `homonimosespecie` text NOT NULL COMMENT 'Indica los homónimos a nivel especie del nombre válidado con los catálogos de autoridades taxonómicas de la CONABIO.',
  `homonimosinfraespecie` text NOT NULL COMMENT 'Indica los homónimos a nivel infraespecie del nombre válidado con los catálogos de autoridades taxonómicas de la CONABIO.',
  `homonimosfamiliacatvalido` tinytext NOT NULL COMMENT 'Indica los homónimos a nivel familia del taxón válido en el que se ubica el ejemplar.',
  `homonimosgenerocatvalido` text NOT NULL COMMENT 'Indica los homónimos a nivel género del taxón válido en el que se ubica el ejemplar.',
  `homonimosespeciecatvalido` text NOT NULL COMMENT 'Indica los homónimos a nivel especie del taxón válido en el que se ubica el ejemplar.',
  `homonimosinfraespeciecatvalido` text NOT NULL COMMENT 'Indica los homónimos a nivel infraespecie del taxón válido en el que se ubica el ejemplar.',
  `ambientenombre` varchar(100) NOT NULL COMMENT 'Indica el ambiente del taxón.',
  `origenambientenombre` varchar(45) NOT NULL COMMENT 'Indica la referencia mediante la cual se asignó el ambiente al nombre.',
  `formadecrecimiento` varchar(100) NOT NULL COMMENT 'Forma o aspecto que presenta una planta en su etapa madura: hierba, árbol, arbusto, y bejuco entre otros.',
  `gruposcat` varchar(50) NOT NULL COMMENT 'Nombre utilizado para agrupar taxones con características biológicas generales similares asignado por la CONABIO.',
  `hibrido` varchar(50) NOT NULL COMMENT 'Indica la categoría taxonómica en la que el nombre es híbrido.',
  `categoriaoriginalscat` varchar(50) NOT NULL COMMENT 'Última categoria original del registro según la SCAT',
  `nombreoriginallimpioscat` varchar(100) NOT NULL COMMENT 'Nombre original limpio según la SCAT',
  `categoriacatscat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `nombrecatscat` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `estatuscatscat` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `autoridadcatscat` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `categoriavalidocatscat` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `nombrevalidocatscat` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `estatusvalidocatscat` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `autoridadvalidocatscat` tinytext CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ultimafechaactualizacion` date DEFAULT NULL COMMENT 'Fecha de última actualización de los datos.',
  `fechaactualizacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ultima fecha de actualización del registro.',
  `version` varchar(20) DEFAULT NULL,
  `idcol` varchar(30) DEFAULT NULL,
  `idcolvalido` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`llavenombre`)
) ENGINE=Aria DEFAULT CHARSET=utf8 PAGE_CHECKSUM=1;


insert into snibdtap.si_ousp_nombre_correcciones(llavenombre,grupo,subgrupo,reinocat,sistemaclasificacionReinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,Estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,estatustribucat,generocat,sistemaclasificaciongenerocat,estatusgenerocat,autoraniogenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,estatusespeciecat,autoranioespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,estatusinfraespeciecat,autoranioinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,catdiccinfraespecie2cat,estatusinfraespecie2cat,autoranioinfraespecie2cat,idnombrecat,cattaxcat,catalogocat,comentarioscat,fuentecat,reinooriginal,divisionphylumoriginal,claseoriginal,ordenoriginal,autoranioordenoriginal,subordenoriginal,familiaoriginal,sistemaclasificacionfamiliaoriginal,autoraniofamiliaoriginal,subfamiliaoriginal,tribuoriginal,generooriginal,catdiccgenerooriginal,autoraniogenerooriginal,estatusgenerooriginal,subgenerooriginal,epitetoespecificooriginal,autoranioespecieoriginal,catdiccespecieoriginal,estatusespecieoriginal,categoriainfraespecieoriginal,epitetoinfraespecificooriginal,autoranioinfraespecieoriginal,catdiccinfraespecieoriginal,estatusinfraespecieoriginal,categoriainfraespecieoriginal2,epitetoinfraespecificooriginal2,autoranioinfraespecieoriginal2,catdiccinfraespecieoriginal2,estatusinfraespecieoriginal2,citanomenclaturaloriginal,anotaciontaxonoriginal,idnombrebdmigrada,proyecto,clavebasedatos,identificacionarchivo,rutabd,difvalidaciontax,distribucionnom2010,taxonextinto,reinocatvalido,sistemaclasificacionReinocatvalido,divisionphylumcatvalido,sistemaclasificaciondivisionphylumcatvalido,clasecatvalido,sistemaclasificacionclasecatvalido,ordencatvalido,sistemaclasificacionordencatvalido,subordencatvalido,sistemaclasificacionsubordencatvalido,familiacatvalido,sistemaclasificacionfamiliacatvalido,estatusfamiliacatvalido,subfamiliacatvalido,sistemaclasificacionsubfamiliacatvalido,Estatussubfamiliacatvalido,tribucatvalido,sistemaclasificaciontribucatvalido,estatustribucatvalido,generocatvalido,sistemaclasificaciongenerocatvalido,estatusgenerocatvalido,autoraniogenerocatvalido,subgenerocatvalido,sistemaclasificacionsubgenerocatvalido,autoraniosubgenerocatvalido,estatussubgenerocatvalido,epitetoespecificocatvalido,catdiccespeciecatvalido,estatusespeciecatvalido,autoranioespeciecatvalido,categoriainfraespeciecatvalido,epitetoinfraespecificocatvalido,catdiccinfraespeciecatvalido,estatusinfraespeciecatvalido,autoranioinfraespeciecatvalido,categoriainfraespecie2catvalido,epitetoinfraespecifico2catvalido,catdiccinfraespecie2catvalido,estatusinfraespecie2catvalido,autoranioinfraespecie2catvalido,idnombrecatvalido,cattaxcatvalido,catalogocatvalido,comentarioscatvalido,fuentecatvalido,homonimosfamilia,homonimosgenero,homonimosespecie,homonimosinfraespecie,homonimosfamiliacatvalido,homonimosgenerocatvalido,homonimosespeciecatvalido,homonimosinfraespeciecatvalido,ambientenombre,origenambientenombre,formadecrecimiento,gruposcat,hibrido,categoriaoriginalscat,nombreoriginallimpioscat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat,categoriavalidocatscat,nombrevalidocatscat,estatusvalidocatscat,autoridadvalidocatscat,ultimafechaactualizacion,fechaactualizacion,version,idcol,idcolvalido)
select l.llavenombre,grupo,subgrupo,reinocat,sistemaclasificacionReinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,Estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,estatustribucat,generocat,sistemaclasificaciongenerocat,estatusgenerocat,autoraniogenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,estatusespeciecat,autoranioespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,estatusinfraespeciecat,autoranioinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,catdiccinfraespecie2cat,estatusinfraespecie2cat,autoranioinfraespecie2cat,idnombrecat,cattaxcat,catalogocat,comentarioscat,fuentecat,reinooriginal,divisionphylumoriginal,claseoriginal,ordenoriginal,autoranioordenoriginal,subordenoriginal,familiaoriginal,sistemaclasificacionfamiliaoriginal,autoraniofamiliaoriginal,subfamiliaoriginal,tribuoriginal,generooriginal,catdiccgenerooriginal,autoraniogenerooriginal,estatusgenerooriginal,subgenerooriginal,epitetoespecificooriginal,autoranioespecieoriginal,catdiccespecieoriginal,estatusespecieoriginal,categoriainfraespecieoriginal,epitetoinfraespecificooriginal,autoranioinfraespecieoriginal,catdiccinfraespecieoriginal,estatusinfraespecieoriginal,categoriainfraespecieoriginal2,epitetoinfraespecificooriginal2,autoranioinfraespecieoriginal2,catdiccinfraespecieoriginal2,estatusinfraespecieoriginal2,citanomenclaturaloriginal,anotaciontaxonoriginal,idnombrebdmigrada,proyecto,clavebasedatos,identificacionarchivo,rutabd,difvalidaciontax,distribucionnom2010,taxonextinto,reinocatvalido,sistemaclasificacionReinocatvalido,divisionphylumcatvalido,sistemaclasificaciondivisionphylumcatvalido,clasecatvalido,sistemaclasificacionclasecatvalido,ordencatvalido,sistemaclasificacionordencatvalido,subordencatvalido,sistemaclasificacionsubordencatvalido,familiacatvalido,sistemaclasificacionfamiliacatvalido,estatusfamiliacatvalido,subfamiliacatvalido,sistemaclasificacionsubfamiliacatvalido,Estatussubfamiliacatvalido,tribucatvalido,sistemaclasificaciontribucatvalido,estatustribucatvalido,generocatvalido,sistemaclasificaciongenerocatvalido,estatusgenerocatvalido,autoraniogenerocatvalido,subgenerocatvalido,sistemaclasificacionsubgenerocatvalido,autoraniosubgenerocatvalido,estatussubgenerocatvalido,epitetoespecificocatvalido,catdiccespeciecatvalido,estatusespeciecatvalido,autoranioespeciecatvalido,categoriainfraespeciecatvalido,epitetoinfraespecificocatvalido,catdiccinfraespeciecatvalido,estatusinfraespeciecatvalido,autoranioinfraespeciecatvalido,categoriainfraespecie2catvalido,epitetoinfraespecifico2catvalido,catdiccinfraespecie2catvalido,estatusinfraespecie2catvalido,autoranioinfraespecie2catvalido,idnombrecatvalido,cattaxcatvalido,catalogocatvalido,comentarioscatvalido,fuentecatvalido,homonimosfamilia,homonimosgenero,homonimosespecie,homonimosinfraespecie,homonimosfamiliacatvalido,homonimosgenerocatvalido,homonimosespeciecatvalido,homonimosinfraespeciecatvalido,ambientenombre,origenambientenombre,formadecrecimiento,gruposcat,hibrido,categoriaoriginalscat,nombreoriginallimpioscat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat,categoriavalidocatscat,nombrevalidocatscat,estatusvalidocatscat,autoridadvalidocatscat,ultimafechaactualizacion,fechaactualizacion,version,'',''
from snibdtap.llavenombreagrupado l inner join snib.nombre n on l.llavenombre=n.llavenombre;

2.- En la tabla snibdtap.si_ousp_nombre_correcciones realizamos las correcciones de taxonomia solicitadas, una vez concluida procedemos a lo siguiente. 
Tomamos como referencia los archivos
G:\PORTUNO\soluciones\Solucion_JIRA-3099, si piden actualizar campos resumen y espejo se basa en el archivo G:\PORTUNO\Soluciones\reestructura_snib_2018

3.- 
-- Primero se debe actualizar la TTN_snib

CALL catalogocentralizado.01_ActualizaCambiosEnCatalogocentralizado();



ALTER TABLE `snibdtap`.`si_ousp_nombre_correcciones` ADD COLUMN `idnombre` INTEGER UNSIGNED AFTER `version`,
 ADD COLUMN `idnombrevalido` INTEGER UNSIGNED AFTER `idnombre`;
 
DROP TABLE IF EXISTS snibdtap.nombrevinculo;

select max(idnombre)+1 from catalogocentralizado._TransformaTablaNombre_snib;

CREATE TABLE snibdtap.nombrevinculo (
  `idnombrevinculo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `llavetaxonomiacat` varchar(32) NOT NULL,
  `reinocat` varchar(100) NOT NULL,
  `sistemaclasificacionreinocat` tinytext NOT NULL,
  `divisionphylumcat` varchar(100) NOT NULL,
  `sistemaclasificaciondivisionphylumcat` tinytext NOT NULL,
  `clasecat` varchar(100) NOT NULL,
  `sistemaclasificacionclasecat` tinytext NOT NULL,
  `ordencat` varchar(100) NOT NULL,
  `sistemaclasificacionordencat` tinytext NOT NULL,
  `subordencat` varchar(100) NOT NULL,
  `sistemaclasificacionsubordencat` tinytext NOT NULL,
  `familiacat` varchar(100) NOT NULL,
  `sistemaclasificacionfamiliacat` tinytext NOT NULL,
  `estatusfamiliacat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `subfamiliacat` varchar(100) NOT NULL,
  `sistemaclasificacionsubfamiliacat` tinytext NOT NULL,
  `estatussubfamiliacat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `tribucat` varchar(100) NOT NULL,
  `sistemaclasificaciontribucat` tinytext NOT NULL,
  `estatustribucat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `generocat` varchar(100) NOT NULL,
  `sistemaclasificaciongenerocat` tinytext NOT NULL,
  `autoraniogenerocat` varchar(200) NOT NULL,
  `estatusgenerocat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `subgenerocat` varchar(100) NOT NULL,
  `sistemaclasificacionsubgenerocat` varchar(255) NOT NULL,
  `autoraniosubgenerocat` varchar(200) NOT NULL,
  `estatussubgenerocat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `epitetoespecificocat` varchar(100) NOT NULL,
  `catdiccespeciecat` varchar(255) NOT NULL,
  `autoranioespeciecat` varchar(200) NOT NULL,
  `estatusespeciecat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `categoriainfraespeciecat` varchar(20) NOT NULL,
  `epitetoinfraespecificocat` varchar(100) NOT NULL,
  `catdiccinfraespeciecat` varchar(255) NOT NULL,
  `autoranioinfraespeciecat` varchar(200) NOT NULL,
  `estatusinfraespeciecat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `categoriainfraespecie2cat` varchar(20) NOT NULL,
  `epitetoinfraespecifico2cat` varchar(100) NOT NULL,
  `catdiccinfraespecie2cat` varchar(255) NOT NULL,
  `autoranioinfraespecie2cat` varchar(200) NOT NULL,
  `estatusinfraespecie2cat` enum('','aceptado','no resuelto','sinónimo','válido','NO APLICA','NO DISPONIBLE') NOT NULL,
  `idnombrecat` varchar(20) NOT NULL,
  `cattaxcat` varchar(50) NOT NULL DEFAULT '',
  `catalogocat` varchar(50) NOT NULL DEFAULT '',
  `fuentecat` varchar(255) NOT NULL DEFAULT '',
  `categoriacatscat` varchar(20) NOT NULL DEFAULT '',
  `nombrecatscat` varchar(100) NOT NULL DEFAULT '',
  `estatuscatscat` enum('','aceptado','NO APLICA','NO DISPONIBLE','no resuelto','sinónimo','válido') NOT NULL DEFAULT '',
  `autoridadcatscat` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`idnombrevinculo`),
  KEY `idx_llavetaxonomiacat` (`llavetaxonomiacat`) USING BTREE
) ENGINE=Aria AUTO_INCREMENT=5144007 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC; -- El autoincremente es el valor max(iidnombre)+1 de la tabla catalogocentralizado._TransformaTablaNombre_snib

/* Modificamos la tabla nombre */

DROP TABLE IF EXISTS snibdtap.si_ousp_nombrecopia;

create table snibdtap.si_ousp_nombrecopia
SELECT llavenombre,idnombre,idnombrevalido,reinocat,sistemaclasificacionreinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,
subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,
estatustribucat,generocat,sistemaclasificaciongenerocat,autoraniogenerocat,estatusgenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,
autoranioespeciecat,estatusespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,autoranioinfraespeciecat,estatusinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,
catdiccinfraespecie2cat,autoranioinfraespecie2cat,estatusinfraespecie2cat,idnombrecat,comentarioscat,cattaxcat,catalogocat,fuentecat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat,reinocatvalido,sistemaclasificacionreinocatvalido,divisionphylumcatvalido,sistemaclasificaciondivisionphylumcatvalido,clasecatvalido,sistemaclasificacionclasecatvalido,ordencatvalido,sistemaclasificacionordencatvalido,
subordencatvalido,sistemaclasificacionsubordencatvalido,familiacatvalido,sistemaclasificacionfamiliacatvalido,estatusfamiliacatvalido,subfamiliacatvalido,sistemaclasificacionsubfamiliacatvalido,estatussubfamiliacatvalido,tribucatvalido,sistemaclasificaciontribucatvalido,
estatustribucatvalido,generocatvalido,sistemaclasificaciongenerocatvalido,autoraniogenerocatvalido,estatusgenerocatvalido,subgenerocatvalido,sistemaclasificacionsubgenerocatvalido,autoraniosubgenerocatvalido,estatussubgenerocatvalido,epitetoespecificocatvalido,catdiccespeciecatvalido,
autoranioespeciecatvalido,estatusespeciecatvalido,categoriainfraespeciecatvalido,epitetoinfraespecificocatvalido,catdiccinfraespeciecatvalido,autoranioinfraespeciecatvalido,estatusinfraespeciecatvalido,categoriainfraespecie2catvalido,epitetoinfraespecifico2catvalido,
catdiccinfraespecie2catvalido,autoranioinfraespecie2catvalido,estatusinfraespecie2catvalido,idnombrecatvalido,comentarioscatvalido,cattaxcatvalido,catalogocatvalido,fuentecatvalido,categoriavalidocatscat,nombrevalidocatscat,estatusvalidocatscat,autoridadvalidocatscat
FROM snibdtap.si_ousp_nombre_correcciones  
where comentarioscat not like "%Validado completamente con CAT%" or comentarioscatvalido not like "%Validado completamente con CAT%";

ALTER TABLE snibdtap.si_ousp_nombrecopia
ADD COLUMN llavetaxonomiacatvinculo varchar(32) NOT NULL NOT NULL DEFAULT '',
ADD COLUMN llavetaxonomiacatvalidovinculo varchar(32) NOT NULL NOT NULL DEFAULT '';


UPDATE snibdtap.si_ousp_nombrecopia
SET llavetaxonomiacatvinculo=MD5(CONCAT(reinocat,sistemaclasificacionreinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,
subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,
estatustribucat,generocat,sistemaclasificaciongenerocat,autoraniogenerocat,estatusgenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,
autoranioespeciecat,estatusespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,autoranioinfraespeciecat,estatusinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,
catdiccinfraespecie2cat,autoranioinfraespecie2cat,estatusinfraespecie2cat,idnombrecat,cattaxcat,catalogocat,fuentecat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat))
WHERE comentarioscat NOT LIKE "%Validado completamente con CAT%" and comentarioscat<>'';

UPDATE snibdtap.si_ousp_nombrecopia
SET llavetaxonomiacatvalidovinculo=MD5(CONCAT(reinocatvalido,sistemaclasificacionreinocatvalido,divisionphylumcatvalido,sistemaclasificaciondivisionphylumcatvalido,clasecatvalido,sistemaclasificacionclasecatvalido,ordencatvalido,sistemaclasificacionordencatvalido,
subordencatvalido,sistemaclasificacionsubordencatvalido,familiacatvalido,sistemaclasificacionfamiliacatvalido,estatusfamiliacatvalido,subfamiliacatvalido,sistemaclasificacionsubfamiliacatvalido,estatussubfamiliacatvalido,tribucatvalido,sistemaclasificaciontribucatvalido,
estatustribucatvalido,generocatvalido,sistemaclasificaciongenerocatvalido,autoraniogenerocatvalido,estatusgenerocatvalido,subgenerocatvalido,sistemaclasificacionsubgenerocatvalido,autoraniosubgenerocatvalido,estatussubgenerocatvalido,epitetoespecificocatvalido,catdiccespeciecatvalido,
autoranioespeciecatvalido,estatusespeciecatvalido,categoriainfraespeciecatvalido,epitetoinfraespecificocatvalido,catdiccinfraespeciecatvalido,autoranioinfraespeciecatvalido,estatusinfraespeciecatvalido,categoriainfraespecie2catvalido,epitetoinfraespecifico2catvalido,
catdiccinfraespecie2catvalido,autoranioinfraespecie2catvalido,estatusinfraespecie2catvalido,idnombrecatvalido,cattaxcatvalido,catalogocatvalido,fuentecatvalido,categoriavalidocatscat,nombrevalidocatscat,estatusvalidocatscat,autoridadvalidocatscat))
WHERE comentarioscatvalido NOT LIKE "%Validado completamente con CAT%" and comentarioscatvalido<>'';

/*Pasamos los datos de nombrecat por vinculo a la tabla nombrevinculo */
insert into snibdtap.nombrevinculo(llavetaxonomiacat,reinocat,sistemaclasificacionreinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,estatustribucat,generocat,sistemaclasificaciongenerocat,autoraniogenerocat,estatusgenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,autoranioespeciecat,estatusespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,autoranioinfraespeciecat,estatusinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,autoranioinfraespecie2cat,estatusinfraespecie2cat,catdiccinfraespecie2cat,idnombrecat,cattaxcat,catalogocat,fuentecat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat)
select llavetaxonomiacatvinculo,reinocat,sistemaclasificacionreinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,estatustribucat,generocat,sistemaclasificaciongenerocat,autoraniogenerocat,estatusgenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,autoranioespeciecat,estatusespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,autoranioinfraespeciecat,estatusinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,autoranioinfraespecie2cat,estatusinfraespecie2cat,catdiccinfraespecie2cat,idnombrecat,cattaxcat,catalogocat,fuentecat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat
from snibdtap.si_ousp_nombrecopia
where llavetaxonomiacatvinculo<>''
group by llavetaxonomiacatvinculo;

/*Pasamos los datos de nombrecat por vinculo a la tabla nombrevinculo */
insert into snibdtap.nombrevinculo(llavetaxonomiacat,reinocat,sistemaclasificacionreinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,estatustribucat,generocat,sistemaclasificaciongenerocat,autoraniogenerocat,estatusgenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,autoranioespeciecat,estatusespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,autoranioinfraespeciecat,estatusinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,autoranioinfraespecie2cat,estatusinfraespecie2cat,catdiccinfraespecie2cat,idnombrecat,cattaxcat,catalogocat,fuentecat,categoriacatscat,nombrecatscat,estatuscatscat,autoridadcatscat)
select llavetaxonomiacatvalidovinculo,reinocatvalido,sistemaclasificacionreinocatvalido,divisionphylumcatvalido,sistemaclasificaciondivisionphylumcatvalido,clasecatvalido,sistemaclasificacionclasecatvalido,ordencatvalido,sistemaclasificacionordencatvalido,subordencatvalido,sistemaclasificacionsubordencatvalido,familiacatvalido,sistemaclasificacionfamiliacatvalido,estatusfamiliacatvalido,subfamiliacatvalido,sistemaclasificacionsubfamiliacatvalido,estatussubfamiliacatvalido,tribucatvalido,sistemaclasificaciontribucatvalido,estatustribucatvalido,generocatvalido,sistemaclasificaciongenerocatvalido,autoraniogenerocatvalido,estatusgenerocatvalido,subgenerocatvalido,sistemaclasificacionsubgenerocatvalido,autoraniosubgenerocatvalido,estatussubgenerocatvalido,epitetoespecificocatvalido,catdiccespeciecatvalido,autoranioespeciecatvalido,estatusespeciecatvalido,categoriainfraespeciecatvalido,epitetoinfraespecificocatvalido,catdiccinfraespeciecatvalido,autoranioinfraespeciecatvalido,estatusinfraespeciecatvalido,categoriainfraespecie2catvalido,
epitetoinfraespecifico2catvalido,autoranioinfraespecie2catvalido,estatusinfraespecie2catvalido,catdiccinfraespecie2catvalido,idnombrecatvalido,cattaxcatvalido,catalogocatvalido,fuentecatvalido,categoriavalidocatscat,nombrevalidocatscat,estatusvalidocatscat,autoridadvalidocatscat
from snibdtap.si_ousp_nombrecopia
where llavetaxonomiacatvalidovinculo not in (select llavetaxonomiacat from snibdtap.nombrevinculo) and llavetaxonomiacatvalidovinculo<>''
group by llavetaxonomiacatvalidovinculo;

/* Creamos la tabla TTN_snib que es en donde tendremos los registro de la TTN y nombrevinculo */

DROP TABLE IF EXISTS snibdtap._TransformaTablaNombre_snib;

CREATE TABLE snibdtap._TransformaTablaNombre_snib
select * from catalogocentralizado._TransformaTablaNombre_snib limit 0;

ALTER TABLE snibdtap._TransformaTablaNombre_snib ADD INDEX uno(idnombre),
ADD INDEX dos(idcat);

insert into snibdtap._TransformaTablaNombre_snib(IdNombre,IdNombreRel,IdCAT,UltimaCategoriaTaxonomica,Taxon,TaxonConSubgenero,TaxonCompleto,EstatusTaxon,AutorTaxon,SistClasCatDiccTaxon,Fuente,GrupoSCAT,Homonimos,Reino,SistClasCatDiccReino,AutoridadReino,Divisionphylum,SistClasCatDiccDivisionphylum,AutoridadDivisionphylum,Clase,SistClasCatDiccClase,AutoridadClase,Orden,SistClasCatDiccOrden,AutoridadOrden,Suborden,SistClasCatDiccSuborden,AutoridadSuborden,Familia,SistClasCatDiccFamilia,AutoridadFamilia,EstatusFamilia,Subfamilia,SistClasCatDiccSubfamilia,AutoridadSubfamilia,EstatusSubfamilia,Tribu,SistClasCatDiccTribu,AutoridadTribu,EstatusTribu,Genero,SistClasCatDiccGenero,AutoridadGenero,EstatusGenero,Subgenero,SistClasCatDiccSubgenero,AutoridadSubgenero,EstatusSubgenero,Especie_epiteto,SistClasCatDiccEspecie_epiteto,EstatusEspecie_epiteto,AutoridadEspecie_epiteto,Categinfra,Nombreinfra,SistClasCatDiccNombreinfra,EstatusCategInfra,AutoridadCategInfra,CategSubInfra,NombreSubInfra,SistClasCatDiccNombreSubInfra,EstatusCategSubInfra,AutoridadCategSubInfra,IdCATValido,Catalogo,CategoriaTaxon)
select IdNombre,IdNombreRel,IdCAT,UltimaCategoriaTaxonomica,Taxon,TaxonConSubgenero,TaxonCompleto,EstatusTaxon,AutorTaxon,SistClasCatDiccTaxon,Fuente,GrupoSCAT,Homonimos,Reino,SistClasCatDiccReino,AutoridadReino,Divisionphylum,SistClasCatDiccDivisionphylum,AutoridadDivisionphylum,Clase,SistClasCatDiccClase,AutoridadClase,Orden,SistClasCatDiccOrden,AutoridadOrden,Suborden,SistClasCatDiccSuborden,AutoridadSuborden,Familia,SistClasCatDiccFamilia,AutoridadFamilia,EstatusFamilia,Subfamilia,SistClasCatDiccSubfamilia,AutoridadSubfamilia,EstatusSubfamilia,Tribu,SistClasCatDiccTribu,AutoridadTribu,EstatusTribu,Genero,SistClasCatDiccGenero,AutoridadGenero,EstatusGenero,Subgenero,SistClasCatDiccSubgenero,AutoridadSubgenero,EstatusSubgenero,Especie_epiteto,SistClasCatDiccEspecie_epiteto,EstatusEspecie_epiteto,AutoridadEspecie_epiteto,Categinfra,Nombreinfra,SistClasCatDiccNombreinfra,EstatusCategInfra,AutoridadCategInfra,CategSubInfra,NombreSubInfra,SistClasCatDiccNombreSubInfra,EstatusCategSubInfra,AutoridadCategSubInfra,IdCATValido,Fuente,UltimaCategoriaTaxonomica
from catalogocentralizado._TransformaTablaNombre_snib where idnombre<5000000;

/*Agregamos en la _TTN_snib recien creada los registros que no estan en el catalogo */
insert into snibdtap._TransformaTablaNombre_snib(idnombre,AutoridadReino,AutoridadDivisionphylum,AutoridadClase,AutoridadOrden,AutoridadSuborden,AutoridadFamilia,AutoridadSubfamilia,AutoridadTribu,Homonimos,SistClasCatDiccTaxon,Reino,SistClasCatDiccReino,DivisionPhylum,SistClasCatDiccDivisionPhylum,clase,SistClasCatDiccclase,orden,SistClasCatDiccorden,suborden,SistClasCatDiccsuborden,familia,SistClasCatDiccfamilia,Estatusfamilia,subfamilia,SistClasCatDiccsubfamilia,Estatussubfamilia,tribu,SistClasCatDicctribu,Estatustribu,genero,SistClasCatDiccGenero,AutoridadGenero,EstatusGenero,subgenero,SistClasCatDiccsubgenero,Autoridadsubgenero,Estatussubgenero,especie_epiteto,SistClasCatDiccEspecie_epiteto,AutoridadEspecie_epiteto,EstatusEspecie_epiteto,CategInfra,NombreInfra,SistClasCatDiccNombreInfra,AutoridadCategInfra,EstatusCategInfra,CategSubinfra,NombreSubinfra,SistClasCatDiccNombreSubinfra,AutoridadCategSubinfra,EstatusCategSubinfra,IdCAT,Catalogo,CategoriaTaxon,UltimaCategoriaTaxonomica,Fuente,TaxonConsubgenero,EstatusTaxon,AutorTaxon,llavetaxonomiacat)
select idnombrevinculo,'' as AutoridadReino,'' as AutoridadDivisionphylum,'' as AutoridadClase,'' as AutoridadOrden,'' as AutoridadSuborden,'' as AutoridadFamilia,'' as AutoridadSubfamilia,'' as AutoridadTribu,
'' as Homonimos,'' as SistClasCatDiccTaxon,reinocat,sistemaclasificacionreinocat,divisionphylumcat,sistemaclasificaciondivisionphylumcat,clasecat,
sistemaclasificacionclasecat,ordencat,sistemaclasificacionordencat,subordencat,sistemaclasificacionsubordencat,familiacat,sistemaclasificacionfamiliacat,estatusfamiliacat,subfamiliacat,sistemaclasificacionsubfamiliacat,estatussubfamiliacat,tribucat,sistemaclasificaciontribucat,estatustribucat,generocat,sistemaclasificaciongenerocat,autoraniogenerocat,estatusgenerocat,subgenerocat,sistemaclasificacionsubgenerocat,autoraniosubgenerocat,estatussubgenerocat,epitetoespecificocat,catdiccespeciecat,autoranioespeciecat,estatusespeciecat,categoriainfraespeciecat,epitetoinfraespecificocat,catdiccinfraespeciecat,autoranioinfraespeciecat,estatusinfraespeciecat,categoriainfraespecie2cat,epitetoinfraespecifico2cat,catdiccinfraespecie2cat,autoranioinfraespecie2cat,estatusinfraespecie2cat,idnombrecat,catalogocat,categoriacatscat,cattaxcat,fuentecat,nombrecatscat,estatuscatscat,autoridadcatscat,llavetaxonomiacat
from snibdtap.nombrevinculo;

/* Actualizamos el idnombre para los registros validados completamente con CAT de la tabla nombretaxonomia*/
UPDATE snibdtap.si_ousp_nombre_correcciones n inner join snibdtap._TransformaTablaNombre_snib t on n.idnombrecat=t.idcat
set n.idnombre=t.idnombre
where comentarioscat like "%Validado completamente con CAT%" and t.idnombre<5000000;

/* Actualizamos el idnombre para los registros validados completamente con CAT */
UPDATE snibdtap.si_ousp_nombrecopia n inner join snibdtap._TransformaTablaNombre_snib t on n.idnombrecat=t.idcat
set n.idnombre=t.idnombre
where comentarioscat like "%Validado completamente con CAT%" and t.idnombre<5000000;

/* Actualizamos el idnombrevalido para los registros validados completamente con CAT  de la tabla nombre_taxonomia*/
UPDATE snibdtap.si_ousp_nombre_correcciones n inner join snibdtap._TransformaTablaNombre_snib t on n.idnombrecatvalido=t.idcat
set n.idnombrevalido=t.idnombre
where comentarioscatvalido like "%Validado completamente con CAT%" and t.idnombre<5000000;

/* Actualizamos el idnombrevalido para los registros validados completamente con CAT */
UPDATE snibdtap.si_ousp_nombrecopia n inner join snibdtap._TransformaTablaNombre_snib t on n.idnombrecatvalido=t.idcat
set n.idnombrevalido=t.idnombre
where comentarioscatvalido like "%Validado completamente con CAT%" and t.idnombre<5000000;

/*Actualizamos el idnombre para los registros no validados completamente con cat */
update snibdtap.si_ousp_nombrecopia n inner join snibdtap.nombrevinculo nv on n.llavetaxonomiacatvinculo=nv.llavetaxonomiacat
set n.idnombre=nv.idnombrevinculo where n.comentarioscat NOT LIKE "%Validado completamente con CAT%" and n.comentarioscat<>'';

/*Actualizamos el idnombrevalido para los registros no validados completamente con cat */
update snibdtap.si_ousp_nombrecopia n inner join snibdtap.nombrevinculo nv on n.llavetaxonomiacatvalidovinculo=nv.llavetaxonomiacat
set n.idnombrevalido=nv.idnombrevinculo where n.comentarioscatvalido NOT LIKE "%Validado completamente con CAT%" and n.comentarioscatvalido<>'';

/* Simulamos la relacion en la tabla _TTN_snib para los registros no validados con CAT */
update snibdtap.si_ousp_nombrecopia n inner join snibdtap._TransformaTablaNombre_snib t on n.idnombre=t.IdNombre
set t.IdNombreRel=n.idnombrevalido
where n.idnombre>=5000000;

update snibdtap._TransformaTablaNombre_snib
set IdNombreRel=0
where IdnombreRel is null;

update snibdtap.si_ousp_nombrecopia s inner join snibdtap.si_ousp_nombre_correcciones n on s.llavenombre=n.llavenombre
set n.idnombre=s.idnombre,
n.idnombrevalido=s.idnombrevalido;

DROP TABLE IF EXISTS snibdtap.si_ousp_nombrecopia;

-- Agregamos los nuevos registros a la tabla catlogocentralizado._TransformaTablaNombre_snib
drop table if exists snibdtap._TransformaTablaNombre_snib_backup;

create table snibdtap._TransformaTablaNombre_snib_backup
select * from catalogocentralizado._TransformaTablaNombre_snib;

drop table if exists snibdtap.nombre_taxonomia_backup;

create table snibdtap.nombre_taxonomia_backup
select * from snib.nombre_taxonomia;

insert into catalogocentralizado._TransformaTablaNombre_snib(idnombre,idnombrerel,Reino,SistClasCatDiccTaxon,Homonimos,AutoridadReino,AutoridadDivisionphylum,AutoridadClase,AutoridadOrden,AutoridadSuborden,AutoridadFamilia,AutoridadSubfamilia,AutoridadTribu,SistClasCatDiccReino,DivisionPhylum,SistClasCatDiccDivisionPhylum,clase,SistClasCatDiccclase,orden,SistClasCatDiccorden,suborden,SistClasCatDiccsuborden,familia,SistClasCatDiccfamilia,Estatusfamilia,subfamilia,SistClasCatDiccsubfamilia,Estatussubfamilia,tribu,SistClasCatDicctribu,Estatustribu,genero,SistClasCatDiccGenero,AutoridadGenero,EstatusGenero,subgenero,SistClasCatDiccsubgenero,Autoridadsubgenero,Estatussubgenero,especie_epiteto,SistClasCatDiccEspecie_epiteto,AutoridadEspecie_epiteto,EstatusEspecie_epiteto,CategInfra,NombreInfra,SistClasCatDiccNombreInfra,AutoridadCategInfra,EstatusCategInfra,CategSubinfra,NombreSubinfra,SistClasCatDiccNombreSubinfra,AutoridadCategSubinfra,EstatusCategSubinfra,IdCAT,Catalogo,CategoriaTaxon,UltimaCategoriaTaxonomica,Fuente,TaxonConsubgenero,EstatusTaxon,AutorTaxon,llavetaxonomiacat)
select idnombre,idnombrerel,Reino,''as SistClasCatDiccTaxon,'' as Homonimos,'' as AutoridadReino,'' as AutoridadDivisionphylum,'' as AutoridadClase,'' as AutoridadOrden,'' as AutoridadSuborden,'' as AutoridadFamilia,'' as AutoridadSubfamilia,'' as AutoridadTribu,SistClasCatDiccReino,DivisionPhylum,SistClasCatDiccDivisionPhylum,clase,SistClasCatDiccclase,orden,SistClasCatDiccorden,suborden,SistClasCatDiccsuborden,familia,SistClasCatDiccfamilia,Estatusfamilia,subfamilia,SistClasCatDiccsubfamilia,Estatussubfamilia,tribu,SistClasCatDicctribu,Estatustribu,genero,SistClasCatDiccGenero,AutoridadGenero,EstatusGenero,subgenero,SistClasCatDiccsubgenero,Autoridadsubgenero,Estatussubgenero,especie_epiteto,SistClasCatDiccEspecie_epiteto,AutoridadEspecie_epiteto,EstatusEspecie_epiteto,CategInfra,NombreInfra,SistClasCatDiccNombreInfra,AutoridadCategInfra,EstatusCategInfra,CategSubinfra,NombreSubinfra,SistClasCatDiccNombreSubinfra,AutoridadCategSubinfra,EstatusCategSubinfra,IdCAT,Catalogo,CategoriaTaxon,UltimaCategoriaTaxonomica,Fuente,TaxonConsubgenero,EstatusTaxon,AutorTaxon,llavetaxonomiacat
from snibdtap._TransformaTablaNombre_snib where idnombre>=5000000;

update snib.nombre_taxonomia n inner join snibdtap.si_ousp_nombre_correcciones nc on nc.llavenombre=n.llavenombre
set n.idnombre=nc.idnombre,
n.grupo=nc.grupo,
n.subgrupo=nc.subgrupo,
n.comentarioscat=nc.comentarioscat,
n.comentarioscatvalido=nc.comentarioscatvalido,
n.homonimosfamilia=nc.homonimosfamilia,
n.homonimosgenero=nc.homonimosgenero,
n.homonimosespecie=nc.homonimosespecie,
n.homonimosinfraespecie=nc.homonimosinfraespecie,
n.homonimosfamiliacatvalido=nc.homonimosfamiliacatvalido,
n.homonimosgenerocatvalido=nc.homonimosgenerocatvalido,
n.homonimosespeciecatvalido=nc.homonimosespeciecatvalido,
n.homonimosinfraespeciecatvalido=nc.homonimosinfraespeciecatvalido,
n.gruposcat=nc.gruposcat,
n.ultimafechaactualizacion=nc.ultimafechaactualizacion;


-- Consulta para revisar que todo haya pasado bien

select n.llavenombre,
n.grupo,n1.grupo,
n.reinocat,n1.reinocat,
n.sistemaclasificacionreinocat,n1.sistemaclasificacionreinocat,
n.divisionphylumcat,n1.divisionphylumcat,
n.sistemaclasificaciondivisionphylumcat,n1.sistemaclasificaciondivisionphylumcat,
n.clasecat,n1.clasecat,
n.sistemaclasificacionclasecat,n1.sistemaclasificacionclasecat,
n.ordencat,n1.ordencat,
n.sistemaclasificacionordencat,n1.sistemaclasificacionordencat,
n.subordencat,n1.subordencat,
n.sistemaclasificacionsubordencat,n1.sistemaclasificacionsubordencat,
n.familiacat,n1.familiacat,
n.sistemaclasificacionfamiliacat,n1.sistemaclasificacionfamiliacat,
n.estatusfamiliacat,n1.estatusfamiliacat,
n.subfamiliacat,n1.subfamiliacat,
n.sistemaclasificacionsubfamiliacat,n1.sistemaclasificacionsubfamiliacat,
n.estatussubfamiliacat,n1.estatussubfamiliacat,
n.tribucat,n1.tribucat,
n.sistemaclasificaciontribucat,n1.sistemaclasificaciontribucat,
n.estatustribucat,n1.estatustribucat,
n.generocat,n1.generocat,
n.sistemaclasificaciongenerocat,n1.sistemaclasificaciongenerocat,
n.estatusgenerocat,n1.estatusgenerocat,
n.autoraniogenerocat,n1.autoraniogenerocat,
n.subgenerocat,n1.subgenerocat,
n.sistemaclasificacionsubgenerocat,n1.sistemaclasificacionsubgenerocat,
n.autoraniosubgenerocat,n1.autoraniosubgenerocat,
n.estatussubgenerocat,n1.estatussubgenerocat,
n.epitetoespecificocat,n1.epitetoespecificocat,
n.catdiccespeciecat,n1.catdiccespeciecat,
n.estatusespeciecat,n1.estatusespeciecat,
n.autoranioespeciecat,n1.autoranioespeciecat,
n.categoriainfraespeciecat,n1.categoriainfraespeciecat,
n.epitetoinfraespecificocat,n1.epitetoinfraespecificocat,
n.catdiccinfraespeciecat,n1.catdiccinfraespeciecat,
n.estatusinfraespeciecat,n1.estatusinfraespeciecat,
n.autoranioinfraespeciecat,n1.autoranioinfraespeciecat,
n.categoriainfraespecie2cat,n1.categoriainfraespecie2cat,
n.epitetoinfraespecifico2cat,n1.epitetoinfraespecifico2cat,
n.catdiccinfraespecie2cat,n1.catdiccinfraespecie2cat,
n.estatusinfraespecie2cat,n1.estatusinfraespecie2cat,
n.autoranioinfraespecie2cat,n1.autoranioinfraespecie2cat,
n.idnombrecat,n1.idnombrecat,
n.cattaxcat,n1.cattaxcat,
n.catalogocat,n1.catalogocat,
n.comentarioscat,n1.comentarioscat,
n.fuentecat,n1.fuentecat,
n.reinocatvalido,n1.reinocatvalido,
n.sistemaclasificacionreinocatvalido,n1.sistemaclasificacionreinocatvalido,
n.divisionphylumcatvalido,n1.divisionphylumcatvalido,
n.sistemaclasificaciondivisionphylumcatvalido,n1.sistemaclasificaciondivisionphylumcatvalido,
n.clasecatvalido,n1.clasecatvalido,
n.sistemaclasificacionclasecatvalido,n1.sistemaclasificacionclasecatvalido,
n.ordencatvalido,n1.ordencatvalido,
n.sistemaclasificacionordencatvalido,n1.sistemaclasificacionordencatvalido,
n.subordencatvalido,n1.subordencatvalido,
n.sistemaclasificacionsubordencatvalido,n1.sistemaclasificacionsubordencatvalido,
n.familiacatvalido,n1.familiacatvalido,
n.sistemaclasificacionfamiliacatvalido,n1.sistemaclasificacionfamiliacatvalido,
n.estatusfamiliacatvalido,n1.estatusfamiliacatvalido,
n.subfamiliacatvalido,n1.subfamiliacatvalido,
n.sistemaclasificacionsubfamiliacatvalido,n1.sistemaclasificacionsubfamiliacatvalido,
n.Estatussubfamiliacatvalido,n1.Estatussubfamiliacatvalido,
n.tribucatvalido,n1.tribucatvalido,
n.sistemaclasificaciontribucatvalido,n1.sistemaclasificaciontribucatvalido,
n.estatustribucatvalido,n1.estatustribucatvalido,
n.generocatvalido,n1.generocatvalido,
n.sistemaclasificaciongenerocatvalido,n1.sistemaclasificaciongenerocatvalido,
n.estatusgenerocatvalido,n1.estatusgenerocatvalido,
n.autoraniogenerocatvalido,n1.autoraniogenerocatvalido,
n.subgenerocatvalido,n1.subgenerocatvalido,
n.sistemaclasificacionsubgenerocatvalido,n1.sistemaclasificacionsubgenerocatvalido,
n.autoraniosubgenerocatvalido,n1.autoraniosubgenerocatvalido,
n.estatussubgenerocatvalido,n1.estatussubgenerocatvalido,
n.epitetoespecificocatvalido,n1.epitetoespecificocatvalido,
n.catdiccespeciecatvalido,n1.catdiccespeciecatvalido,
n.estatusespeciecatvalido,n1.estatusespeciecatvalido,
n.autoranioespeciecatvalido,n1.autoranioespeciecatvalido,
n.categoriainfraespeciecatvalido,n1.categoriainfraespeciecatvalido,
n.epitetoinfraespecificocatvalido,n1.epitetoinfraespecificocatvalido,
n.catdiccinfraespeciecatvalido,n1.catdiccinfraespeciecatvalido,
n.estatusinfraespeciecatvalido,n1.estatusinfraespeciecatvalido,
n.autoranioinfraespeciecatvalido,n1.autoranioinfraespeciecatvalido,
n.categoriainfraespecie2catvalido,n1.categoriainfraespecie2catvalido,
n.epitetoinfraespecifico2catvalido,n1.epitetoinfraespecifico2catvalido,
n.catdiccinfraespecie2catvalido,n1.catdiccinfraespecie2catvalido,
n.estatusinfraespecie2catvalido,n1.estatusinfraespecie2catvalido,
n.autoranioinfraespecie2catvalido,n1.autoranioinfraespecie2catvalido,
n.idnombrecatvalido,n1.idnombrecatvalido,
n.cattaxcatvalido,n1.cattaxcatvalido,
n.catalogocatvalido,n1.catalogocatvalido,
n.comentarioscatvalido,n1.comentarioscatvalido,
n.fuentecatvalido,n1.fuentecatvalido,
n.homonimosfamilia,n1.homonimosfamilia,
n.homonimosgenero,n1.homonimosgenero,
n.homonimosespecie,n1.homonimosespecie,
n.homonimosinfraespecie,n1.homonimosinfraespecie,
n.homonimosfamiliacatvalido,n1.homonimosfamiliacatvalido,
n.homonimosgenerocatvalido,n1.homonimosgenerocatvalido,
n.homonimosespeciecatvalido,n1.homonimosespeciecatvalido,
n.homonimosinfraespeciecatvalido,n1.homonimosinfraespeciecatvalido,
n.ambientenombre,n1.ambientenombre,
n.origenambientenombre,n1.origenambientenombre,
n.formadecrecimiento,n1.formadecrecimiento,
n.gruposcat,n1.gruposcat,
n.hibrido,n1.hibrido,
n.categoriaoriginalscat,n1.categoriaoriginalscat,
n.nombreoriginallimpioscat,n1.nombreoriginallimpioscat,
n.categoriacatscat,n1.categoriacatscat,
n.nombrecatscat,n1.nombrecatscat,
n.estatuscatscat,n1.estatuscatscat,
n.autoridadcatscat,n1.autoridadcatscat,
n.categoriavalidocatscat,n1.categoriavalidocatscat,
n.nombrevalidocatscat,n1.nombrevalidocatscat,
n.estatusvalidocatscat,n1.estatusvalidocatscat,
n.autoridadvalidocatscat,n1.autoridadvalidocatscat,
n.ultimafechaactualizacion,n1.ultimafechaactualizacion,
n.fechaactualizacion,n1.fechaactualizacion,
n.version,n1.version
from snibdtap.si_ousp_nombre_correcciones n inner join snib.nombre n1 on n.llavenombre=n1.llavenombre;

-- Actualizamos idcol y idcolvalido en la tabla nombrecatoflive

/*update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snib.nombre_catoflive c using(llavenombre)
inner join snib.nombre_taxonomia n using(llavenombre)
set c.idcol=a.idcol_corregido,
c.idcol_valido=a.idcol_valido_corregido,
c.estadoregistro=n.estadoregistro; */

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snib.nombre_taxonomia n using(llavenombre)
set n.idcol=a.idcol_corregido,
n.idcolvalido=a.idcol_valido_corregido;

update snibdtap.`#Actualiza_idnombrecat&comentarioscat_FaltaValidarTaxon` a inner join snib.nombre_taxonomia n using(llavenombre)
set n.idcol='',
n.idcolvalido='';

update snibdtap.`#Elimina_validacion` a inner join snib.nombretaxonomia n using(llavenombre)
set n.idcol='',
n.idcolvalido='';
