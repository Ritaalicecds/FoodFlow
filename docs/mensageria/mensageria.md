# Mensageria — FoodFlow

## Objetivo

A mensageria é utilizada para representar a comunicação assíncrona entre diferentes serviços do FoodFlow.

## Evento 1 — PedidoCriado

**Produtor:** Serviço de Pedidos

**Fila/Tópico:** `pedidos-criados`

**Consumidores:**

* Serviço de Estoque
* Serviço de Pagamento
* Serviço de Notificações

**Ações:**

* Validar ou reservar disponibilidade dos produtos
* Iniciar processamento do pagamento
* Informar o cliente sobre o pedido

## Evento 2 — PagamentoAprovado

**Produtor:** Serviço de Pagamento

**Consumidores:**

* Serviço de Notificações
* Serviço de Pedidos

**Ação:**

Atualizar o fluxo do pedido e informar o cliente.

## Evento 3 — PedidoPronto

**Produtor:** Serviço responsável pela preparação do pedido

**Consumidor:** Serviço de Notificações

**Ação:**

Informar ao cliente que o pedido está pronto.

## Tecnologia escolhida

A tecnologia considerada para a arquitetura é o RabbitMQ.

A escolha é conceitual e representa o modelo:

```text
Produtor
   ↓
Fila
   ↓
Consumidor
   ↓
Ação
```

O RabbitMQ permite representar de forma clara a comunicação assíncrona entre os serviços do FoodFlow.
