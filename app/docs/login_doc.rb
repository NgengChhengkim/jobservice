module LoginDoc
  extend Apipie::DSL::Concern

  api :POST, "/v1/oauth/token", "User login"

  param :grant_type, String, required: true
  param :email, String, required: true
  param :password, String, required: true

  error 2000, "Email or password is not match"
  error 2001, "Your account has not been activated"
  error 3002, "Missing or invalid parameter"

  meta author: {name: "Yong Sokheng"}
  example <<-EOS
    - Request
    ■ URL: /api/v1/oauth/token
    ■ Method : POST
    Header:
        Content-Type : application/json
    ■ Body :
    {
      "grant_type": "password",
      "email": "user@gmail.com",
      "password": "12345678"
    }

    - Response
    ■ Status : 200
    ■ Body :
    {
      "success": true,
      "data": {
        "user": {
            "email": "user@gmail.com"
        },
        "access_token": {
          "token": "a4ffd4b171e5ace0da58931aa15183036970eeb12bb687852bb745ee5296c240",
          "refresh_token": "c9e3f0d0420c369dbceac7fae2a575d1ea29b86693db2fc7cac0dc95e881644e",
          "expires_in": 7200,
          "created_at": "2017-09-09T15:31:47.000Z",
          "expires_on": "2017-09-09T17:31:47.000Z"
        }
      }
    }
  EOS
  def create
  end
end
