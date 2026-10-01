# FoodFlow

## Sistema Mobile de Pedidos para Restaurantes

Projeto desenvolvido para o Projeto Tech 360, do 3º ano do Ensino Médio — Técnico em Desenvolvimento de Sistemas.

O FoodFlow é uma solução digital voltada para pequenos restaurantes que recebem pedidos principalmente por telefone ou aplicativos de mensagens. A proposta é centralizar o processo de pedidos, permitindo consultar o cardápio, selecionar produtos, criar pedidos, acompanhar seu status e receber notificações.

## Problema

Pequenos restaurantes podem enfrentar dificuldades para organizar pedidos recebidos por diferentes canais, acompanhar o andamento das solicitações, controlar a disponibilidade dos produtos e manter os clientes informados.

O FoodFlow propõe centralizar essas informações em uma solução digital.

## Objetivo

Desenvolver e documentar uma solução digital para organizar o processo de pedidos de pequenos restaurantes, integrando banco de dados, API, Back End, interface e arquitetura orientada a eventos.

## Integrantes

* Rita Alice Cavalcanti dos Santos
* Isadora Nascimento Queiroz Silva
* Luigi Pereira Silva de Almeida
* Giulia Rodrigues Lutfi
* Cauã Alonso Cinquini

## Funcionalidades previstas

* Cadastro de usuários
* Login e autenticação
* Consulta do cardápio
* Consulta de categorias e produtos
* Criação de pedidos
* Consulta de detalhes do pedido
* Atualização do status do pedido
* Controle da disponibilidade dos produtos
* Histórico de pedidos
* Notificações
* Integração conceitual com serviço de pagamento

## Tecnologias e ferramentas

### Banco de dados

* MySQL
* SQL

### Back End

* API REST
* Arquitetura de Back End planejada
* [Framework escolhido pelo grupo]

### Interface

O protótipo das telas foi desenvolvido no Canva. Nesta versão do projeto, não foi desenvolvida uma aplicação mobile funcional.

### Versionamento

* Git
* GitHub

### Mensageria

A arquitetura de mensageria utiliza o RabbitMQ como referência conceitual para representar a comunicação assíncrona entre os serviços.

## Banco de dados

O banco de dados utiliza MySQL e foi estruturado para armazenar usuários, categorias, produtos, pedidos, itens de pedidos e notificações.

O script SQL completo está disponível em:

`/banco/FoodFlow_banco.sql`

Principais tabelas:

* `usuarios`
* `categorias`
* `produtos`
* `pedidos`
* `itens_pedido`
* `notificacoes`

O banco também possui relacionamentos por chaves estrangeiras, índices e uma VIEW para resumo dos pedidos.

## API

A API foi projetada para realizar a comunicação entre a interface e o Back End.

Principais endpoints definidos:

| Método | Endpoint                | Função              |
| ------ | ----------------------- | ------------------- |
| POST   | `/usuarios`             | Cadastrar usuário   |
| POST   | `/login`                | Realizar login      |
| GET    | `/produtos`             | Listar produtos     |
| POST   | `/pedidos`              | Criar pedido        |
| GET    | `/pedidos/:id`          | Consultar pedido    |
| PUT    | `/pedidos/:id`          | Atualizar pedido    |
| PUT    | `/produtos/:id`         | Atualizar produto   |
| GET    | `/historico/:usuarioId` | Consultar histórico |

## Interface / Mobile

O projeto possui um protótipo visual das telas desenvolvido no Canva.

O fluxo principal planejado é:

LOGIN → INÍCIO → CARDÁPIO → DETALHES → CARRINHO → CONFIRMAÇÃO → PEDIDO → ACOMPANHAMENTO → HISTÓRICO

O protótipo representa a interface proposta para o sistema, mas não corresponde a uma aplicação mobile funcional nesta versão.

## Mensageria

O principal evento de negócio é:

`PedidoCriado`

Fluxo:

PedidoCriado → Serviço de Pedidos → fila `pedidos-criados` → Estoque / Pagamento / Notificações

Também foram definidos os eventos:

* `PedidoCriado`
* `PagamentoAprovado`
* `PedidoPronto`

A documentação completa está em `/docs/mensageria.md`.

## Segurança

A solução prevê:

* Autenticação
* Autorização
* HTTPS em ambiente de produção
* Validação de dados
* Hash de senhas
* CORS
* Variáveis de ambiente para credenciais
* Backup e recuperação dos dados

## Versionamento

O projeto utiliza Git e GitHub para controle de versões.

Estratégia de branches:

* `main` — versão estável
* `develop` — desenvolvimento
* `feature/banco-dados`
* `feature/backend`
* `feature/mobile`
* `feature/mensageria`

Os integrantes devem possuir participação identificável no histórico de commits.

O projeto também utiliza Pull Requests e Code Reviews.

## Versão

Versão atual:

**v1.0.0**

## Estrutura do repositório

```text
FoodFlow/
├── README.md
├── CHANGELOG.md
├── .gitignore
├── banco/
│   └── FoodFlow_banco.sql
├── docs/
│   ├── arquitetura.md
│   ├── api.md
│   ├── mensageria.md
│   └── testes.md
└── mobile/
    └── README.md
```

## Finalidade

Este projeto foi desenvolvido para fins acadêmicos como parte do Projeto Tech 360 — Trabalho Multidisciplinar Bimestral.
