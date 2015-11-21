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
    |> validate
  end
  def validates(emails) when is_list(emails) do
    emails
    |> Enum.map(&validate/1)
  end

  defp validate(email) do
    DoesThisEmailWork.ValidationCache.validates(email)
  end
end
