resource "aws_key_pair" "my-project-key" {
    key_name = "my-project-key"
    public_key = file(var.PUB_KEY_PATH)
}