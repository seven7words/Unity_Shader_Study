// Compiled shader for PC, Mac & Linux Standalone

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "UnityShaderBook/Chapter9-ForwardRendering" {
Properties {
 _Diffuse ("Diffuse", Color) = (1.000000,1.000000,1.000000,1.000000)
 _Specular ("Specular", Color) = (1.000000,1.000000,1.000000,1.000000)
 _Gloss ("Gloss", Range(8.000000,256.000000)) = 20.000000
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="FORWARDBASE" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"

Constant Buffer "Globals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    return output;
}


-- Fragment shader for "metal":
Constant Buffer "Globals" (100 bytes) on slot 0 {
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 glstate_lightmodel_ambient at 32
  Vector4 _LightColor0 at 48
  Vector4 _Diffuse at 64
  Vector4 _Specular at 80
  Float _Gloss at 96
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 glstate_lightmodel_ambient;
    float4 _LightColor0;
    float4 _Diffuse;
    float4 _Specular;
    float _Gloss;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float u_xlat9;
    u_xlat0.x = dot(Globals._WorldSpaceLightPos0.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * Globals._WorldSpaceLightPos0.xyz;
    u_xlat1.xyz = (-input.TEXCOORD1.xyz) + Globals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat2.xyz = float3(u_xlat9) * input.TEXCOORD0.xyz;
    u_xlat0.w = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xy = max(u_xlat0.xw, float2(0.0, 0.0));
    u_xlat3.x = log2(u_xlat0.y);
    u_xlat3.x = u_xlat3.x * Globals._Gloss;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.xyz = Globals._LightColor0.xyz * Globals._Specular.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = Globals._LightColor0.xyz * Globals._Diffuse.xyz;
    u_xlat0.xyz = fma(u_xlat1.xyz, u_xlat0.xxx, u_xlat3.xyz);
    output.SV_Target0.xyz = fma(Globals.glstate_lightmodel_ambient.xyz, float3(2.0, 2.0, 2.0), u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
out vec3 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Diffuse;
uniform 	vec4 _Specular;
uniform 	float _Gloss;
in  vec3 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
layout(location = 0) out vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat0.w = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xy = max(u_xlat0.xw, vec2(0.0, 0.0));
    u_xlat3.x = log2(u_xlat0.y);
    u_xlat3.x = u_xlat3.x * _Gloss;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.xyz = _LightColor0.xyz * _Specular.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = _LightColor0.xyz * _Diffuse.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat3.xyz;
    SV_Target0.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL SHADOWS_SCREEN 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"

Constant Buffer "Globals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    return output;
}


-- Fragment shader for "metal":
Constant Buffer "Globals" (100 bytes) on slot 0 {
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 glstate_lightmodel_ambient at 32
  Vector4 _LightColor0 at 48
  Vector4 _Diffuse at 64
  Vector4 _Specular at 80
  Float _Gloss at 96
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 glstate_lightmodel_ambient;
    float4 _LightColor0;
    float4 _Diffuse;
    float4 _Specular;
    float _Gloss;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float u_xlat9;
    u_xlat0.x = dot(Globals._WorldSpaceLightPos0.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * Globals._WorldSpaceLightPos0.xyz;
    u_xlat1.xyz = (-input.TEXCOORD1.xyz) + Globals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat2.xyz = float3(u_xlat9) * input.TEXCOORD0.xyz;
    u_xlat0.w = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xy = max(u_xlat0.xw, float2(0.0, 0.0));
    u_xlat3.x = log2(u_xlat0.y);
    u_xlat3.x = u_xlat3.x * Globals._Gloss;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.xyz = Globals._LightColor0.xyz * Globals._Specular.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = Globals._LightColor0.xyz * Globals._Diffuse.xyz;
    u_xlat0.xyz = fma(u_xlat1.xyz, u_xlat0.xxx, u_xlat3.xyz);
    output.SV_Target0.xyz = fma(Globals.glstate_lightmodel_ambient.xyz, float3(2.0, 2.0, 2.0), u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
out vec3 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Diffuse;
uniform 	vec4 _Specular;
uniform 	float _Gloss;
in  vec3 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
layout(location = 0) out vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat0.w = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xy = max(u_xlat0.xw, vec2(0.0, 0.0));
    u_xlat3.x = log2(u_xlat0.y);
    u_xlat3.x = u_xlat3.x * _Gloss;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.xyz = _LightColor0.xyz * _Specular.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = _LightColor0.xyz * _Diffuse.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat3.xyz;
    SV_Target0.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL VERTEXLIGHT_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"

Constant Buffer "Globals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
out vec3 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Diffuse;
uniform 	vec4 _Specular;
uniform 	float _Gloss;
in  vec3 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
layout(location = 0) out vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat0.w = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xy = max(u_xlat0.xw, vec2(0.0, 0.0));
    u_xlat3.x = log2(u_xlat0.y);
    u_xlat3.x = u_xlat3.x * _Gloss;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.xyz = _LightColor0.xyz * _Specular.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = _LightColor0.xyz * _Diffuse.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat3.xyz;
    SV_Target0.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL SHADOWS_SCREEN VERTEXLIGHT_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"

Constant Buffer "Globals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
out vec3 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Diffuse;
uniform 	vec4 _Specular;
uniform 	float _Gloss;
in  vec3 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
layout(location = 0) out vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat0.w = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xy = max(u_xlat0.xw, vec2(0.0, 0.0));
    u_xlat3.x = log2(u_xlat0.y);
    u_xlat3.x = u_xlat3.x * _Gloss;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.xyz = _LightColor0.xyz * _Specular.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = _LightColor0.xyz * _Diffuse.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat3.xyz;
    SV_Target0.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

 }
 Pass {
  Tags { "LIGHTMODE"="FORWARDADD" "RenderType"="Opaque" }
  Blend One One
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Keywords set in this variant: POINT 
-- Vertex shader for "metal":
// Compile errors generating this shader.

-- Fragment shader for "metal":
// Compile errors generating this shader.

-- Vertex shader for "glcore":
// Compile errors generating this shader.

-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

-- Vertex shader for "metal":
// Compile errors generating this shader.

-- Fragment shader for "metal":
// Compile errors generating this shader.

-- Vertex shader for "glcore":
// Compile errors generating this shader.

-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

-- Vertex shader for "metal":
// Compile errors generating this shader.

-- Fragment shader for "metal":
// Compile errors generating this shader.

-- Vertex shader for "glcore":
// Compile errors generating this shader.

-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: POINT_COOKIE 
-- Vertex shader for "metal":
// Compile errors generating this shader.

-- Fragment shader for "metal":
// Compile errors generating this shader.

-- Vertex shader for "glcore":
// Compile errors generating this shader.

-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

-- Vertex shader for "metal":
// Compile errors generating this shader.

-- Fragment shader for "metal":
// Compile errors generating this shader.

-- Vertex shader for "glcore":
// Compile errors generating this shader.

-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
}
Fallback "Specular"
}