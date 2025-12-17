terraform {
  required_version = ">= 1.6.0"

  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.16"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "web1" {
  name  = "web1"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 8081
  }
}

resource "docker_container" "web2" {
  name  = "web2"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 8082
  }
}

output "web1_ip" {
  value = docker_container.web1.ip_address
}

output "web2_ip" {
  value = docker_container.web2.ip_address
}
