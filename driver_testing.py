__author__ = 'cjrolo'
from cassandra.cluster import Cluster
from cassandra.policies import DCAwareRoundRobinPolicy
from cassandra.query import ConsistencyLevel
import time

i = 0
cluster = Cluster(
    ['127.0.0.1', '127.0.0.2', '127.0.0.3', '127.0.0.4'],
    load_balancing_policy=DCAwareRoundRobinPolicy(local_dc='datacenter1'),
    port=9042)
t0 = time.time()
cluster = Cluster()
t1 = time.time()
session = cluster.connect('sandbox')
t2 = time.time()
ps = session.prepare("select * from mytable")
ps.consistency_level = ConsistencyLevel.ONE
while i<=150:
    t3 = time.time()
    rows = session.execute(ps)
    print('%d ) Time: %f ms' %(i, (time.time() - t3)*1000))
    i+=1
print("Driver start: %f ms. Driver connection: %f ms." % ((t0-t1)*1000, (t2-t1)*1000) )
for user_row in rows:
    print user_row.name, user_row.age, user_row.email