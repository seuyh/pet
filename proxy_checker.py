import requests
from time import sleep

a, d = 0, 0
answer = input("<<<PROXY CHECKER>>>\nLets check ur proxy?(y/n)>>>\n")
if answer != "n":
    lines = 0
    i = 0
    user_timeout = input("Enter connection timeout (default: 5) >>> ")
    user_domen = input("Enter ur domen (default: http://ya.ru) >>> ")
    if not user_domen:
        user_domen = "http://ya.ru"
    if not user_timeout:
        user_timeout = 5
    for line in open("dirt_proxies", "r"):
        lines += 1
    with open("alive_proxies", "a") as alive:
        with open("dirt_proxies") as f:
            for line in f:
                proxy_url = line.rstrip("\r\n")
                proxies = {"http": "http://" + proxy_url}
                i += 1
                try:
                    print(
                        f"({i}/{lines}) | trying to connect to {proxy_url} wait {user_timeout} seconds..."
                    )
                    response = requests.get(user_domen, proxies=proxies, timeout=int(user_timeout))
                    if response:
                        a += 1
                        print(f"{proxy_url} is alive!\n{a} proxies alive, {d} dead")
                        alive.write(line)
                except (
                    requests.exceptions.ConnectionError,
                    requests.exceptions.ChunkedEncodingError,
                    requests.exceptions.ReadTimeout,
                ):
                    d += 1
                    print(f"{proxy_url} is dead!\n{a} proxies alive, {d} dead")
                    continue
    print(f"check end, {a} is alive, {d} is dead, {lines-(a+d)} is skipped")
    sleep(5)
else:
    print("skipping>>>")
    sleep(5)
