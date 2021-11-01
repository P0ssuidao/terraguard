variable "rules" {
  description = "Standard set of predefined rules"
  type        = map(any)

  # [direction, access, protocol, source_port_range, destination_port_range, description]"
  # The following info are in the submodules: source_address_prefix, destination_address_prefix
  default = {
    #ActiveDirectory
    ActiveDirectory-AllowADReplication          = ["Inbound", "Allow", "*", "*", "389", "AllowADReplication"]
    ActiveDirectory-AllowADReplicationSSL       = ["Inbound", "Allow", "*", "*", "636", "AllowADReplicationSSL"]
    ActiveDirectory-AllowADGCReplication        = ["Inbound", "Allow", "TCP", "*", "3268", "AllowADGCReplication"]
    ActiveDirectory-AllowADGCReplicationSSL     = ["Inbound", "Allow", "TCP", "*", "3269", "AllowADGCReplicationSSL"]
    ActiveDirectory-AllowDNS                    = ["Inbound", "Allow", "*", "*", "53", "AllowDNS"]
    ActiveDirectory-AllowKerberosAuthentication = ["Inbound", "Allow", "*", "*", "88", "AllowKerberosAuthentication"]
    ActiveDirectory-AllowADReplicationTrust     = ["Inbound", "Allow", "*", "*", "445", "AllowADReplicationTrust"]
    ActiveDirectory-AllowSMTPReplication        = ["Inbound", "Allow", "TCP", "*", "25", "AllowSMTPReplication"]
    ActiveDirectory-AllowRPCReplication         = ["Inbound", "Allow", "TCP", "*", "135", "AllowRPCReplication"]
    ActiveDirectory-AllowFileReplication        = ["Inbound", "Allow", "TCP", "*", "5722", "AllowFileReplication"]
    ActiveDirectory-AllowWindowsTime            = ["Inbound", "Allow", "UDP", "*", "123", "AllowWindowsTime"]
    ActiveDirectory-AllowPasswordChangeKerberes = ["Inbound", "Allow", "*", "*", "464", "AllowPasswordChangeKerberes"]
    ActiveDirectory-AllowDFSGroupPolicy         = ["Inbound", "Allow", "UDP", "*", "138", "AllowDFSGroupPolicy"]
    ActiveDirectory-AllowADDSWebServices        = ["Inbound", "Allow", "TCP", "*", "9389", "AllowADDSWebServices"]
    ActiveDirectory-AllowNETBIOSAuthentication  = ["Inbound", "Allow", "UDP", "*", "137", "AllowNETBIOSAuthentication"]
    ActiveDirectory-AllowNETBIOSReplication     = ["Inbound", "Allow", "TCP", "*", "139", "AllowNETBIOSReplication"]

    #Cassandra
    Cassandra = ["Inbound", "Allow", "TCP", "*", "9042", "Cassandra"]

    #Cassandra-JMX
    Cassandra-JMX = ["Inbound", "Allow", "TCP", "*", "7199", "Cassandra-JMX"]

    #Cassandra-Thrift
    Cassandra-Thrift = ["Inbound", "Allow", "TCP", "*", "9160", "Cassandra-Thrift"]

    #CouchDB
    CouchDB = ["Inbound", "Allow", "TCP", "*", "5984", "CouchDB"]

    #CouchDB-HTTPS
    CouchDB-HTTPS = ["Inbound", "Allow", "TCP", "*", "6984", "CouchDB-HTTPS"]

    #DNS-TCP
    DNS-TCP = ["Inbound", "Allow", "TCP", "*", "53", "DNS-TCP"]

    #DNS-UDP
    DNS-UDP = ["Inbound", "Allow", "UDP", "*", "53", "DNS-UDP"]

    #DynamicPorts
    DynamicPorts = ["Inbound", "Allow", "TCP", "*", "49152-65535", "DynamicPorts"]

    #ElasticSearch
    ElasticSearch = ["Inbound", "Allow", "TCP", "*", "9200-9300", "ElasticSearch"]

    #FTP
    FTP = ["Inbound", "Allow", "TCP", "*", "21", "FTP"]

    #HTTP
    HTTP = ["Inbound", "Allow", "TCP", "*", "80", "HTTP"]

    #HTTPS
    HTTPS = ["Inbound", "Allow", "TCP", "*", "443", "HTTPS"]

    #IMAP
    IMAP = ["Inbound", "Allow", "TCP", "*", "143", "IMAP"]

    #IMAPS
    IMAPS = ["Inbound", "Allow", "TCP", "*", "993", "IMAPS"]

    #Kestrel
    Kestrel = ["Inbound", "Allow", "TCP", "*", "22133", "Kestrel"]

    #LDAP
    LDAP = ["Inbound", "Allow", "TCP", "*", "389", "LDAP"]

    #MongoDB
    MongoDB = ["Inbound", "Allow", "TCP", "*", "27017", "MongoDB"]

    #Memcached
    Memcached = ["Inbound", "Allow", "TCP", "*", "11211", "Memcached"]

    #MSSQL
    MSSQL = ["Inbound", "Allow", "TCP", "*", "1433", "MSSQL"]

    #MySQL
    MySQL = ["Inbound", "Allow", "TCP", "*", "3306", "MySQL"]

    #Neo4J
    Neo4J = ["Inbound", "Allow", "TCP", "*", "7474", "Neo4J"]

    #POP3
    POP3 = ["Inbound", "Allow", "TCP", "*", "110", "POP3"]

    #POP3S
    POP3S = ["Inbound", "Allow", "TCP", "*", "995", "POP3S"]

    #PostgreSQL
    PostgreSQL = ["Inbound", "Allow", "TCP", "*", "5432", "PostgreSQL"]

    #RabbitMQ
    RabbitMQ = ["Inbound", "Allow", "TCP", "*", "5672", "RabbitMQ"]

    #RDP
    RDP = ["Inbound", "Allow", "TCP", "*", "3389", "RDP"]

    #Redis
    Redis = ["Inbound", "Allow", "TCP", "*", "6379", "Redis"]

    #Riak
    Riak = ["Inbound", "Allow", "TCP", "*", "8093", "Riak"]

    #Riak-JMX
    Riak-JMX = ["Inbound", "Allow", "TCP", "*", "8985", "Riak-JMX"]

    #SMTP
    SMTP = ["Inbound", "Allow", "TCP", "*", "25", "SMTP"]

    #SMTPS
    SMTPS = ["Inbound", "Allow", "TCP", "*", "465", "SMTPS"]

    #SSH
    SSH = ["Inbound", "Allow", "TCP", "*", "22", "SSH"]

    #WinRM
    WinRM = ["Inbound", "Allow", "TCP", "*", "5986", "WinRM"]
  }
}
