defmodule Etlicus.PageController do
  use Etlicus.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def tweets(conn, _params) do
    render conn, "tweets.html"
  end
end
