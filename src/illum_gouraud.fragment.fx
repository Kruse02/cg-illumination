precision highp float;

// Light properties
uniform vec3 lightPosition;
uniform vec3 lightColor;
uniform float ambientStrength;
uniform float specularStrength;
uniform float shininess;

// Material properties
uniform vec3 diffuseColor;

// Varyings
varying vec3 vNormal;
varying vec3 vPosition;

void main(void) {
  // Calculate the direction from the vertex to the light
  vec3 lightDirection = normalize(lightPosition - vPosition);

  // Calculate the diffuse intensity using the Lambertian model
  float diffuseIntensity = max(dot(vNormal, lightDirection), 0.0);

  // Calculate the ambient intensity
  float ambientIntensity = ambientStrength;

  // Calculate the specular intensity using the Blinn-Phong model
  vec3 viewDirection = normalize(-vPosition);
  vec3 halfwayDirection = normalize(viewDirection + lightDirection);
  float specularIntensity = pow(max(dot(halfwayDirection, vNormal), 0.0), shininess);

  // Calculate the final color
  vec3 color = diffuseColor * (diffuseIntensity + ambientIntensity) * lightColor;
  color += specularStrength * specularIntensity * lightColor;

  gl_FragColor = vec4(color, 1.0);
}
