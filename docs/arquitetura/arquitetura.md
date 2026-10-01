# Arquitetura do FoodFlow

## Visão geral

O FoodFlow foi projetado como uma solução integrada para gerenciamento de pedidos de pequenos restaurantes.

A arquitetura proposta segue o fluxo:

```text
Interface
    ↓
API
    ↓
Back End
    ↓
Banco de Dados
    ↓
Serviços externos
```

A arquitetura também utiliza mensageria para representar eventos de negócio.

## Componentes

### Interface

O projeto possui um protótipo visual desenvolvido no Canva. Ele representa as telas que seriam utilizadas pelo cliente.

Nesta versão, não foi desenvolvida uma aplicação mobile funcional.

### API

A API representa a camada responsável por receber as solicitações da interface e encaminhá-las para o Back End.

### Back End

O Back End seria responsável pelas regras de negócio, autenticação, validação dos dados, acesso ao banco e publicação dos eventos.

### Banco de Dados

O banco utiliza MySQL e armazena informações de usuários, categorias, produtos, pedidos, itens de pedidos e notificações.

### Mensageria

A mensageria representa a comunicação assíncrona entre os serviços.

## Fluxo principal

```text
Cliente
  ↓
Interface
  ↓
API
  ↓
Back End
  ↓
Banco de Dados
  ↓
PedidoCriado
  ↓
Estoque / Pagamento / Notificações
```
