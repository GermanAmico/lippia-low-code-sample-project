Feature: Project
  Background:
    And base url https://api.clockify.me/api

  @GetAllProjects
  Scenario: traer todos los projectos
    Given endpoint /v1/workspaces/{{idworkspace}}/projects
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 200
    And response should be $.[1].name = workspace1
    * define idproject = $.[1].id

  @CreateProyecto
  Scenario: Crear project
    Given call Workspace.feature@InfoWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And header Content-Type = application/json
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    And body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 201
    * define idproject = $.id


  @IdFindProject
  Scenario: Buscar proyecto a traves de su id
    Given call Project.feature@CreateProyecto
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 200

  @ModifyProject
  Scenario: modificacion de proyecto
    Given call Project.feature@IdFindProject
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    And header Content-Type = application/json
    And body jsons/bodies/ModifyProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.name = projecto201

  @ProjectNotFound
  Scenario: No encuentra projecto error 404
    Given endpoint /v1/workspaces/{{idworkspace}}/project
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlA
    When execute method GET
    Then the status code should be 404
    And response should be $.[1].name = workspace1


  @BadRequest
  Scenario: Error al crear projecto con mismo nombre
    Given call Workspace.feature@InfoWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And header Content-Type = application/json
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    And body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 400

  @NoAuthorization
  Scenario:
    Given endpoint /v1/workspaces/{{idworkspace}}/projects
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 401
    And response should be $.[1].name = workspace1
    * define idproject = $.[1].id