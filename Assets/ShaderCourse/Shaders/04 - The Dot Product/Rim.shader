Shader "Holistic/04 - The Dot Product/Rim" 
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
      };

      void surf (Input IN, inout SurfaceOutput o) {
				half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = _RimColor.rgb * pow(rim,_RimPower);
      }
      ENDCG
	}
	FallBack "Diffuse"
}
