locals {                          //Para definir variables o constantes del programa que no vienen definidas por algo externo que definiriamos en tfvars
  whitelist_cidr = ["1.1.1.1/32"] //Aqui habria que adecuar la IP a nuestra maquina origen del acceso al bucket
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "Dev"
    Project     = "Terraform-101"
  }
}

resource "aws_s3_object" "bucket_object" {
  bucket       = aws_s3_bucket.example_bucket.id
  key          = "bucket-obj-hello-world"
  source       = "hello-world.html"
  content_type = "text/html"
}

// Ejemplo de Datasource
/*
data "aws_iam_policy_document" "app_iam_policy_document" {
  statement {
    effect = "Allow"  //Permitimos
    actions = [
      "s3:GetObject"  //Obtener del bucket
    ]
    resources = [
      "${aws_s3_bucket.example_bucket.arn}/*"  //ARN identificador de recursos de AWS sobre el cual se aplica la policy 
    ]
    condition {
      variable = "aws:sourceIp"
      test     = "IpAddress"
      values   = local.whitelist_cidr   //Restrict to your IP definida en la variable local
    }
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_iam_policy" "app_iam_policy" {
  name   = "app_iam_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.app_iam_policy_document.json
}
*/