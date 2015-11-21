defmodule DoesThisEmailWork.Validation.SingleController do
  use DoesThisEmailWork.Web, :controller

  def new(conn, _params) do
    render conn, "new.html", email: nil
  end

  def create(conn, %{"validation" => %{"email" => email}}) when is_binary(email) do
    conn
    |> validate_email(email)
    |> render("new.html", email: email)
  end

  defp validate_email(conn, email) do
    case email |> DoesThisEmailWork.Validation.validates do
      {:ok, email} ->
        conn
        |> put_flash(:success, "#{email} is a valid email")
      {:error, email} ->
        conn
        |> put_flash(:error, "#{email} is not a valid email")
    end
  end
end
