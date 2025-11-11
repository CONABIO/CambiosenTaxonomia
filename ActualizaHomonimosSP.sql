DELIMITER $$

DROP PROCEDURE IF EXISTS `snib4567`.`ActualizaHomonimos` $$
CREATE DEFINER=`si`@`%` PROCEDURE `ActualizaHomonimos`()
BEGIN

  DROP TEMPORARY TABLE IF EXISTS catalogocentralizado.HomonimosNoEnCAT1;

CREATE TEMPORARY TABLE catalogocentralizado.`HomonimosNoEnCAT1` (
  `Taxon` varchar(255) NOT NULL DEFAULT '',
  `TaxonConSubGenero` varchar(255) NOT NULL DEFAULT '',
  `UltimaCategoriaTaxonomica` varchar(80) NOT NULL DEFAULT '',
  `Homonimos` mediumtext NOT NULL,
  `genero` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `subgenero` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `especie_epiteto` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Nombreinfra` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  KEY `idx_taxonconsubgenero` (`TaxonConSubGenero`),
  KEY `idx_especie` (`genero`,`subgenero`,`especie_epiteto`),
  KEY `idx_infraespecie` (`genero`,`subgenero`,`especie_epiteto`,`Nombreinfra`),
  KEY `idx_ultimacategoria` (`UltimaCategoriaTaxonomica`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO catalogocentralizado.HomonimosNoEnCAT1(Taxon,TaxonConSubGenero,UltimaCategoriaTaxonomica,Homonimos,genero,subgenero,especie_epiteto,Nombreinfra)
SELECT Taxon,TaxonConSubGenero,UltimaCategoriaTaxonomica,Homonimos,genero,subgenero,especie_epiteto,NombreInfra
FROM catalogocentralizado.HomonimosNoEnCAT;

DROP TEMPORARY TABLE IF EXISTS snibdtap.si_ousp_homonimosTTN;
	 
CREATE TEMPORARY TABLE snibdtap.si_ousp_homonimosTTN
SELECT Taxonconsubgenero,Genero,Subgenero,Especie_epiteto,Nombreinfra,Nombresubinfra,Homonimos,UltimaCategoriaTaxonomica
FROM catalogocentralizado._TransformaTablaNombre
WHERE Homonimos<>'';
	 
ALTER TABLE snibdtap.si_ousp_homonimosTTN
ADD INDEX uno(Genero,Subgenero,Especie_epiteto),
ADD INDEX dos(Genero,Subgenero,Especie_epiteto,Nombreinfra),
ADD INDEX tres(UltimaCategoriaTaxonomica),
ADD INDEX cuatro(Taxonconsubgenero);
	 
UPDATE snibdtap.si_ousp_homonimosTTN
SET UltimaCategoriaTaxonomica='infraespecie'
WHERE Nombreinfra<>'' and NombreSubinfra='';

DROP  TEMPORARY TABLE IF EXISTS snibdtap.nombre1;

-- Para poder hace rlos cruces fue necesario generar una tabla solo con los campos a necesitar.	 
CREATE TEMPORARY TABLE snibdtap.nombre1
SELECT llaveagrupado,familiacat,generocat,subgenerocat,epitetoespecificocat,epitetoinfraespecificocat,familiacatvalido,generocatvalido,subgenerocatvalido,epitetoespecificocatvalido,
epitetoinfraespecificocatvalido,familiaoriginallimpio as familiaoriginal,generooriginallimpio as generooriginal,subgenerooriginallimpio as subgenerooriginal,
epitetoespecificooriginallimpio as epitetoespecificooriginal,epitetoinfraespecificooriginallimpio as epitetoinfraespecificooriginal,comentarioscat
FROM ValidacionesSCAT.cortevalidacion;

	 
-- FAMILIA 
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Taxonconsubgenero = n.familiacat
                             where t.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);

                            
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamilia = p.Homonimos;

-- GENERO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Taxonconsubgenero = n.generocat
							 WHERE t.UltimaCategoriaTaxonomica = 'género'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenero = p.Homonimos;

-- ESPECIE

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Genero = n.generocat and t.Subgenero=n.subgenerocat and t.Especie_epiteto=n.epitetoespecificocat
							 WHERE t.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespecie = p.Homonimos;


-- INFRAESPECIE

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Genero = n.generocat and t.Subgenero=n.subgenerocat and t.Especie_epiteto=n.epitetoespecificocat and t.Nombreinfra=n.epitetoinfraespecificocat
							 WHERE t.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespecie = p.Homonimos;


-- FAMILIA VALIDO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.TaxonConSubgenero = n.familiacatvalido 
                             where t.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);

ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamiliacatvalido = p.Homonimos;

-- GENERO VALIDO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.TaxonConSubgenero = n.generocatvalido
							 WHERE t.UltimaCategoriaTaxonomica = 'género'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenerocatvalido = p.Homonimos;

-- ESPECIE VALIDO

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Genero = n.generocatvalido and t.Subgenero=n.subgenerocatvalido and t.Especie_epiteto=n.epitetoespecificocatvalido
							 WHERE t.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespeciecatvalido = p.Homonimos;


-- INFRAESPECIE VALIDO

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Genero = n.generocatvalido and t.Subgenero=n.subgenerocatvalido and t.Especie_epiteto=n.epitetoespecificocatvalido and t.Nombreinfra=n.epitetoinfraespecificocatvalido
							 WHERE t.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespeciecatvalido = p.Homonimos;

-- Asignar Homonimos no en CAT
-- FAMILIA 
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.TaxonConSubgenero = n.familiacat 
                             where h.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);
                             
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamilia = p.Homonimos
where n.homonimosfamilia='';

-- GENERO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.TaxonConSubgenero = n.generocat 
                             where h.UltimaCategoriaTaxonomica = 'género'
                             GROUP BY n.llaveagrupado);
                             
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenero = p.Homonimos
where n.homonimosgenero='';

-- ESPECIE

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.Genero = n.generocat and h.Subgenero=n.subgenerocat and h.Especie_epiteto=n.epitetoespecificocat
							 WHERE h.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespecie = p.Homonimos
where n.homonimosespecie='';

-- INFRAESPECIE

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.Genero = n.generocat and h.Subgenero=n.subgenerocat and h.Especie_epiteto=n.epitetoespecificocat and h.Nombreinfra=n.epitetoinfraespecificocat
							 WHERE h.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespecie = p.Homonimos
where n.homonimosinfraespecie='';

-- FAMILIA VALIDO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.TaxonConSubgenero = n.familiacatvalido 
                             where h.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);
                             
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamiliacatvalido = p.Homonimos
where n.homonimosfamiliacatvalido='';

-- GENERO VALIDO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.TaxonConSubgenero = n.generocatvalido 
                             WHERE h.UltimaCategoriaTaxonomica = 'género'
                             GROUP BY n.llaveagrupado);
                             
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenerocatvalido = p.Homonimos
where n.homonimosgenerocatvalido='';

-- ESPECIE VALIDO

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.Genero = n.generocatvalido and h.Subgenero=n.subgenerocatvalido and h.Especie_epiteto=n.epitetoespecificocatvalido
							 WHERE h.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespeciecatvalido = p.Homonimos
where n.homonimosespeciecatvalido='';

-- INFRAESPECIE VALIDO

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.Genero = n.generocatvalido and h.Subgenero=n.subgenerocatvalido and h.Especie_epiteto=n.epitetoespecificocatvalido and h.Nombreinfra=n.epitetoinfraespecificocatvalido
							 WHERE h.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespeciecatvalido = p.Homonimos
where n.homonimosinfraespeciecatvalido='';


-- Asignamos homonimos mediante _TTN_COL

DROP TEMPORARY TABLE IF EXISTS snibdtap.si_ousp_homonimosTTN_COL;
	 
CREATE TEMPORARY TABLE snibdtap.si_ousp_homonimosTTN_COL
SELECT Taxonconsubgenero,Genero,Subgenero,Especie_epiteto,Nombreinfra,Nombresubinfra,Homonimos,UltimaCategoriaTaxonomica
FROM catalogocentralizado.TransformaTablaNombreCOL
WHERE Homonimos<>'';
	 
ALTER TABLE snibdtap.si_ousp_homonimosTTN_COL
ADD INDEX uno(Genero,Subgenero,Especie_epiteto),
ADD INDEX dos(Genero,Subgenero,Especie_epiteto,Nombreinfra),
ADD INDEX tres(UltimaCategoriaTaxonomica),
ADD INDEX cuatro(Taxonconsubgenero);
	 
UPDATE snibdtap.si_ousp_homonimosTTN_COL
SET UltimaCategoriaTaxonomica='infraespecie'
WHERE Nombreinfra<>'' and NombreSubinfra='';

-- FAMILIA
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Taxonconsubgenero = n.familiacat 
                             where t.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);
                             
                            
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamilia = p.Homonimos
WHERE n.homonimosfamilia='' AND n.comentarioscat like '%completamente con otra fuente%';

-- GENERO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Taxonconsubgenero = n.generocat
							 WHERE t.UltimaCategoriaTaxonomica = 'género'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenero = p.Homonimos
WHERE n.homonimosgenero='' AND n.comentarioscat like '%completamente con otra fuente%';

-- ESPECIE

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Genero = n.generocat and t.Subgenero=n.subgenerocat and t.Especie_epiteto=n.epitetoespecificocat
							 WHERE t.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespecie = p.Homonimos
WHERE n.homonimosespecie='' AND n.comentarioscat like '%completamente con otra fuente%';


-- INFRAESPECIE

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Genero = n.generocat and t.Subgenero=n.subgenerocat and t.Especie_epiteto=n.epitetoespecificocat and t.Nombreinfra=n.epitetoinfraespecificocat
							 WHERE t.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespecie = p.Homonimos
WHERE n.homonimosinfraespecie='' AND n.comentarioscat like '%completamente con otra fuente%';


-- FAMILIA VALIDO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.TaxonConSubgenero = n.familiacatvalido 
                             where t.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);
                             
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamiliacatvalido = p.Homonimos
WHERE n.homonimosfamiliacatvalido='' AND n.comentarioscat like '%completamente con otra fuente%';

-- GENERO VALIDO
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.TaxonConSubgenero = n.generocatvalido
							 WHERE t.UltimaCategoriaTaxonomica = 'género'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenerocatvalido = p.Homonimos
WHERE n.homonimosgenerocatvalido='' AND n.comentarioscat like '%completamente con otra fuente%';

-- ESPECIE VALIDO

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Genero = n.generocatvalido and t.Subgenero=n.subgenerocatvalido and t.Especie_epiteto=n.epitetoespecificocatvalido
							 WHERE t.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespeciecatvalido = p.Homonimos
WHERE n.homonimosespeciecatvalido='' AND n.comentarioscat like '%completamente con otra fuente%';


-- INFRAESPECIE VALIDO

DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Genero = n.generocatvalido and t.Subgenero=n.subgenerocatvalido and t.Especie_epiteto=n.epitetoespecificocatvalido and t.Nombreinfra=n.epitetoinfraespecificocatvalido
							 WHERE t.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespeciecatvalido = p.Homonimos
WHERE n.homonimosinfraespeciecatvalido='' AND n.comentarioscat like '%completamente con otra fuente%';

-- Agregado 09/04/2021 para asignar mediante los campos originales con la TTN
-- FAMILIAOriginal
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Taxonconsubgenero = n.familiaoriginal
                             where t.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);

ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamilia = p.Homonimos
WHERE n.homonimosfamilia='';

-- GENEROOriginal
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Taxonconsubgenero = n.generooriginal
							 WHERE t.UltimaCategoriaTaxonomica = 'género'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenero = p.Homonimos
WHERE n.homonimosgenero='';

-- ESPECIEOriginal
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Genero = n.generooriginal and t.Subgenero=n.subgenerooriginal and t.Especie_epiteto=n.epitetoespecificooriginal
							 WHERE t.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespecie = p.Homonimos
WHERE n.homonimosespecie='';


-- INFRAESPECIEOriginal
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN t  on t.Genero = n.generooriginal and t.Subgenero=n.subgenerooriginal and t.Especie_epiteto=n.epitetoespecificooriginal and t.Nombreinfra=n.epitetoinfraespecificooriginal
							 WHERE t.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespecie = p.Homonimos
WHERE n.homonimosinfraespecie='';

-- Agregado 09/04/2021 para asignar mediante campos originales vs HomonimosNoEnCAT
-- FAMILIA Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.TaxonConSubgenero = n.familiaoriginal
                             where h.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);

ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamilia = p.Homonimos
where n.homonimosfamilia='';

-- GENERO Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.TaxonConSubgenero = n.generooriginal 
                             where h.UltimaCategoriaTaxonomica = 'género'
                             GROUP BY n.llaveagrupado);
                             
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenero = p.Homonimos
where n.homonimosgenero='';

-- ESPECIE Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.Genero = n.generooriginal and h.Subgenero=n.subgenerooriginal and h.Especie_epiteto=n.epitetoespecificooriginal
							 WHERE h.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespecie = p.Homonimos
where n.homonimosespecie='';

-- INFRAESPECIE Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(h.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos 
							 FROM snibdtap.nombre1 n inner join catalogocentralizado.HomonimosNoEnCAT1 h  on h.Genero = n.generooriginal and h.Subgenero=n.subgenerooriginal and h.Especie_epiteto=n.epitetoespecificooriginal and h.Nombreinfra=n.epitetoinfraespecificooriginal
							 WHERE h.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespecie = p.Homonimos
where n.homonimosinfraespecie='';

-- Agregado 09/04/2021 para incluir taxonomia original vs TTN_COL

-- FAMILIA Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (
SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Taxonconsubgenero = n.familiaoriginal
                             where t.UltimaCategoriaTaxonomica = 'familia'
                             GROUP BY n.llaveagrupado);

ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosfamilia = p.Homonimos
WHERE n.homonimosfamilia='' AND n.comentarioscat like '%completamente con otra fuente%';

-- GENERO Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Taxonconsubgenero = n.generooriginal
							 WHERE t.UltimaCategoriaTaxonomica = 'género'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosgenero = p.Homonimos
WHERE n.homonimosgenero='' AND n.comentarioscat like '%completamente con otra fuente%';

-- ESPECIE Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Genero = n.generooriginal and t.Subgenero=n.subgenerooriginal and t.Especie_epiteto=n.epitetoespecificooriginal
							 WHERE t.UltimaCategoriaTaxonomica = 'especie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosespecie = p.Homonimos
WHERE n.homonimosespecie='' AND n.comentarioscat like '%completamente con otra fuente%';

-- INFRAESPECIE Original
DROP TEMPORARY TABLE IF EXISTS snibdtap.Paso;
CREATE TEMPORARY TABLE snibdtap.Paso (SELECT n.llaveagrupado, GROUP_CONCAT(distinct(t.Homonimos) ORDER BY Homonimos SEPARATOR '; ') AS Homonimos
							 FROM snibdtap.nombre1 n inner join snibdtap.si_ousp_homonimosTTN_COL t  on t.Genero = n.generooriginal and t.Subgenero=n.subgenerooriginal and t.Especie_epiteto=n.epitetoespecificooriginal and t.Nombreinfra=n.epitetoinfraespecificooriginal
							 WHERE t.UltimaCategoriaTaxonomica = 'infraespecie'
							 GROUP BY n.llaveagrupado);
ALTER TABLE snibdtap.Paso ADD INDEX (llaveagrupado);

UPDATE ValidacionesSCAT.cortevalidacion n inner join snibdtap.Paso p  on n.llaveagrupado = p.llaveagrupado
SET n.homonimosinfraespecie = p.Homonimos
WHERE n.homonimosinfraespecie='' AND n.comentarioscat like '%completamente con otra fuente%';

SELECT 'Termino';

END $$

DELIMITER ;