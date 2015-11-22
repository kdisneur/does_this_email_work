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

  def add(result) do
    GenServer.call(@gen_server_name, {:add, result})
  end

  def fetch(email) when is_binary(email) do
    GenServer.call(@gen_server_name, {:fetch, email})
  end

  def handle_call({:fetch, email}, _from, emails_cache) do
    {:reply, emails_cache[email], emails_cache}
  end

  def handle_call({:add, result={_state, email}}, _from, emails_cache) do
    {:reply, result, Map.put(emails_cache, email, result)}
  end
end
