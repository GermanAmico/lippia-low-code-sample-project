Feature: Workspace
  Background:
    And base url https://api.clockify.me/api

  @GetAllWorkspace
  Scenario: traer todos los workspace
    Given endpoint /v1/workspaces
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 200
    And response should be $.[1].name = workspace1
    * define idworkspace = $.[1].id


  @InfoWorkspace
  Scenario: Buscar informacion de workspace
    Given call Workspace.feature@GetAllWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 200

  @AddWorkspace
  Scenario: Crear workspace
    Given endpoint /v1/workspaces
    And header Content-Type = application/json
    And body jsons/bodies/AddWorkspace.json
    When execute method POST
    And the status code should be 201
    * define idworkspace = $.id

  @AddClient
  Scenario: Agregar cliente
    Given call Workspace.feature@AddWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/clients
    And header Content-Type = application/json
    And body jsons/bodies/AddClient.json
    When execute method POST
    And the status code should be 201

  @FindClientsOnWorkspace
    Scenario: Encontrar clientes en un workspace
    Given call Workspace.feature@InfoWorksspace
    And endpoint /v1/workspaces/{{idworkspace}}/clients
    When execute method GET
    And the status code should be 200



