sampler2D Target;
float viewwidth;
float viewheight;
float4 LUMINENCE_FACTOR;
struct PS_INPUT
{
   float2 uv : TEXCOORD1;
   float4 diffuse : COLOR;
};

struct PS_OUTPUT
{
   float4 oColor;
};

float4 ps_main(PS_INPUT Input) : COLOR0
{
   PS_OUTPUT Output;
   float texelSize = 1.0/min(viewwidth, viewheight);
   float4 color = float4(0.0f, 0.0f, 0.0f, 0.0f);

   
   float2 texOffset[4] = {
      -0.5, -0.5,
      -0.5,  0.5, 
       0.5, -0.5,
       0.5, 0.5 };

   for( int i = 0; i < 4; i++ )
   {
      color+=tex2D( Target,Input.uv + texelSize * texOffset[i]);
   }

   float luminance = dot(color, LUMINENCE_FACTOR);
   // take average of 4 samples
   luminance *= 0.25;
   Output.oColor = luminance;
   return Output.oColor;
}

