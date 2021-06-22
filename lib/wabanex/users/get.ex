defmodule Wabanex.User.Get do
  alias Ecto.UUID
  alias Wabanex.{Repo, User}

  def call(id) do
    case UUID.cast(id) do
      :error ->
        {:error, "Invalid UUID"}

      {:ok, uuid} ->
        case Repo.get(User, uuid) do
          nil -> {:error, "User not found"}
          user -> {:ok, user}
        end
    end
  end
end
