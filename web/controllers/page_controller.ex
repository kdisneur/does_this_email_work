defmodule DoesThisEmailWork.PageController do
  use DoesThisEmailWork.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
