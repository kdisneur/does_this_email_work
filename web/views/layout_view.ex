defmodule DoesThisEmailWork.LayoutView do
  use DoesThisEmailWork.Web, :view

  def get_flash_css_type(:error) do
    :alert
  end
  def get_flash_css_type(:success) do
    :success
  end
end
