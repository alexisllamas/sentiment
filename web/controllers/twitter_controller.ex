defmodule Etlicus.TwitterController do
  use Etlicus.Web, :controller

  alias Etlicus.Twitter

  def index(conn, _params) do
    search =  Map.get _params, "search"
    tweets = ExTwitter.search(search, [count: 3])
    json conn, tweets
  end

  def show(conn, %{"url" => search}) do
    json conn, []
  end

  def sendTwitts(twits) do
    render([], "index.json", twitter: twits)
  end

end
