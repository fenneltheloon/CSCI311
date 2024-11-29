import sqlite3

con = sqlite3.connect("/home/fennel/CSCI311/HW5/museum.db")
with open("object_has_material.html", "w") as f:
    f.write('''
<!DOCTYPE html>
<html lang="en">
  <head>
	  <title>CSCI HW5 Object has Material</title>

  </head>
  <body>
    <table id="table">
            ''')
    cur = con.execute("SELECT * from object_has_material")
    rows = cur.fetchall()
    headers = [d[0] for d in cur.description]
    f.write("<tr>\n")
    for header in headers:
        f.write('''
                <th>
                {header}
                </th>
                '''.format(header=header))
    f.write("</tr>\n")
    for row in rows:
        f.write("<tr>\n")
        for item in row:
            f.write('''
                    <td>
                    {item}
                    </td>
                    '''.format(item=item))
        f.write("</tr>\n")
    f.write('''
                </table>
            </body>
        </html>
            ''')
