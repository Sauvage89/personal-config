#!/usr/bin/env python3

import json
import subprocess
import sys


DIRECTIONS = {
    "up": "vertical",
    "down": "vertical",
    "left": "horizontal",
    "right": "horizontal",
}

OPPOSITE = {
    "up": "bottom",
    "down": "top",
    "left": "right",
    "right": "left",
}


def kitty(*args):
    result = subprocess.run(
        ["kitten", "@", *args],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        sys.exit(result.returncode)

    return result.stdout


def has_neighbor(direction):
    """
    Vérifie si la fenêtre active possède un voisin
    dans la direction demandée.

    Kitty fournit le champ `neighbor` dans ses critères
    de sélection des fenêtres.
    """
    output = kitty(
        "ls",
        "--match",
        f"neighbor:{direction}",
    )

    try:
        data = json.loads(output)
    except json.JSONDecodeError:
        return False

    # kitty @ ls retourne une arborescence OS -> tabs -> windows.
    for os_window in data:
        for tab in os_window.get("tabs", []):
            if tab.get("windows"):
                return True

    return False


def resize(direction):
    axis = DIRECTIONS[direction]

    # Si un voisin existe dans la direction de la flèche,
    # on agrandit la fenêtre active vers ce voisin.
    #
    # Sinon, on déplace la séparation opposée en direction
    # de la fenêtre active, ce qui la rétrécit.

    if has_neighbor(direction):
        increment = 2
    else:
        increment = -2

    kitty(
        "resize-window",
        "--axis",
        axis,
        "--increment",
        str(increment),
    )


if len(sys.argv) != 2 or sys.argv[1] not in DIRECTIONS:
    print(
        "Usage: terminator-resize.py "
        "{up|down|left|right}",
        file=sys.stderr,
    )
    sys.exit(1)

resize(sys.argv[1])
