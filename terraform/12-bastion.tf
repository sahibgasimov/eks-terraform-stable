
// resource "aws_instance" "ec2_example" {
//     ami = "ami-04505e74c0741db8d"  #ubuntu
//     instance_type = "t2.micro" 
//     key_name= "terraform_key"
//     vpc_security_group_ids = [aws_security_group.bastion.id]
//     security_groups = [aws_security_group.bastion.name]
//     tags = {
//     Name  = "bastion-host"
//   }
// }
// resource "aws_security_group" "bastion" {
//     name = "bastion_host"
//   egress = [
//     {
//       cidr_blocks      = [ "0.0.0.0/0", ]
//       description      = ""
//       from_port        = 0
//       ipv6_cidr_blocks = []
//       prefix_list_ids  = []
//       protocol         = "-1"
//       security_groups  = []
//       self             = false
//       to_port          = 0
//     }
//   ]
//  ingress                = [
//    {
//      cidr_blocks      = [ "0.0.0.0/0", ]
//      description      = ""
//      from_port        = 22
//      ipv6_cidr_blocks = []
//      prefix_list_ids  = []
//      protocol         = "tcp"
//      security_groups  = []
//      self             = false
//      to_port          = 22
//   }
//   ]
// }

// resource "aws_key_pair" "terraform_key" {
//   key_name   = "terraform_key"
//   public_key = file("~/.ssh/id_rsa.pub")
// }