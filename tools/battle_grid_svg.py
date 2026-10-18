#!/usr/bin/env python3
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def get9GridPos(base_x, base_y, gap, is_left):
    sign = 1 if is_left else -1
    offs = [0, -40, -80, -120]
    return [[(c * 150 + base_x + gap * c + offs[r] * sign, r * 60 + base_y) for r in range(4)] for c in range(3)]


POS_LEFT = get9GridPos(295, 570, 0, True)
POS_RIGHT = get9GridPos(905, 570, 0, False)


def role_point_by_pos(pos, face):
    arr = POS_LEFT if face == 1 else POS_RIGHT
    r = (pos - 1) // 3
    c = 2 - (pos - 1) % 3 if face == 1 else (pos - 1) % 3
    return c, r, arr[c][r]


def get_position(side, pos):
    c, r = (pos - 1) % 3, -(-pos // 3) - 1
    return c, r, (POS_LEFT if side == 1 else POS_RIGHT)[c][r]


def table():
    out = ["| pos | face 1 (esquerda, próprio) col,fila → (x, y) | face 2 (direita, inimigo) col,fila → (x, y) | coluna | getPosition(1,pos) |",
           "|---:|---|---|---|---|"]
    for p in range(1, 13):
        c1, r1, (x1, y1) = role_point_by_pos(p, 1)
        c2, r2, (x2, y2) = role_point_by_pos(p, 2)
        kind = ["frente", "meio", "trás"][(p - 1) % 3]
        gc, gr, (gx, gy) = get_position(1, p)
        out.append(f"| {p} | [{c1}][{r1}] → ({x1}, {y1}) | [{c2}][{r2}] → ({x2}, {y2}) | {kind} | ({gx}, {gy}) |")
    return "\n".join(out)


def svg():
    W, H = 1500, 900
    e = []
    a = e.append
    a(f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" width="{W}" height="{H}" font-family="Arial, sans-serif">')
    a('<title>Grade de combate do Legend Online (BattleUtils.get9GridPos)</title>')
    a('<style>.t{font-size:15px;fill:#222}.s{font-size:12px;fill:#555}.p{font-size:20px;font-weight:bold;fill:#fff;text-anchor:middle;dominant-baseline:central}'
      '.c{font-size:11px;fill:#333;text-anchor:middle}.h{font-size:22px;font-weight:bold;fill:#111}</style>')
    a(f'<rect width="{W}" height="{H}" fill="#f7f5ef"/>')
    for (w, h, col, lab) in [(1500, 900, "#9aa", "cena máx. 1500×900"), (1000, 600, "#c66", "cena mín. 1000×600")]:
        x0, y0 = 750 - w / 2, 900 - h
        a(f'<rect x="{x0}" y="{y0}" width="{w}" height="{h}" fill="none" stroke="{col}" stroke-width="3" stroke-dasharray="12 8"/>')
        a(f'<text class="s" x="{x0 + 8}" y="{y0 + 18}" fill="{col}">{lab} (mundo x {x0:.0f}–{x0 + w:.0f}, y {y0}–900)</text>')
    a('<line x1="750" y1="300" x2="750" y2="900" stroke="#bbb" stroke-width="2"/>')
    a('<text class="s" x="756" y="330">x = 750 (centro da cena; câmera fixa em X)</text>')
    a('<line x1="0" y1="900" x2="1500" y2="900" stroke="#666" stroke-width="2"/>')
    for r in range(4):
        y = 570 + 60 * r
        a(f'<text class="s" x="20" y="{y + 4}">fila {r} · y={y}</text>')
    for arr, colr in [(POS_LEFT, "#3b6ea8"), (POS_RIGHT, "#a8463b")]:
        for c in range(3):
            pts = " ".join(f"{x},{y}" for (x, y) in arr[c])
            a(f'<polyline points="{pts}" fill="none" stroke="{colr}" stroke-opacity=".35" stroke-width="2"/>')
    front = {1, 4, 7, 10}
    for face, colr in [(1, "#3b6ea8"), (2, "#a8463b")]:
        for p in range(1, 13):
            c, r, (x, y) = role_point_by_pos(p, face)
            fill = colr
            stroke = "#111" if p in front else "none"
            a(f'<circle cx="{x}" cy="{y}" r="19" fill="{fill}" stroke="{stroke}" stroke-width="3"/>')
            a(f'<text class="p" x="{x}" y="{y}">{p}</text>')
            a(f'<text class="c" x="{x}" y="{y + 33}">[{c}][{r}] {x},{y}</text>')
    for (x, y), lab in [(POS_LEFT[1][1], "centro esq."), (POS_RIGHT[1][1], "centro dir.")]:
        a(f'<path d="M{x - 8},{y - 30} l16,0 M{x},{y - 38} l0,16" stroke="#111" stroke-width="2"/>')
        a(f'<text class="s" x="{x + 10}" y="{y - 32}">{lab} ({x},{y})</text>')
    a('<text class="s" x="780" y="535">attackPointByPos: o atacante para em alvo.x ± (dx + 120)</text>')
    a('<text class="h" x="40" y="60">Grade de combate 3 colunas × 4 filas por lado</text>')
    a('<text class="t" x="40" y="88">esquerda: x = 295 + 150·col − 40·fila · direita: x = 905 + 150·col + 40·fila · y = 570 + 60·fila</text>')
    a('<text class="t" x="40" y="112">face 1 = próprio lado (sempre à esquerda) · face 2 = inimigo (à direita, scaleX = −1 nas unidades)</text>')
    a('<text class="t" x="40" y="136">contorno preto = coluna da frente (pos 1, 4, 7, 10) · [col][fila] = índice em posLeft/posRight</text>')
    a('<text class="t" x="40" y="160">fonte: decompiled/core_module/scripts/battle/utils/BattleUtils.as:108-262</text>')
    a('<text class="s" x="40" y="186">z-order: maior pointY (= y do ponto) desenhado na frente; selfHero +1, pet +2, prioridade +2 (RoleViewBase.as:814-834)</text>')
    a('</svg>')
    return "\n".join(e) + "\n"


if __name__ == "__main__":
    if "--table" in sys.argv:
        print(table())
    else:
        path = os.path.join(ROOT, "docs", "docs/battle/grid.svg")
        with open(path, "w", encoding="utf-8") as f:
            f.write(svg())
        print("escrito", path)
