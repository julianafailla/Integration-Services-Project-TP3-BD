USE FacturacionVentas;

SELECT
    r.Factura AS NumeroFactura,
    r.Articulo AS IdArticulo,
    v.Id_vendedor AS IdVendedor,
    v.Nombre AS Vendedor,
    p.Id_producto AS IdProducto,
    COALESCE(cp.Descripcion, CONCAT(N'Producto ', p.Id_producto)) AS Producto,
    g.Id_ciudad AS IdCiudad,
    g.Nom_ciudad AS Ciudad,
    d.Nom_depto AS Departamento,
    CONVERT(char(10), f.Fecha, 23) AS Fecha,
    r.Unidades,
    CAST(r.Importe AS decimal(18, 2)) AS Importe
FROM dbo.Registros_Facturas AS r
LEFT JOIN dbo.Facturas AS f ON f.Factura = r.Factura
LEFT JOIN dbo.Vendedores AS v ON v.Id_vendedor = f.Vendedor
LEFT JOIN dbo.Clientes AS cl ON cl.Id_cliente = f.Cliente
LEFT JOIN dbo.Ciudades AS g ON g.Id_ciudad = cl.Ciudad
LEFT JOIN dbo.Departamentos AS d ON d.Id_depto = g.Id_depto
LEFT JOIN dbo.Articulos AS a ON a.Id_articulo = r.Articulo
LEFT JOIN dbo.Productos AS p ON p.Id_producto = a.Id_producto
LEFT JOIN dbo.Codigos AS cp ON cp.Codigo = p.Id_producto AND cp.Tipo = 'PRODUCTO'
ORDER BY r.Factura, r.Articulo;
