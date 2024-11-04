Feature: Project
  Background:
    And base url https://api.clockify.me/api

  @GetAllProjects
  Scenario: traer todos los projectos
    Given call Workspace.feature@InfoWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id