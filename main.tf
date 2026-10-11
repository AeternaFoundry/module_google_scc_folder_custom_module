resource "google_scc_folder_custom_module" "scc_folder_custom_modules" {
  for_each = var.scc_folder_custom_modules

  display_name     = each.value.display_name
  enablement_state = each.value.enablement_state
  folder           = each.value.folder
  deletion_policy  = each.value.deletion_policy

  custom_config {
    dynamic "custom_output" {
      for_each = each.value.custom_config.custom_output != null ? [each.value.custom_config.custom_output] : []
      content {
        dynamic "properties" {
          for_each = custom_output.value.properties != null ? custom_output.value.properties : []
          content {
            name = properties.value.name
            dynamic "value_expression" {
              for_each = properties.value.value_expression != null ? [properties.value.value_expression] : []
              content {
                description = value_expression.value.description
                expression  = value_expression.value.expression
                location    = value_expression.value.location
                title       = value_expression.value.title
              }
            }
          }
        }
      }
    }
    description = each.value.custom_config.description
    predicate {
      description = each.value.custom_config.predicate.description
      expression  = each.value.custom_config.predicate.expression
      location    = each.value.custom_config.predicate.location
      title       = each.value.custom_config.predicate.title
    }
    recommendation = each.value.custom_config.recommendation
    resource_selector {
      resource_types = each.value.custom_config.resource_selector.resource_types
    }
    severity = each.value.custom_config.severity
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

