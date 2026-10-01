# API FoodFlow

## Objetivo

A API do FoodFlow foi planejada para realizar a comunicação entre a interface, o Back End e o banco de dados.

## Endpoints

### POST /usuarios

Cadastra um novo usuário.

Entrada:

```json
{
  "nome": "Nome do usuário",
  "email": "usuario@email.com",
  "senha": "senha"
}
```

Resposta esperada:

```text
201 — Usuário criado
```

### POST /login

Realiza a autenticação do usuário.

Entrada:

```json
{
  "email": "usuario@email.com",
  "senha": "senha"
}
```

Resposta esperada:

```text
200 — Token/sessão
```

### GET /produtos

Retorna a lista de produtos disponíveis.

Resposta esperada:

```text
200 — Lista de produtos
```

### POST /pedidos

Cria um novo pedido.

Entrada:

```json
{
  "usuario": 1,
  "itens": []
}
```

Resposta esperada:

```text
201 — Pedido criado
```

### GET /pedidos/:id

Consulta os detalhes e o status de um pedido.

Resposta esperada:

```text
200 — Detalhes e status do pedido
```

### PUT /pedidos/:id

Atualiza o status de um pedido.

Resposta esperada:

```text
200 — Pedido atualizado
```

### PUT /produtos/:id

Atualiza os dados ou a disponibilidade de um produto.

Resposta esperada:

```text
200 — Produto atualizado
```

### GET /historico/:usuarioId

Consulta o histórico de pedidos de um usuário.

Resposta esperada:

```text
200 — Histórico de pedidos
```

## Autenticação

Os endpoints privados devem exigir autenticação.

O projeto prevê a utilização conceitual de JWT ou outro mecanismo estudado.

## Validação

A API deve validar os dados recebidos antes de executar as operações.

Entre as validações previstas estão:

* Campos obrigatórios
* Tipos dos dados
* Valores
* Disponibilidade dos produtos
* Permissões do usuário
