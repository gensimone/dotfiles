#!/bin/python

import os
import asyncio
import logging
from subprocess import run, PIPE
from typing import List, Tuple

logger = logging.getLogger()
HERE = os.path.dirname(os.path.abspath(__file__))
SETTER = f'{HERE}/dwm-sb-set.sh'
UPDATE = f'{HERE}/dwm-sb-update-module.sh'
CONFIG = run(
    f'{HERE}/dwm-sb-get-conf.sh',
    stdout=PIPE,
    check=True,
    shell=True
).stdout.decode().strip()


def get_table(config: str) -> List[Tuple[float, str]]:
    file = open(config, 'r')
    lines = file.readlines()
    file.close()

    table: List[Tuple[float, str]] = []
    for line in lines:
        line = line.strip().split()
        if line and len(line) == 2:
            module, sleep_time = line
            table.append((float(sleep_time), module))
    return table


async def update(sleep_time: float, module: str) -> None:
    while True:
        await asyncio.sleep(sleep_time)
        cp = run(f'{UPDATE} {module}', stdout=PIPE, stderr=PIPE, check=False, shell=True)
        if cp.returncode != 0:
            logger.error(cp.stderr.decode().strip())
            break


async def main() -> None:
    table = get_table(CONFIG)
    run(f'{SETTER}', stdout=PIPE, stderr=PIPE, check=True, shell=True)
    coroutines = [update(sleep_time, module) for sleep_time, module in table]
    await asyncio.gather(*coroutines)


if __name__ == "__main__":
    format=(
        "%(name)s:"
        "%(levelname)s:"
        "%(taskName)s:"
        "%(message)s"
    )
    logging.basicConfig(level=logging.DEBUG, format=format)
    asyncio.run(main())
