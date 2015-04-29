sampler2D Target;
float blurx;
float blury;
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
   float PixelWeight[8] = { 0.2537, 0.2185, 0.0821, 0.0461, 0.0262, 0.0162, 0.0102, 0.0052 };
   
   float4 color = tex2D(Target, Input.uv);

   // Sample pixels on x side
   for( int i = 0; i < 8; ++i )
   {
     color += tex2D( Target, Input.uv + ( float2(blurx,blury) * i )) * PixelWeight[i];
     color += tex2D( Target, Input.uv - ( float2(blurx,blury) * i )) * PixelWeight[i];
   }
   Output.oColor = color;

   return Output.oColor;
}