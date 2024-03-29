resource "azurerm_resource_group" "rgst" {
  location = var.location
  name     = var.rgname
}

#resource "random_uuid" "test" {
#}
resource "random_string" "stnamepostfix" {
  length  = 3
  special = false
  upper   = false
  keepers = {
    stname = var.stname
  }
}



resource "azurerm_storage_account" "stweb" {
  location            = azurerm_resource_group.rgst.location
  resource_group_name = azurerm_resource_group.rgst.name
  name                     = "${var.stname}${random_string.stnamepostfix.result}"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  enable_https_traffic_only     = true
  public_network_access_enabled = true
  
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"

  }

  tags = {
    Environment = "Dev"
  }
}

data "azurerm_storage_container" "stcontainer" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.stweb.name
#  container_access_type = "container"
#  depends_on = [
#    azurerm_storage_account.stweb
#  ]
}


#resource "azurerm_storage_blob" "stblob" {
#  for_each               = fileset("${path.root}/upload/", "**/**/*")
#  name                   = each.key
#  storage_account_name   = azurerm_storage_account.stweb.name
#  storage_container_name = data.azurerm_storage_container.stcontainer.name
#  type                   = "Block"
#  source = "${path.root}/upload/${each.key}"

#    depends_on = [
#    azurerm_storage_account.stweb
#  ]
#}

resource "azurerm_storage_blob" "stblobnew" {
  for_each               = fileset("${path.root}", "*.html")
  name                   = each.key
  storage_account_name   = azurerm_storage_account.stweb.name
  storage_container_name = data.azurerm_storage_container.stcontainer.name
  type                   = "Block"
  content_type           = "text/html"
  source = "${path.root}/upload/${each.key}"
  depends_on = [
    azurerm_storage_account.stweb
  
  ]
}


resource "azurerm_cdn_profile" "cdnprofile" {
  name                = "stcdnprofile"
  location            = azurerm_resource_group.rgst.location
  resource_group_name = azurerm_resource_group.rgst.name
  sku                 = "Standard_Verizon"
}

#resource "azurerm_cdn_endpoint" "cdnep" {
#  name                = "stcdnep"
#  profile_name        = azurerm_cdn_profile.cdnprofile.name
#  location            = azurerm_resource_group.rgst.location
#  resource_group_name = azurerm_resource_group.rgst.name
#  is_http_allowed               = false
#  is_https_allowed              = true
#  querystring_caching_behaviour = "IgnoreQueryString"
#  is_compression_enabled        = true
#  content_types_to_compress = [
#    "application/eot",
#    "application/font",
#    "application/font-sfnt",
#    "application/javascript",
#    "application/json",
#    "application/opentype",
#    "application/otf",
#    "application/pkcs7-mime",
#    "application/truetype",
#    "application/ttf",
#    "application/vnd.ms-fontobject",
#    "application/xhtml+xml",
#    "application/xml",
#    "application/xml+rss",
#    "application/x-font-opentype",
#    "application/x-font-truetype",
#    "application/x-font-ttf",
#    "application/x-httpd-cgi",
#    "application/x-javascript",
#    "application/x-mpegurl",
#    "application/x-opentype",
#    "application/x-otf",
#    "application/x-perl",
#    "application/x-ttf",
#    "font/eot",
#    "font/ttf",
#    "font/otf",
#    "font/opentype",
#    "image/svg+xml",
#    "text/css",
#    "text/csv",
#    "text/html",
#    "text/javascript",
#    "text/js",
#    "text/plain",
#    "text/richtext",
#    "text/tab-separated-values",
#    "text/xml",
#    "text/x-script",
#    "text/x-component",
#    "text/x-java-source",
#  ]

#  origin {
#    name      = "myorigin"
#    host_name = azurerm_storage_account.stweb.primary_web_host

#  }
#}


