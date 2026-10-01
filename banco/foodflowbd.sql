DROP DATABASE IF EXISTS foodflow;
CREATE DATABASE foodflow CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE foodflow;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    tipo_usuario ENUM('CLIENTE','ADMIN') NOT NULL DEFAULT 'CLIENTE',
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    disponivel BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    status_pedido ENUM('PENDENTE','CONFIRMADO','EM_PREPARO','PRONTO','ENTREGUE','CANCELADO')
        NOT NULL DEFAULT 'PENDENTE',
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    observacao VARCHAR(255),
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_quantidade CHECK (quantidade > 0),
    CONSTRAINT chk_preco_unitario CHECK (preco_unitario >= 0),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE notificacoes (
    id_notificacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_pedido INT NULL,
    titulo VARCHAR(120) NOT NULL,
    mensagem VARCHAR(255) NOT NULL,
    lida BOOLEAN NOT NULL DEFAULT FALSE,
    criada_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notificacao_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_notificacao_pedido FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE INDEX idx_produtos_nome ON produtos(nome);
CREATE INDEX idx_pedidos_status ON pedidos(status_pedido);
CREATE INDEX idx_pedidos_usuario ON pedidos(id_usuario);

INSERT INTO usuarios (nome,email,senha,telefone,tipo_usuario) VALUES
('Maria Silva','maria@email.com','senha_hash_001','11999990001','CLIENTE'),
('João Santos','joao@email.com','senha_hash_002','11999990002','CLIENTE'),
('Ana Oliveira','ana@email.com','senha_hash_003','11999990003','CLIENTE'),
('Administrador FoodFlow','admin@foodflow.com','senha_hash_admin','11999990000','ADMIN');

INSERT INTO categorias (nome,descricao) VALUES
('Hambúrgueres','Hambúrgueres artesanais e tradicionais'),
('Pizzas','Pizzas de diferentes sabores'),
('Bebidas','Refrigerantes, sucos e outras bebidas'),
('Sobremesas','Doces e sobremesas');

INSERT INTO produtos (id_categoria,nome,descricao,preco,disponivel) VALUES
(1,'X-Burger','Pão, hambúrguer, queijo e molho especial',22.90,TRUE),
(1,'X-Salada','Pão, hambúrguer, queijo, alface e tomate',25.90,TRUE),
(2,'Pizza Calabresa','Pizza de calabresa com queijo e cebola',42.90,TRUE),
(2,'Pizza Frango com Catupiry','Pizza de frango com catupiry',45.90,TRUE),
(3,'Refrigerante Lata','Refrigerante lata 350 ml',6.00,TRUE),
(3,'Suco Natural','Suco natural de frutas',8.50,TRUE),
(4,'Brownie','Brownie de chocolate',10.00,TRUE),
(4,'Pudim','Pudim de leite condensado',9.50,TRUE);

INSERT INTO pedidos (id_usuario,status_pedido,valor_total,observacao) VALUES
(1,'CONFIRMADO',34.90,'Sem cebola'),
(2,'EM_PREPARO',51.90,NULL),
(3,'ENTREGUE',48.90,'Entregar na portaria');

INSERT INTO itens_pedido (id_pedido,id_produto,quantidade,preco_unitario) VALUES
(1,1,1,22.90),(1,5,2,6.00),
(2,3,1,42.90),(2,5,1,6.00),(2,7,1,10.00),
(3,2,1,25.90),(3,6,1,8.50),(3,7,1,10.00),(3,5,1,6.00);

INSERT INTO notificacoes (id_usuario,id_pedido,titulo,mensagem,lida) VALUES
(1,1,'Pedido confirmado','Seu pedido foi confirmado pelo restaurante.',FALSE),
(2,2,'Pedido em preparo','Seu pedido está sendo preparado.',FALSE),
(3,3,'Pedido entregue','Seu pedido foi entregue. Obrigado pela preferência!',TRUE);

CREATE VIEW vw_resumo_pedidos AS
SELECT p.id_pedido,u.nome AS cliente,p.status_pedido,p.valor_total,p.criado_em
FROM pedidos p INNER JOIN usuarios u ON p.id_usuario=u.id_usuario;

-- SELECT com WHERE
SELECT id_produto,nome,preco FROM produtos WHERE disponivel=TRUE;

-- ORDER BY
SELECT nome,preco FROM produtos ORDER BY preco DESC;

-- Agregação
SELECT COUNT(*) AS quantidade_produtos, AVG(preco) AS preco_medio, SUM(preco) AS soma_precos
FROM produtos;

-- GROUP BY
SELECT c.nome AS categoria, COUNT(p.id_produto) AS quantidade_produtos
FROM categorias c LEFT JOIN produtos p ON c.id_categoria=p.id_categoria
GROUP BY c.id_categoria,c.nome ORDER BY quantidade_produtos DESC;

-- INNER JOIN
SELECT p.id_pedido,u.nome AS cliente,p.status_pedido,p.valor_total
FROM pedidos p INNER JOIN usuarios u ON p.id_usuario=u.id_usuario
ORDER BY p.criado_em DESC;

-- JOIN completo dos itens
SELECT p.id_pedido,u.nome AS cliente,pr.nome AS produto,i.quantidade,
       i.preco_unitario,(i.quantidade*i.preco_unitario) AS subtotal
FROM itens_pedido i
INNER JOIN pedidos p ON i.id_pedido=p.id_pedido
INNER JOIN usuarios u ON p.id_usuario=u.id_usuario
INNER JOIN produtos pr ON i.id_produto=pr.id_produto
ORDER BY p.id_pedido;

-- LEFT JOIN
SELECT c.nome AS categoria,p.nome AS produto
FROM categorias c LEFT JOIN produtos p ON c.id_categoria=p.id_categoria
ORDER BY c.nome,p.nome;

-- UPDATE
UPDATE produtos SET disponivel=FALSE WHERE id_produto=8;
SELECT id_produto,nome,disponivel FROM produtos WHERE id_produto=8;

-- DELETE demonstrativo
INSERT INTO categorias (nome,descricao)
VALUES ('Categoria Teste','Registro utilizado para demonstrar DELETE');
DELETE FROM categorias WHERE nome='Categoria Teste';

-- VIEW
SELECT * FROM vw_resumo_pedidos;
