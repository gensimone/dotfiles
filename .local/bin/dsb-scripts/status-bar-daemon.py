#!/bin/python

from asyncio.tasks import Task
import os
import asyncio
import logging
from subprocess import run, PIPE
from typing import Dict, List, Tuple

logger = logging.getLogger(__name__)
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


async def exec_script(script: str) -> None:
    completed_process = run(
        f'{SCRIPTS_DIR}/{script}',
        stdout=PIPE,
        stderr=PIPE,
        shell=True
    )
    if completed_process.returncode != 0:
        stderr = completed_process.stderr.decode().strip()
        logger.error(stderr)
    else:
        stdout = completed_process.stdout.decode().strip()
        logger.info(stdout)


async def exec_tasks(tasks: List[Task], sleep_time: float) -> None:
    while True:
        await asyncio.sleep(sleep_time)
        for task in tasks:
            logger.debug(f'awaiting task {task}')
            await task
        completed_process = run(SETTER, stdout=PIPE, stderr=PIPE, shell=True)
        if completed_process.returncode != 0:
            stderr = completed_process.stderr.decode().strip()
            logger.error(stderr)
            break


def get_grouped_tasks(table: Dict[str, List[str]]) -> List[Tuple[float, List[Task]]]:
    grouped_tasks: List[Tuple[float, List[Task]]] = []
    for sleep_time, scripts in table.items():
        sleep_time = float(sleep_time)
        tasks: List[Task] = []
        for script in scripts:
            task = asyncio.create_task(
                coro=exec_script(script),
                name=script
            )
            logger.debug('append task')
            tasks.append(task)
        grouped_tasks.append((sleep_time, tasks))
    return grouped_tasks


async def main() -> None:
    table = get_table(CONFIG)
    logger.debug(table)
    grouped_tasks = get_grouped_tasks(table)
    for sleep_time, tasks in grouped_tasks:
        logger.debug(f'awaiting tasks: {tasks}')
        await exec_tasks(tasks, sleep_time)


if __name__ == "__main__":
    format=(
        "%(name)s:"
        "%(levelname)s:"
        "%(taskName)s:"
        "%(message)s"
    )
    logging.basicConfig(
        level=logging.DEBUG,
        format=format
    )
    asyncio.run(main())
