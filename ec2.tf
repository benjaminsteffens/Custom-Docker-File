resource "aws_instance" "bentest" {
  ami           = ""
  instance_type = "t2.micro"

  tags = {
    Name = "pipelinetest"
  }
}