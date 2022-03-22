CREATE DATABASE `vendas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `vendas`;

CREATE TABLE `clientes` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) DEFAULT NULL,
  `Cidade` varchar(50) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Márcio André Bernardo Galvão', 'Aracaju', 'SE');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Renato Thiago Mendes', 'Ananindeua', 'PA');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Larissa Sabrina Alves', 'Macapá', 'AP');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Ian Mário Araújo', 'Campina Grande', 'PB');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Pietro Theo Luiz Pinto', 'Boa Vista', 'RR');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Ana Alice Nogueira', 'Mossoró', 'RN');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Kamilly Stefany Sarah Gonçalves', 'Canoas', 'RS');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Sophia Bianca Santos', 'Maceió', 'AL');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Alexandre Rodrigo Davi Mendes', 'Brasília', 'DF');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Andrea Cláudia Vieira', 'Cidade Ocidental', 'GO');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Benício João Igor Galvão', 'São Luís', 'MA');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Julio Igor das Neves', 'Salvador', 'BA');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Antonella Camila Moraes', 'Santana', 'AP');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Geraldo Kaique Moreira', 'Maracanaú', 'CE');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Beatriz Bianca Farias', 'Arapiraca', 'AL');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Patrícia Isadora Bernardes', 'Luziânia', 'GO');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Julio Oliver Cavalcanti', 'Rio de Janeiro', 'RJ');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Camila Luiza Jesus', 'Foz do Iguaçu', 'PR');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Anthony Felipe da Cruz', 'Fortaleza', 'CE');
INSERT INTO `vendas`.`clientes` (`Nome`, `Cidade`, `UF`) VALUES ('Danilo Caio Yuri Mendes', 'Macapá', 'AP');

CREATE TABLE `produtos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(50) DEFAULT NULL,
  `ValorVenda` double DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Smartphone', 1000);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Sapato', 250);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Impressora', 350);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Perfume', 80);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Notebook', 3200);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Relógio', 375);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Microondas', 490);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Calça', 160);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Camisa', 90);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Câmera', 930);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Tênis', 280);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Caderno', 38);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Lápis', 3);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Caneta', 16);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Caneca', 49);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Copo', 6);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Prato', 21);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Garfo', 4);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Faca', 5);
INSERT INTO `vendas`.`produtos` (`Descricao`, `ValorVenda`) VALUES ('Colher', 6);

CREATE TABLE `pedidos` (
  `Id` int NOT NULL,
  `Emissao` datetime DEFAULT NULL,
  `Cliente` int DEFAULT NULL,
  `ValorTotal` double DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_cliente_pedidos_idx` (`Cliente`),
  CONSTRAINT `fk_cliente_pedidos` FOREIGN KEY (`Cliente`) REFERENCES `clientes` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedido_produtos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Pedido` int DEFAULT NULL,
  `Produto` int DEFAULT NULL,
  `Quantidade` int DEFAULT NULL,
  `ValorUnitario` double DEFAULT NULL,
  `ValorTotal` double DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_pedido_pedidos_produto_idx` (`Pedido`),
  KEY `fk_produto_pedidos_produto_idx` (`Produto`),
  CONSTRAINT `fk_pedido_pedidos_produto` FOREIGN KEY (`Pedido`) REFERENCES `pedidos` (`Id`),
  CONSTRAINT `fk_produto_pedidos_produto` FOREIGN KEY (`Produto`) REFERENCES `produtos` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;