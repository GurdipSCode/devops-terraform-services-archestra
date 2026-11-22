
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "teams" {
  description = "Archestra teams to create"
  type        = set(string)
  default     = []
}

variable "mcp_catalog_items" {
  description = "MCP server catalog definitions"

  type = map(object({
    description = string
    command     = string
    arguments   = list(string)
  }))

  default = {}
}

variable "mcp_gateways" {
  description = "MCP gateways"

  type = map(object({
    description = string
    team        = optional(string)
  }))

  default = {}
}

variable "agents" {
  description = "Archestra AI agents"

  type = map(object({
    description   = string
    system_prompt = string
    llm_model     = string
    team          = optional(string)
  }))

  default = {}
}
