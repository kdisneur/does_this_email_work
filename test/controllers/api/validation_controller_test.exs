defmodule DoesThisEmailWork.API.ValidationControllerTest do
  use DoesThisEmailWork.ConnCase

  test "POST /api/validation" do
    expected_body =
      Poison.encode!(expected_result_data)
    response =
      post(conn, "/api/validation", [emails: ["non-existing@domain.tld", "kevin@disneur.me"]])

    assert 200 == response.status
    assert expected_body == response.resp_body
  end

  defp expected_result_data do
    [
      %{valid: false, email: "non-existing@domain.tld"},
      %{valid: true, email: "kevin@disneur.me"}
    ]
  end
end
