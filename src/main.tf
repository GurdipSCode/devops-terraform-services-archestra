
# --------------------------------------------------
# Teams
# --------------------------------------------------

resource "archestra_team" "this" {
  for_each = var.teams

  name = each.key
}

# --------------------------------------------------
# MCP Registry Catalog
# --------------------------------------------------

resource "archestra_mcp_registry_catalog_item" "this" {
  for_each = var.mcp_catalog_items

  name        = each.key
  description = each.value.description

  local_config = {
    command   = each.value.command
    arguments = each.value.arguments
  }
}

# --------------------------------------------------
# MCP Gateways
# --------------------------------------------------

resource "archestra_mcp_gateway" "this" {
  for_each = var.mcp_gateways

  name        = each.key
  description = each.value.description

  scope = each.value.team == null ? "org" : "team"

  teams = each.value.team == null ? [] : [
    archestra_team.this[each.value.team].id
  ]

  consider_context_untrusted = true

  passthrough_headers = [
    "x-correlation-id"
  ]

  labels = [
    {
      key   = "environment"
      value = var.environment
    },
    {
      key   = "managed-by"
      value = "terraform"
    }
  ]
}

# --------------------------------------------------
# AI Agents
# --------------------------------------------------

resource "archestra_agent" "this" {
  for_each = var.agents

  name          = each.key
  description   = each.value.description
  system_prompt = each.value.system_prompt
  llm_model     = each.value.llm_model

  scope = each.value.team == null ? "org" : "team"

  teams = each.value.team == null ? [] : [
    archestra_team.this[each.value.team].id
  ]

  access_all_tools         = false
  consider_context_untrusted = true

  labels = [
    {
      key   = "environment"
      value = var.environment
    },
    {
      key   = "managed-by"
      value = "terraform"
    }
  ]
}
