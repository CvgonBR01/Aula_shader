Shader "Unlit/Arvore"
{
    Properties
    {
        _MainText ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque"}
        LOD 100

        Pass
        {
            
            HLSLPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

                struct Attributes
                {
                    float2 uv : TEXCOORD0;
                    half3 normal : NORMAL;
                    float4 position : POSITION;
                     half4 color : COLOR;
                };
                
                struct Varyings
                {
                    float2 uvVAR : TEXCOORD0;
                    half4 color : COLOR0;
                    float4 positionVAR : SV_POSITION;
                };

                Varyings vert(Attributes Input)
                {
                    Varyings Output;

                    float oscilation = -0.0005 - (cos(_Time.w) * 0.01 * Input.position.y);
                    float3 position = Input.position.xyz;

                    if(Input.color.y > 0.5)
                        position += Input.normal * oscilation;

                    
                    Output.positionVAR = TransformObjectToHClip(position);
                    Output.uvVAR = Input.uv;

                    
                    Light l = GetMainLight();
                    
                    float intensity = dot(l.direction, TransformObjectToWorldNormal(Input.normal));

                   
                    Output.color = Input.color * intensity;

                    return Output;
                }
                
                float4 frag(Varyings Input) : SV_TARGET
                {
                    float4 color = Input.color;
                    
                    return color;
                }


           
            ENDHLSL
        }
    }
}
