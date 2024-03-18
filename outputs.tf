#output "cdn_endpoint_fqdn" {
#  value = azurerm_cdn_endpoint.cdnep.fqdn
#}
output "stweb_web_endpoint" {
  value = azurerm_storage_account.stweb.primary_web_endpoint
}