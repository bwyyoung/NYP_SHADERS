sampler2D Target;
sampler2D Luminance;
float MIDDLE_GREY;
float FUDGE;
float L_WHITE;
float4 BRIGHT_LIMITER;
float viewwidth;
float viewheight;
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
//the brightpass downsamples the texture 3x3, and applies Reinhard tonemapping
float4 ps_main(PS_INPUT Input) : COLOR0
{
   PS_OUTPUT Output;


   float4 average = { 0.0f, 0.0f, 0.0f, 0.0f };

   float texelSize = 1/min(viewwidth,viewheight);

   float2 texOffset[9] = {
      -1.0, -1.0,
       0.0, -1.0,
       1.0, -1.0,
      -1.0,  0.0,
       0.0,  0.0,
       1.0,  0.0,
      -1.0,  1.0,
       0.0,  1.0,
       1.0,  1.0
   };

   for( int i = 0; i < 9; i++)
   {
      average += tex2D(Target, Input.uv + texelSize * texOffset[i]);
   } 
   
   average *= 0.1111111111111111;
    // Reduce bright and clamp
    average = max(float4(0.0f, 0.0f, 0.0f, 1.0f), average - BRIGHT_LIMITER);

   // Sample the luminence texture
   float4 lum = tex2D(Luminance, float2(0.5f, 0.5f));
            
   Output.oColor = toneMap(average, lum.r);

    return Output.oColor;
}
