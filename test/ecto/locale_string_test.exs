defmodule Ecto.LocaleStringTest do
  use ExUnit.Case
  alias Ecto.LocaleString

  test "cast binary" do
    assert LocaleString.cast("Test") == {:ok, %{Application.get_env(:ecto_locale_string, :default_locale) => "Test"}}
  end

  test "cast map" do
    map = %{"en" => "Test", "zh" => "测试"}
    assert LocaleString.cast(map) == {:ok, map}
  end

  test "cast map with atom as key" do
    map = %{en: "Test",zh: "测试"}
    assert LocaleString.cast(map) == {:ok, %{"en" => "Test", "zh" => "测试"}}
  end

  test "dump map" do
    assert LocaleString.dump(%{"en" => "Test"}) == {:ok, %{"en" => "Test"}}
  end

  test "dump map with atom as key" do
    assert LocaleString.dump(%{en: "Test"}) == :error
  end
end
