defmodule DoesThisEmailWork.Validation.SingleControllerTest do
  use DoesThisEmailWork.ConnCase

  test "POST / with bad email" do
    response =
      post(conn, "/", [validation: [email: "non-existing@domain.tld"]])

    assert 200 == response.status
    assert get_flash(response, :error) != nil
    assert get_flash(response, :success) == nil
  end

  test "POST / with good email" do
    response =
      post(conn, "/", [validation: [email: "kevin@disneur.me"]])

    assert 200 == response.status
    assert get_flash(response, :error) == nil
    assert get_flash(response, :success) != nil
  end
end
