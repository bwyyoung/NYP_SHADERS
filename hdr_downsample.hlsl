sampler2D Target;
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
            
   Output.oColor = average;
   
   return Output.oColor;
}
