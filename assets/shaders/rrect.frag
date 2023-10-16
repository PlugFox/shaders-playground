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
  vec2 position = gl_FragCoord.xy / uSize;
  position -= vec2(0.5); // центрируем координаты

  vec2 correctedPosition =
      position * uSize /
      min(uSize.x, uSize.y); // корректируем позицию с учетом соотношения сторон

  // Рассчитываем размеры внешнего прямоугольника, учитывая соотношение сторон
  vec2 outerBoxSize = vec2(0.5, 0.5) * uSize / min(uSize.x, uSize.y);

  // Рассчитываем размеры внутреннего прямоугольника, учитывая толщину границы и
  // соотношение сторон
  vec2 innerBoxSize = outerBoxSize - uBorderThickness / min(uSize.x, uSize.y);

  // Скорректированный радиус скругления
  float correctedRadius = uRadius / min(uSize.x, uSize.y);

  // Вычисляем внешний и внутренний прямоугольники
  float outer = udRoundBox(correctedPosition, outerBoxSize, correctedRadius);
  float inner = udRoundBox(correctedPosition, innerBoxSize, correctedRadius);

  if (inner < 0.0) {
    fragColor = uColor;
  } else if (outer < 0.0) {
    fragColor = uBorderColor;
  } else {
    fragColor = vec4(0.0); // полностью прозрачный цвет
  }
}
