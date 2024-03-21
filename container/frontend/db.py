import oracledb
import os
# import cx_Oracle

db_user = os.environ.get("DB_USER")
db_password = os.environ.get("DB_PASSWORD")
cs = """(description= (retry_count=2)(retry_delay=3)
    (address=(protocol=tcps)(port=1521)(host=ryenbxf5.adb.us-ashburn-1.oraclecloud.com))
    (connect_data=(service_name=g992c28d78bf6f1_t60f7j4t1f0bwxfp_medium.adb.oraclecloud.com))
    (security=(ssl_server_dn_match=no)))
"""

response = []

def test():
    with oracledb.connect(user=db_user, password=db_password, dsn=cs) as connection:
        with connection.cursor() as cursor:
            sql = """select sysdate from dual"""
            for r in cursor.execute(sql):
                response.append(r)
    return r
