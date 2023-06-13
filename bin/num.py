import subprocess

command = ['/usr/bin/checkupdates'];
p = subprocess.Popen(command, stdout=subprocess.PIPE)
text = p.stdout.read()
updatelist  = text.splitlines()
number_of_updates = len(updatelist)

if(number_of_updates == 0):
    print(" " + str(number_of_updates))
else:
    print(" " + str(number_of_updates))

