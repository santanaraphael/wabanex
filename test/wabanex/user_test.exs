defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Raphael", email: "rapha@foo.com", password: "foobar"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "rapha@foo.com", name: "Raphael", password: "foobar"},
               errors: []
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{name: "v"}

      response = User.changeset(params)

      assert errors_on(response) == %{
               email: ["can't be blank"],
               name: ["should be at least 2 character(s)"],
               password: ["can't be blank"]
             }
    end
  end
end
