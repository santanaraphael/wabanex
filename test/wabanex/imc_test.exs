defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, return the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      assert response ==
               {:ok,
                %{
                  "Dani" => 23.437499999999996,
                  "Diego" => 23.04002019946976,
                  "Gabul" => 22.857142857142858,
                  "Rafael" => 24.897060231734173,
                  "Raphael" => 30.52469135802469,
                  "Rodrigo" => 24.691358024691358
                }}
    end

    test "when the file donesnt exist, return an error" do
      params = %{"filename" => "studentss.csv"}

      response = IMC.calculate(params)

      assert response == {:error, "Error while opening the file"}
    end
  end
end
