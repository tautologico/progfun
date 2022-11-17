defmodule ClienteA do
  def compra(serv_pid) do
    # compra 10 unidades de cafe
    compra_cafe(serv_pid, 10)
    processa_resposta_compra()

    # compra 12 unidades de cha
    compra_cha(serv_pid, 12)
    processa_resposta_compra()

    # reporta quantidades que restaram
    ncafe = consulta_cafe(serv_pid)
    ncha = consulta_cha(serv_pid)
    IO.puts "Sobraram #{ncafe} pacotes de cafe e #{ncha} pacotes de cha"
  end

  def compra_cafe(servidor, unidades) do
    IO.puts "Tentando comprar #{unidades} pacotes de cafe..."
    send servidor, { self(), :compra_cafe, unidades }
  end

  def compra_cha(servidor, unidades) do
    IO.puts "Tentando comprar #{unidades} pacotes de cha..."
    send servidor, { self(), :compra_cha, unidades }
  end

  def processa_resposta_compra do
    receive do
      { :ok, n } -> IO.puts "Ok, comprou #{n} unidades."
      { :semestoque, n } -> IO.puts "Estoque insuficiente, comprou #{n} unidades."
    end
  end

  def consulta_cafe(servidor) do
    send servidor, { self(), :quant_cafe }
    receive do
      { :ok, n } -> n
    end
  end

  def consulta_cha(servidor) do
    send servidor, { self(), :quant_cha }
    receive do
      { :ok, n } -> n
    end
  end
end
