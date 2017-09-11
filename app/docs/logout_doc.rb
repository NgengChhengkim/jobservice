module LogoutDoc
  extend Apipie::DSL::Concern

  api :POST, "/v1/oauth/revoke", "User logout"

  param :token, String, required: true

  error 2003, "Invalid token"
  error 3002, "Missing or invalid parameter"

  meta author: {name: "Yong Sokheng"}
  example <<-EOS
    - Request
    ■ URL: /api/v1/oauth/revoke
    ■ Method : POST
    Header:
        Content-Type : application/json
    ■ Body :
    {
      "token": "afcf9307b45c759a5a91cf29c3a8c8fb649f93afe19cd487d54759d0d622f371"
    }

    - Response
    ■ Status : 200
    ■ Body :
    {
      "success": true,
      "data": {}
    }

    - Request
    ■ URL: /api/v1/oauth/revoke
    ■ Method : POST
    Header:
        Content-Type : application/json
    ■ Body :
    {
      "token": "afcf9307b45c759a5a91cf29c3a8c8fb649f93afe19cd487d54759d0d622f371"
    }

    - Response
    ■ Status : 400
    ■ Body :
    {
      "success": false,
      "errors": [
        {
          "code": 2003,
          "message": "Invalid token"
        }
      ]
    }

    - Request
    ■ URL: /api/v1/oauth/token
    ■ Method : POST
    Header:
        Content-Type : application/json
    ■ Body :
    {
      "taken": "6a4a922069e4e9cb4a0cd3934ad07b605bf91b5a8b6d85d46b9f33283c4a9ce1"
    }

    - Response
    ■ Status : 400
    ■ Body :
    {
      "success": false,
      "errors": [
        {
          "code": 3002,
          "message": "Missing or invalid parameter"
        }
      ]
    }
  EOS
  def revoke
  end
end
