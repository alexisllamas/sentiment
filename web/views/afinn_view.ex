defmodule Etlicus.AfinnView do
  use Etlicus.Web, :view

  def render("index.json", %{afinn: afinn}) do
    %{data: render_many(afinn, Etlicus.AfinnView, "afinn.json")}
  end

  def render("show.json", %{afinn: afinn}) do
    %{data: render_one(afinn, Etlicus.AfinnView, "afinn.json")}
  end

  def render("afinn.json", %{afinn: afinn}) do
    %{word: afinn.word,
      score: afinn.score}
  end

end
