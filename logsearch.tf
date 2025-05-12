data "azurerm_log_analytics_workspace" "live" {
  name                = "LogAnalyticsWorkspace-prod"
  resource_group_name = var.live_rg
}
 
data "azurerm_monitor_action_group" "actgrp" {
  resource_group_name = var.resource_group_name
  name                = "shivesh-test"
}
 
 
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "logsrch" {
  for_each            = var.log_alrt
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
 
  evaluation_frequency = each.value.evaluation_frequency
  window_duration      = each.value.window_duration
  scopes               = [data.azurerm_log_analytics_workspace.live.id]
  severity             = each.value.severity
  criteria {
    query                   = each.value.query
    time_aggregation_method = each.value.time_aggregation_method
    threshold               = each.value.threshold
    operator                = each.value.operator
    metric_measure_column   = each.value.metric_measure_column
    resource_id_column      = each.value.resource_id_column
 
 
    dimension {
      name     = each.value.display_name
      operator = each.value.dimension_operator
      values   = each.value.dimension_value
    }
    # failing_periods {
    #   minimum_failing_periods_to_trigger_alert = each.value.minimum_failing_periods_to_trigger_alert
    #   number_of_evaluation_periods             = each.value.number_of_evaluation_periods
    # }
  }
 
  auto_mitigation_enabled          = true
  workspace_alerts_storage_enabled = false
  description                      = each.value.description
  display_name                     = each.value.display_name
  enabled                          = true
  # query_time_range_override        = each.value.query_time_range_override
  skip_query_validation = true
 
  action {
    action_groups = [data.azurerm_monitor_action_group.actgrp.id]
  }
 
  #   identity {
  #     type = "UserAssigned"
  #     identity_ids = [
  #       azurerm_user_assigned_identity.example.id,
  #     ]
  #   }
  tags = {
    availability-sla                   = "'99'"
    cartesis-code                      = "'sksk'"
    dataclassification-confidentiality = "'restricted'"
    dataclassification-owner-type      = "'bns'"
    dataclassification-pii             = "'no'"
    division                           = "'media'"
    environment                        = "'prd'"
    expiry-action                      = "'review'"
    expiry-date-utc                    = "'2##0-12-##'"
    maintenance-hours-utc              = "'##########'"
    managed-by                         = "'shivesh.so@hash.com'"
    product                            = "'my-product'"
    service-type                       = "'self'"
    technical-owner-email              = "'shivesh.so@hash.com'"
    working-hours-utc                  = "'###############'"
 
  }
 
  #   depends_on = [azurerm_role_assignment.example]
}
