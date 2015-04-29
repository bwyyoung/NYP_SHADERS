sampler2D Original;
sampler2D Bloom;
sampler2D Luminance;
float MIDDLE_GREY;
float FUDGE;
float L_WHITE;

struct PS_INPUT
{
   float2 uv : TEXCOORD1;
   float4 diffuse : COLOR;
};

struct PS_OUTPUT
{
   float4 oColor;
};

float4 toneMap(float4 inColour, float lum)
{
   // From Reinhard et al
   // "Photographic Tone Reproduction for Digital Images"
   
   // Initial luminence scaling (equation 2)
    inColour.rgb *= MIDDLE_GREY / (FUDGE + lum);

   // Control white out (equation 4 nom)
    inColour.rgb *= (1.0f + inColour / L_WHITE);

   // Final mapping (equation 4 denom)
   inColour.rgb /= (1.0f + inColour);
   
   return inColour;

}

float4 ps_main(PS_INPUT Input) : COLOR0
{
   PS_OUTPUT Output;

   // Get main scene colour
    float4 sceneCol = tex2D(Original, Input.uv);

   // Get luminence value
   float4 lum = tex2D(Luminance, float2(0.5f, 0.5f));

   // tone map this
   float4 toneMappedSceneCol = toneMap(sceneCol, lum.x);
   
   // Get bloom colour
    float4 bloom = tex2D(Bloom, Input.uv);

   // Add scene & bloom
   return float4(toneMappedSceneCol.rgb + bloom.rgb, 1.0f);
   
   return Output.oColor;
}


