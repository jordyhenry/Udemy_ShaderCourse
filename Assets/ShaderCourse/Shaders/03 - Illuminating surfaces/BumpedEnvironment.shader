Shader "Holistic/03 - Illuminating Surfaces/BumpedEnvironment" 
{
	Properties {
    _myDiffuse ("Diffuse Texture", 2D) = "white" {}
    _myBump ("Normal Texture", 2D) = "bump" {}
    _myBumpSlider("Bump Amount", Range(0,10)) = 1
    _myBrightSlider("Birght Amount", Range(0,10)) = 1
    _myCube("Cube Map", CUBE) = "white" {}
  }
  SubShader {

    CGPROGRAM
      #pragma surface surf Lambert
      
      sampler2D _myDiffuse;
      sampler2D _myBump;
      half _myBumpSlider;
      half _myBrightSlider;
      samplerCUBE _myCube;

      struct Input {
        float2 uv_myDiffuse;
        float2 uv_myBump;
        float3 worldRefl; INTERNAL_DATA
      };
      
      void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = (tex2D(_myDiffuse, IN.uv_myDiffuse)).rgb;
				o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
				o.Normal *= float3(_myBumpSlider, _myBumpSlider, _myBrightSlider);
				o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
      }
    ENDCG
  }
  Fallback "Diffuse"
}
