#!/bin/python

import os
import asyncio
import logging
from subprocess import run, PIPE
from typing import Coroutine, Dict, List

LOGGER = logging.getLogger(__name__)
HERE = os.path.dirname(os.path.abspath(__file__))
SETTER = f'{HERE}/status-bar-setter.sh'
SCRIPTS_DIR = f'{HERE}/status-bar-scripts'
CONFIG = run(
    f'{HERE}/status-bar-conf.sh',
    stdout=PIPE,
    check=True,
    shell=True
).stdout.decode().strip()


def get_table(config: str) -> Dict[str, List[str]]:
    with open(config, 'r') as f:
        lines: List[str] = []
        for line in f.readlines():
            line = line.strip()
            if line:
                lines.append(line)
    table: Dict[str, List[str]] = {}
    for line in lines:
        module, time = line.split()
        if time in table:
            table[time].append(module)
        else:
            table[time] = [module]
    return table


async def exec_script(script: str, sleep_time: int) -> None:
    while True:
        await asyncio.sleep(sleep_time)
        completed_process = run(
            f'{SCRIPTS_DIR}/{script}',
            stdout=PIPE,
            stderr=PIPE
        )
        if completed_process.returncode != 0:
            stderr = completed_process.stderr.decode()
            LOGGER.error(stderr)


async def main() -> None:
    table = get_table(CONFIG)

if __name__ == "__main__":
    asyncio.run(main())
