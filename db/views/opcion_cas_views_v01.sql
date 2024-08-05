SELECT
    oc.id,
    o.nombre AS opcion,
    c.nombre AS componente,
    a.nombre AS atributo,
    oc.descripcion,
    oc.estado
FROM
    OPCION_CAS OC
    INNER JOIN OPCIONES O ON
	O.ID = OC.OPCION_ID
    INNER JOIN COMPONENTES C ON
	C.ID = OC.COMPONENTE_ID
    INNER JOIN ATRIBUTOS A ON
	A.ID = OC.ATRIBUTO_ID
WHERE
	OC.ESTADO = 'A'
ORDER BY
	OC.ID ASC