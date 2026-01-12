Shader "BasicLearn/First"
{
    Properties
    {
        _BaseColor("BaseColor", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags 
        {
            "RenderPipeline" = "UniversalPipeline" 
            "RenderType" = "Opaque"
            "Queue" = "Geometry" 
        }

        pass 
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            float4 _BaseColor;
            struct Attributes
            {
                float4 positionOS : POSITION;
            };
            struct v2f 
            {
                float4 positionCS : SV_POSITION;
            };


            v2f vert(Attributes v)
            {
                v2f o = (v2f)0;

                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);

                return o;
            }

            float frag(v2f i) : SV_TARGET
            {
                return _BaseColor;
            }
            ENDHLSL
        }
    }
    
}

