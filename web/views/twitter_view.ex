defmodule Etlicus.TwitterView do
  use Etlicus.Web, :view

  def render("index.json", %{twitter: twitter}) do
    %{data: render_many(twitter, Etlicus.TwitterView, "twitter.json")}
  end

  def render("show.json", %{twitter: twitter}) do
    %{data: render_one(twitter, Etlicus.TwitterView, "twitter.json")}
  end

  def render("twitter.json", %{twitter: twitter}) do
    %{id: twitter.id}
  end
end
