﻿
Shader "Custom/ShaderCosas"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white"{}
        _Albedo("Albedo", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white"{}
		_BumpTex("Normal", 2D) = "bump" {}
		
      
    }

    SubShader   
    {
		Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf ToonRamp
       
       
        fixed4 _Color;
        float4 _Albedo;
        sampler2D _MainTex;
        sampler2D _RampTex;
		sampler2D _BumpTex;

        float4 LightingToonRamp(SurfaceOutput s, fixed2 lightDir, fixed atten)
        {   
            half diff = dot(s.Normal, lightDir);
            float uv = (diff * 0.5) + 0.5;
            float3 ramp = tex2D(_RampTex,uv);
            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp;
            c.a = s.Alpha;
            return c;
        }
        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Albedo.rgb;
			
        }

        ENDCG
    }
}