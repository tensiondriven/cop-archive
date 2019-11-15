defmodule Mix.Tasks.Render do
  use Mix.Task

  @shortdoc "Render content to files."
  def run(_) do
    # calling our Hello.say() function from earlier
    IO.puts("hello")
  end
end
