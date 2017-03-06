defmodule Etlicus.AfinnController do
  require Logger
  use Etlicus.Web, :controller

  alias Etlicus.Afinn

  def index(conn, params) do
    text =  Map.get params, "text"
    if (is_nil text) do
      afinn = Repo.all(Afinn)
      render(conn, "index.json", afinn: afinn)
    else
      words = Enum.map String.split(text, "-"), fn(word) -> formatWord(word) end
      wordsScore = Enum.map words, fn(word) -> get_score word end
      wordsFound = Enum.filter wordsScore, fn(word) -> word.score != 0 end
      scoresNumbers = Enum.map wordsFound, fn(word) -> word.score end
      score = Enum.sum scoresNumbers
      comparative = get_comparative score, Enum.count(words)
      json conn, %{
        score: score,
        wordsFound: wordsFound,
        comparative: comparative,
        words: words
      }
    end
  end

  def show(conn, %{"word" => word}) do
    value = get_score word

    render(conn, "show.json", afinn: value)
  end

  def get_score(word) do
    query = from a in "afinn",
          where: a.word == ^word,
          select: [:word, :score]
    queryResult = Repo.all(query)
    if (length queryResult) > 0 do
      hd queryResult
    else
      %{word: word, score: 0}
    end
  end

  def formatWord(word) do
    Regex.replace ~r/\W+/, String.downcase(word), ""
  end

  def get_comparative(score, length) do
    score / length
  end
end
