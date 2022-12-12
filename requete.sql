-- 1 -  Liste des clients français :
SELECT CompanyName, ContactName, ContactTitle, Phone FROM `customers` WHERE Country = 'France';

-- 2 - Liste des produits vendus par le fournisseur "Exotic Liquids" :
SELECT ProductName, UnitPrice FROM `products` JOIN `suppliers` ON suppliers.SupplierID = products.ProductID WHERE CompanyName = 'Exotic Liquids'; 

-- 3 - Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant) :
SELECT CompanyName, COUNT(UnitsOnOrder) FROM `suppliers` JOIN `products` ON products.SupplierID = suppliers.SupplierID WHERE Country = 'France' GROUP BY CompanyName;

-- 4 - Liste des clients français ayant passé plus de 10 commandes :
SELECT CompanyName, COUNT(OrderId) FROM `customers` JOIN `orders` ON orders.CustomerID = customers.CustomerID WHERE Country = 'France' GROUP BY CompanyName HAVING COUNT(OrderId) > 10;

-- 5 - Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :
SELECT SUM(UnitPrice * Quantity), CompanyName FROM `customers` INNER JOIN `orders` ON orders.CustomerID = customers.CustomerID
JOIN `order details` ON `order details`.orderID = orders.OrderID GROUP BY CompanyName HAVING SUM(UnitPrice * Quantity) > 3000;

-- 6 - Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés :
SELECT ShipCountry FROM `orders` JOIN `order details`ON `order details`.`OrderID` = orders.OrderID 
JOIN `products` ON products.ProductID = `order details`.`ProductID`
JOIN `suppliers` ON suppliers.SupplierID = products.SupplierID
WHERE suppliers.CompanyName = 'Exotic Liquids' GROUP BY ShipCountry;

-- 7 - Chiffre d'affaires global sur les ventes de 1997 :
SELECT SUM(UnitPrice * Quantity) FROM `order details` JOIN `orders` ON orders.OrderID = `order details`.`OrderID` WHERE YEAR(OrderDate) = 1997;

-- 8 - Chiffre d'affaires détaillé par mois, sur les ventes de 1997 :
SELECT MONTH(OrderDate), SUM(UnitPrice * Quantity)FROM `order details` JOIN `orders` ON orders.OrderID = `order details`.`OrderID` WHERE YEAR(OrderDate) = 1997 GROUP BY MONTH(OrderDate);

-- 9 - A quand remonte la dernière commande du client nommé "Du monde entier" ?
SELECT MAX(OrderDate) FROM `orders` JOIN `customers` ON customers.CustomerID = orders.CustomerID WHERE CompanyName = 'Du monde entier';

-- 10 - Quel est le délai moyen de livraison en jours ?
SELECT AVG(DATEDIFF(ShippedDate, OrderDate )) FROM `orders`;