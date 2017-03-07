defmodule Etlicus.TwitterControllerTest do
  use Etlicus.ConnCase

  alias Etlicus.Twitter
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, twitter_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    twitter = Repo.insert! %Twitter{}
    conn = get conn, twitter_path(conn, :show, twitter)
    assert json_response(conn, 200)["data"] == %{"id" => twitter.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, twitter_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, twitter_path(conn, :create), twitter: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Twitter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, twitter_path(conn, :create), twitter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    twitter = Repo.insert! %Twitter{}
    conn = put conn, twitter_path(conn, :update, twitter), twitter: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Twitter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    twitter = Repo.insert! %Twitter{}
    conn = put conn, twitter_path(conn, :update, twitter), twitter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    twitter = Repo.insert! %Twitter{}
    conn = delete conn, twitter_path(conn, :delete, twitter)
    assert response(conn, 204)
    refute Repo.get(Twitter, twitter.id)
  end
end
