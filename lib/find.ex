defmodule Constitution.Find do
  @original_path "data/original/"
  @amendment_path "data/original/"

  def article(number) do
    "ARTICLE #{number}\n\n" <> File.read!(article_path(number))
    |> clean_tags
  end

  def clean_tags(text) do
    Regex.replace(~r/{{ .+ }}/, text, "", global: true)
    |> String.replace("\n\n\n\n", "\n\n", global: true)
    |> String.replace("\nSECTION", "SECTION", global: true)
  end

  def section(number) do
  end

  def article_path(number) do
    @original_path <> "article-#{String.downcase(number)}.txt"
  end

  def find_part(file, tag_name) do
    ~r/{{ BEGIN #{tag_name} }}\n(.+)\n{{ END #{tag_name} }}/s
    |> Regex.run(File.read!(file))
    |> Enum.at(1)
    |> clean_tags
  end
end
