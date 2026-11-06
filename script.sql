create database loja_gamer;
use loja_gamer;
-- 1. Tabelas Independentes (Sem chaves estrangeiras)

CREATE TABLE pessoa (
    id_pessoa INTEGER NOT NULL,
    nome_pessoa VARCHAR(100) NOT NULL,
    tipo_pessoa VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_pessoa)
);

CREATE TABLE categoria (
    id_categoria INTEGER NOT NULL,
    nome_categoria VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE marca (
    id_marca INTEGER NOT NULL,
    nome_marca VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_marca)
);

-- 2. Tabelas dependentes de 'pessoa' (Especializações PFK e Tabelas Relacionadas)

CREATE TABLE cliente (
    id_cliente INTEGER NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_cadastro DATE NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cliente) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE fornecedor (
    id_fornecedor INTEGER NOT NULL,
    cnpj VARCHAR(14) NOT NULL,
    razao_social VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_fornecedor),
    FOREIGN KEY (id_fornecedor) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE contato (
    id_contato INTEGER NOT NULL,
    telefone VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    id_pessoa INTEGER NOT NULL,
    PRIMARY KEY (id_contato),
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE endereco (
    id_endereco INTEGER NOT NULL,
    rua VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    complemento VARCHAR(100) NOT NULL,
    id_pessoa INTEGER NOT NULL,
    PRIMARY KEY (id_endereco),
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
);

-- 3. Produto e dependentes (Relaciona com categoria, marca e fornecedor)

CREATE TABLE produto (
    id_produto INTEGER NOT NULL,
    nome_produto VARCHAR(100) NOT NULL,
    preco DOUBLE NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    id_marca INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL,
    PRIMARY KEY (id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE estoque (
    id_produto_estoque INTEGER NOT NULL,
    qtd_disponivel INTEGER NOT NULL,
    PRIMARY KEY (id_produto_estoque),
    FOREIGN KEY (id_produto_estoque) REFERENCES produto(id_produto)
);

-- 4. Pedido e dependentes 

CREATE TABLE pedido (
    id_pedido INTEGER NOT NULL,
    data_pedido DATE NOT NULL,
    status_pedido VARCHAR(50) NOT NULL,
    valor_total DOUBLE NOT NULL,
    id_cliente INTEGER NOT NULL,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE pagamento (
    id_pagamento INTEGER NOT NULL,
    forma_pagamento VARCHAR(100) NOT NULL,
    status_pagamento VARCHAR(50) NOT NULL,
    valor_pago DOUBLE NOT NULL,
    data_pagamento DATE NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_pagamento),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

CREATE TABLE entrega (
    id_entrega INTEGER NOT NULL,
    transportadora VARCHAR(100) NOT NULL,
    codigo_rastreio VARCHAR(15) NOT NULL,
    status_entrega VARCHAR(50) NOT NULL,
    data_envio DATE NOT NULL,
    data_entrega DATE NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_entrega),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- 5. Relacionamento N:M entre Pedido e Produto

CREATE TABLE item_pedido (
    id_produto INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unit DOUBLE NOT NULL,
    PRIMARY KEY (id_produto, id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- 1. Tabelas de Domínio (Sem Chaves Estrangeiras)
INSERT INTO categoria (id_categoria, nome_categoria) VALUES 
(1, 'Eletrônicos'),
(2, 'Informática'),
(3, 'Eletrodomésticos'),
(4, 'Telefonia'),
(5, 'Games');

INSERT INTO marca (id_marca, nome_marca) VALUES 
(1, 'Samsung'),
(2, 'Dell'),
(3, 'LG'),
(4, 'Apple'),
(5, 'Sony');

-- 2. Tabela Pessoa (10 registros: 1 ao 5 serão Clientes, 6 ao 10 serão Fornecedores)
INSERT INTO pessoa (id_pessoa, nome_pessoa, tipo_pessoa) VALUES 
(1, 'Ana Clara Silva', 'Cliente'),
(2, 'João Pedro Souza', 'Cliente'),
(3, 'Marcos Oliveira', 'Cliente'),
(4, 'Fernanda Costa', 'Cliente'),
(5, 'Lucas Mendes', 'Cliente'),
(6, 'GigaByte Distribuidora', 'Fornecedor'),
(7, 'TechMax Comércio', 'Fornecedor'),
(8, 'Eletro Sul S.A.', 'Fornecedor'),
(9, 'Mundo Digital', 'Fornecedor'),
(10, 'Importadora Alpha', 'Fornecedor');

-- 3. Tabelas Dependentes de Pessoa
INSERT INTO cliente (id_cliente, cpf, data_cadastro) VALUES 
(1, '11122233344', '2023-01-10'),
(2, '22233344455', '2023-02-15'),
(3, '33344455566', '2023-03-20'),
(4, '44455566677', '2023-04-25'),
(5, '55566677788', '2023-05-30');

INSERT INTO fornecedor (id_fornecedor, cnpj, razao_social) VALUES 
(6, '12345678000199', 'GigaByte Distribuidora Ltda'),
(7, '98765432000188', 'TechMax Comércio de Eletrônicos'),
(8, '11222333000177', 'Eletro Sul S.A.'),
(9, '44555666000155', 'Mundo Digital Suprimentos'),
(10, '77888999000144', 'Importadora Alpha Brasil');

INSERT INTO contato (id_contato, telefone, email, id_pessoa) VALUES 
(1, '34999991111', 'ana@email.com', 1),
(2, '34988882222', 'joao@email.com', 2),
(3, '1133334444', 'vendas@gigabyte.com', 6),
(4, '1144445555', 'contato@techmax.com', 7),
(5, '31977778888', 'fernanda@email.com', 4);

INSERT INTO endereco (id_endereco, rua, bairro, estado, numero, cidade, cep, complemento, id_pessoa) VALUES 
(1, 'Rua A', 'Centro', 'MG', '100', 'Patrocínio', '38740000', 'Casa', 1),
(2, 'Rua B', 'Boa Vista', 'MG', '200', 'Patrocínio', '38740000', 'Apto 12', 2),
(3, 'Av. Brasil', 'Industrial', 'SP', '1000', 'São Paulo', '01000000', 'Galpão 1', 6),
(4, 'Av. das Nações', 'Comercial', 'RJ', '500', 'Rio de Janeiro', '20000000', 'Sala 301', 7),
(5, 'Rua C', 'Jardim', 'MG', '300', 'Uberlândia', '38400000', 'Casa 2', 4);

-- 4. Tabela Produto (Usando Fornecedores de 6 a 10, e Categorias/Marcas de 1 a 5)
INSERT INTO produto (id_produto, nome_produto, preco, id_fornecedor, id_marca, id_categoria) VALUES 
(1, 'Smartphone Galaxy S23', 4500.00, 6, 1, 4),
(2, 'Notebook Inspiron', 3500.00, 7, 2, 2),
(3, 'Smart TV 55 4K', 2800.00, 8, 3, 1),
(4, 'iPhone 13', 4200.00, 9, 4, 4),
(5, 'PlayStation 5', 4000.00, 10, 5, 5);

-- 5. Tabela Estoque (Referenciando os 5 produtos)
INSERT INTO estoque (id_produto_estoque, qtd_disponivel) VALUES 
(1, 50),
(2, 30),
(3, 20),
(4, 45),
(5, 15);

-- 6. Tabela Pedido (Feitos pelos Clientes de 1 a 5)
INSERT INTO pedido (id_pedido, data_pedido, status_pedido, valor_total, id_cliente) VALUES 
(1, '2023-10-01', 'Faturado', 4500.00, 1),
(2, '2023-10-02', 'Em Separação', 3500.00, 2),
(3, '2023-10-03', 'Enviado', 2800.00, 3),
(4, '2023-10-04', 'Entregue', 4200.00, 4),
(5, '2023-10-05', 'Aguardando Pagamento', 4000.00, 5);

-- 7. Tabela Item_Pedido (Associando Produtos 1 a 5 aos Pedidos 1 a 5)
INSERT INTO item_pedido (id_produto, id_pedido, quantidade, preco_unit) VALUES 
(1, 1, 1, 4500.00),
(2, 2, 1, 3500.00),
(3, 3, 1, 2800.00),
(4, 4, 1, 4200.00),
(5, 5, 1, 4000.00);

-- 8. Tabela Pagamento (Referente aos Pedidos 1 a 5)
INSERT INTO pagamento (id_pagamento, forma_pagamento, status_pagamento, valor_pago, data_pagamento, id_pedido) VALUES 
(1, 'PIX', 'Aprovado', 4500.00, '2023-10-01', 1),
(2, 'Cartão de Crédito', 'Aprovado', 3500.00, '2023-10-02', 2),
(3, 'Boleto', 'Aprovado', 2800.00, '2023-10-03', 3),
(4, 'PIX', 'Aprovado', 4200.00, '2023-10-04', 4),
(5, 'Cartão de Crédito', 'Pendente', 0.00, '2023-10-05', 5);

-- 9. Tabela Entrega (Referente aos Pedidos 1 a 5)
INSERT INTO entrega (id_entrega, transportadora, codigo_rastreio, status_entrega, data_envio, data_entrega, id_pedido) VALUES 
(1, 'Correios', 'BR111111111BR', 'Em Rota', '2023-10-02', '2023-10-10', 1),
(2, 'Jadlog', 'JD222222222', 'Aguardando Coleta', '2023-10-03', '2023-10-11', 2),
(3, 'Loggi', 'LG333333333', 'Em Trânsito', '2023-10-04', '2023-10-12', 3),
(4, 'Correios', 'BR444444444BR', 'Entregue', '2023-10-05', '2023-10-08', 4),
(5, 'Azul Cargo', 'AZ555555555', 'Pendente', '2023-10-06', '2023-10-14', 5);

CREATE VIEW catalogo_produtos AS
SELECT 
    p.nome_produto AS Produto,
    m.nome_marca AS Marca,
    c.nome_categoria AS Categoria,
    p.preco AS Preco,
    e.qtd_disponivel AS Estoque_Disponivel
FROM produto p
JOIN marca m ON p.id_marca = m.id_marca
JOIN categoria c ON p.id_categoria = c.id_categoria
JOIN estoque e ON p.id_produto = e.id_produto_estoque
WHERE e.qtd_disponivel > 0;

DELIMITER //
CREATE TRIGGER trg_baixa_estoque_venda
AFTER INSERT ON item_pedido
FOR EACH ROW
BEGIN
    UPDATE estoque
    SET qtd_disponivel = qtd_disponivel - NEW.quantidade
    WHERE id_produto_estoque = NEW.id_produto;
END //
DELIMITER ;
