defmodule DoesThisEmailWork.API.ValidationView do
  use DoesThisEmailWork.Web, :view

  def render("create.json", %{result: result}) do
    result
    |> Enum.map(fn ({status, email}) -> %{ status: status, email: email } end)
  end
end
