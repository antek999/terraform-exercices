import subprocess

output = subprocess.check_output(["terraform", "state", "list"])

if len(output) > 0:
    subprocess.run(["terraform", "destroy", "-force"])
    