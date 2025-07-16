 1.	#Actualiza_Homonimos_TTN_COL (12 registros). Por medio del IdNombre, actualizar el campo Homonimos de la TransformaTablaNombreCOL del catalogocentralizado con el campo Homonimos_corregido de la tabla de entrega.

update snibdtap.`#Actualiza_Homonimos_TTN_COL` a inner join catalogocentralizado.TransformaTablaNombreCOL t on a.idnombre=t.idnombre
set t.Homonimos=a.Homonimos_corregido;

2.	#Actualiza_CompletamenteCAT (12 registros). Por medio de la llavenombre, el idnombrecat_corregido y idnombrecatvalido_corregido actualizar toda la información taxonómica de los campos cat y catvalidos (nombre del taxón, 
autor, estatus y catalogo o sistclascatdic) con la _TransformaTablaNombre desde Reino hasta infraespecie2, incluyendo los campos cattaxcat, catalogocat, fuentecat, gruposcat, cattaxcatvalido, catalogocatvalido, fuentecatvalido.
Actualizar también los campos comentarioscat y comentarioscatvalido de la vista nombre a partir de la información contenida en los campos comentarioscat_corregido, comentarioscatvalido_corregido de la tabla de entrega.

update snibdtap.`#Actualiza_CompletamenteCAT` a inner join snib.nombre_taxonomia n on a.llavenombre=n.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idCAT
set n.idnombre=t.IdNombre,
n.comentarioscat=a.comentarioscat_corregido,
n.comentarioscatvalido=a.comentarioscatvalido_corregido,
n.gruposcat=t.gruposcat,
idcol='',
idcolvalido='',
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

3.	#Actualiza_CompletamenteCOL (2 registros). Por medio de la llavenombre, el idnombrecat_corregido y idnombrecatvalido_corregido actualizar toda la información taxonómica de los campos cat y catvalidos (nombre del taxón, 
autor, estatus y catalogo o sistclascatdic) con la _TransformaTablaNombre desde Reino hasta la categoría del idnombrecat_corregido y idnombrecatvalido_corregido, incluyendo los campos cattaxcat, catalogocat, gruposcat, 
cattaxcatvalido, catalogocatvalido, actualizar también los campos comentarioscat y comentarioscatvalido de la vista nombre a partir de la información contenida en los campos comentarioscat_corregido, 
comentarioscatvalido_corregido de la tabla de entrega. A si mismo mediante los campos idcol, idcol_valido actualizar toda la información taxonómica de los campos cat y catvalidos (nombre del taxón, autor, estatus y catalogo o 
sistclascatdic) con la TransformaTablaNombreCOL por debajo de la categoría del vínculo  hasta infraespecie2, incluyendo los campos fuentecat, fuentecatvalido y gruposcat.

update `#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado.TransformaTablaNombreCOL t on a.idcol_corregido=t.idnombre
set n.reinocat= t.Reino,
n.sistemaclasificacionreinocat= t.SistClasCatDiccReino,
n.divisionphylumcat= t.Divisionphylum,
n.sistemaclasificaciondivisionphylumcat= t.SistClasCatDiccDivisionphylum,
n.clasecat= t.Clase,
n.sistemaclasificacionclasecat= t.SistClasCatDiccClase,
n.ordencat= t.Orden,
n.sistemaclasificacionordencat= t.SistClasCatDiccOrden,
n.subordencat= t.Suborden,
n.sistemaclasificacionsubordencat= t.SistClasCatDiccSuborden,
n.familiacat= t.Familia,
n.sistemaclasificacionfamiliacat= t.SistClasCatDiccFamilia,
n.estatusfamiliacat= t.EstatusFamilia,
n.subfamiliacat= t.Subfamilia,
n.sistemaclasificacionsubfamiliacat= t.SistClasCatDiccSubfamilia,
n.estatussubfamiliacat= t.EstatusSubfamilia,
n.tribucat= t.Tribu,
n.sistemaclasificaciontribucat= t.SistClasCatDiccTribu,
n.estatustribucat= t.EstatusTribu,
n.generocat= t.Genero,
n.sistemaclasificaciongenerocat= t.SistClasCatDiccGenero,
n.estatusgenerocat= t.EstatusGenero,
n.autoraniogenerocat= t.AutoridadGenero,
n.subgenerocat= t.Subgenero,
n.sistemaclasificacionsubgenerocat= t.SistClasCatDiccSubgenero,
n.autoraniosubgenerocat= t.AutoridadSubgenero,
n.estatussubgenerocat= t.EstatusSubgenero,
n.epitetoespecificocat= t.Especie_epiteto,
n.catdiccespeciecat= t.SistClasCatDiccEspecie_epiteto,
n.estatusespeciecat= t.EstatusEspecie_epiteto,
n.autoranioespeciecat= t.AutoridadEspecie_epiteto,
n.categoriainfraespeciecat= t.Categinfra,
n.epitetoinfraespecificocat= t.Nombreinfra,
n.catdiccinfraespeciecat= t.SistClasCatDiccNombreinfra,
n.estatusinfraespeciecat= t.EstatusCategInfra,
n.autoranioinfraespeciecat= t.AutoridadCategInfra,
n.categoriainfraespecie2cat= t.CategSubInfra,
n.epitetoinfraespecifico2cat= t.NombreSubInfra,
n.catdiccinfraespecie2cat= t.SistClasCatDiccNombreSubInfra,
n.estatusinfraespecie2cat= t.EstatusCategSubInfra,
n.autoranioinfraespecie2cat= t.AutoridadCategSubInfra,
n.idnombrecat= '',
n.cattaxcat= '',
n.catalogocat= '',
n.comentarioscat= a.comentarioscat_corregido,
n.fuentecat= t.fuente,
n.gruposcat= t.gruposcat,
n.idcol=a.idcol_corregido,
n.idcolvalido=idcol_valido_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

update `#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado.TransformaTablaNombreCOL tv on a.idcol_valido_corregido=tv.idnombre
set n.reinocatvalido= tv.Reino,
n.sistemaclasificacionreinocatvalido= tv.SistClasCatDiccReino,
n.divisionphylumcatvalido= tv.Divisionphylum,
n.sistemaclasificaciondivisionphylumcatvalido= tv.SistClasCatDiccDivisionphylum,
n.clasecatvalido= tv.Clase,
n.sistemaclasificacionclasecatvalido= tv.SistClasCatDiccClase,
n.ordencatvalido= tv.Orden,
n.sistemaclasificacionordencatvalido= tv.SistClasCatDiccOrden,
n.subordencatvalido= tv.Suborden,
n.sistemaclasificacionsubordencatvalido= tv.SistClasCatDiccSuborden,
n.familiacatvalido= tv.Familia,
n.sistemaclasificacionfamiliacatvalido= tv.SistClasCatDiccFamilia,
n.estatusfamiliacatvalido= tv.EstatusFamilia,
n.subfamiliacatvalido= tv.Subfamilia,
n.sistemaclasificacionsubfamiliacatvalido= tv.SistClasCatDiccSubfamilia,
n.estatussubfamiliacatvalido= tv.EstatusSubfamilia,
n.tribucatvalido= tv.Tribu,
n.sistemaclasificaciontribucatvalido= tv.SistClasCatDiccTribu,
n.estatustribucatvalido= tv.EstatusTribu,
n.generocatvalido= tv.Genero,
n.sistemaclasificaciongenerocatvalido= tv.SistClasCatDiccGenero,
n.estatusgenerocatvalido= tv.EstatusGenero,
n.autoraniogenerocatvalido= tv.AutoridadGenero,
n.subgenerocatvalido= tv.Subgenero,
n.sistemaclasificacionsubgenerocatvalido= tv.SistClasCatDiccSubgenero,
n.autoraniosubgenerocatvalido= tv.AutoridadSubgenero,
n.estatussubgenerocatvalido= tv.EstatusSubgenero,
n.epitetoespecificocatvalido= tv.Especie_epiteto,
n.catdiccespeciecatvalido= tv.SistClasCatDiccEspecie_epiteto,
n.estatusespeciecatvalido= tv.EstatusEspecie_epiteto,
n.autoranioespeciecatvalido= tv.AutoridadEspecie_epiteto,
n.categoriainfraespeciecatvalido= tv.Categinfra,
n.epitetoinfraespecificocatvalido= tv.Nombreinfra,
n.catdiccinfraespeciecatvalido= tv.SistClasCatDiccNombreinfra,
n.estatusinfraespeciecatvalido= tv.EstatusCategInfra,
n.autoranioinfraespeciecatvalido= tv.AutoridadCategInfra,
n.categoriainfraespecie2catvalido= tv.CategSubInfra,
n.epitetoinfraespecifico2catvalido= tv.NombreSubInfra,
n.catdiccinfraespecie2catvalido= tv.SistClasCatDiccNombreSubInfra,
n.estatusinfraespecie2catvalido= tv.EstatusCategSubInfra,
n.autoranioinfraespecie2catvalido= tv.AutoridadCategSubInfra,
n.idnombrecatvalido= '',
n.cattaxcatvalido= '',
n.catalogocatvalido= '',
n.comentarioscatvalido= ifnull(a.comentarioscatvalido_corregido,''),
n.fuentecatvalido= tv.fuente,
n.gruposcat= tv.gruposcat,
n.ultimafechaactualizacion= date_format(now(),'%Y-%m-%d');



-- Ahora llenamos de Reino hasta el vinculo a partir de la TTNombre
update `#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido =t.IdCAT
set
n.reinocat=if(t.Reino='',n.reinocat,t.Reino),
n.sistemaclasificacionreinocat=if(t.SistClasCatDiccReino='',n.sistemaclasificacionreinocat,t.SistClasCatDiccReino),
n.divisionphylumcat=if(t.Divisionphylum='',n.divisionphylumcat,t.Divisionphylum),
n.sistemaclasificaciondivisionphylumcat=if(t.SistClasCatDiccDivisionphylum='',n.sistemaclasificaciondivisionphylumcat,t.SistClasCatDiccDivisionphylum),
n.clasecat=if(t.Clase='',n.clasecat,t.Clase),
n.sistemaclasificacionclasecat=if(t.SistClasCatDiccClase='',n.sistemaclasificacionclasecat,t.SistClasCatDiccClase),
n.ordencat=if(t.Orden='',n.ordencat,t.Orden),
n.sistemaclasificacionordencat=if(t.SistClasCatDiccOrden='',n.sistemaclasificacionordencat,t.SistClasCatDiccOrden),
n.subordencat=if(t.Suborden='',n.subordencat,t.Suborden),
n.sistemaclasificacionsubordencat=if(t.SistClasCatDiccSuborden='',n.sistemaclasificacionsubordencat,t.SistClasCatDiccSuborden),
n.familiacat=if(t.Familia='',n.familiacat,t.Familia),
n.sistemaclasificacionfamiliacat=if(t.SistClasCatDiccFamilia='',n.sistemaclasificacionfamiliacat,t.SistClasCatDiccFamilia),
n.estatusfamiliacat=if(t.EstatusFamilia='',n.estatusfamiliacat,t.EstatusFamilia),
n.subfamiliacat=if(t.Subfamilia='',n.subfamiliacat,t.Subfamilia),
n.sistemaclasificacionsubfamiliacat=if(t.SistClasCatDiccSubfamilia='',n.sistemaclasificacionsubfamiliacat,t.SistClasCatDiccSubfamilia),
n.estatussubfamiliacat=if(t.EstatusSubfamilia='',n.estatussubfamiliacat,t.EstatusSubfamilia),
n.tribucat=if(t.Tribu='',n.tribucat,t.Tribu),
n.sistemaclasificaciontribucat=if(t.SistClasCatDiccTribu='',n.sistemaclasificaciontribucat,t.SistClasCatDiccTribu),
n.estatustribucat=if(t.EstatusTribu='',n.estatustribucat,t.EstatusTribu),
n.generocat=if(t.Genero='',n.generocat,t.Genero),
n.sistemaclasificaciongenerocat=if(t.SistClasCatDiccGenero='',n.sistemaclasificaciongenerocat,t.SistClasCatDiccGenero),
n.estatusgenerocat=if(t.EstatusGenero='',n.estatusgenerocat,t.EstatusGenero),
n.autoraniogenerocat=if(t.AutoridadGenero='',n.autoraniogenerocat,t.AutoridadGenero),
n.subgenerocat=if(t.Subgenero='',n.subgenerocat,t.Subgenero),
n.sistemaclasificacionsubgenerocat=if(t.SistClasCatDiccSubgenero='',n.sistemaclasificacionsubgenerocat,t.SistClasCatDiccSubgenero),
n.autoraniosubgenerocat=if(t.AutoridadSubgenero='',n.autoraniosubgenerocat,t.AutoridadSubgenero),
n.estatussubgenerocat=if(t.EstatusSubgenero='',n.estatussubgenerocat,t.EstatusSubgenero),
n.epitetoespecificocat=if(t.Especie_epiteto='',n.epitetoespecificocat,t.Especie_epiteto),
n.catdiccespeciecat=if(t.SistClasCatDiccEspecie_epiteto='',n.catdiccespeciecat,t.SistClasCatDiccEspecie_epiteto),
n.estatusespeciecat=if(t.EstatusEspecie_epiteto='',n.estatusespeciecat,t.EstatusEspecie_epiteto),
n.autoranioespeciecat=if(t.AutoridadEspecie_epiteto='',n.autoranioespeciecat,t.AutoridadEspecie_epiteto),
n.categoriainfraespeciecat=if(t.Categinfra='',n.categoriainfraespeciecat,t.Categinfra),
n.epitetoinfraespecificocat=if(t.Nombreinfra='',n.epitetoinfraespecificocat,t.Nombreinfra),
n.catdiccinfraespeciecat=if(t.SistClasCatDiccNombreinfra='',n.catdiccinfraespeciecat,t.SistClasCatDiccNombreinfra),
n.estatusinfraespeciecat=if(t.EstatusCategInfra='',n.estatusinfraespeciecat,t.EstatusCategInfra),
n.autoranioinfraespeciecat=if(t.AutoridadCategInfra='',n.autoranioinfraespeciecat,t.AutoridadCategInfra),
n.categoriainfraespecie2cat=if(t.CategSubInfra='',n.categoriainfraespecie2cat,t.CategSubInfra),
n.epitetoinfraespecifico2cat=if(t.NombreSubInfra='',n.epitetoinfraespecifico2cat,t.NombreSubInfra),
n.catdiccinfraespecie2cat=if(t.SistClasCatDiccNombreSubInfra='',n.catdiccinfraespecie2cat,t.SistClasCatDiccNombreSubInfra),
n.estatusinfraespecie2cat=if(t.EstatusCategSubInfra='',n.estatusinfraespecie2cat,t.EstatusCategSubInfra),
n.autoranioinfraespecie2cat=if(t.AutoridadCategSubInfra='',n.autoranioinfraespecie2cat,t.AutoridadCategSubInfra),
n.idnombrecat=t.IdCAT,
n.cattaxcat=t.UltimaCategoriaTaxonomica,
n.catalogocat=t.Fuente;

update `#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado._TransformaTablaNombre tv on a.idnombrecatvalido_corregido=tv.IdCAT
set n.reinocatvalido=if(tv.Reino='',n.reinocatvalido,tv.Reino),
n.sistemaclasificacionreinocatvalido=if(tv.SistClasCatDiccReino='',n.sistemaclasificacionreinocatvalido,tv.SistClasCatDiccReino),
n.divisionphylumcatvalido=if(tv.Divisionphylum='',n.divisionphylumcatvalido,tv.Divisionphylum),
n.sistemaclasificaciondivisionphylumcatvalido=if(tv.SistClasCatDiccDivisionphylum='',n.sistemaclasificaciondivisionphylumcatvalido,tv.SistClasCatDiccDivisionphylum),
n.clasecatvalido=if(tv.Clase='',n.clasecatvalido,tv.Clase),
n.sistemaclasificacionclasecatvalido=if(tv.SistClasCatDiccClase='',n.sistemaclasificacionclasecatvalido,tv.SistClasCatDiccClase),
n.ordencatvalido=if(tv.Orden='',n.ordencatvalido,tv.Orden),
n.sistemaclasificacionordencatvalido=if(tv.SistClasCatDiccOrden='',n.sistemaclasificacionordencatvalido,tv.SistClasCatDiccOrden),
n.subordencatvalido=if(tv.Suborden='',n.subordencatvalido,tv.Suborden),
n.sistemaclasificacionsubordencatvalido=if(tv.SistClasCatDiccSuborden='',n.sistemaclasificacionsubordencatvalido,tv.SistClasCatDiccSuborden),
n.familiacatvalido=if(tv.Familia='',n.familiacatvalido,tv.Familia),
n.sistemaclasificacionfamiliacatvalido=if(tv.SistClasCatDiccFamilia='',n.sistemaclasificacionfamiliacatvalido,tv.SistClasCatDiccFamilia),
n.estatusfamiliacatvalido=if(tv.EstatusFamilia='',n.estatusfamiliacatvalido,tv.EstatusFamilia),
n.subfamiliacatvalido=if(tv.Subfamilia='',n.subfamiliacatvalido,tv.Subfamilia),
n.sistemaclasificacionsubfamiliacatvalido=if(tv.SistClasCatDiccSubfamilia='',n.sistemaclasificacionsubfamiliacatvalido,tv.SistClasCatDiccSubfamilia),
n.estatussubfamiliacatvalido=if(tv.EstatusSubfamilia='',n.estatussubfamiliacatvalido,tv.EstatusSubfamilia),
n.tribucatvalido=if(tv.Tribu='',n.tribucatvalido,tv.Tribu),
n.sistemaclasificaciontribucatvalido=if(tv.SistClasCatDiccTribu='',n.sistemaclasificaciontribucatvalido,tv.SistClasCatDiccTribu),
n.estatustribucatvalido=if(tv.EstatusTribu='',n.estatustribucatvalido,tv.EstatusTribu),
n.generocatvalido=if(tv.Genero='',n.generocatvalido,tv.Genero),
n.sistemaclasificaciongenerocatvalido=if(tv.SistClasCatDiccGenero='',n.sistemaclasificaciongenerocatvalido,tv.SistClasCatDiccGenero),
n.estatusgenerocatvalido=if(tv.EstatusGenero='',n.estatusgenerocatvalido,tv.EstatusGenero),
n.autoraniogenerocatvalido=if(tv.AutoridadGenero='',n.autoraniogenerocatvalido,tv.AutoridadGenero),
n.subgenerocatvalido=if(tv.Subgenero='',n.subgenerocatvalido,tv.Subgenero),
n.sistemaclasificacionsubgenerocatvalido=if(tv.SistClasCatDiccSubgenero='',n.sistemaclasificacionsubgenerocatvalido,tv.SistClasCatDiccSubgenero),
n.autoraniosubgenerocatvalido=if(tv.AutoridadSubgenero='',n.autoraniosubgenerocatvalido,tv.AutoridadSubgenero),
n.estatussubgenerocatvalido=if(tv.EstatusSubgenero='',n.estatussubgenerocatvalido,tv.EstatusSubgenero),
n.epitetoespecificocatvalido=if(tv.Especie_epiteto='',n.epitetoespecificocatvalido,tv.Especie_epiteto),
n.catdiccespeciecatvalido=if(tv.SistClasCatDiccEspecie_epiteto='',n.catdiccespeciecatvalido,tv.SistClasCatDiccEspecie_epiteto),
n.estatusespeciecatvalido=if(tv.EstatusEspecie_epiteto='',n.estatusespeciecatvalido,tv.EstatusEspecie_epiteto),
n.autoranioespeciecatvalido=if(tv.AutoridadEspecie_epiteto='',n.autoranioespeciecatvalido,tv.AutoridadEspecie_epiteto),
n.categoriainfraespeciecatvalido=if(tv.Categinfra='',n.categoriainfraespeciecatvalido,tv.Categinfra),
n.epitetoinfraespecificocatvalido=if(tv.Nombreinfra='',n.epitetoinfraespecificocatvalido,tv.Nombreinfra),
n.catdiccinfraespeciecatvalido=if(tv.SistClasCatDiccNombreinfra='',n.catdiccinfraespeciecatvalido,tv.SistClasCatDiccNombreinfra),
n.estatusinfraespeciecatvalido=if(tv.EstatusCategInfra='',n.estatusinfraespeciecatvalido,tv.EstatusCategInfra),
n.autoranioinfraespeciecatvalido=if(tv.AutoridadCategInfra='',n.autoranioinfraespeciecatvalido,tv.AutoridadCategInfra),
n.categoriainfraespecie2catvalido=if(tv.CategSubInfra='',n.categoriainfraespecie2catvalido,tv.CategSubInfra),
n.epitetoinfraespecifico2catvalido=if(tv.NombreSubInfra='',n.epitetoinfraespecifico2catvalido,tv.NombreSubInfra),
n.catdiccinfraespecie2catvalido=if(tv.SistClasCatDiccNombreSubInfra='',n.catdiccinfraespecie2catvalido,tv.SistClasCatDiccNombreSubInfra),
n.estatusinfraespecie2catvalido=if(tv.EstatusCategSubInfra='',n.estatusinfraespecie2catvalido,tv.EstatusCategSubInfra),
n.autoranioinfraespecie2catvalido=if(tv.AutoridadCategSubInfra='',n.autoranioinfraespecie2catvalido,tv.AutoridadCategSubInfra),
n.idnombrecatvalido=tv.IdCAT,
n.cattaxcatvalido=tv.UltimaCategoriaTaxonomica,
n.catalogocatvalido=tv.Fuente;

-- Ver lo de las categorias intermedias.
-- Con lo siguiente se corrige lo de las ctaegorías intermedias, revisar que no pase lo mismo en vinculo para los cat.
-- Tener cuidado con las categorías intermedias, cuando ultimacategoria esta por debajo de subfamilia, suborden o tribu se deja lo que traiga la TTN
select t.ultimacategoriataxonomica,count(1)
from snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat group by 1;

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat
set c.subordencatvalido=t.Suborden,
c.sistemaclasificacionsubordencatvalido=t.SistClasCatDiccSuborden,
c.subfamiliacatvalido=t.Subfamilia,
c.sistemaclasificacionsubfamiliacatvalido=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacatvalido=t.EstatusSubfamilia,
c.tribucatvalido=t.Tribu,
c.sistemaclasificaciontribucatvalido=t.SistClasCatDiccTribu,
c.estatustribucatvalido=t.EstatusTribu
where t.ultimacategoriataxonomica in('género','tribu','subfamilia','subgénero');

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat
set c.subordencatvalido=t.Suborden,
c.sistemaclasificacionsubordencatvalido=t.SistClasCatDiccSuborden,
c.subfamiliacatvalido=t.Subfamilia,
c.sistemaclasificacionsubfamiliacatvalido=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacatvalido=t.EstatusSubfamilia,
c.tribucatvalido=t.Tribu,
c.sistemaclasificaciontribucatvalido=t.SistClasCatDiccTribu,
c.estatustribucatvalido=t.EstatusTribu,
c.subgenerocatvalido=t.subgenero,
c.sistemaclasificacionsubgenerocatvalido=t.SistClasCatDiccSubgenero,
c.estatussubgenerocatvalido=t.EstatusSubgenero,
c.autoraniosubgenerocatvalido=t.autoridadsubgenero
where t.ultimacategoriataxonomica in ('especie','forma','variedad','subespecie');

select a.* from snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat
where t.ultimacategoriataxonomica in ('forma','variedad','subespecie');

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat
set c.subordencatvalido=t.Suborden,
c.sistemaclasificacionsubordencatvalido=t.SistClasCatDiccSuborden
where t.ultimacategoriataxonomica in ('familia');


select t.ultimacategoriataxonomica,count(1)
from snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat group by 1;

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat
set c.subordencat=t.Suborden,
c.sistemaclasificacionsubordencat=t.SistClasCatDiccSuborden
where t.ultimacategoriataxonomica in ('familia');

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat
set c.subordencat=t.Suborden,
c.sistemaclasificacionsubordencat=t.SistClasCatDiccSuborden,
c.subfamiliacat=t.Subfamilia,
c.sistemaclasificacionsubfamiliacat=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacat=t.EstatusSubfamilia,
c.tribucat=t.Tribu,
c.sistemaclasificaciontribucat=t.SistClasCatDiccTribu,
c.estatustribucat=t.EstatusTribu
where t.ultimacategoriataxonomica in ('género','tribu','subfamilia','subgénero');

update snibdtap.`#Actualiza_CompletamenteCOL` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat
set c.subordencat=t.Suborden,
c.sistemaclasificacionsubordencat=t.SistClasCatDiccSuborden,
c.subfamiliacat=t.Subfamilia,
c.sistemaclasificacionsubfamiliacat=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacat=t.EstatusSubfamilia,
c.tribucat=t.Tribu,
c.sistemaclasificaciontribucat=t.SistClasCatDiccTribu,
c.estatustribucat=t.EstatusTribu,
c.subgenerocat=t.subgenero,
c.sistemaclasificacionsubgenerocat=t.SistClasCatDiccSubgenero,
c.estatussubgenerocat=t.EstatusSubgenero,
c.autoraniosubgenerocat=t.autoridadsubgenero
where t.ultimacategoriataxonomica in ('especie');


4.	#Actualiza_CompletamenteCATVAL (20 registros). Por medio de la llavenombre, el idnombrecatvalido_corregido actualizar toda la información taxonómica de los campos catvalidos (nombre del taxón, autor, estatus y catalogo o 
sistclascatdic) con la _TransformaTablaNombre desde Reino hasta infraespecie2, incluyendo los campos gruposcat, cattaxcatvalido, catalogocatvalido, fuentecatvalido. Actualizar también el campo comentarioscatvalido de la 
vista nombre a partir de la información contenida en el campo comentarioscatvalido_corregido de la tabla de entrega.


update `#Actualiza_CompletamenteCATVAL` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado._TransformaTablaNombre tv on a.idnombrecatvalido_corregido=tv.IdCAT
set
n.reinocatvalido= tv.Reino,
n.sistemaclasificacionreinocatvalido= tv.SistClasCatDiccReino,
n.divisionphylumcatvalido= tv.Divisionphylum,
n.sistemaclasificaciondivisionphylumcatvalido= tv.SistClasCatDiccDivisionphylum,
n.clasecatvalido= tv.Clase,
n.sistemaclasificacionclasecatvalido= tv.SistClasCatDiccClase,
n.ordencatvalido= tv.Orden,
n.sistemaclasificacionordencatvalido= tv.SistClasCatDiccOrden,
n.subordencatvalido= tv.Suborden,
n.sistemaclasificacionsubordencatvalido= tv.SistClasCatDiccSuborden,
n.familiacatvalido= tv.Familia,
n.sistemaclasificacionfamiliacatvalido= tv.SistClasCatDiccFamilia,
n.estatusfamiliacatvalido= tv.EstatusFamilia,
n.subfamiliacatvalido= tv.Subfamilia,
n.sistemaclasificacionsubfamiliacatvalido= tv.SistClasCatDiccSubfamilia,
n.estatussubfamiliacatvalido= tv.EstatusSubfamilia,
n.tribucatvalido= tv.Tribu,
n.sistemaclasificaciontribucatvalido= tv.SistClasCatDiccTribu,
n.estatustribucatvalido= tv.EstatusTribu,
n.generocatvalido= tv.Genero,
n.sistemaclasificaciongenerocatvalido= tv.SistClasCatDiccGenero,
n.estatusgenerocatvalido= tv.EstatusGenero,
n.autoraniogenerocatvalido= tv.AutoridadGenero,
n.subgenerocatvalido= tv.Subgenero,
n.sistemaclasificacionsubgenerocatvalido= tv.SistClasCatDiccSubgenero,
n.autoraniosubgenerocatvalido= tv.AutoridadSubgenero,
n.estatussubgenerocatvalido= tv.EstatusSubgenero,
n.epitetoespecificocatvalido= tv.Especie_epiteto,
n.catdiccespeciecatvalido= tv.SistClasCatDiccEspecie_epiteto,
n.estatusespeciecatvalido= tv.EstatusEspecie_epiteto,
n.autoranioespeciecatvalido= tv.AutoridadEspecie_epiteto,
n.categoriainfraespeciecatvalido= tv.Categinfra,
n.epitetoinfraespecificocatvalido= tv.Nombreinfra,
n.catdiccinfraespeciecatvalido= tv.SistClasCatDiccNombreinfra,
n.estatusinfraespeciecatvalido= tv.EstatusCategInfra,
n.autoranioinfraespeciecatvalido= tv.AutoridadCategInfra,
n.categoriainfraespecie2catvalido= tv.CategSubInfra,
n.epitetoinfraespecifico2catvalido= tv.NombreSubInfra,
n.catdiccinfraespecie2catvalido= tv.SistClasCatDiccNombreSubInfra,
n.estatusinfraespecie2catvalido= tv.EstatusCategSubInfra,
n.autoranioinfraespecie2catvalido= tv.AutoridadCategSubInfra,
n.idnombrecatvalido= tv.IdCAT,
n.cattaxcatvalido= tv.UltimaCategoriaTaxonomica,
n.catalogocatvalido= tv.Fuente,
n.comentarioscatvalido= a.comentarioscatvalido_corregido,
n.nombrevalidocatscat=tv.Taxonconsubgenero,
n.fuentecatvalido= tv.Fuente,
n.gruposcat= tv.gruposcat,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

5.	#Actualiza_idnombrecat&comentarioscat (73 registros). Por medio de la llavenombre y el idnombrecat_corregido actualizar toda la información taxonómica de los campos cat (nombre del taxón, autor, estatus y catalogo o 
sistclascatdic) con la _TransformaTablaNombre desde la categoría del vínculo (idnombrecat_corregido) hasta Reino, incluyendo los campos cattaxcat y catalogocat. Actualizar también el campo comentarioscat de la vista nombre a 
partir de la información contenida en el campo comentarioscat_corregido de la tabla de entrega.

update snibdtap.`#Actualiza_idnombrecat&comentarioscat` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido =t.IdCAT
set
n.reinocat=if(t.Reino='',n.reinocat,t.Reino),
n.sistemaclasificacionreinocat=if(t.SistClasCatDiccReino='',n.sistemaclasificacionreinocat,t.SistClasCatDiccReino),
n.divisionphylumcat=if(t.Divisionphylum='',n.divisionphylumcat,t.Divisionphylum),
n.sistemaclasificaciondivisionphylumcat=if(t.SistClasCatDiccDivisionphylum='',n.sistemaclasificaciondivisionphylumcat,t.SistClasCatDiccDivisionphylum),
n.clasecat=if(t.Clase='',n.clasecat,t.Clase),
n.sistemaclasificacionclasecat=if(t.SistClasCatDiccClase='',n.sistemaclasificacionclasecat,t.SistClasCatDiccClase),
n.ordencat=if(t.Orden='',n.ordencat,t.Orden),
n.sistemaclasificacionordencat=if(t.SistClasCatDiccOrden='',n.sistemaclasificacionordencat,t.SistClasCatDiccOrden),
n.subordencat=if(t.Suborden='',n.subordencat,t.Suborden),
n.sistemaclasificacionsubordencat=if(t.SistClasCatDiccSuborden='',n.sistemaclasificacionsubordencat,t.SistClasCatDiccSuborden),
n.familiacat=if(t.Familia='',n.familiacat,t.Familia),
n.sistemaclasificacionfamiliacat=if(t.SistClasCatDiccFamilia='',n.sistemaclasificacionfamiliacat,t.SistClasCatDiccFamilia),
n.estatusfamiliacat=if(t.EstatusFamilia='',n.estatusfamiliacat,t.EstatusFamilia),
n.subfamiliacat=if(t.Subfamilia='',n.subfamiliacat,t.Subfamilia),
n.sistemaclasificacionsubfamiliacat=if(t.SistClasCatDiccSubfamilia='',n.sistemaclasificacionsubfamiliacat,t.SistClasCatDiccSubfamilia),
n.estatussubfamiliacat=if(t.EstatusSubfamilia='',n.estatussubfamiliacat,t.EstatusSubfamilia),
n.tribucat=if(t.Tribu='',n.tribucat,t.Tribu),
n.sistemaclasificaciontribucat=if(t.SistClasCatDiccTribu='',n.sistemaclasificaciontribucat,t.SistClasCatDiccTribu),
n.estatustribucat=if(t.EstatusTribu='',n.estatustribucat,t.EstatusTribu),
n.generocat=if(t.Genero='',n.generocat,t.Genero),
n.sistemaclasificaciongenerocat=if(t.SistClasCatDiccGenero='',n.sistemaclasificaciongenerocat,t.SistClasCatDiccGenero),
n.estatusgenerocat=if(t.EstatusGenero='',n.estatusgenerocat,t.EstatusGenero),
n.autoraniogenerocat=if(t.AutoridadGenero='',n.autoraniogenerocat,t.AutoridadGenero),
n.subgenerocat=if(t.Subgenero='',n.subgenerocat,t.Subgenero),
n.sistemaclasificacionsubgenerocat=if(t.SistClasCatDiccSubgenero='',n.sistemaclasificacionsubgenerocat,t.SistClasCatDiccSubgenero),
n.autoraniosubgenerocat=if(t.AutoridadSubgenero='',n.autoraniosubgenerocat,t.AutoridadSubgenero),
n.estatussubgenerocat=if(t.EstatusSubgenero='',n.estatussubgenerocat,t.EstatusSubgenero),
n.epitetoespecificocat=if(t.Especie_epiteto='',n.epitetoespecificocat,t.Especie_epiteto),
n.catdiccespeciecat=if(t.SistClasCatDiccEspecie_epiteto='',n.catdiccespeciecat,t.SistClasCatDiccEspecie_epiteto),
n.estatusespeciecat=if(t.EstatusEspecie_epiteto='',n.estatusespeciecat,t.EstatusEspecie_epiteto),
n.autoranioespeciecat=if(t.AutoridadEspecie_epiteto='',n.autoranioespeciecat,t.AutoridadEspecie_epiteto),
n.categoriainfraespeciecat=if(t.Categinfra='',n.categoriainfraespeciecat,t.Categinfra),
n.epitetoinfraespecificocat=if(t.Nombreinfra='',n.epitetoinfraespecificocat,t.Nombreinfra),
n.catdiccinfraespeciecat=if(t.SistClasCatDiccNombreinfra='',n.catdiccinfraespeciecat,t.SistClasCatDiccNombreinfra),
n.estatusinfraespeciecat=if(t.EstatusCategInfra='',n.estatusinfraespeciecat,t.EstatusCategInfra),
n.autoranioinfraespeciecat=if(t.AutoridadCategInfra='',n.autoranioinfraespeciecat,t.AutoridadCategInfra),
n.categoriainfraespecie2cat=if(t.CategSubInfra='',n.categoriainfraespecie2cat,t.CategSubInfra),
n.epitetoinfraespecifico2cat=if(t.NombreSubInfra='',n.epitetoinfraespecifico2cat,t.NombreSubInfra),
n.catdiccinfraespecie2cat=if(t.SistClasCatDiccNombreSubInfra='',n.catdiccinfraespecie2cat,t.SistClasCatDiccNombreSubInfra),
n.estatusinfraespecie2cat=if(t.EstatusCategSubInfra='',n.estatusinfraespecie2cat,t.EstatusCategSubInfra),
n.autoranioinfraespecie2cat=if(t.AutoridadCategSubInfra='',n.autoranioinfraespecie2cat,t.AutoridadCategSubInfra),
n.idnombrecat=t.IdCAT,
n.cattaxcat=t.UltimaCategoriaTaxonomica,
n.catalogocat=t.Fuente,
n.gruposcat=t.gruposcat,
n.comentarioscat=a.comentarioscat_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

-- Ver lo de las categorias intermedias.

select t.ultimacategoriataxonomica,count(1)
from snibdtap.`#Actualiza_idnombrecat&comentarioscat` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat group by 1;

update snibdtap.`#Actualiza_idnombrecat&comentarioscat` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat
set c.subordencat=t.Suborden,
c.sistemaclasificacionsubordencat=t.SistClasCatDiccSuborden,
c.subfamiliacat=t.Subfamilia,
c.sistemaclasificacionsubfamiliacat=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacat=t.EstatusSubfamilia,
c.tribucat=t.Tribu,
c.sistemaclasificaciontribucat=t.SistClasCatDiccTribu,
c.estatustribucat=t.EstatusTribu
where t.ultimacategoriataxonomica in('género','tribu','subfamilia','subgénero');

update snibdtap.`#Actualiza_idnombrecat&comentarioscat` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat
set c.subordencat=t.Suborden,
c.sistemaclasificacionsubordencat=t.SistClasCatDiccSuborden,
c.subfamiliacat=t.Subfamilia,
c.sistemaclasificacionsubfamiliacat=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacat=t.EstatusSubfamilia,
c.tribucat=t.Tribu,
c.sistemaclasificaciontribucat=t.SistClasCatDiccTribu,
c.estatustribucat=t.EstatusTribu,
c.subgenerocat=t.subgenero,
c.sistemaclasificacionsubgenerocat=t.SistClasCatDiccSubgenero,
c.estatussubgenerocat=t.EstatusSubgenero,
c.autoraniosubgenerocat=t.autoridadsubgenero
where t.ultimacategoriataxonomica in ('especie');

update snibdtap.`#Actualiza_idnombrecat&comentarioscat` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.idcat
set c.subordencat=t.Suborden,
c.sistemaclasificacionsubordencat=t.SistClasCatDiccSuborden
where t.ultimacategoriataxonomica in ('familia');


6.	#Actualiza_ idnombrecatvalido&comentarioscatvalido (4 registros). Por medio de la llavenombre y el idnombrecatvalido_corregido actualizar toda la información taxonómica de los campos catvalidos (nombre del taxón, autor, 
estatus y catalogo o sistclascatdic) con la _TransformaTablaNombre desde la categoría del vínculo válido (idnombrecatvalido_corregido) hasta Reino, incluyendo los campos cattaxcatvalido y catalogocatvalido. Actualizar también
 el campo comentarioscatvalido de la vista nombre a partir de la información contenida en los campos comentarioscatvalido_corregido de la tabla de entrega.
 
update `#Actualiza_idnombrecatvalido&comentarioscatvalido` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado._TransformaTablaNombre tv on a.idnombrecatvalido_corregido =tv.IdCAT
set n.reinocatvalido=if(tv.Reino='',n.reinocatvalido,tv.Reino),
n.sistemaclasificacionreinocatvalido=if(tv.SistClasCatDiccReino='',n.sistemaclasificacionreinocatvalido,tv.SistClasCatDiccReino),
n.divisionphylumcatvalido=if(tv.Divisionphylum='',n.divisionphylumcatvalido,tv.Divisionphylum),
n.sistemaclasificaciondivisionphylumcatvalido=if(tv.SistClasCatDiccDivisionphylum='',n.sistemaclasificaciondivisionphylumcatvalido,tv.SistClasCatDiccDivisionphylum),
n.clasecatvalido=if(tv.Clase='',n.clasecatvalido,tv.Clase),
n.sistemaclasificacionclasecatvalido=if(tv.SistClasCatDiccClase='',n.sistemaclasificacionclasecatvalido,tv.SistClasCatDiccClase),
n.ordencatvalido=if(tv.Orden='',n.ordencatvalido,tv.Orden),
n.sistemaclasificacionordencatvalido=if(tv.SistClasCatDiccOrden='',n.sistemaclasificacionordencatvalido,tv.SistClasCatDiccOrden),
n.subordencatvalido=if(tv.Suborden='',n.subordencatvalido,tv.Suborden),
n.sistemaclasificacionsubordencatvalido=if(tv.SistClasCatDiccSuborden='',n.sistemaclasificacionsubordencatvalido,tv.SistClasCatDiccSuborden),
n.familiacatvalido=if(tv.Familia='',n.familiacatvalido,tv.Familia),
n.sistemaclasificacionfamiliacatvalido=if(tv.SistClasCatDiccFamilia='',n.sistemaclasificacionfamiliacatvalido,tv.SistClasCatDiccFamilia),
n.estatusfamiliacatvalido=if(tv.EstatusFamilia='',n.estatusfamiliacatvalido,tv.EstatusFamilia),
n.subfamiliacatvalido=if(tv.Subfamilia='',n.subfamiliacatvalido,tv.Subfamilia),
n.sistemaclasificacionsubfamiliacatvalido=if(tv.SistClasCatDiccSubfamilia='',n.sistemaclasificacionsubfamiliacatvalido,tv.SistClasCatDiccSubfamilia),
n.estatussubfamiliacatvalido=if(tv.EstatusSubfamilia='',n.estatussubfamiliacatvalido,tv.EstatusSubfamilia),
n.tribucatvalido=if(tv.Tribu='',n.tribucatvalido,tv.Tribu),
n.sistemaclasificaciontribucatvalido=if(tv.SistClasCatDiccTribu='',n.sistemaclasificaciontribucatvalido,tv.SistClasCatDiccTribu),
n.estatustribucatvalido=if(tv.EstatusTribu='',n.estatustribucatvalido,tv.EstatusTribu),
n.generocatvalido=if(tv.Genero='',n.generocatvalido,tv.Genero),
n.sistemaclasificaciongenerocatvalido=if(tv.SistClasCatDiccGenero='',n.sistemaclasificaciongenerocatvalido,tv.SistClasCatDiccGenero),
n.estatusgenerocatvalido=if(tv.EstatusGenero='',n.estatusgenerocatvalido,tv.EstatusGenero),
n.autoraniogenerocatvalido=if(tv.AutoridadGenero='',n.autoraniogenerocatvalido,tv.AutoridadGenero),
n.subgenerocatvalido=if(tv.Subgenero='',n.subgenerocatvalido,tv.Subgenero),
n.sistemaclasificacionsubgenerocatvalido=if(tv.SistClasCatDiccSubgenero='',n.sistemaclasificacionsubgenerocatvalido,tv.SistClasCatDiccSubgenero),
n.autoraniosubgenerocatvalido=if(tv.AutoridadSubgenero='',n.autoraniosubgenerocatvalido,tv.AutoridadSubgenero),
n.estatussubgenerocatvalido=if(tv.EstatusSubgenero='',n.estatussubgenerocatvalido,tv.EstatusSubgenero),
n.epitetoespecificocatvalido=if(tv.Especie_epiteto='',n.epitetoespecificocatvalido,tv.Especie_epiteto),
n.catdiccespeciecatvalido=if(tv.SistClasCatDiccEspecie_epiteto='',n.catdiccespeciecatvalido,tv.SistClasCatDiccEspecie_epiteto),
n.estatusespeciecatvalido=if(tv.EstatusEspecie_epiteto='',n.estatusespeciecatvalido,tv.EstatusEspecie_epiteto),
n.autoranioespeciecatvalido=if(tv.AutoridadEspecie_epiteto='',n.autoranioespeciecatvalido,tv.AutoridadEspecie_epiteto),
n.categoriainfraespeciecatvalido=if(tv.Categinfra='',n.categoriainfraespeciecatvalido,tv.Categinfra),
n.epitetoinfraespecificocatvalido=if(tv.Nombreinfra='',n.epitetoinfraespecificocatvalido,tv.Nombreinfra),
n.catdiccinfraespeciecatvalido=if(tv.SistClasCatDiccNombreinfra='',n.catdiccinfraespeciecatvalido,tv.SistClasCatDiccNombreinfra),
n.estatusinfraespeciecatvalido=if(tv.EstatusCategInfra='',n.estatusinfraespeciecatvalido,tv.EstatusCategInfra),
n.autoranioinfraespeciecatvalido=if(tv.AutoridadCategInfra='',n.autoranioinfraespeciecatvalido,tv.AutoridadCategInfra),
n.categoriainfraespecie2catvalido=if(tv.CategSubInfra='',n.categoriainfraespecie2catvalido,tv.CategSubInfra),
n.epitetoinfraespecifico2catvalido=if(tv.NombreSubInfra='',n.epitetoinfraespecifico2catvalido,tv.NombreSubInfra),
n.catdiccinfraespecie2catvalido=if(tv.SistClasCatDiccNombreSubInfra='',n.catdiccinfraespecie2catvalido,tv.SistClasCatDiccNombreSubInfra),
n.estatusinfraespecie2catvalido=if(tv.EstatusCategSubInfra='',n.estatusinfraespecie2catvalido,tv.EstatusCategSubInfra),
n.autoranioinfraespecie2catvalido=if(tv.AutoridadCategSubInfra='',n.autoranioinfraespecie2catvalido,tv.AutoridadCategSubInfra),
n.idnombrecatvalido=tv.IdCAT,
n.cattaxcatvalido=tv.UltimaCategoriaTaxonomica,
n.catalogocatvalido=tv.Fuente,
n.comentarioscatvalido=a.comentarioscatvalido_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

-- Ver lo de las categorias intermedias.

select t.ultimacategoriataxonomica,count(1)
from snibdtap.`#Actualiza_idnombrecatvalido&comentarioscatvalido` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat group by 1;

update snibdtap.`#Actualiza_idnombrecatvalido&comentarioscatvalido` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat
set c.subordencatvalido=t.Suborden,
c.sistemaclasificacionsubordencatvalido=t.SistClasCatDiccSuborden,
c.subfamiliacatvalido=t.Subfamilia,
c.sistemaclasificacionsubfamiliacatvalido=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacatvalido=t.EstatusSubfamilia,
c.tribucatvalido=t.Tribu,
c.sistemaclasificaciontribucatvalido=t.SistClasCatDiccTribu,
c.estatustribucatvalido=t.EstatusTribu
where t.ultimacategoriataxonomica in ('género');

update snibdtap.`#Actualiza_idnombrecatvalido&comentarioscatvalido` a inner join snibdtap.si_ousp_nombre_correcciones c on a.llavenombre=c.llavenombre
inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecatvalido_corregido=t.idcat
set c.subordencatvalido=t.Suborden,
c.sistemaclasificacionsubordencatvalido=t.SistClasCatDiccSuborden,
c.subfamiliacatvalido=t.Subfamilia,
c.sistemaclasificacionsubfamiliacatvalido=t.SistClasCatDiccSubfamilia,
c.estatussubfamiliacatvalido=t.EstatusSubfamilia,
c.tribucatvalido=t.Tribu,
c.sistemaclasificaciontribucatvalido=t.SistClasCatDiccTribu,
c.estatustribucatvalido=t.EstatusTribu,
c.subgenerocatvalido=t.subgenero,
c.sistemaclasificacionsubgenerocatvalido=t.SistClasCatDiccSubgenero,
c.estatussubgenerocatvalido=t.EstatusSubgenero,
c.autoraniosubgenerocatvalido=t.autoridadsubgenero
where t.ultimacategoriataxonomica in ('especie');

7.	#Actualiza_idnombrecat&comentarioscat_FaltaValidarTaxon (19 registros). Por medio de la llavenombre y el idnombrecat_corregido actualizar toda la información taxonómica de los campos cat (nombre del taxón, autor, estatus 
y catalogo o sistclascatdic) con la _TransformaTablaNombre desde la categoría del vínculo (idnombrecat_corregido) hasta Reino, incluyendo los campos cattaxcat y catalogocat. La información de categorías inferiores al vínculo
 de los campos cat, el campo fuentecat, la información de los campos catvalido (desde Reinocatvalido hasta infraespecie2catvalido, idnombrecatvalido, comentarioscatvalido, fuentecatvalido, cattaxcatvalido y catalogocatvalido)
 y toda la información adicional se debe eliminar. Además, actualizar el campo comentarioscat de la vista nombre a partir de la información contenida en el campo comentarioscat_corregido de la tabla de entrega.
 
update `#Actualiza_idnombrecat&comentarioscat_FaltaValidarTaxon` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre inner join catalogocentralizado._TransformaTablaNombre t on a.idnombrecat_corregido=t.IdCAT
set
n.reinocat= t.Reino,
n.sistemaclasificacionreinocat= t.SistClasCatDiccReino,
n.divisionphylumcat= t.Divisionphylum,
n.sistemaclasificaciondivisionphylumcat= t.SistClasCatDiccDivisionphylum,
n.clasecat= t.Clase,
n.sistemaclasificacionclasecat= t.SistClasCatDiccClase,
n.ordencat= t.Orden,
n.sistemaclasificacionordencat= t.SistClasCatDiccOrden,
n.subordencat= t.Suborden,
n.sistemaclasificacionsubordencat= t.SistClasCatDiccSuborden,
n.familiacat= t.Familia,
n.sistemaclasificacionfamiliacat= t.SistClasCatDiccFamilia,
n.estatusfamiliacat= t.EstatusFamilia,
n.subfamiliacat= t.Subfamilia,
n.sistemaclasificacionsubfamiliacat= t.SistClasCatDiccSubfamilia,
n.estatussubfamiliacat= t.EstatusSubfamilia,
n.tribucat= t.Tribu,
n.sistemaclasificaciontribucat= t.SistClasCatDiccTribu,
n.estatustribucat= t.EstatusTribu,
n.generocat= t.Genero,
n.sistemaclasificaciongenerocat= t.SistClasCatDiccGenero,
n.estatusgenerocat= t.EstatusGenero,
n.autoraniogenerocat= t.AutoridadGenero,
n.subgenerocat= t.Subgenero,
n.sistemaclasificacionsubgenerocat= t.SistClasCatDiccSubgenero,
n.autoraniosubgenerocat= t.AutoridadSubgenero,
n.estatussubgenerocat= t.EstatusSubgenero,
n.epitetoespecificocat= t.Especie_epiteto,
n.catdiccespeciecat= t.SistClasCatDiccEspecie_epiteto,
n.estatusespeciecat= t.EstatusEspecie_epiteto,
n.autoranioespeciecat= t.AutoridadEspecie_epiteto,
n.categoriainfraespeciecat= t.Categinfra,
n.epitetoinfraespecificocat= t.Nombreinfra,
n.catdiccinfraespeciecat= t.SistClasCatDiccNombreinfra,
n.estatusinfraespeciecat= t.EstatusCategInfra,
n.autoranioinfraespeciecat= t.AutoridadCategInfra,
n.categoriainfraespecie2cat= t.CategSubInfra,
n.epitetoinfraespecifico2cat= t.NombreSubInfra,
n.catdiccinfraespecie2cat= t.SistClasCatDiccNombreSubInfra,
n.estatusinfraespecie2cat= t.EstatusCategSubInfra,
n.autoranioinfraespecie2cat= t.AutoridadCategSubInfra,
n.idnombrecat= t.IdCAT,
n.cattaxcat= t.UltimaCategoriaTaxonomica,
n.catalogocat= t.Fuente,
n.comentarioscat= a.comentarioscat_corregido,
n.fuentecat= '',
n.reinocatvalido= '',
n.sistemaclasificacionreinocatvalido= '',
n.divisionphylumcatvalido= '',
n.sistemaclasificaciondivisionphylumcatvalido= '',
n.clasecatvalido= '',
n.sistemaclasificacionclasecatvalido= '',
n.ordencatvalido= '',
n.sistemaclasificacionordencatvalido= '',
n.subordencatvalido= '',
n.sistemaclasificacionsubordencatvalido= '',
n.familiacatvalido= '',
n.sistemaclasificacionfamiliacatvalido= '',
n.estatusfamiliacatvalido= '',
n.subfamiliacatvalido= '',
n.sistemaclasificacionsubfamiliacatvalido= '',
n.estatussubfamiliacatvalido= '',
n.tribucatvalido= '',
n.sistemaclasificaciontribucatvalido= '',
n.estatustribucatvalido= '',
n.generocatvalido= '',
n.sistemaclasificaciongenerocatvalido= '',
n.estatusgenerocatvalido= '',
n.autoraniogenerocatvalido= '',
n.subgenerocatvalido= '',
n.sistemaclasificacionsubgenerocatvalido= '',
n.autoraniosubgenerocatvalido= '',
n.estatussubgenerocatvalido= '',
n.epitetoespecificocatvalido= '',
n.catdiccespeciecatvalido= '',
n.estatusespeciecatvalido= '',
n.autoranioespeciecatvalido= '',
n.categoriainfraespeciecatvalido= '',
n.epitetoinfraespecificocatvalido= '',
n.catdiccinfraespeciecatvalido= '',
n.estatusinfraespeciecatvalido= '',
n.autoranioinfraespeciecatvalido= '',
n.categoriainfraespecie2catvalido= '',
n.epitetoinfraespecifico2catvalido= '',
n.catdiccinfraespecie2catvalido= '',
n.estatusinfraespecie2catvalido= '',
n.autoranioinfraespecie2catvalido= '',
n.idnombrecatvalido= '',
n.cattaxcatvalido= '',
n.catalogocatvalido= '',
n.comentarioscatvalido= '',
n.fuentecatvalido= '',
n.homonimosfamiliacatvalido='',
n.homonimosgenerocatvalido='',
n.homonimosespeciecatvalido='',
n.homonimosinfraespeciecatvalido='',
n.categoriavalidocatscat='',
n.nombrevalidocatscat='',
n.estatusvalidocatscat='',
n.autoridadvalidocatscat='',
n.gruposcat=t.gruposcat,
n.idcol=''.
n.idcolvalido='',
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');


8.	# Elimina_validacion (22 registros). Por medio de la llavenombre eliminar la información de los campos cat (nombre del taxón, autor, estatus y catalogo o sistclascatdic) desde Reino hasta infraespecie2, los campos 
gruposcat, fuentecat, idnombrecat, cattaxcat, categoriacatscat, nombrecatscat, estatuscatscat, autoridadcatscat, reftaxintermediacatscat, todos los campos catvalido (incluyendo campos categoriavalidocatscat, 
nombrevalidocatscat, estatusvalidocatscat, autoridadvalidocatscat y comentarioscatvalido) y toda la información adicional de la vista nombre. Además, actualizar el campo comentarioscat de la vista nombre a partir de la 
información contenida en el campo comentarioscat_corregido de la tabla de entrega.

update snibdtap.`#Elimina_validacion` a inner join snibdtap.si_ousp_nombre_correcciones n on a.llavenombre=n.llavenombre
set
n.reinocat= '',
n.sistemaclasificacionreinocat= '',
n.divisionphylumcat= '',
n.sistemaclasificaciondivisionphylumcat= '',
n.clasecat= '',
n.sistemaclasificacionclasecat= '',
n.ordencat= '',
n.sistemaclasificacionordencat= '',
n.subordencat= '',
n.sistemaclasificacionsubordencat= '',
n.familiacat= '',
n.sistemaclasificacionfamiliacat= '',
n.estatusfamiliacat= '',
n.subfamiliacat= '',
n.sistemaclasificacionsubfamiliacat= '',
n.estatussubfamiliacat= '',
n.tribucat= '',
n.sistemaclasificaciontribucat= '',
n.estatustribucat= '',
n.generocat= '',
n.sistemaclasificaciongenerocat= '',
n.estatusgenerocat= '',
n.autoraniogenerocat= '',
n.subgenerocat= '',
n.sistemaclasificacionsubgenerocat= '',
n.autoraniosubgenerocat= '',
n.estatussubgenerocat= '',
n.epitetoespecificocat= '',
n.catdiccespeciecat= '',
n.estatusespeciecat= '',
n.autoranioespeciecat= '',
n.categoriainfraespeciecat= '',
n.epitetoinfraespecificocat= '',
n.catdiccinfraespeciecat= '',
n.estatusinfraespeciecat= '',
n.autoranioinfraespeciecat= '',
n.categoriainfraespecie2cat= '',
n.epitetoinfraespecifico2cat= '',
n.catdiccinfraespecie2cat= '',
n.estatusinfraespecie2cat= '',
n.autoranioinfraespecie2cat= '',
n.idnombrecat= '',
n.cattaxcat= '',
n.catalogocat= '',
n.comentarioscat= a.comentarioscat_corregido,
n.fuentecat= '',
n.gruposcat='NO DISPONIBLE',
n.reinocatvalido= '',
n.sistemaclasificacionreinocatvalido= '',
n.divisionphylumcatvalido= '',
n.sistemaclasificaciondivisionphylumcatvalido= '',
n.clasecatvalido= '',
n.sistemaclasificacionclasecatvalido= '',
n.ordencatvalido= '',
n.sistemaclasificacionordencatvalido= '',
n.subordencatvalido= '',
n.sistemaclasificacionsubordencatvalido= '',
n.familiacatvalido= '',
n.sistemaclasificacionfamiliacatvalido= '',
n.estatusfamiliacatvalido= '',
n.subfamiliacatvalido= '',
n.sistemaclasificacionsubfamiliacatvalido= '',
n.Estatussubfamiliacatvalido= '',
n.tribucatvalido= '',
n.sistemaclasificaciontribucatvalido= '',
n.estatustribucatvalido= '',
n.generocatvalido= '',
n.sistemaclasificaciongenerocatvalido= '',
n.estatusgenerocatvalido= '',
n.autoraniogenerocatvalido= '',
n.subgenerocatvalido= '',
n.sistemaclasificacionsubgenerocatvalido= '',
n.autoraniosubgenerocatvalido= '',
n.estatussubgenerocatvalido= '',
n.epitetoespecificocatvalido= '',
n.catdiccespeciecatvalido= '',
n.estatusespeciecatvalido= '',
n.autoranioespeciecatvalido= '',
n.categoriainfraespeciecatvalido= '',
n.epitetoinfraespecificocatvalido= '',
n.catdiccinfraespeciecatvalido= '',
n.estatusinfraespeciecatvalido= '',
n.autoranioinfraespeciecatvalido= '',
n.categoriainfraespecie2catvalido= '',
n.epitetoinfraespecifico2catvalido= '',
n.catdiccinfraespecie2catvalido= '',
n.estatusinfraespecie2catvalido= '',
n.autoranioinfraespecie2catvalido= '',
n.idnombrecatvalido= '',
n.cattaxcatvalido= '',
n.catalogocatvalido= '',
n.comentarioscatvalido= '',
n.fuentecatvalido= '',
n.homonimosfamilia= '',
n.homonimosgenero= '',
n.homonimosespecie= '',
n.homonimosinfraespecie= '',
n.homonimosfamiliacatvalido= '',
n.homonimosgenerocatvalido= '',
n.homonimosespeciecatvalido= '',
n.homonimosinfraespeciecatvalido= '',
n.categoriacatscat= '',
n.nombrecatscat= '',
n.estatuscatscat= '',
n.autoridadcatscat= '',
n.categoriavalidocatscat= '',
n.nombrevalidocatscat= '',
n.estatusvalidocatscat= '',
n.autoridadvalidocatscat= '',
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');;


9.	#Actualiza_comentarioscat (31 registros). Por medio de la llavenombre actualizar el campo comentarioscat de la vista nombre a partir de la información contenida en el campo comentarioscat_corregido de la tabla de entrega.

update `#Actualiza_comentarioscat` a inner join snib.nombre_taxonomia n on a.llavenombre=n.llavenombre
set
n.comentarioscat=a.comentarioscat_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');


10.	#Actualiza_comentarioscatvalido (744 registros). Por medio de la llavenombre actualizar el campo comentarioscatvalido de la vista nombre a partir de la información contenida en el campo comentarioscatvalido_corregido de
 la tabla de entrega.
 
update `#Actualiza_comentarioscatvalido` a inner join snib.nombre_taxonomia n on a.llavenombre=n.llavenombre
set
n.comentarioscatvalido=a.comentarioscatvalido_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');


11.	#Actualiza_gruposcat (80). Por medio de la llavenombre actualizar el campo gruposcat de la vista nombre a partir de la información contenida en el campo gruposcat_corregido de la tabla de entrega.

update `#Actualiza_gruposcat` a inner join snib.nombre_taxonomia n on a.llavenombre=n.llavenombre
set
n.gruposcat=a.gruposcat_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

14.	Llenar campos resumen cat y catvalidos, actualizar el espejo de acuerdo con lo indicado en el jira SNIB-2434.

-- actualizar los campos resumen

update snibdtap.si_ousp_nombre_correcciones
set categoriacatscat='',
nombrecatscat='',
estatuscatscat='',
autoridadcatscat='',
categoriavalidocatscat='',
nombrevalidocatscat='',
estatusvalidocatscat='',
autoridadvalidocatscat='';

update snibdtap.si_ousp_nombre_correcciones n inner join catalogocentralizado._TransformaTablaNombre t on n.idnombrecat=t.IdCAT
set n.categoriacatscat=t.UltimaCategoriaTaxonomica,
n.nombrecatscat=t.TaxonConSubgenero,
n.estatuscatscat=t.EstatusTaxon,
n.autoridadcatscat=t.AutorTaxon
where n.comentarioscat like '%Validado completamente con CAT%';

update snibdtap.si_ousp_nombre_correcciones n inner join catalogocentralizado._TransformaTablaNombre t on n.idnombrecatvalido=t.IdCAT
set n.categoriavalidocatscat=t.UltimaCategoriaTaxonomica,
n.nombrevalidocatscat=t.TaxonConSubgenero,
n.estatusvalidocatscat=t.EstatusTaxon,
n.autoridadvalidocatscat=t.AutorTaxon
where n.comentarioscatvalido like '%Validado completamente con CAT%';


UPDATE snibdtap.si_ousp_nombre_correcciones n1
SET n1.categoriacatscat= IF(n1.epitetoinfraespecifico2cat <> '',n1.categoriainfraespecie2cat,
IF(n1.epitetoinfraespecificocat <> '',n1.categoriainfraespeciecat ,
IF(n1.epitetoespecificocat <> '','especie',
IF(n1.subgenerocat <> '','subgénero',
IF(n1.generocat <> '','género',
IF(n1.tribucat <> '','tribu',
IF(n1.subfamiliacat <> '','subfamilia',
IF(n1.familiacat <> '','familia',
IF(n1.subordencat <> '','suborden',
IF(n1.ordencat <> '','orden',
IF(n1.clasecat <> '','clase',
IF(n1.divisionphylumcat <> '','divisionphylum',
IF(n1.reinocat <> '','Reino',''))))))))))))),
n1.nombrecatscat = IF(n1.epitetoinfraespecifico2cat <> '',CONCAT(n1.generocat,IF(n1.subgenerocat <> '',CONCAT(' (',n1.subgenerocat,')'),''),' ',n1.epitetoespecificocat,' ',n1.epitetoinfraespecificocat,' ',n1.epitetoinfraespecifico2cat),
IF(n1.epitetoinfraespecificocat <> '',CONCAT(n1.generocat,IF(n1.subgenerocat <> '',CONCAT(' (',n1.subgenerocat,')'),''),' ',n1.epitetoespecificocat,' ',n1.epitetoinfraespecificocat),
IF(n1.epitetoespecificocat <> '',CONCAT(n1.generocat,IF(n1.subgenerocat <> '',CONCAT(' (',n1.subgenerocat,')'),''),' ',n1.epitetoespecificocat),
IF(n1.subgenerocat <> '',CONCAT(n1.generocat,IF(n1.subgenerocat <> '',CONCAT(' (',n1.subgenerocat,')'),'')),
IF(n1.generocat <> '',n1.generocat,
IF(n1.tribucat <> '',n1.tribucat,
IF(n1.subfamiliacat <> '',n1.subfamiliacat,
IF(n1.familiacat <> '',n1.familiacat,
IF(n1.subordencat <> '',n1.subordencat,
IF(n1.ordencat <> '',n1.ordencat,
IF(n1.clasecat <> '',n1.clasecat,
IF(n1.divisionphylumcat <> '',n1.divisionphylumcat,
IF(n1.reinocat <> '',n1.reinocat,''))))))))))))),
n1.estatuscatscat=IF(n1.epitetoinfraespecifico2cat <> '',n1.estatusinfraespecie2cat,
IF(n1.epitetoinfraespecificocat <> '',n1.estatusinfraespeciecat ,
IF(n1.epitetoespecificocat <> '',n1.estatusespeciecat,
IF(n1.subgenerocat <> '',n1.estatussubgenerocat,
IF(n1.generocat <> '',n1.estatusgenerocat,
IF(n1.tribucat <> '',n1.estatustribucat,
IF(n1.subfamiliacat <> '',n1.estatussubfamiliacat,
IF(n1.familiacat <> '',n1.estatusfamiliacat,'')))))))),
n1.autoridadcatscat=IF(n1.epitetoinfraespecifico2cat <> '',n1.autoranioinfraespecie2cat,
IF(n1.epitetoinfraespecificocat <> '',n1.autoranioinfraespeciecat ,
IF(n1.epitetoespecificocat <> '',n1.autoranioespeciecat,
IF(n1.subgenerocat <> '',n1.autoraniosubgenerocat,
IF(n1.generocat <> '',n1.autoraniogenerocat,'')))))
WHERE n1.comentarioscat LIKE '%completamente con otra fuente%';


UPDATE snibdtap.si_ousp_nombre_correcciones n1
SET n1.categoriavalidocatscat= IF(n1.epitetoinfraespecifico2catvalido <> '',n1.categoriainfraespecie2catvalido,
IF(n1.epitetoinfraespecificocatvalido <> '',n1.categoriainfraespeciecatvalido ,
IF(n1.epitetoespecificocatvalido <> '','especie',
IF(n1.subgenerocatvalido <> '','subgénero',
IF(n1.generocatvalido <> '','género',
IF(n1.tribucatvalido <> '','tribu',
IF(n1.subfamiliacatvalido <> '','subfamilia',
IF(n1.familiacatvalido <> '','familia',
IF(n1.subordencatvalido <> '','suborden',
IF(n1.ordencatvalido <> '','orden',
IF(n1.clasecatvalido <> '','clase',
IF(n1.divisionphylumcatvalido <> '','divisionphylum',
IF(n1.reinocatvalido <> '','Reino',''))))))))))))),
n1.nombrevalidocatscat=IF(n1.epitetoinfraespecifico2catvalido <> '',CONCAT(n1.generocatvalido,IF(n1.subgenerocatvalido <> '',CONCAT(' (',n1.subgenerocatvalido,')'),''),' ',n1.epitetoespecificocatvalido,' ',n1.epitetoinfraespecificocatvalido,' ',n1.epitetoinfraespecifico2catvalido),
IF(n1.epitetoinfraespecificocatvalido <> '',CONCAT(n1.generocatvalido,IF(n1.subgenerocatvalido <> '',CONCAT(' (',n1.subgenerocatvalido,')'),''),' ',n1.epitetoespecificocatvalido,' ',n1.epitetoinfraespecificocatvalido),
IF(n1.epitetoespecificocatvalido <> '',CONCAT(n1.generocatvalido,IF(n1.subgenerocatvalido <> '',CONCAT(' (',n1.subgenerocatvalido,')'),''),' ',n1.epitetoespecificocatvalido),
IF(n1.subgenerocatvalido <> '',CONCAT(n1.generocatvalido,IF(n1.subgenerocatvalido <> '',CONCAT(' (',n1.subgenerocatvalido,')'),'')),
IF(n1.generocatvalido <> '',n1.generocatvalido,
IF(n1.tribucatvalido <> '',n1.tribucatvalido,
IF(n1.subfamiliacatvalido <> '',n1.subfamiliacatvalido,
IF(n1.familiacatvalido <> '',n1.familiacatvalido,
IF(n1.subordencatvalido <> '',n1.subordencatvalido,
IF(n1.ordencatvalido <> '',n1.ordencatvalido,
IF(n1.clasecatvalido <> '',n1.clasecatvalido,
IF(n1.divisionphylumcatvalido <> '',n1.divisionphylumcatvalido,
IF(n1.reinocatvalido <> '',reinocatvalido,''))))))))))))),
n1.estatusvalidocatscat=IF(n1.epitetoinfraespecifico2catvalido <> '',n1.estatusinfraespecie2catvalido,
IF(n1.epitetoinfraespecificocatvalido <> '',n1.estatusinfraespeciecatvalido ,
IF(n1.epitetoespecificocatvalido <> '',n1.estatusespeciecatvalido,
IF(n1.subgenerocatvalido <> '',n1.estatussubgenerocatvalido,
IF(n1.generocatvalido <> '',n1.estatusgenerocatvalido,
IF(n1.tribucatvalido <> '',n1.estatustribucatvalido,
IF(n1.subfamiliacatvalido <> '',n1.estatussubfamiliacatvalido,
IF(n1.familiacatvalido <> '',n1.estatusfamiliacatvalido,'')))))))),
n1.autoridadvalidocatscat=IF(n1.epitetoinfraespecifico2catvalido <> '',n1.autoranioinfraespecie2catvalido,
IF(n1.epitetoinfraespecificocatvalido <> '',n1.autoranioinfraespeciecatvalido ,
IF(n1.epitetoespecificocatvalido <> '',n1.autoranioespeciecatvalido,
IF(n1.subgenerocatvalido <> '',n1.autoraniosubgenerocatvalido,
IF(n1.generocatvalido <> '',n1.autoraniogenerocatvalido,'')))))
WHERE n1.comentarioscatvalido LIKE '%completamente con otra fuente%';

-- actualizar el espejo

update snibdtap.si_ousp_nombre_correcciones
SET
    reinocatvalido = '',
    sistemaclasificacionreinocatvalido = '',
    divisionphylumcatvalido = '',
    sistemaclasificaciondivisionphylumcatvalido = '',
    clasecatvalido = '',
    sistemaclasificacionclasecatvalido = '',
    ordencatvalido = '',
    sistemaclasificacionordencatvalido = '',
    subordencatvalido = '',
    sistemaclasificacionsubordencatvalido = '',
    familiacatvalido = '',
	estatusfamiliacatvalido = '',
    sistemaclasificacionfamiliacatvalido = '',
    subfamiliacatvalido = '',
    sistemaclasificacionsubfamiliacatvalido = '',
    estatussubfamiliacatvalido = '',
    tribucatvalido = '',
    sistemaclasificaciontribucatvalido = '',
    estatustribucatvalido = '',
    generocatvalido = '',
    sistemaclasificaciongenerocatvalido = '',
    autoraniogenerocatvalido = '',
    estatusgenerocatvalido = '',
    subgenerocatvalido = '',
    sistemaclasificacionsubgenerocatvalido = '',
    autoraniosubgenerocatvalido = '',
    estatussubgenerocatvalido = '',
    epitetoespecificocatvalido = '',
    catdiccespeciecatvalido = '',
    autoranioespeciecatvalido = '',
    estatusespeciecatvalido = '',
    categoriainfraespeciecatvalido = '',
    epitetoinfraespecificocatvalido = '',
    catdiccinfraespeciecatvalido = '',
    autoranioinfraespeciecatvalido = '',
    estatusinfraespeciecatvalido = '',
	categoriainfraespecie2catvalido='',
    epitetoinfraespecifico2catvalido='',
    autoranioinfraespecie2catvalido='',
    estatusinfraespecie2catvalido='',
    catdiccinfraespecie2catvalido='',
    idnombrecatvalido = '',
    cattaxcatvalido = '',
    catalogocatvalido = '',
    comentarioscatvalido = '',
    fuentecatvalido = '',
    homonimosfamiliacatvalido = '',
    homonimosgenerocatvalido = '',
    homonimosespeciecatvalido = '',
    homonimosinfraespeciecatvalido = '',
    categoriavalidocatscat = '',
    nombrevalidocatscat = '',
    estatusvalidocatscat = '',
    autoridadvalidocatscat = ''
WHERE (comentarioscat like "%completamente%" and estatuscatscat in ('válido', 'aceptado'))
or (comentarioscat like '%completamente con otra fuente%' and estatuscatscat = '');

update snibdtap.si_ousp_nombre_correcciones
SET
    reinocatvalido = reinocat,
    sistemaclasificacionreinocatvalido = sistemaclasificacionreinocat,
    divisionphylumcatvalido = divisionphylumcat,
    sistemaclasificaciondivisionphylumcatvalido = sistemaclasificaciondivisionphylumcat,
    clasecatvalido = clasecat,
    sistemaclasificacionclasecatvalido = sistemaclasificacionclasecat,
    ordencatvalido = ordencat,
    sistemaclasificacionordencatvalido = sistemaclasificacionordencat,
    subordencatvalido = subordencat,
    sistemaclasificacionsubordencatvalido = sistemaclasificacionsubordencat,
    familiacatvalido = familiacat,
	estatusfamiliacatvalido = estatusfamiliacat,
    sistemaclasificacionfamiliacatvalido = sistemaclasificacionfamiliacat,
    subfamiliacatvalido = subfamiliacat,
    sistemaclasificacionsubfamiliacatvalido = sistemaclasificacionsubfamiliacat,
    estatussubfamiliacatvalido = estatussubfamiliacat,
    tribucatvalido = tribucat,
    sistemaclasificaciontribucatvalido = sistemaclasificaciontribucat,
    estatustribucatvalido = estatustribucat,
    generocatvalido = generocat,
    sistemaclasificaciongenerocatvalido = sistemaclasificaciongenerocat,
    autoraniogenerocatvalido = autoraniogenerocat,
    estatusgenerocatvalido = estatusgenerocat,
    subgenerocatvalido = subgenerocat,
    sistemaclasificacionsubgenerocatvalido = sistemaclasificacionsubgenerocat,
    autoraniosubgenerocatvalido = autoraniosubgenerocat,
    estatussubgenerocatvalido = estatussubgenerocat,
    epitetoespecificocatvalido = epitetoespecificocat,
    catdiccespeciecatvalido = catdiccespeciecat,
    autoranioespeciecatvalido = autoranioespeciecat,
    estatusespeciecatvalido = estatusespeciecat,
    categoriainfraespeciecatvalido = categoriainfraespeciecat,
    epitetoinfraespecificocatvalido = epitetoinfraespecificocat,
    catdiccinfraespeciecatvalido = catdiccinfraespeciecat,
    autoranioinfraespeciecatvalido = autoranioinfraespeciecat,
    estatusinfraespeciecatvalido = estatusinfraespeciecat,
	categoriainfraespecie2catvalido=categoriainfraespecie2cat,
    epitetoinfraespecifico2catvalido=epitetoinfraespecifico2cat,
    autoranioinfraespecie2catvalido=autoranioinfraespecie2cat,
    estatusinfraespecie2catvalido=estatusinfraespecie2cat,
    catdiccinfraespecie2catvalido=catdiccinfraespecie2cat,
    idnombrecatvalido = idnombrecat,
    cattaxcatvalido = cattaxcat,
    catalogocatvalido = catalogocat,
    comentarioscatvalido = comentarioscat,
    fuentecatvalido = fuentecat,
    homonimosfamiliacatvalido = homonimosfamilia,
    homonimosgenerocatvalido = homonimosgenero,
    homonimosespeciecatvalido = homonimosespecie,
    homonimosinfraespeciecatvalido = homonimosinfraespecie,
    categoriavalidocatscat = categoriacatscat,
    nombrevalidocatscat = nombrecatscat,
    estatusvalidocatscat = estatuscatscat,
    autoridadvalidocatscat = autoridadcatscat
WHERE (comentarioscat like "%completamente%" and estatuscatscat in ('válido', 'aceptado'))
or (comentarioscat like '%completamente con otra fuente%' and estatuscatscat = '');

12.	#Actualiza_llavenombre_verificada, 18 registros (Rellena unos registros con la validación de otros registros). Por medio de la llavenombre actualizar todos los campos cat y catvalidos (excepto grupo2 y subgrupo) de la 
tabla nombre a partir de lo que hay en los registros en el campo llavenombre_verificada incluyendo los campos comentarioscat, comentarioscatvalido.

update snibdtap.`#Actualiza_llavenombre_verificada` r inner join snib.nombre_taxonomia n on r.llavenombre=n.llavenombre
inner join snib.nombre_taxonomia n1 on r.llavenombre_verificada=n1.llavenombre
set n.grupo=n1.grupo,
n.idnombre=n1.idnombre,
n.comentarioscat=n1.comentarioscat,
n.comentarioscatvalido=n1.comentarioscatvalido,
n.homonimosfamilia=n1.homonimosfamilia,
n.homonimosgenero=n1.homonimosgenero,
n.homonimosespecie=n1.homonimosespecie,
n.homonimosinfraespecie=n1.homonimosinfraespecie,
n.homonimosfamiliacatvalido=n1.homonimosfamiliacatvalido,
n.homonimosgenerocatvalido=n1.homonimosgenerocatvalido,
n.homonimosespeciecatvalido=n1.homonimosespeciecatvalido,
n.homonimosinfraespeciecatvalido=n1.homonimosinfraespeciecatvalido,
n.gruposcat=n1.gruposcat,
n.formadecrecimiento=n1.formadecrecimiento,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

13.	Actualizar para todos los registros el campo grupo de la vista nombre mediante el gruposcat y la tabla de equivalencias: #Equivalencias_GrupoSCAT&Grupo

/* update `#Equivalencias_GrupoSCAT&Grupo` e inner join snib.nombre_taxonomia n on e.gruposcat=n.gruposcat
set n.grupo=if(e.Grupo='NO DISPONIBLE',n.grupo,e.grupo),
n.ultimafechaactualizacion=if(e.grupo='NO DISPONIBLE',n.ultimafechaactualizacion,date_format(now(),'%Y-%m-%d'))
where n.grupo<>e.Grupo; */

-- El qry anterior cambio el día 19/06/2024 en reunión con José Mendoza y Dulce Parra

-- Este qry se corre al final una vez que ya se pasaron las correcciones de la tabla si_ousp_nombrecorrecciones a la tabla nombre_taxonomia en la base snib
update catalogocentralizado.`Equivalencias_GrupoSCAT&Grupo` e inner join snib.nombre_taxonomia n on e.gruposcat=n.gruposcat
set n.grupo=e.Grupo,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d')
where n.grupo<>e.Grupo;

14. #Actualiza_ambientenombre (13 registros). Por medio de la llavenombre actualizar los campos ambientenombre y origenambientenombre de la vista 
nombre a partir de la información contenida en el campo ambientenombre_corregido y origenambientenombre_corregido de la tabla de entrega.
Se repiten dos registros con la tabla #Actualiza_CompletamenteCOL. 


update snibdtap.`#Actualiza_ambientenombre` a inner join snib.nombre_taxonomia n on a.llavenombre=n.llavenombre
set n.ambientenombre=ambientenombre_corregido,
n.origenambientenombre=origenambientenombre_corregido,
n.ultimafechaactualizacion=date_format(now(),'%Y-%m-%d');

insert into si_ousp_cambiosenambiente_noborrar
select a.llavenombre,a.ambientenombre,ambientenombre_corregido,'2023-11-17'
from snibdtap.`#Actualiza_ambientenombre` a inner join snib.nombre_taxonomia n on a.llavenombre=n.llavenombre;

-- revisamos si amerita llenar la tabla snibdtap.si_ousp_cambiosenambiente_residenciaaves_noborrar por el cambio de ambiente

insert into snibdtap.si_ousp_cambiosenambiente_residenciaaves_noborrar(llavenombre,ambientenombre_old,ambientenombre_new,ultimafechaactualizacion)
select llavenombre,ambientenombre,ambientenombre_corregido,'2022-11-14'
from `#Actualiza_ambientenombre`
where ambientenombre<>ambientenombre_corregido;
