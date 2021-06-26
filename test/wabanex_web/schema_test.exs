defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.User.Create

  describe "users queries" do
    test "when the id is valid return the user", %{conn: conn} do
      params = %{name: "Raphael", email: "rapha@foo.com", password: "foobar"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id:"#{user_id}") {
            id
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == %{"data" => %{"getUser" => %{"id" => user_id}}}
    end

    test "when the id is invalid return an error", %{conn: conn} do
      query = """
        {
          getUser(id:"6fdb8f96-1a4b-4723-9995-d61b826baf76") {
            id
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == %{
               "data" => %{"getUser" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "User not found",
                   "path" => ["getUser"]
                 }
               ]
             }
    end
  end

  describe "user mutation" do
    test "when params are valid return the user", %{conn: conn} do
      params = %{name: "Raphael", email: "rapha@foo.com", password: "foobar"}

      query = """
      mutation {
        createUser(input:{
          email:"#{params.email}"
          name:"#{params.name}"
          password:"#{params.password}"
        }) {
          id
          email
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "email" => "rapha@foo.com",
                   "id" => _id,
                   "name" => "Raphael"
                 }
               }
             } = response
    end
  end
end
