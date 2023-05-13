output vpc_id_out {
  value       = aws_vpc.main.id
}

output subnet_id_out {
  value       = aws_subnet.sub.id
}

output sg_out {
    value       = aws_security_group.sg.id
}

output rds_sg_out {
  value       = aws_security_group.rds_sg.id
}

output rds_subs_out {
  value       = [aws_subnet.rds_sub.id, aws_subnet.rds_sub2.id]
}