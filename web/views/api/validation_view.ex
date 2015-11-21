defmodule DoesThisEmailWork.API.ValidationView do
  use DoesThisEmailWork.Web, :view

  def render("create.json", %{result: result}) do
    result
    |> Enum.map(fn ({status, email}) -> %{ valid: status == :ok, email: email } end)
  end
end
