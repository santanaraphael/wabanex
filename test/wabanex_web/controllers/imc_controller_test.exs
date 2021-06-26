defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when params are valid return the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      assert response == %{
               "result" => %{
                 "Dani" => 23.437499999999996,
                 "Diego" => 23.04002019946976,
                 "Gabul" => 22.857142857142858,
                 "Rafael" => 24.897060231734173,
                 "Raphael" => 30.52469135802469,
                 "Rodrigo" => 24.691358024691358
               }
             }
    end

    test "when params are invalid return an error", %{conn: conn} do
      params = %{"filename" => "studentss.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      assert response == %{"result" => "Error while opening the file"}
    end
  end
end
