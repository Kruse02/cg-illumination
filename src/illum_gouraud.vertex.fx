precision highp float;

// Attributes
attribute vec3 position;
attribute vec3 normal;

// Uniforms
uniform mat4 world;
uniform mat4 view;
uniform mat4 projection;

// Varyings
varying vec3 vNormal;
varying vec3 vPosition;

void main(void) {
  // Calculate the normal and position in world space
  vNormal = normalize(vec3(world * vec4(normal, 0.0)));
  vPosition = vec3(world * vec4(position, 1.0));
  
  // Calculate the vertex position in clip space
  gl_Position = projection * view * world * vec4(position, 1.0);
}
