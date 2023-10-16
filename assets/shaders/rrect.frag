#version 460 core
#define SHOW_GRID

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;     // size of the shape
uniform vec4 uColor;    // color of the shape
uniform float uRadius;  // radius of the shape
uniform vec4 uBorderColor;      // color of the border
uniform float uBorderThickness; // thickness of the border

out vec4 fragColor;

void main() {
  vec2 position = gl_FragCoord.xy / uSize; // Нормализованные координаты

  // Проверка, находится ли фрагмент в пределах прямоугольника.
  if (position.x > 0.0 && position.x < 1.0 && position.y > 0.0 &&
      position.y < 1.0) {
    // Вычисляем координаты внутри прямоугольника, относительно его размеров и
    // толщины рамки
    float innerRectLeft = uBorderThickness / uSize.x;
    float innerRectRight = 1.0 - innerRectLeft;
    float innerRectBottom = uBorderThickness / uSize.y;
    float innerRectTop = 1.0 - innerRectBottom;

    // Проверяем, находится ли точка внутри внутреннего прямоугольника (за
    // пределами рамки)
    if (position.x > innerRectLeft && position.x < innerRectRight &&
        position.y > innerRectBottom && position.y < innerRectTop) {
      fragColor = uColor; // Если да, используем цвет из uColor для внутренней
                          // части прямоугольника.
    } else {
      fragColor = uBorderColor; // Если нет, точка находится на рамке,
                                // используем цвет рамки.
    }
  } else {
    fragColor =
        vec4(0.0, 0.0, 0.0, 0.0); // Если точка за пределами прямоугольника,
                                  // используем полностью прозрачный цвет.
  }
}