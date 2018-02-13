Shader "Holistic/04 - The Dot Product/CutOff" 
{
	Properties
	{
		_RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
	}

	SubShader 
	{
		CGPROGRAM
      #pragma surface surf Lambert

      float4 _RimColor;
      half _RimPower;

      struct Input{
      	float3 viewDir;
      	float3 worldPos;
      };

      void surf (Input IN, inout SurfaceOutput o) {
				half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = rim > 0.6 ? float3(0,1,0)*rim: rim > 0.3 ? float3(1,0,0)*rim :float3(0,0,1)*rim;
      }
      ENDCG
	}
	FallBack "Diffuse"
}