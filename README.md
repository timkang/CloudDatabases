MMO Gaming Applications of Cloud Databases
==============
authors: Tim Kang, Edmund Yee

Project 3 Proposal: Databases in the cloud and gaming
==============
1. Description of the research issue

The issue involves databases in the cloud that suffer from heavy load. As more and more people begin to utilize the internet, traditional databases run on single servers can no longer handle all the load. This problem can refer to several real world applications like social media, gaming, and etc. For our project, we have chosen to focus specifically on gaming. MMO’s such as Guild Wars or EVE Online have several thousands of concurrent users online at the same time. Each player accesses the database servers with numerous reads and writes as players complete quests, update their inventory, move around, and trade items.

----------------------------------------------------------------------------
2. Description of the existing solution

There is no standard solution. Every company has come up with their own way of coping with the problem, sometimes with commercial off the shelf hardware and software. Crowd Control Production (CCP) runs EVE Online using a cluster of MySQL servers. ArenaNet ran the original Guild Wars using MS SQL servers with a non SQL-like BLOB schema. Many other companies create their own custom solutions. A lot of this information is confidential and considered trade secrets. However, with the advent of more readily accessible and open source NoSQL databases, more developers are given the opportunity to build MMO’s without having to worry about rewriting SQL to fit their game’s needs.

To model the existing solution, we plan on using the open-source MySQL database.

----------------------------------------------------------------------------
3. Description of the enhanced solution

We plan to test the viability of using popular open-source NoSQL solutions to handle heavy traffic game database servers. When the most popular MMO games of today were being developed, NoSQL was a new and immature technology that was unsuitable for use in a production environment. NoSQL has now matured and is now being at several high traffic websites such as Facebook, LinkedIn, and Twitter.

Our enhanced solution will involve servers running a NoSQL database. These databases will basically serve as a drop-in replacement for the existing database. Due to the difference in schema between the different database offerings, we will create a customized schema for each database that will be tested.

We expect to see major improvements in throughput and an increase in the number of concurrent users.

----------------------------------------------------------------------------
4. Project setup

Four databases will be tested:
MySQL Cluster -- this is one of the most popular SQL databases and powers a significant portion of the web. At least one MMO company (CCP Games) uses it in their production servers.
MongoDB -- The most popular NoSQL database in use today and is considered by many to be a drop-in replacement for a SQL database. MongoDB uses a “document-oriented” model for storing entries, which is similar to what ArenaNet did using their MS SQL database.
Redis -- this NoSQL is of the key-value store type and is known for its speed. Since speed and efficiency are of the utmost concern, we believe it salient to include Redis in our tests.

Our tests will emulate the client-server setup of a simple MMORPG:

Client[A] ---> Server[B] <---> Database Shard[C]
                         \__> Database Shard[C]
                         \__> Database Shard[C]
Explanation:
Client will be written in a scripting language like Python. The client sends HTTP requests to the server.
The server receives the HTTP requests and interprets the client requests by sending the appropriate query to the database to either write or read the information.
The database receives the query and does the appropriate action. The database will be divided up into several different shards. 

Our testing procedure will have the client will send a large number of requests over a few set time periods. Requests can consist of data like movement, inventory changes, or quest completion. The server interprets each request and either performs a read/write (or both) to the database. After each test, the throughput will be measured by recording the number of entries written to the database.

----------------------------------------------------------------------------
5. References

Tilmann Rabl, Sergio Gómez-Villamor, Mohammad Sadoghi, Victor Muntés-Mulero, Hans-Arno Jacobsen, and Serge Mankovskii. 2012. Solving big data challenges for enterprise application performance management. Proc. VLDB Endow. 5, 12 (August 2012), 1724-1735.

Daniel Bartholomew. 2010. SQL vs. NoSQL. Linux J. 2010, 195, pages. <http://dl.acm.org/citation.cfm?id=1883478.1883482>
Monash, Curt. "The Database Technology of Guild Wars." A Monash Research Publication. N.p., 9 June 2007. Web. <http://www.dbms2.com/2007/06/09/the-database-technology-of-guild-wars/>.
Valar, CCP. "MAKING OUR BACKSIDE BIGGER." EVE Community. N.p., 2009 Oct. 6. Web. <http://community.eveonline.com/news/dev-blogs/making-our-backside-bigger/>

