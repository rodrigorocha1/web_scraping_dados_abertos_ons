import subprocess
import platform

host = "dados.ons.org.br"  # Remova "https://"
param = "-n" if platform.system().lower() == "windows" else "-c"
command = ["ping", param, "1", host]

try:
    subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)
    print(f"{host} está acessível.")
except subprocess.CalledProcessError:
    print(f"Falha ao alcançar {host}.")
