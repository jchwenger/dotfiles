# https://stackoverflow.com/a/2148925
import signal, os

def main():

    print("looping through signals")
    for i in [x for x in dir(signal) if x.startswith("SIG")]:
        print(f"signal: {i}", end="")
        try:
            signum = getattr(signal,i)
            try:
                signal.signal(signum, handler)
                print(f" | ok, set up {signum}")
            except Exception as e:
                print()
                print("\toops:", e)
        except (OSError, RuntimeError) as m: #OSError for Python3, RuntimeError for 2
            print (f" | skipping")

    x = 0
    while True:
        x = x+1

def handler(signum, frame):
    print(f"\033[92;1;6m\t>>> SIGNAL HANDLER CALLED WITH SIGNAL: {signum}\033[0m")
    exit()

if __name__ == '__main__':
    main()
