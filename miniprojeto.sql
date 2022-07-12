CREATE DATABASE sistema_resilia;

USE sistema_resilia;

CREATE TABLE cursos (
	id_cursos INT NOT NULL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(10))
    ENGINE = innodb;

CREATE TABLE turmas (
	id_turmas INT NOT NULL PRIMARY KEY, 
    numero INT NOT NULL,
    nome_turma VARCHAR(100) NOT NULL,
    id_cursos INT NOT NULL)
    ENGINE = innodb;

CREATE TABLE estudantes (
	cpf VARCHAR(11) NOT NULL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    id_turmas INT NOT NULL)
    ENGINE = innodb;

CREATE TABLE entregas (
	cpf VARCHAR(11) NOT NULL,
    link VARCHAR(500) NOT NULL,
    modulo INT NOT NULL,
	situacao VARCHAR(200))
    ENGINE = innodb;
    
ALTER TABLE `turmas` ADD CONSTRAINT `fk_cursos` FOREIGN KEY ( `id_cursos` ) REFERENCES `cursos` ( `id_cursos` );
ALTER TABLE `estudantes` ADD CONSTRAINT `fk_turmas` FOREIGN KEY ( `id_turmas` ) REFERENCES `cursos` ( `id_turmas` );
ALTER TABLE `entregas` ADD CONSTRAINT `fk_estudantes` FOREIGN KEY ( `cpf` ) REFERENCES `estudantes` ( `cpf` );

INSERT INTO `cursos` (
	ID_CURSOS,
    NOME,
    TIPO
) VALUES (
	11111,
    'Web FullStack',
    'Web');

INSERT INTO `entregas` (
	CPF,
    LINK,
    MODULO,
    SITUACAO
) VALUES (
	'11111111111',
    'link-da-atividade.com.br',
    3,
    'Mais que pronto');

INSERT INTO `entregas` (
	CPF,
    LINK,
    MODULO,
    SITUACAO
) VALUES (
	'22222222222',
    'link-da-atividade2.com.br',
    1,
    'Pronto');

INSERT INTO `entregas` (
	CPF,
    LINK,
    MODULO,
    SITUACAO
) VALUES (
	'33333333333',
    'link-da-atividade3.com.br',
    4,
    'Chegando Lá');

SELECT * FROM `cursos`;
SELECT * FROM `turmas`;
SELECT * FROM `estudantes`;
SELECT * FROM `entregas`;
    
ALTER TABLE `estudantes` ADD COLUMN email VARCHAR(150);

/*Saber quem são os alunos que entregaram o projeto do módulo 1 e estão com o conceito em 
“Pronto” ou “Mais que pronto”*/
SELECT nome, situacao
	FROM entregas
    INNER JOIN estudantes 
    ON estudantes.cpf = entregas.cpf
    WHERE situacao = 'Pronto' OR situacao = 'Mais que pronto';
    
/*Consultar quantos alunos temos em cada turma*/
SELECT COUNT(cpf) AS QuantidadeAlunos, turmas.nome_turma FROM estudantes
	INNER JOIN turmas ON estudantes.id_turmas = turmas.id_turmas
    GROUP BY cpf;

/*Quantos projetos no total (entre todas as turmas) foram entregues com conceito “Ainda não está
pronto” e “Chegando lá”*/
SELECT COUNT(situacao) AS ConceitoEntrega 
	FROM entregas
    WHERE entregas.situacao = 'Chegando Lá';
    
/*Qual a turma com a maior quantidade de projetos no “Mais que pronto”*/
SELECT COUNT(estudantes.cpf) AS Qtd_Projetos, turmas.nome_turma FROM estudantes
	INNER JOIN turmas ON estudantes.id_turmas = turmas.id_turmas
    INNER JOIN entregas ON estudantes.cpf = entregas.cpf
    WHERE entregas.situacao = 'Mais que pronto'
    GROUP BY estudantes.cpf;