attribute vec3 atribut_poziciya_vershin;
attribute vec3 atribut_normali_vershin;
attribute vec2 atribut_koordinaty_tekstury;

uniform mat4 uniform_matrica_model_vid;
uniform mat4 uniform_matrica_proekcii;
uniform mat3 uniform_matrica_normalej;

uniform vec3 uniform_cvet_fonovogo_osveshheniya;

uniform vec3 uniform_napravlenie_osveshheniya;
uniform vec3 uniform_cvet_napravlennogo_osveshheniya;

uniform vec3 uniform_koordinaty_istochnika_tochechnogo_osveshheniya;
uniform vec3 uniform_cvet_istochnika_tochechnogo_osveshheniya;

uniform bool uniform_svet_vkljuchon;

varying vec2 koordinaty_tekstury;
varying vec3 sila_osveshheniya;



void main(void) {
    vec4 matrica_pozicii = uniform_matrica_model_vid * vec4(atribut_poziciya_vershin, 1.0);
    gl_Position = uniform_matrica_proekcii * matrica_pozicii;

    koordinaty_tekstury = atribut_koordinaty_tekstury;

    if (!uniform_svet_vkljuchon) {
        sila_osveshheniya = vec3(1.0, 1.0, 1.0);
    } else {
        vec3 napravlenie_osveshheniya = normalize(uniform_koordinaty_istochnika_tochechnogo_osveshheniya -
            matrica_pozicii.xyz);

        vec3 transformirovannaya_normal = uniform_matrica_normalej * atribut_normali_vershin;
        float sila_napravlennogo_osveshheniya = max(dot(transformirovannaya_normal, napravlenie_osveshheniya), 0.0);
        sila_osveshheniya = uniform_cvet_fonovogo_osveshheniya + uniform_cvet_istochnika_tochechnogo_osveshheniya *
            sila_napravlennogo_osveshheniya;
    }
}