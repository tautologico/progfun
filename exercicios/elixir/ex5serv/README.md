# Ex5serv

Projeto com codigo do Exercicio 5 em Elixir. O exercicio consiste em 
implementar um servidor simples que atende a algumas requisicoes. Veja 
os comentarios no arquivo `lib/ex5serv.ex` que deve ser a implementacao
do servidor, e no arquivo `lib/clienteA.ex` que tem um cliente. 

Para testar (manualmente), abra o interpretador IEx com o projeto:

```
iex -S mix
```

Em seguida, crie o processo do servidor chamando a funcao `start` do 
modulo `Ex5serv`:

```elixir
pid = Ex5serv.start()
```

Com o servidor executando, chame a funcao `ClienteA.compra` passando o 
PID do servidor:

```elixir
ClienteA.compra(pid)
```

Observe o codigo do cliente para ver as mensagens que ele envia para o 
servidor.

