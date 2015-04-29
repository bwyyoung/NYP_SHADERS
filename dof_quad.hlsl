
struct VS_INPUT 
{
   float4 Position:POSITION0;
   float4 uv: TEXCOORD0; 
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   float2 uv : TEXCOORD1;
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;
   Input.Position.xy = sign(Input.Position.xy);
   Output.Position = float4(Input.Position.xy,0,1);
   Output.uv.x = 0.5 * (1 + Input.Position.x);
   Output.uv.y = 0.5 * (1 - Input.Position.y);
   return( Output );   
}

