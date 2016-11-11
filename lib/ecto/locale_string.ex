defmodule Ecto.LocaleString do
  @moduledoc"""
  Support for locale string type for ecto
  """
  @behaviour Ecto.Type

  def type, do: :locale_string

  @doc """
  Handle casting to
  """
  def cast(input) when is_binary(input) do
    {:ok, %{Application.get_env(:ecto_locale_string, :default_locale, "en") => input}}
  end

  def cast(input) when is_map(input) do
    result = Enum.reduce_while(input, nil, fn
      {key, value}, nil when is_binary(key) and is_binary(value) -> {:cont, nil}
      _, _ -> {:halt, do_cast(input)}
    end) || input
    {:ok, result}
  end

  defp do_cast(input) when is_map(input) do
    Enum.reduce(input, %{}, fn {key, value}, map ->
      Map.put(map, to_string(key), to_string(value))
    end)
  end

  def load(term) do
    {:ok, term}
  end

  @doc """
  Convert to %{string => string} format
  """
  def dump(term) when is_map(term) do
    Enum.reduce(term, nil, fn
      {key, value}, nil when is_binary(key) and is_binary(value) -> nil
      _, _  -> :error
    end) || {:ok, term}
  end
end
