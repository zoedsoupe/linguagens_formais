defmodule LinguagensFormais.DFA do
  @doc """
  Esse DFA reconhece cadeias que possuam
  número ímpar de números 1

  ex: 1000 -> aceito
      1010 -> não aceito
      1110 -> aceito
  """

  alias LinguagensFormais.Menu
  alias LinguagensFormais.DFA

  @enforce_keys [:cadeia_atual, :estado]
  defstruct [:cadeia_atual, :cadeia, estado: 0]

  @estados_aceitacao [1]

  def inicia() do
    # pegamos a cadeia do stdin
    cadeia = IO.gets("\ncadeia> ")
    
    # remove todos as quebras de linha
    # e cria uma tupla com o elemento e seu indice na lista
    cadeia_e_posicao =
      cadeia
      |> String.replace("\n", "")
      |> String.split("", trim: true)
      |> Enum.with_index()

    # devolve um novo DFA
    %DFA{cadeia_atual: cadeia_e_posicao, cadeia: cadeia, estado: 0}
  end

  @doc """
  Método principal!
  Primeiro ele imprime a configuração instantânea
  e depois chama as funções delta para
  executar as transições
  """
  def executa(dfa) do
    [{atual, posicao_atual} | _resto] = dfa.cadeia_atual

    imprimeCI(dfa.cadeia, dfa.estado, posicao_atual)
    transicao(atual, dfa.estado, dfa)
    Menu.main()
  end

  defp transicao(_, _, %DFA{cadeia_atual: []} = dfa) do
    estado_final = dfa.estado
    aceita = Enum.find(@estados_aceitacao, &(&1 == estado_final))

    case aceita do
      nil -> IO.puts("Rejeita!")
      _ -> IO.puts("Aceita!")
    end
  end

  defp transicao("0", 0, dfa) do
    [{atual, posicao_atual} | resto] = dfa.cadeia_atual

    dfa = %{dfa | cadeia_atual: resto}

    imprimeCI(dfa.cadeia, dfa.estado, posicao_atual)
    transicao(atual, dfa.estado, dfa)
  end

  defp transicao("1", 0, dfa) do
    [{atual, posicao_atual} | resto] = dfa.cadeia_atual

    dfa = %DFA{cadeia_atual: resto, estado: 1, cadeia: dfa.cadeia}

    imprimeCI(dfa.cadeia, dfa.estado, posicao_atual)
    transicao(atual, dfa.estado, dfa)
  end

  defp transicao("0", 1, dfa) do
    [{atual, posicao_atual} | resto] = dfa.cadeia_atual

    dfa = %{dfa | cadeia_atual: resto}

    imprimeCI(dfa.cadeia, dfa.estado, posicao_atual)
    transicao(atual, dfa.estado, dfa)
  end

  defp transicao("1", 1, dfa) do
    [{atual, posicao_atual} | resto] = dfa.cadeia_atual

    dfa = %DFA{cadeia_atual: resto, estado: 0, cadeia: dfa.cadeia}

    imprimeCI(dfa.cadeia, dfa.estado, posicao_atual)
    transicao(atual, dfa.estado, dfa)
  end

  # Imprime a configuração instantânea da cadeia
  #
  # ex: 10 -> [q0]10
  #           1[q1]0
  #           10[q1]
  defp imprimeCI(cadeia, estado, posicao) do
    if posicao > 0 do
      tamanho = cadeia |> String.replace("\n", "") |> String.length()

      IO.write(
        "#{String.slice(cadeia, 0..posicao)}[q#{estado}]#{String.slice(cadeia, posicao..tamanho)}"
      )
    else
      IO.write("[q#{estado}]#{cadeia}")
    end
  end
end
