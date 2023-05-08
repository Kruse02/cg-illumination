in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoord;

out vec4 FragColor;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform sampler2D texture_diffuse1;

struct Material {
    sampler2D diffuse;
    vec3 ambient;
    vec3 diffuseColor;
    vec3 specular;
    float shininess;
};

uniform Material material;

void main()
{
    // ambient
    vec3 ambient = material.ambient * texture(texture_diffuse1, TexCoord).rgb;

    // diffuse
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(Normal, lightDir), 0.0);
    vec3 diffuse = material.diffuseColor * diff * texture(texture_diffuse1, TexCoord).rgb;

    // specular
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, Normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = material.specular * spec;

    vec3 result = (ambient + diffuse + specular) * texture(texture_diffuse1, TexCoord).rgb;
    FragColor = vec4(result, 1.0);
}
