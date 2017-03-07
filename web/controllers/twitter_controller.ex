defmodule Etlicus.TwitterController do
  use Etlicus.Web, :controller

  alias Etlicus.Twitter

  def index(conn, _params) do
    search =  Map.get _params, "search"
    tweets = ExTwitter.search(search, [count: 50])
    json conn, tweets
  end

  def show(conn, %{"url" => url}) do
    response = HTTPotion.get("https://publish.twitter.com/oembed", query: %{url: url})
    json conn, response
  end

end
