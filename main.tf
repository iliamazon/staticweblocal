resource "azurerm_resource_group" "rgst"{
    location = var.location
    name = var.rgname
}

resource "random_id" "stnamepostfix" {
  byte_length = 3
  keepers ={
    stname = var.stname
  }
}



resource "azurerm_storage_account" "stweb"{
    location = azurerm_resource_group.rgst.location
    resource_group_name = azurerm_resource_group.rgst.name
    name = random_id.stnamepostfix.keepers.stname
    access_tier = "Hot"
    account_kind = "StorageV2"
    account_replication_type = "LRS"
    account_tier = "Standard"

    #network_rules {
    #    default_action = "allow"
     #   #ip_rules =["195.46.18.146"]
    #}

    static_website {
        index_document = "index.html"
    }

    tags ={
        Environment = "Dev"
    }
}

resource "azurerm_storage_container" "stcontainer" {
    name ="$web"
    storage_account_name = azurerm_storage_account.stweb.name
    container_access_type = "public"
    depends_on = [
      azurerm_storage_account.stweb
    ]
    
}

resource "azurerm_storage_blob" "stblob" {
    name = "index.html"
    storage_account_name = azurerm_storage_account.stweb.name
    storage_container_name = azurerm_storage_container.stcontainer.name
    type = "Block"
    content_type           = "text/html"
    source                 = "index.html"
}

resource "azurerm_cdn_profile" "cdnprofile" {
  name                = "stcdnprofile"
  location            = azurerm_resource_group.rgst.location
  resource_group_name = azurerm_resource_group.rgst.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "cdnep" {
  name                = "stcdnep"
  profile_name        = azurerm_cdn_profile.cdnprofile.name
  location            = azurerm_resource_group.rgst.location
  resource_group_name = azurerm_resource_group.rgst.name
  is_http_allowed               = true
  is_https_allowed              = true
  querystring_caching_behaviour = "IgnoreQueryString"
  is_compression_enabled        = true
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "font/eot",
    "font/ttf",
    "font/otf",
    "font/opentype",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/xml",
    "text/x-script",
    "text/x-component",
    "text/x-java-source",
  ]

  origin {
    name      = "myorigin"
    host_name = var.origin_url
  }
}


