defmodule Constitution.Find do
  @original_path "data/original/"
  @amendment_path "data/amendment/"

  def amendment_path(number) do
    @amendment_path <> "amendment-#{number}.txt"
  end

  def article_path(number) do
    @original_path <> "article-#{String.downcase(number)}.txt"
  end

  def clean_tags(nil), do: nil
  def clean_tags(text) do
    Regex.replace(~r/{{ .+ }}/, text, "", global: true)
    |> String.replace("\n\n\n\n", "\n\n", global: true)
    |> String.replace("\nSECTION", "SECTION", global: true)
  end

  def part(file, tag_name) do
    ~r/{{ BEGIN #{tag_name} }}\n(.+)\n{{ END #{tag_name} }}/s
    |> Regex.run(File.read!(file))
    |> clean_part
  end

  def clean_part(nil) do
    ""
  end

  def clean_part(selection) do
    selection
    |> Enum.at(1)
    |> clean_tags
  end
end
