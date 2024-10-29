Feature: User
  Background:
    And base url https://api.clockify.me/api

  @GetCurrentUserInfo
  Scenario: Buscar informacion del usuario actual
    Given endpoint /v1/user
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 200
    * define userId = $.id