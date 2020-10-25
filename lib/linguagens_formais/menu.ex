defmodule LinguagensFormais.Menu do
  alias LinguagensFormais.DFA
  alias LinguagensFormais.NFA
  alias LinguagensFormais.ENFA

  @prompt "LFs> "

  def main() do
    IO.puts("\nQual tipo de automato você quer testar?")
    IO.puts("1 - DFA")
    IO.puts("2 - NFA")
    IO.puts("3 - E-NFA")
    IO.puts("0 - Sair")
    IO.puts("")
    opcao = IO.gets(@prompt)
    IO.puts("")

    case String.trim(opcao, "\n") do
      "1" ->
        DFA.inicia() |> DFA.executa()

      "2" ->
        NFA.inicia() |> NFA.executa()

      "3" ->
        ENFA.inicia() |> ENFA.executa()

      "0" ->
        System.stop(0)

      _ ->
        IO.puts("Opção inválida!")
        main()
    end
  end
end
