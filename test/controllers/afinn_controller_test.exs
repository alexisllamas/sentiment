defmodule Etlicus.AfinnControllerTest do
  use Etlicus.ConnCase

  alias Etlicus.Afinn
  @valid_attrs %{score: 42, word: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, afinn_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    afinn = Repo.insert! %Afinn{}
    conn = get conn, afinn_path(conn, :show, afinn)
    assert json_response(conn, 200)["data"] == %{"id" => afinn.id,
      "word" => afinn.word,
      "score" => afinn.score}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, afinn_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, afinn_path(conn, :create), afinn: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Afinn, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, afinn_path(conn, :create), afinn: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    afinn = Repo.insert! %Afinn{}
    conn = put conn, afinn_path(conn, :update, afinn), afinn: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Afinn, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    afinn = Repo.insert! %Afinn{}
    conn = put conn, afinn_path(conn, :update, afinn), afinn: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    afinn = Repo.insert! %Afinn{}
    conn = delete conn, afinn_path(conn, :delete, afinn)
    assert response(conn, 204)
    refute Repo.get(Afinn, afinn.id)
  end
end
