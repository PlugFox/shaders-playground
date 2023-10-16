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
  vec2 position =
      gl_FragCoord.xy / uSize; // координаты в пределах [0,0] до [1,1]
  position -= vec2(0.5); // центрирование координат, теперь в пределах
                         // [-0.5,-0.5] до [0.5,0.5]

  float aspectRatio = uSize.x / uSize.y; // учёт соотношения сторон

  // коррекция позиции для учета соотношения сторон
  vec2 correctedPosition = vec2(position.x * aspectRatio, position.y);

  // Вычисляем внешнюю часть прямоугольника (границу)
  float outer = udRoundBox(correctedPosition, vec2(0.5 * aspectRatio, 0.5),
                           uRadius / uSize.y);

  // Размер внутреннего прямоугольника, учитывая толщину границы и соотношение
  // сторон
  vec2 innerBoxSize = vec2(0.5 - uBorderThickness / uSize.x * aspectRatio,
                           0.5 - uBorderThickness / uSize.y);

  // Вычисляем внутреннюю часть прямоугольника
  float inner = udRoundBox(correctedPosition, innerBoxSize, uRadius / uSize.y);

  if (inner < 0.0) {
    fragColor = uColor;
  } else if (outer < 0.0) {
    fragColor = uBorderColor;
  } else {
    fragColor = vec4(0.0); // полностью прозрачный цвет
  }
}

// fragColor = vec4(0.0);