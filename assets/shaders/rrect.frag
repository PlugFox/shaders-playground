#version 460 core
#define SHOW_GRID

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;     // size of the shape
uniform vec4 uColor;    // color of the shape
uniform float uRadius;  // radius of the shape
uniform vec4 uBorderColor;      // color of the border
uniform float uBorderThickness; // thickness of the border

out vec4 fragColor;

float udRoundBox(vec2 p, vec2 b, float r) {
  return length(max(abs(p) - b + vec2(r), 0.0)) - r;
}

void main() {
  // Преобразование координат фрагмента в диапазон от [0,0] до [uSize.x,
  // uSize.y]
  vec2 position = gl_FragCoord.xy / uSize;

  // Преобразуем координаты так, чтобы центр прямоугольника был в [0.5,0.5]
  position -= vec2(0.5);

  // Вычисляем размер прямоугольника, учитывая толщину границы
  vec2 boxSize = vec2(0.5) - vec2(uBorderThickness) / uSize;

  // Сначала рассчитываем внутреннюю часть прямоугольника
  float inner = udRoundBox(position, boxSize, uRadius / min(uSize.x, uSize.y));

  // Теперь рассчитываем внешнюю часть прямоугольника, которая будет границей
  float outer =
      udRoundBox(position, vec2(0.5), uRadius / min(uSize.x, uSize.y));

  if (inner < 0.0) {
    fragColor = uColor;
  } else if (outer < 0.0) {
    fragColor = uBorderColor;
  } else {
    fragColor = vec4(0.0); // полностью прозрачный цвет
  }
}

// fragColor = vec4(0.0);