defmodule DoesThisEmailWork.API.ValidationController do
  use DoesThisEmailWork.Web, :controller

  def create(conn, %{"emails" => emails}) when is_list(emails) do
    result =
      emails
      |> DoesThisEmailWork.Validation.validates

    render(conn, result: result)
  end
end
