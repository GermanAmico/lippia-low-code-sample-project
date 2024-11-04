Feature: TimeEntry
  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NWVlMTMzMzUtMTZlNS00ZDg0LWEzYTMtNTQyN2QyMTA4NTlj

  @TimeEntriesForUser
  Scenario: Se consultan las horas registradas de un usuario
    Given call User.feature@GetCurrentUserInfo
    And call Workspace.feature@InfoWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200
    * define timeEntryId = $.[0].id
    * define projectId = $.[0].projectId

  @AddTimeEntry @Do
  Scenario: Se agrega una nueva entrada de tiempo
    Given call Workspace.feature@InfoWorkspace
    And call Project.feature@GetAllProjects
    And endpoint /v1/workspaces/{{idworkspace}}/time-entries
    And header Content-Type = application/json
    And body jsons/bodies/AddTimeEntry.json
    When execute method POST
    Then the status code should be 201
    * define timeEntryId = $.id


  @UpdateTimeEntry @Do
  Scenario: Se modifica algun campo de algun registro de hora
    Given call Time.feature@TimeEntriesForUser
    And endpoint /v1/workspaces/{{idworkspace}}/time-entries/{{timeEntryId}}
    And header Content-Type = application/json
    And body jsons/bodies/ModifyTimeEntry.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.description = Descripcion modificada.


  @DeleteTimeEntry @Do
  Scenario: Se elimina una entrada de tiempo cargada
    Given call Time.feature@TimeEntriesForUser
    And endpoint /v1/workspaces/{{idworkspace}}/time-entries/{{timeEntryId}}
    When execute method DELETE
    Then the status code should be 204