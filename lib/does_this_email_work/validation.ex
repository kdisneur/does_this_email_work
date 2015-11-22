defmodule DoesThisEmailWork.Validation do
  @moduledoc ~s"""
  This module is used to validate if an email, or a list of emails, are valid.
  It performs many check against:

  * regular expression
  * existence of an MX record for the domain name
  * existence of the email address on the SMTP sever behind the MX record
  """

  @doc ~s"""
  With a single email it will return a tuple containing either `{:ok, <email>}`
  or `{:error, <email>}`. If called with a list, it will return a list of
  tuples following this format.

  ## Examples

      iex> DoesThisEmailWork.Validation.validates("wrong-email@domain.tld")
      {:error, "wrong-email@domain.tld"}
      iex> DoesThisEmailWork.Validation.validates("kevin@disneur.me")
      {:ok, "kevin@disneur.me"}
      iex> DoesThisEmailWork.Validation.validates([
      ...>   "wrong-email@domain.tld",
      ...>   "kevin@disneur.me"
      ...> ])
      [{:error, "wrong-email@domain.tld"}, {:ok, "kevin@disneur.me"}]
  """
  def validates(email) when is_binary(email) do
    email
    |> fetch_or_validate
  end
  def validates(emails) when is_list(emails) do
    emails
    |> Enum.map(&asynchronous_fetch_or_validate/1)
    |> Enum.map(&analyze_validation_reply/1)
  end

  defp analyze_validation_reply({pid, email}) do
    try do
      Task.await(pid, 5_000)
    catch
      :exit, _ ->
        invalid_tuple(email)
    end
  end

  defp asynchronous_fetch_or_validate(email) do
    pid = Task.async(fn -> fetch_or_validate(email) end)

    {pid, email}
  end

  defp fetch_or_validate(email) do
    case DoesThisEmailWork.ValidationCache.fetch(email) do
      nil ->
        email
        |> validate
        |> DoesThisEmailWork.ValidationCache.add
      result ->
        result
    end
  end

  defp invalid_tuple(email) do
    {:error, email}
  end

  defp validate(email) do
    case EmailChecker.valid?(email) do
      true ->
        valid_tuple(email)
      false ->
        invalid_tuple(email)
    end
  end

  defp valid_tuple(email) do
    {:ok, email}
  end
end
