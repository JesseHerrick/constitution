defmodule FindTest do
  use ExUnit.Case
  doctest Constitution

  alias Constitution.Find

  test "Find.article returns the full article" do
    article_i_path = "test/fixtures/article-i-full.txt"
    assert Constitution.Find.article("I") == File.read!(article_i_path) <> "\n\n"
  end

  test "Find.article_path returns the path to the proper article" do
    assert Constitution.Find.article_path("I") == "data/original/article-i.txt"
  end

  test "Find.find_part returns the specified part" do
    assert Find.find_part(Find.article_path("I"), "Section_1") == "SECTION 1\n\nAll legislative Powers herein granted shall be vested in a Congress of the United States, which shall consist of a Senate and House of Representatives.\n"
  end

  test "Find.clean_tags cleans all tags from text" do
    result = Find.clean_tags("{{ BEGIN Section_1 }}\n{{ BEGIN Section_1_Clause_3 }}\nInner\n{{ END Section_1_Clause_3 }}\n{{ END Section_1 }}")
    expected = "\n\nInner\n\n"
    assert result == expected
  end
end
