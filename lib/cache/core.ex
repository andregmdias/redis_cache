defmodule Cache.Core do
  @redis_conn :redis_server

  def set(value) do
    @redis_conn
    |> Redix.command!(["SET", value.id, Base.encode16(value.values)])
  end

  def get(key) do
    @redis_conn
    |> Redix.command(["GET"], key)
    |> decode()
  end

  defp decode({:ok, nil}), do: {:not_foun, "Key not found"}

  defp decode({:ok, value}) do
    {_, bin} =
      value
      |> Base.decode16!()
      |> :erlang.binary_to_term()

    {:ok, bin}
  end
end
