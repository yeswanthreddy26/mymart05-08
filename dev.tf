provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "name" {
  ami = "ami-0862be96e41dcbf74"
  instance_type = "t2.medium"
  key_name = "praveen"
  vpc_security_group_ids = [ "sg-0e7783eb3e866cde2" ]
  tags = {
    Name = "dev12"
  }
  
provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt-get upgrade -y",
        "sudo apt install python3-pip -y",
        "sudo apt install python3-venv -y",
        "sudo apt install python3-virtualenv -y",
        "python3 -m venv /home/ubuntu/yeswanth",
        ". /home/ubuntu/yeswanth/bin/activate",
        "git clone https://github.com/yeswanthreddy26/mymart05-08.git",
        "cd mymaer05-08",
        "sud0 apt install openjdk-17-jdk -y",
        "sudo apt install maven -y",
        "pip install spring -y",
        "pip install gradle -y",
        "mvn clean package",
        "java -jar target/MyMart-0.0.1-SNAPSHOT.jar",
        "nohup java -jar target/MyMart-0.0.1-SNAPSHOT.jar > spring_boot.log 2>&1 &"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"  
      private_key = file("praveen.pem")  
      host     = self.public_ip  
    }
 }
}
