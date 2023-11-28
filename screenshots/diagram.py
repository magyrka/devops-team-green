from diagrams import Diagram, Cluster
from diagrams.onprem.database import PostgreSQL, MongoDB
from diagrams.onprem.inmemory import Redis
from diagrams.onprem.client import Users
from diagrams.onprem.network import Tomcat
from diagrams.programming.language import Java
from diagrams.programming.language import Nodejs

with (Diagram("Schedule Application Architecture", show=True)):

    # with Cluster('Tomcat Service'):
    #     tom_group = [Nodejs("Node.js"), Java("Java App")]

    Users("Clients") >> Tomcat("Tomcat") >> [
        MongoDB("MongoDB"),
        Redis("Redis"),
        PostgreSQL("PostgreSQL")
    ]

