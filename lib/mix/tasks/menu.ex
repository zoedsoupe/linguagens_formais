defmodule Mix.Tasks.Menu do
  use Mix.Task

  def run(_) do
    LinguagensFormais.Menu.main()
  end
end
