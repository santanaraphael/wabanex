defmodule WabanexWeb.Resolvers.Training do
  def create(%{input: params}, _context), do: Wabanex.Training.Create.call(params)
end
