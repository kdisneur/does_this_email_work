defmodule DoesThisEmailWork.Validation.FileController do
  use DoesThisEmailWork.Web, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
