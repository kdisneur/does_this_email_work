defmodule DoesThisEmailWork.ValidationCache do
  @moduledoc ~s"""
  Keep a cache of MX and SMTP responses for emails. It allows us to not call
  the same SMTP several times for the same email address. It will speed up
  things and will, maybe, keep us safe from IP blacklisting.
  """

  use GenServer

  @gen_server_name :validation_cache

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: @gen_server_name)
  end

  def validates(email) when is_binary(email) do
    GenServer.call(@gen_server_name, {:validates, email})
  end

  def handle_call({:validates, email}, _from, emails_cache) do
    result =
      emails_cache
      |> validate_from_cache_or_generate(email)

    {:reply, result, Map.put(emails_cache, email, result)}
  end

  defp validate_from_cache_or_generate(emails_cache, email) do
    case emails_cache[email] do
      nil ->
        validate(email)
      cache_result ->
        cache_result
    end
  end

  defp validate(email) do
    case EmailChecker.valid?(email) do
      true ->
        {:ok, email}
      false ->
        {:error, email}
    end
  end
end
