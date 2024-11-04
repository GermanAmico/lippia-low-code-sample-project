Feature: Workspace
  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj

  @GetAllWorkspace
  Scenario: traer todos los workspace
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    And response should be $.[1].name = workspace1
    * define idworkspace = $.[1].id


  @InfoWorkspace
  Scenario: Buscar informacion de workspace
    Given call Workspace.feature@GetAllWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}
    When execute method GET
    Then the status code should be 200







