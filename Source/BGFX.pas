unit BGFX;

(*
  Copyright 2020 Akira13641
  License: http://www.opensource.org/licenses/BSD-2-Clause

  This unit contains a translation of the BGFX C99 API headers to Free Pascal,
  and was partially automatically generated with Chet:
  https://github.com/neslib/Chet
*)

{$MINENUMSIZE 4}

interface

const
  {$if Defined(Windows)}
    LIB_BGFX = 'bgfx.dll';
  {$elseif Defined(Linux}
    LIB_BGFX = 'bgfx.so';
  {$elseif Defined(MacOS)}
    LIB_BGFX = 'bgfx.dylib';
  {$endif}

const
  BGFX_API_VERSION = UInt32(103);
  BGFX_STATE_WRITE_R = UInt64($0000000000000001);
  BGFX_STATE_WRITE_G = UInt64($0000000000000002);
  BGFX_STATE_WRITE_B = UInt64($0000000000000004);
  BGFX_STATE_WRITE_A = UInt64($0000000000000008);
  BGFX_STATE_WRITE_Z = UInt64($0000004000000000);
  BGFX_STATE_WRITE_RGB = (0 or BGFX_STATE_WRITE_R or BGFX_STATE_WRITE_G or BGFX_STATE_WRITE_B);
  BGFX_STATE_WRITE_MASK = (0 or BGFX_STATE_WRITE_RGB or BGFX_STATE_WRITE_A or BGFX_STATE_WRITE_Z);
  BGFX_STATE_DEPTH_TEST_LESS = UInt64($0000000000000010);
  BGFX_STATE_DEPTH_TEST_LEQUAL = UInt64($0000000000000020);
  BGFX_STATE_DEPTH_TEST_EQUAL = UInt64($0000000000000030);
  BGFX_STATE_DEPTH_TEST_GEQUAL = UInt64($0000000000000040);
  BGFX_STATE_DEPTH_TEST_GREATER = UInt64($0000000000000050);
  BGFX_STATE_DEPTH_TEST_NOTEQUAL = UInt64($0000000000000060);
  BGFX_STATE_DEPTH_TEST_NEVER = UInt64($0000000000000070);
  BGFX_STATE_DEPTH_TEST_ALWAYS = UInt64($0000000000000080);
  BGFX_STATE_DEPTH_TEST_SHIFT = 4;
  BGFX_STATE_DEPTH_TEST_MASK = UInt64($00000000000000f0);
  BGFX_STATE_BLEND_ZERO = UInt64($0000000000001000);
  BGFX_STATE_BLEND_ONE = UInt64($0000000000002000);
  BGFX_STATE_BLEND_SRC_COLOR = UInt64($0000000000003000);
  BGFX_STATE_BLEND_INV_SRC_COLOR = UInt64($0000000000004000);
  BGFX_STATE_BLEND_SRC_ALPHA = UInt64($0000000000005000);
  BGFX_STATE_BLEND_INV_SRC_ALPHA = UInt64($0000000000006000);
  BGFX_STATE_BLEND_DST_ALPHA = UInt64($0000000000007000);
  BGFX_STATE_BLEND_INV_DST_ALPHA = UInt64($0000000000008000);
  BGFX_STATE_BLEND_DST_COLOR = UInt64($0000000000009000);
  BGFX_STATE_BLEND_INV_DST_COLOR = UInt64($000000000000a000);
  BGFX_STATE_BLEND_SRC_ALPHA_SAT = UInt64($000000000000b000);
  BGFX_STATE_BLEND_FACTOR = UInt64($000000000000c000);
  BGFX_STATE_BLEND_INV_FACTOR = UInt64($000000000000d000);
  BGFX_STATE_BLEND_SHIFT = 12;
  BGFX_STATE_BLEND_MASK = UInt64($000000000ffff000);
  BGFX_STATE_BLEND_EQUATION_ADD = UInt64($0000000000000000);
  BGFX_STATE_BLEND_EQUATION_SUB = UInt64($0000000010000000);
  BGFX_STATE_BLEND_EQUATION_REVSUB = UInt64($0000000020000000);
  BGFX_STATE_BLEND_EQUATION_MIN = UInt64($0000000030000000);
  BGFX_STATE_BLEND_EQUATION_MAX = UInt64($0000000040000000);
  BGFX_STATE_BLEND_EQUATION_SHIFT = 28;
  BGFX_STATE_BLEND_EQUATION_MASK = UInt64($00000003f0000000);
  BGFX_STATE_CULL_CW = UInt64($0000001000000000);
  BGFX_STATE_CULL_CCW = UInt64($0000002000000000);
  BGFX_STATE_CULL_SHIFT = 36;
  BGFX_STATE_CULL_MASK = UInt64($0000003000000000);
  BGFX_STATE_ALPHA_REF_SHIFT = 40;
  BGFX_STATE_ALPHA_REF_MASK = UInt64($0000ff0000000000);
  BGFX_STATE_PT_TRISTRIP = UInt64($0001000000000000);
  BGFX_STATE_PT_LINES = UInt64($0002000000000000);
  BGFX_STATE_PT_LINESTRIP = UInt64($0003000000000000);
  BGFX_STATE_PT_POINTS = UInt64($0004000000000000);
  BGFX_STATE_PT_SHIFT = 48;
  BGFX_STATE_PT_MASK = UInt64($0007000000000000);
  BGFX_STATE_POINT_SIZE_SHIFT = 52;
  BGFX_STATE_POINT_SIZE_MASK = UInt64($00f0000000000000);
  BGFX_STATE_MSAA = UInt64($0100000000000000);
  BGFX_STATE_LINEAA = UInt64($0200000000000000);
  BGFX_STATE_CONSERVATIVE_RASTER = UInt64($0400000000000000);
  BGFX_STATE_NONE = UInt64($0000000000000000);
  BGFX_STATE_FRONT_CCW = UInt64($0000008000000000);
  BGFX_STATE_BLEND_INDEPENDENT = UInt64($0000000400000000);
  BGFX_STATE_BLEND_ALPHA_TO_COVERAGE = UInt64($0000000800000000);
  BGFX_STATE_DEFAULT = (0 or BGFX_STATE_WRITE_RGB or BGFX_STATE_WRITE_A or BGFX_STATE_WRITE_Z or BGFX_STATE_DEPTH_TEST_LESS or BGFX_STATE_CULL_CW or BGFX_STATE_MSAA);
  BGFX_STATE_MASK = UInt64($ffffffffffffffff);
  BGFX_STATE_RESERVED_SHIFT = 61;
  BGFX_STATE_RESERVED_MASK = UInt64($e000000000000000);
  BGFX_STENCIL_FUNC_REF_SHIFT = 0;
  BGFX_STENCIL_FUNC_REF_MASK = UInt32($000000ff);
  BGFX_STENCIL_FUNC_RMASK_SHIFT = 8;
  BGFX_STENCIL_FUNC_RMASK_MASK = UInt32($0000ff00);
  BGFX_STENCIL_NONE = UInt32($00000000);
  BGFX_STENCIL_MASK = UInt32($ffffffff);
  BGFX_STENCIL_DEFAULT = UInt32($00000000);
  BGFX_STENCIL_TEST_LESS = UInt32($00010000);
  BGFX_STENCIL_TEST_LEQUAL = UInt32($00020000);
  BGFX_STENCIL_TEST_EQUAL = UInt32($00030000);
  BGFX_STENCIL_TEST_GEQUAL = UInt32($00040000);
  BGFX_STENCIL_TEST_GREATER = UInt32($00050000);
  BGFX_STENCIL_TEST_NOTEQUAL = UInt32($00060000);
  BGFX_STENCIL_TEST_NEVER = UInt32($00070000);
  BGFX_STENCIL_TEST_ALWAYS = UInt32($00080000);
  BGFX_STENCIL_TEST_SHIFT = 16;
  BGFX_STENCIL_TEST_MASK = UInt32($000f0000);
  BGFX_STENCIL_OP_FAIL_S_ZERO = UInt32($00000000);
  BGFX_STENCIL_OP_FAIL_S_KEEP = UInt32($00100000);
  BGFX_STENCIL_OP_FAIL_S_REPLACE = UInt32($00200000);
  BGFX_STENCIL_OP_FAIL_S_INCR = UInt32($00300000);
  BGFX_STENCIL_OP_FAIL_S_INCRSAT = UInt32($00400000);
  BGFX_STENCIL_OP_FAIL_S_DECR = UInt32($00500000);
  BGFX_STENCIL_OP_FAIL_S_DECRSAT = UInt32($00600000);
  BGFX_STENCIL_OP_FAIL_S_INVERT = UInt32($00700000);
  BGFX_STENCIL_OP_FAIL_S_SHIFT = 20;
  BGFX_STENCIL_OP_FAIL_S_MASK = UInt32($00f00000);
  BGFX_STENCIL_OP_FAIL_Z_ZERO = UInt32($00000000);
  BGFX_STENCIL_OP_FAIL_Z_KEEP = UInt32($01000000);
  BGFX_STENCIL_OP_FAIL_Z_REPLACE = UInt32($02000000);
  BGFX_STENCIL_OP_FAIL_Z_INCR = UInt32($03000000);
  BGFX_STENCIL_OP_FAIL_Z_INCRSAT = UInt32($04000000);
  BGFX_STENCIL_OP_FAIL_Z_DECR = UInt32($05000000);
  BGFX_STENCIL_OP_FAIL_Z_DECRSAT = UInt32($06000000);
  BGFX_STENCIL_OP_FAIL_Z_INVERT = UInt32($07000000);
  BGFX_STENCIL_OP_FAIL_Z_SHIFT = 24;
  BGFX_STENCIL_OP_FAIL_Z_MASK = UInt32($0f000000);
  BGFX_STENCIL_OP_PASS_Z_ZERO = UInt32($00000000);
  BGFX_STENCIL_OP_PASS_Z_KEEP = UInt32($10000000);
  BGFX_STENCIL_OP_PASS_Z_REPLACE = UInt32($20000000);
  BGFX_STENCIL_OP_PASS_Z_INCR = UInt32($30000000);
  BGFX_STENCIL_OP_PASS_Z_INCRSAT = UInt32($40000000);
  BGFX_STENCIL_OP_PASS_Z_DECR = UInt32($50000000);
  BGFX_STENCIL_OP_PASS_Z_DECRSAT = UInt32($60000000);
  BGFX_STENCIL_OP_PASS_Z_INVERT = UInt32($70000000);
  BGFX_STENCIL_OP_PASS_Z_SHIFT = 28;
  BGFX_STENCIL_OP_PASS_Z_MASK = UInt32($f0000000);
  BGFX_CLEAR_NONE = UInt16($0000);
  BGFX_CLEAR_COLOR = UInt16($0001);
  BGFX_CLEAR_DEPTH = UInt16($0002);
  BGFX_CLEAR_STENCIL = UInt16($0004);
  BGFX_CLEAR_DISCARD_COLOR_0 = UInt16($0008);
  BGFX_CLEAR_DISCARD_COLOR_1 = UInt16($0010);
  BGFX_CLEAR_DISCARD_COLOR_2 = UInt16($0020);
  BGFX_CLEAR_DISCARD_COLOR_3 = UInt16($0040);
  BGFX_CLEAR_DISCARD_COLOR_4 = UInt16($0080);
  BGFX_CLEAR_DISCARD_COLOR_5 = UInt16($0100);
  BGFX_CLEAR_DISCARD_COLOR_6 = UInt16($0200);
  BGFX_CLEAR_DISCARD_COLOR_7 = UInt16($0400);
  BGFX_CLEAR_DISCARD_DEPTH = UInt16($0800);
  BGFX_CLEAR_DISCARD_STENCIL = UInt16($1000);
  BGFX_CLEAR_DISCARD_COLOR_MASK = (0 or BGFX_CLEAR_DISCARD_COLOR_0 or BGFX_CLEAR_DISCARD_COLOR_1 or BGFX_CLEAR_DISCARD_COLOR_2 or BGFX_CLEAR_DISCARD_COLOR_3 or BGFX_CLEAR_DISCARD_COLOR_4 or BGFX_CLEAR_DISCARD_COLOR_5 or BGFX_CLEAR_DISCARD_COLOR_6 or BGFX_CLEAR_DISCARD_COLOR_7);
  BGFX_CLEAR_DISCARD_MASK = (0 or BGFX_CLEAR_DISCARD_COLOR_MASK or BGFX_CLEAR_DISCARD_DEPTH or BGFX_CLEAR_DISCARD_STENCIL);
  BGFX_DISCARD_INDEX_BUFFER = UInt8($01);
  BGFX_DISCARD_VERTEX_STREAMS = UInt8($02);
  BGFX_DISCARD_TEXTURE_SAMPLERS = UInt8($04);
  BGFX_DISCARD_COMPUTE = UInt8($08);
  BGFX_DISCARD_STATE = UInt8($10);
  BGFX_DISCARD_ALL = (0 or BGFX_DISCARD_INDEX_BUFFER or BGFX_DISCARD_VERTEX_STREAMS or BGFX_DISCARD_TEXTURE_SAMPLERS or BGFX_DISCARD_COMPUTE or BGFX_DISCARD_STATE);
  BGFX_DEBUG_NONE = UInt32($00000000);
  BGFX_DEBUG_WIREFRAME = UInt32($00000001);
  BGFX_DEBUG_IFH = UInt32($00000002);
  BGFX_DEBUG_STATS = UInt32($00000004);
  BGFX_DEBUG_TEXT = UInt32($00000008);
  BGFX_DEBUG_PROFILER = UInt32($00000010);
  BGFX_BUFFER_COMPUTE_FORMAT_8X1 = UInt16($0001);
  BGFX_BUFFER_COMPUTE_FORMAT_8X2 = UInt16($0002);
  BGFX_BUFFER_COMPUTE_FORMAT_8X4 = UInt16($0003);
  BGFX_BUFFER_COMPUTE_FORMAT_16X1 = UInt16($0004);
  BGFX_BUFFER_COMPUTE_FORMAT_16X2 = UInt16($0005);
  BGFX_BUFFER_COMPUTE_FORMAT_16X4 = UInt16($0006);
  BGFX_BUFFER_COMPUTE_FORMAT_32X1 = UInt16($0007);
  BGFX_BUFFER_COMPUTE_FORMAT_32X2 = UInt16($0008);
  BGFX_BUFFER_COMPUTE_FORMAT_32X4 = UInt16($0009);
  BGFX_BUFFER_COMPUTE_FORMAT_SHIFT = 0;
  BGFX_BUFFER_COMPUTE_FORMAT_MASK = UInt16($000f);
  BGFX_BUFFER_COMPUTE_TYPE_INT = UInt16($0010);
  BGFX_BUFFER_COMPUTE_TYPE_UINT = UInt16($0020);
  BGFX_BUFFER_COMPUTE_TYPE_FLOAT = UInt16($0030);
  BGFX_BUFFER_COMPUTE_TYPE_SHIFT = 4;
  BGFX_BUFFER_COMPUTE_TYPE_MASK = UInt16($0030);
  BGFX_BUFFER_NONE = UInt16($0000);
  BGFX_BUFFER_COMPUTE_READ = UInt16($0100);
  BGFX_BUFFER_COMPUTE_WRITE = UInt16($0200);
  BGFX_BUFFER_DRAW_INDIRECT = UInt16($0400);
  BGFX_BUFFER_ALLOW_RESIZE = UInt16($0800);
  BGFX_BUFFER_INDEX32 = UInt16($1000);
  BGFX_BUFFER_COMPUTE_READ_WRITE = (0 or BGFX_BUFFER_COMPUTE_READ or BGFX_BUFFER_COMPUTE_WRITE);
  BGFX_TEXTURE_NONE = UInt64($0000000000000000);
  BGFX_TEXTURE_MSAA_SAMPLE = UInt64($0000000800000000);
  BGFX_TEXTURE_RT = UInt64($0000001000000000);
  BGFX_TEXTURE_COMPUTE_WRITE = UInt64($0000100000000000);
  BGFX_TEXTURE_SRGB = UInt64($0000200000000000);
  BGFX_TEXTURE_BLIT_DST = UInt64($0000400000000000);
  BGFX_TEXTURE_READ_BACK = UInt64($0000800000000000);
  BGFX_TEXTURE_RT_MSAA_X2 = UInt64($0000002000000000);
  BGFX_TEXTURE_RT_MSAA_X4 = UInt64($0000003000000000);
  BGFX_TEXTURE_RT_MSAA_X8 = UInt64($0000004000000000);
  BGFX_TEXTURE_RT_MSAA_X16 = UInt64($0000005000000000);
  BGFX_TEXTURE_RT_MSAA_SHIFT = 36;
  BGFX_TEXTURE_RT_MSAA_MASK = UInt64($0000007000000000);
  BGFX_TEXTURE_RT_WRITE_ONLY = UInt64($0000008000000000);
  BGFX_TEXTURE_RT_SHIFT = 36;
  BGFX_TEXTURE_RT_MASK = UInt64($000000f000000000);
  BGFX_SAMPLER_U_MIRROR = UInt32($00000001);
  BGFX_SAMPLER_U_CLAMP = UInt32($00000002);
  BGFX_SAMPLER_U_BORDER = UInt32($00000003);
  BGFX_SAMPLER_U_SHIFT = 0;
  BGFX_SAMPLER_U_MASK = UInt32($00000003);
  BGFX_SAMPLER_V_MIRROR = UInt32($00000004);
  BGFX_SAMPLER_V_CLAMP = UInt32($00000008);
  BGFX_SAMPLER_V_BORDER = UInt32($0000000c);
  BGFX_SAMPLER_V_SHIFT = 2;
  BGFX_SAMPLER_V_MASK = UInt32($0000000c);
  BGFX_SAMPLER_W_MIRROR = UInt32($00000010);
  BGFX_SAMPLER_W_CLAMP = UInt32($00000020);
  BGFX_SAMPLER_W_BORDER = UInt32($00000030);
  BGFX_SAMPLER_W_SHIFT = 4;
  BGFX_SAMPLER_W_MASK = UInt32($00000030);
  BGFX_SAMPLER_MIN_POINT = UInt32($00000040);
  BGFX_SAMPLER_MIN_ANISOTROPIC = UInt32($00000080);
  BGFX_SAMPLER_MIN_SHIFT = 6;
  BGFX_SAMPLER_MIN_MASK = UInt32($000000c0);
  BGFX_SAMPLER_MAG_POINT = UInt32($00000100);
  BGFX_SAMPLER_MAG_ANISOTROPIC = UInt32($00000200);
  BGFX_SAMPLER_MAG_SHIFT = 8;
  BGFX_SAMPLER_MAG_MASK = UInt32($00000300);
  BGFX_SAMPLER_MIP_POINT = UInt32($00000400);
  BGFX_SAMPLER_MIP_SHIFT = 10;
  BGFX_SAMPLER_MIP_MASK = UInt32($00000400);
  BGFX_SAMPLER_COMPARE_LESS = UInt32($00010000);
  BGFX_SAMPLER_COMPARE_LEQUAL = UInt32($00020000);
  BGFX_SAMPLER_COMPARE_EQUAL = UInt32($00030000);
  BGFX_SAMPLER_COMPARE_GEQUAL = UInt32($00040000);
  BGFX_SAMPLER_COMPARE_GREATER = UInt32($00050000);
  BGFX_SAMPLER_COMPARE_NOTEQUAL = UInt32($00060000);
  BGFX_SAMPLER_COMPARE_NEVER = UInt32($00070000);
  BGFX_SAMPLER_COMPARE_ALWAYS = UInt32($00080000);
  BGFX_SAMPLER_COMPARE_SHIFT = 16;
  BGFX_SAMPLER_COMPARE_MASK = UInt32($000f0000);
  BGFX_SAMPLER_BORDER_COLOR_SHIFT = 24;
  BGFX_SAMPLER_BORDER_COLOR_MASK = UInt32($0f000000);
  BGFX_SAMPLER_RESERVED_SHIFT = 28;
  BGFX_SAMPLER_RESERVED_MASK = UInt32($f0000000);
  BGFX_SAMPLER_NONE = UInt32($00000000);
  BGFX_SAMPLER_SAMPLE_STENCIL = UInt32($00100000);
  BGFX_SAMPLER_POINT = (0 or BGFX_SAMPLER_MIN_POINT or BGFX_SAMPLER_MAG_POINT or BGFX_SAMPLER_MIP_POINT);
  BGFX_SAMPLER_UVW_MIRROR = (0 or BGFX_SAMPLER_U_MIRROR or BGFX_SAMPLER_V_MIRROR or BGFX_SAMPLER_W_MIRROR);
  BGFX_SAMPLER_UVW_CLAMP = (0 or BGFX_SAMPLER_U_CLAMP or BGFX_SAMPLER_V_CLAMP or BGFX_SAMPLER_W_CLAMP);
  BGFX_SAMPLER_UVW_BORDER = (0 or BGFX_SAMPLER_U_BORDER or BGFX_SAMPLER_V_BORDER or BGFX_SAMPLER_W_BORDER);
  BGFX_SAMPLER_BITS_MASK = (0 or BGFX_SAMPLER_U_MASK or BGFX_SAMPLER_V_MASK or BGFX_SAMPLER_W_MASK or BGFX_SAMPLER_MIN_MASK or BGFX_SAMPLER_MAG_MASK or BGFX_SAMPLER_MIP_MASK or BGFX_SAMPLER_COMPARE_MASK);
  BGFX_RESET_MSAA_X2 = UInt32($00000010);
  BGFX_RESET_MSAA_X4 = UInt32($00000020);
  BGFX_RESET_MSAA_X8 = UInt32($00000030);
  BGFX_RESET_MSAA_X16 = UInt32($00000040);
  BGFX_RESET_MSAA_SHIFT = 4;
  BGFX_RESET_MSAA_MASK = UInt32($00000070);
  BGFX_RESET_NONE = UInt32($00000000);
  BGFX_RESET_FULLSCREEN = UInt32($00000001);
  BGFX_RESET_VSYNC = UInt32($00000080);
  BGFX_RESET_MAXANISOTROPY = UInt32($00000100);
  BGFX_RESET_CAPTURE = UInt32($00000200);
  BGFX_RESET_FLUSH_AFTER_RENDER = UInt32($00002000);
  BGFX_RESET_FLIP_AFTER_RENDER = UInt32($00004000);
  BGFX_RESET_SRGB_BACKBUFFER = UInt32($00008000);
  BGFX_RESET_HDR10 = UInt32($00010000);
  BGFX_RESET_HIDPI = UInt32($00020000);
  BGFX_RESET_DEPTH_CLAMP = UInt32($00040000);
  BGFX_RESET_SUSPEND = UInt32($00080000);
  BGFX_RESET_FULLSCREEN_SHIFT = 0;
  BGFX_RESET_FULLSCREEN_MASK = UInt32($00000001);
  BGFX_RESET_RESERVED_SHIFT = 31;
  BGFX_RESET_RESERVED_MASK = UInt32($80000000);
  BGFX_CAPS_ALPHA_TO_COVERAGE = UInt64($0000000000000001);
  BGFX_CAPS_BLEND_INDEPENDENT = UInt64($0000000000000002);
  BGFX_CAPS_COMPUTE = UInt64($0000000000000004);
  BGFX_CAPS_CONSERVATIVE_RASTER = UInt64($0000000000000008);
  BGFX_CAPS_DRAW_INDIRECT = UInt64($0000000000000010);
  BGFX_CAPS_FRAGMENT_DEPTH = UInt64($0000000000000020);
  BGFX_CAPS_FRAGMENT_ORDERING = UInt64($0000000000000040);
  BGFX_CAPS_FRAMEBUFFER_RW = UInt64($0000000000000080);
  BGFX_CAPS_GRAPHICS_DEBUGGER = UInt64($0000000000000100);
  BGFX_CAPS_RESERVED = UInt64($0000000000000200);
  BGFX_CAPS_HDR10 = UInt64($0000000000000400);
  BGFX_CAPS_HIDPI = UInt64($0000000000000800);
  BGFX_CAPS_INDEX32 = UInt64($0000000000001000);
  BGFX_CAPS_INSTANCING = UInt64($0000000000002000);
  BGFX_CAPS_OCCLUSION_QUERY = UInt64($0000000000004000);
  BGFX_CAPS_RENDERER_MULTITHREADED = UInt64($0000000000008000);
  BGFX_CAPS_SWAP_CHAIN = UInt64($0000000000010000);
  BGFX_CAPS_TEXTURE_2D_ARRAY = UInt64($0000000000020000);
  BGFX_CAPS_TEXTURE_3D = UInt64($0000000000040000);
  BGFX_CAPS_TEXTURE_BLIT = UInt64($0000000000080000);
  BGFX_CAPS_TEXTURE_COMPARE_RESERVED = UInt64($0000000000100000);
  BGFX_CAPS_TEXTURE_COMPARE_LEQUAL = UInt64($0000000000200000);
  BGFX_CAPS_TEXTURE_CUBE_ARRAY = UInt64($0000000000400000);
  BGFX_CAPS_TEXTURE_DIRECT_ACCESS = UInt64($0000000000800000);
  BGFX_CAPS_TEXTURE_READ_BACK = UInt64($0000000001000000);
  BGFX_CAPS_VERTEX_ATTRIB_HALF = UInt64($0000000002000000);
  BGFX_CAPS_VERTEX_ATTRIB_UINT10 = UInt64($0000000004000000);
  BGFX_CAPS_VERTEX_ID = UInt64($0000000008000000);
  BGFX_CAPS_TEXTURE_COMPARE_ALL = (0 or BGFX_CAPS_TEXTURE_COMPARE_RESERVED or BGFX_CAPS_TEXTURE_COMPARE_LEQUAL);
  BGFX_CAPS_FORMAT_TEXTURE_NONE = UInt16($0000);
  BGFX_CAPS_FORMAT_TEXTURE_2D = UInt16($0001);
  BGFX_CAPS_FORMAT_TEXTURE_2D_SRGB = UInt16($0002);
  BGFX_CAPS_FORMAT_TEXTURE_2D_EMULATED = UInt16($0004);
  BGFX_CAPS_FORMAT_TEXTURE_3D = UInt16($0008);
  BGFX_CAPS_FORMAT_TEXTURE_3D_SRGB = UInt16($0010);
  BGFX_CAPS_FORMAT_TEXTURE_3D_EMULATED = UInt16($0020);
  BGFX_CAPS_FORMAT_TEXTURE_CUBE = UInt16($0040);
  BGFX_CAPS_FORMAT_TEXTURE_CUBE_SRGB = UInt16($0080);
  BGFX_CAPS_FORMAT_TEXTURE_CUBE_EMULATED = UInt16($0100);
  BGFX_CAPS_FORMAT_TEXTURE_VERTEX = UInt16($0200);
  BGFX_CAPS_FORMAT_TEXTURE_IMAGE = UInt16($0400);
  BGFX_CAPS_FORMAT_TEXTURE_FRAMEBUFFER = UInt16($0800);
  BGFX_CAPS_FORMAT_TEXTURE_FRAMEBUFFER_MSAA = UInt16($1000);
  BGFX_CAPS_FORMAT_TEXTURE_MSAA = UInt16($2000);
  BGFX_CAPS_FORMAT_TEXTURE_MIP_AUTOGEN = UInt16($4000);
  BGFX_RESOLVE_NONE = UInt8($00);
  BGFX_RESOLVE_AUTO_GEN_MIPS = UInt8($01);
  BGFX_PCI_ID_NONE = UInt16($0000);
  BGFX_PCI_ID_SOFTWARE_RASTERIZER = UInt16($0001);
  BGFX_PCI_ID_AMD = UInt16($1002);
  BGFX_PCI_ID_INTEL = UInt16($8086);
  BGFX_PCI_ID_NVIDIA = UInt16($10de);
  BGFX_CUBE_MAP_POSITIVE_X = UInt8($00);
  BGFX_CUBE_MAP_NEGATIVE_X = UInt8($01);
  BGFX_CUBE_MAP_POSITIVE_Y = UInt8($02);
  BGFX_CUBE_MAP_NEGATIVE_Y = UInt8($03);
  BGFX_CUBE_MAP_POSITIVE_Z = UInt8($04);
  BGFX_CUBE_MAP_NEGATIVE_Z = UInt8($05);

type
  // Forward declarations
  Pbgfx_encoder_s = Pointer;
  PPbgfx_encoder_s = ^Pbgfx_encoder_s;
  Pbgfx_allocator_interface_s = ^bgfx_allocator_interface_s;
  Pbgfx_allocator_vtbl_s = ^bgfx_allocator_vtbl_s;
  Pbgfx_callback_interface_s = ^bgfx_callback_interface_s;
  Pbgfx_callback_vtbl_s = ^bgfx_callback_vtbl_s;
  Pbgfx_dynamic_index_buffer_handle_s = ^bgfx_dynamic_index_buffer_handle_s;
  Pbgfx_dynamic_vertex_buffer_handle_s = ^bgfx_dynamic_vertex_buffer_handle_s;
  Pbgfx_frame_buffer_handle_s = ^bgfx_frame_buffer_handle_s;
  Pbgfx_index_buffer_handle_s = ^bgfx_index_buffer_handle_s;
  Pbgfx_indirect_buffer_handle_s = ^bgfx_indirect_buffer_handle_s;
  Pbgfx_occlusion_query_handle_s = ^bgfx_occlusion_query_handle_s;
  Pbgfx_program_handle_s = ^bgfx_program_handle_s;
  Pbgfx_shader_handle_s = ^bgfx_shader_handle_s;
  Pbgfx_texture_handle_s = ^bgfx_texture_handle_s;
  Pbgfx_uniform_handle_s = ^bgfx_uniform_handle_s;
  Pbgfx_vertex_buffer_handle_s = ^bgfx_vertex_buffer_handle_s;
  Pbgfx_vertex_layout_handle_s = ^bgfx_vertex_layout_handle_s;
  Pbgfx_caps_gpu_s = ^bgfx_caps_gpu_s;
  Pbgfx_caps_limits_s = ^bgfx_caps_limits_s;
  Pbgfx_caps_s = ^bgfx_caps_s;
  Pbgfx_internal_data_s = ^bgfx_internal_data_s;
  Pbgfx_platform_data_s = ^bgfx_platform_data_s;
  Pbgfx_resolution_s = ^bgfx_resolution_s;
  Pbgfx_init_limits_s = ^bgfx_init_limits_s;
  Pbgfx_init_s = ^bgfx_init_s;
  Pbgfx_memory_s = ^bgfx_memory_s;
  Pbgfx_transient_index_buffer_s = ^bgfx_transient_index_buffer_s;
  Pbgfx_transient_vertex_buffer_s = ^bgfx_transient_vertex_buffer_s;
  Pbgfx_instance_data_buffer_s = ^bgfx_instance_data_buffer_s;
  Pbgfx_texture_info_s = ^bgfx_texture_info_s;
  Pbgfx_uniform_info_s = ^bgfx_uniform_info_s;
  Pbgfx_attachment_s = ^bgfx_attachment_s;
  Pbgfx_transform_s = ^bgfx_transform_s;
  Pbgfx_view_stats_s = ^bgfx_view_stats_s;
  Pbgfx_encoder_stats_s = ^bgfx_encoder_stats_s;
  Pbgfx_stats_s = ^bgfx_stats_s;
  Pbgfx_vertex_layout_s = ^bgfx_vertex_layout_s;
  Pbgfx_interface_vtbl = ^bgfx_interface_vtbl;

  (* Fatal error enum. *)
  bgfx_fatal = (
    BGFX_FATAL_DEBUG_CHECK = 0,
    (* ( 0) *)
    BGFX_FATAL_INVALID_SHADER = 1,
    (* ( 1) *)
    BGFX_FATAL_UNABLE_TO_INITIALIZE = 2,
    (* ( 2) *)
    BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE = 3,
    (* ( 3) *)
    BGFX_FATAL_DEVICE_LOST = 4,
    (* ( 4) *)
    BGFX_FATAL_COUNT = 5);
  Pbgfx_fatal = ^bgfx_fatal;
  (* Fatal error enum. *)
  bgfx_fatal_t = bgfx_fatal;

  (* Renderer backend type enum. *)
  bgfx_renderer_type = (
    BGFX_RENDERER_TYPE_NOOP = 0,
    (* ( 0) No rendering. *)
    BGFX_RENDERER_TYPE_DIRECT3D9 = 1,
    (* ( 1) Direct3D 9.0 *)
    BGFX_RENDERER_TYPE_DIRECT3D11 = 2,
    (* ( 2) Direct3D 11.0 *)
    BGFX_RENDERER_TYPE_DIRECT3D12 = 3,
    (* ( 3) Direct3D 12.0 *)
    BGFX_RENDERER_TYPE_GNM = 4,
    (* ( 4) GNM *)
    BGFX_RENDERER_TYPE_METAL = 5,
    (* ( 5) Metal *)
    BGFX_RENDERER_TYPE_NVN = 6,
    (* ( 6) NVN *)
    BGFX_RENDERER_TYPE_OPENGLES = 7,
    (* ( 7) OpenGL ES 2.0+ *)
    BGFX_RENDERER_TYPE_OPENGL = 8,
    (* ( 8) OpenGL 2.1+ *)
    BGFX_RENDERER_TYPE_VULKAN = 9,
    (* ( 9) Vulkan *)
    BGFX_RENDERER_TYPE_COUNT = 10);
  Pbgfx_renderer_type = ^bgfx_renderer_type;
  (* Renderer backend type enum. *)
  bgfx_renderer_type_t = bgfx_renderer_type;
  Pbgfx_renderer_type_t = ^bgfx_renderer_type_t;

  (* Access mode enum. *)
  bgfx_access = (
    BGFX_ACCESS_READ = 0,
    (* ( 0) Read. *)
    BGFX_ACCESS_WRITE = 1,
    (* ( 1) Write. *)
    BGFX_ACCESS_READWRITE = 2,
    (* ( 2) Read and write. *)
    BGFX_ACCESS_COUNT = 3);
  Pbgfx_access = ^bgfx_access;
  (* Access mode enum. *)
  bgfx_access_t = bgfx_access;

  (* Vertex attribute enum. *)
  bgfx_attrib = (
    BGFX_ATTRIB_POSITION = 0,
    (* ( 0) a_position *)
    BGFX_ATTRIB_NORMAL = 1,
    (* ( 1) a_normal *)
    BGFX_ATTRIB_TANGENT = 2,
    (* ( 2) a_tangent *)
    BGFX_ATTRIB_BITANGENT = 3,
    (* ( 3) a_bitangent *)
    BGFX_ATTRIB_COLOR0 = 4,
    (* ( 4) a_color0 *)
    BGFX_ATTRIB_COLOR1 = 5,
    (* ( 5) a_color1 *)
    BGFX_ATTRIB_COLOR2 = 6,
    (* ( 6) a_color2 *)
    BGFX_ATTRIB_COLOR3 = 7,
    (* ( 7) a_color3 *)
    BGFX_ATTRIB_INDICES = 8,
    (* ( 8) a_indices *)
    BGFX_ATTRIB_WEIGHT = 9,
    (* ( 9) a_weight *)
    BGFX_ATTRIB_TEXCOORD0 = 10,
    (* (10) a_texcoord0 *)
    BGFX_ATTRIB_TEXCOORD1 = 11,
    (* (11) a_texcoord1 *)
    BGFX_ATTRIB_TEXCOORD2 = 12,
    (* (12) a_texcoord2 *)
    BGFX_ATTRIB_TEXCOORD3 = 13,
    (* (13) a_texcoord3 *)
    BGFX_ATTRIB_TEXCOORD4 = 14,
    (* (14) a_texcoord4 *)
    BGFX_ATTRIB_TEXCOORD5 = 15,
    (* (15) a_texcoord5 *)
    BGFX_ATTRIB_TEXCOORD6 = 16,
    (* (16) a_texcoord6 *)
    BGFX_ATTRIB_TEXCOORD7 = 17,
    (* (17) a_texcoord7 *)
    BGFX_ATTRIB_COUNT = 18);
  Pbgfx_attrib = ^bgfx_attrib;
  (* Vertex attribute enum. *)
  bgfx_attrib_t = bgfx_attrib;

  (* Vertex attribute type enum. *)
  bgfx_attrib_type = (
    BGFX_ATTRIB_TYPE_UINT8 = 0,
    (* ( 0) Uint8 *)
    BGFX_ATTRIB_TYPE_UINT10 = 1,
    (* ( 1) Uint10, availability depends on: `BGFX_CAPS_VERTEX_ATTRIB_UINT10`. *)
    BGFX_ATTRIB_TYPE_INT16 = 2,
    (* ( 2) Int16 *)
    BGFX_ATTRIB_TYPE_HALF = 3,
    (* ( 3) Half, availability depends on: `BGFX_CAPS_VERTEX_ATTRIB_HALF`. *)
    BGFX_ATTRIB_TYPE_FLOAT = 4,
    (* ( 4) Float *)
    BGFX_ATTRIB_TYPE_COUNT = 5);
  Pbgfx_attrib_type = ^bgfx_attrib_type;
  (* Vertex attribute type enum. *)
  bgfx_attrib_type_t = bgfx_attrib_type;
  Pbgfx_attrib_type_t = ^bgfx_attrib_type_t;

  (* Texture format enum.
     Notation:
     RGBA16S
     ^   ^ ^
     |   | +-- [ ]Unorm
     |   |     [F]loat
     |   |     [S]norm
     |   |     [I]nt
     |   |     [U]int
     |   +---- Number of bits per component
     +-------- Components

     Availability depends on Caps (see: formats). *)
  bgfx_texture_format = (
    BGFX_TEXTURE_FORMAT_BC1 = 0,
    (* ( 0) DXT1 R5G6B5A1 *)
    BGFX_TEXTURE_FORMAT_BC2 = 1,
    (* ( 1) DXT3 R5G6B5A4 *)
    BGFX_TEXTURE_FORMAT_BC3 = 2,
    (* ( 2) DXT5 R5G6B5A8 *)
    BGFX_TEXTURE_FORMAT_BC4 = 3,
    (* ( 3) LATC1/ATI1 R8 *)
    BGFX_TEXTURE_FORMAT_BC5 = 4,
    (* ( 4) LATC2/ATI2 RG8 *)
    BGFX_TEXTURE_FORMAT_BC6H = 5,
    (* ( 5) BC6H RGB16F *)
    BGFX_TEXTURE_FORMAT_BC7 = 6,
    (* ( 6) BC7 RGB 4-7 bits per color channel, 0-8 bits alpha *)
    BGFX_TEXTURE_FORMAT_ETC1 = 7,
    (* ( 7) ETC1 RGB8 *)
    BGFX_TEXTURE_FORMAT_ETC2 = 8,
    (* ( 8) ETC2 RGB8 *)
    BGFX_TEXTURE_FORMAT_ETC2A = 9,
    (* ( 9) ETC2 RGBA8 *)
    BGFX_TEXTURE_FORMAT_ETC2A1 = 10,
    (* (10) ETC2 RGB8A1 *)
    BGFX_TEXTURE_FORMAT_PTC12 = 11,
    (* (11) PVRTC1 RGB 2BPP *)
    BGFX_TEXTURE_FORMAT_PTC14 = 12,
    (* (12) PVRTC1 RGB 4BPP *)
    BGFX_TEXTURE_FORMAT_PTC12A = 13,
    (* (13) PVRTC1 RGBA 2BPP *)
    BGFX_TEXTURE_FORMAT_PTC14A = 14,
    (* (14) PVRTC1 RGBA 4BPP *)
    BGFX_TEXTURE_FORMAT_PTC22 = 15,
    (* (15) PVRTC2 RGBA 2BPP *)
    BGFX_TEXTURE_FORMAT_PTC24 = 16,
    (* (16) PVRTC2 RGBA 4BPP *)
    BGFX_TEXTURE_FORMAT_ATC = 17,
    (* (17) ATC RGB 4BPP *)
    BGFX_TEXTURE_FORMAT_ATCE = 18,
    (* (18) ATCE RGBA 8 BPP explicit alpha *)
    BGFX_TEXTURE_FORMAT_ATCI = 19,
    (* (19) ATCI RGBA 8 BPP interpolated alpha *)
    BGFX_TEXTURE_FORMAT_ASTC4X4 = 20,
    (* (20) ASTC 4x4 8.0 BPP *)
    BGFX_TEXTURE_FORMAT_ASTC5X5 = 21,
    (* (21) ASTC 5x5 5.12 BPP *)
    BGFX_TEXTURE_FORMAT_ASTC6X6 = 22,
    (* (22) ASTC 6x6 3.56 BPP *)
    BGFX_TEXTURE_FORMAT_ASTC8X5 = 23,
    (* (23) ASTC 8x5 3.20 BPP *)
    BGFX_TEXTURE_FORMAT_ASTC8X6 = 24,
    (* (24) ASTC 8x6 2.67 BPP *)
    BGFX_TEXTURE_FORMAT_ASTC10X5 = 25,
    (* (25) ASTC 10x5 2.56 BPP *)
    BGFX_TEXTURE_FORMAT_UNKNOWN = 26,
    (* (26) Compressed formats above. *)
    BGFX_TEXTURE_FORMAT_R1 = 27,
    (* (27) *)
    BGFX_TEXTURE_FORMAT_A8 = 28,
    (* (28) *)
    BGFX_TEXTURE_FORMAT_R8 = 29,
    (* (29) *)
    BGFX_TEXTURE_FORMAT_R8I = 30,
    (* (30) *)
    BGFX_TEXTURE_FORMAT_R8U = 31,
    (* (31) *)
    BGFX_TEXTURE_FORMAT_R8S = 32,
    (* (32) *)
    BGFX_TEXTURE_FORMAT_R16 = 33,
    (* (33) *)
    BGFX_TEXTURE_FORMAT_R16I = 34,
    (* (34) *)
    BGFX_TEXTURE_FORMAT_R16U = 35,
    (* (35) *)
    BGFX_TEXTURE_FORMAT_R16F = 36,
    (* (36) *)
    BGFX_TEXTURE_FORMAT_R16S = 37,
    (* (37) *)
    BGFX_TEXTURE_FORMAT_R32I = 38,
    (* (38) *)
    BGFX_TEXTURE_FORMAT_R32U = 39,
    (* (39) *)
    BGFX_TEXTURE_FORMAT_R32F = 40,
    (* (40) *)
    BGFX_TEXTURE_FORMAT_RG8 = 41,
    (* (41) *)
    BGFX_TEXTURE_FORMAT_RG8I = 42,
    (* (42) *)
    BGFX_TEXTURE_FORMAT_RG8U = 43,
    (* (43) *)
    BGFX_TEXTURE_FORMAT_RG8S = 44,
    (* (44) *)
    BGFX_TEXTURE_FORMAT_RG16 = 45,
    (* (45) *)
    BGFX_TEXTURE_FORMAT_RG16I = 46,
    (* (46) *)
    BGFX_TEXTURE_FORMAT_RG16U = 47,
    (* (47) *)
    BGFX_TEXTURE_FORMAT_RG16F = 48,
    (* (48) *)
    BGFX_TEXTURE_FORMAT_RG16S = 49,
    (* (49) *)
    BGFX_TEXTURE_FORMAT_RG32I = 50,
    (* (50) *)
    BGFX_TEXTURE_FORMAT_RG32U = 51,
    (* (51) *)
    BGFX_TEXTURE_FORMAT_RG32F = 52,
    (* (52) *)
    BGFX_TEXTURE_FORMAT_RGB8 = 53,
    (* (53) *)
    BGFX_TEXTURE_FORMAT_RGB8I = 54,
    (* (54) *)
    BGFX_TEXTURE_FORMAT_RGB8U = 55,
    (* (55) *)
    BGFX_TEXTURE_FORMAT_RGB8S = 56,
    (* (56) *)
    BGFX_TEXTURE_FORMAT_RGB9E5F = 57,
    (* (57) *)
    BGFX_TEXTURE_FORMAT_BGRA8 = 58,
    (* (58) *)
    BGFX_TEXTURE_FORMAT_RGBA8 = 59,
    (* (59) *)
    BGFX_TEXTURE_FORMAT_RGBA8I = 60,
    (* (60) *)
    BGFX_TEXTURE_FORMAT_RGBA8U = 61,
    (* (61) *)
    BGFX_TEXTURE_FORMAT_RGBA8S = 62,
    (* (62) *)
    BGFX_TEXTURE_FORMAT_RGBA16 = 63,
    (* (63) *)
    BGFX_TEXTURE_FORMAT_RGBA16I = 64,
    (* (64) *)
    BGFX_TEXTURE_FORMAT_RGBA16U = 65,
    (* (65) *)
    BGFX_TEXTURE_FORMAT_RGBA16F = 66,
    (* (66) *)
    BGFX_TEXTURE_FORMAT_RGBA16S = 67,
    (* (67) *)
    BGFX_TEXTURE_FORMAT_RGBA32I = 68,
    (* (68) *)
    BGFX_TEXTURE_FORMAT_RGBA32U = 69,
    (* (69) *)
    BGFX_TEXTURE_FORMAT_RGBA32F = 70,
    (* (70) *)
    BGFX_TEXTURE_FORMAT_R5G6B5 = 71,
    (* (71) *)
    BGFX_TEXTURE_FORMAT_RGBA4 = 72,
    (* (72) *)
    BGFX_TEXTURE_FORMAT_RGB5A1 = 73,
    (* (73) *)
    BGFX_TEXTURE_FORMAT_RGB10A2 = 74,
    (* (74) *)
    BGFX_TEXTURE_FORMAT_RG11B10F = 75,
    (* (75) *)
    BGFX_TEXTURE_FORMAT_UNKNOWNDEPTH = 76,
    (* (76) Depth formats below. *)
    BGFX_TEXTURE_FORMAT_D16 = 77,
    (* (77) *)
    BGFX_TEXTURE_FORMAT_D24 = 78,
    (* (78) *)
    BGFX_TEXTURE_FORMAT_D24S8 = 79,
    (* (79) *)
    BGFX_TEXTURE_FORMAT_D32 = 80,
    (* (80) *)
    BGFX_TEXTURE_FORMAT_D16F = 81,
    (* (81) *)
    BGFX_TEXTURE_FORMAT_D24F = 82,
    (* (82) *)
    BGFX_TEXTURE_FORMAT_D32F = 83,
    (* (83) *)
    BGFX_TEXTURE_FORMAT_D0S8 = 84,
    (* (84) *)
    BGFX_TEXTURE_FORMAT_COUNT = 85);
  Pbgfx_texture_format = ^bgfx_texture_format;
  (* Texture format enum.
     Notation:
     RGBA16S
     ^   ^ ^
     |   | +-- [ ]Unorm
     |   |     [F]loat
     |   |     [S]norm
     |   |     [I]nt
     |   |     [U]int
     |   +---- Number of bits per component
     +-------- Components

     Availability depends on Caps (see: formats). *)
  bgfx_texture_format_t = bgfx_texture_format;

  (* Uniform type enum. *)
  bgfx_uniform_type = (
    BGFX_UNIFORM_TYPE_SAMPLER = 0,
    (* ( 0) Sampler. *)
    BGFX_UNIFORM_TYPE_END = 1,
    (* ( 1) Reserved, do not use. *)
    BGFX_UNIFORM_TYPE_VEC4 = 2,
    (* ( 2) 4 floats vector. *)
    BGFX_UNIFORM_TYPE_MAT3 = 3,
    (* ( 3) 3x3 matrix. *)
    BGFX_UNIFORM_TYPE_MAT4 = 4,
    (* ( 4) 4x4 matrix. *)
    BGFX_UNIFORM_TYPE_COUNT = 5);
  Pbgfx_uniform_type = ^bgfx_uniform_type;
  (* Uniform type enum. *)
  bgfx_uniform_type_t = bgfx_uniform_type;

  (* Backbuffer ratio enum. *)
  bgfx_backbuffer_ratio = (
    BGFX_BACKBUFFER_RATIO_EQUAL = 0,
    (* ( 0) Equal to backbuffer. *)
    BGFX_BACKBUFFER_RATIO_HALF = 1,
    (* ( 1) One half size of backbuffer. *)
    BGFX_BACKBUFFER_RATIO_QUARTER = 2,
    (* ( 2) One quarter size of backbuffer. *)
    BGFX_BACKBUFFER_RATIO_EIGHTH = 3,
    (* ( 3) One eighth size of backbuffer. *)
    BGFX_BACKBUFFER_RATIO_SIXTEENTH = 4,
    (* ( 4) One sixteenth size of backbuffer. *)
    BGFX_BACKBUFFER_RATIO_DOUBLE = 5,
    (* ( 5) Double size of backbuffer. *)
    BGFX_BACKBUFFER_RATIO_COUNT = 6);
  Pbgfx_backbuffer_ratio = ^bgfx_backbuffer_ratio;
  (* Backbuffer ratio enum. *)
  bgfx_backbuffer_ratio_t = bgfx_backbuffer_ratio;

  (* Occlusion query result. *)
  bgfx_occlusion_query_result = (
    BGFX_OCCLUSION_QUERY_RESULT_INVISIBLE = 0,
    (* ( 0) Query failed test. *)
    BGFX_OCCLUSION_QUERY_RESULT_VISIBLE = 1,
    (* ( 1) Query passed test. *)
    BGFX_OCCLUSION_QUERY_RESULT_NORESULT = 2,
    (* ( 2) Query result is not available yet. *)
    BGFX_OCCLUSION_QUERY_RESULT_COUNT = 3);
  Pbgfx_occlusion_query_result = ^bgfx_occlusion_query_result;
  (* Occlusion query result. *)
  bgfx_occlusion_query_result_t = bgfx_occlusion_query_result;

  (* Primitive topology. *)
  bgfx_topology = (
    BGFX_TOPOLOGY_TRI_LIST = 0,
    (* ( 0) Triangle list. *)
    BGFX_TOPOLOGY_TRI_STRIP = 1,
    (* ( 1) Triangle strip. *)
    BGFX_TOPOLOGY_LINE_LIST = 2,
    (* ( 2) Line list. *)
    BGFX_TOPOLOGY_LINE_STRIP = 3,
    (* ( 3) Line strip. *)
    BGFX_TOPOLOGY_POINT_LIST = 4,
    (* ( 4) Point list. *)
    BGFX_TOPOLOGY_COUNT = 5);
  Pbgfx_topology = ^bgfx_topology;
  (* Primitive topology. *)
  bgfx_topology_t = bgfx_topology;

  (* Topology conversion function. *)
  bgfx_topology_convert_t = (
    BGFX_TOPOLOGY_CONVERT_TRI_LIST_FLIP_WINDING = 0,
    (* ( 0) Flip winding order of triangle list. *)
    BGFX_TOPOLOGY_CONVERT_TRI_STRIP_FLIP_WINDING = 1,
    (* ( 1) Flip winding order of trinagle strip. *)
    BGFX_TOPOLOGY_CONVERT_TRI_LIST_TO_LINE_LIST = 2,
    (* ( 2) Convert triangle list to line list. *)
    BGFX_TOPOLOGY_CONVERT_TRI_STRIP_TO_TRI_LIST = 3,
    (* ( 3) Convert triangle strip to triangle list. *)
    BGFX_TOPOLOGY_CONVERT_LINE_STRIP_TO_LINE_LIST = 4,
    (* ( 4) Convert line strip to line list. *)
    BGFX_TOPOLOGY_CONVERT_COUNT = 5);
  Pbgfx_topology_convert = ^bgfx_topology_convert_t;
  (* Topology conversion function. *)

  (* Topology sort order. *)
  bgfx_topology_sort = (
    BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_MIN = 0,
    (* ( 0) *)
    BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_AVG = 1,
    (* ( 1) *)
    BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_MAX = 2,
    (* ( 2) *)
    BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_MIN = 3,
    (* ( 3) *)
    BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_AVG = 4,
    (* ( 4) *)
    BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_MAX = 5,
    (* ( 5) *)
    BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_MIN = 6,
    (* ( 6) *)
    BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_AVG = 7,
    (* ( 7) *)
    BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_MAX = 8,
    (* ( 8) *)
    BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_MIN = 9,
    (* ( 9) *)
    BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_AVG = 10,
    (* (10) *)
    BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_MAX = 11,
    (* (11) *)
    BGFX_TOPOLOGY_SORT_COUNT = 12);
  Pbgfx_topology_sort = ^bgfx_topology_sort;
  (* Topology sort order. *)
  bgfx_topology_sort_t = bgfx_topology_sort;

  (* View mode sets draw call sort order. *)
  bgfx_view_mode = (
    BGFX_VIEW_MODE_DEFAULT = 0,
    (* ( 0) Default sort order. *)
    BGFX_VIEW_MODE_SEQUENTIAL = 1,
    (* ( 1) Sort in the same order in which submit calls were called. *)
    BGFX_VIEW_MODE_DEPTH_ASCENDING = 2,
    (* ( 2) Sort draw call depth in ascending order. *)
    BGFX_VIEW_MODE_DEPTH_DESCENDING = 3,
    (* ( 3) Sort draw call depth in descending order. *)
    BGFX_VIEW_MODE_COUNT = 4);
  Pbgfx_view_mode = ^bgfx_view_mode;
  (* View mode sets draw call sort order. *)
  bgfx_view_mode_t = bgfx_view_mode;

  (* Render frame enum. *)
  bgfx_render_frame_t = (
    BGFX_RENDER_FRAME_NO_CONTEXT = 0,
    (* ( 0) Renderer context is not created yet. *)
    BGFX_RENDER_FRAME_RENDER = 1,
    (* ( 1) Renderer context is created and rendering. *)
    BGFX_RENDER_FRAME_TIMEOUT = 2,
    (* ( 2) Renderer context wait for main thread signal timed out without rendering. *)
    BGFX_RENDER_FRAME_EXITING = 3,
    (* ( 3) Renderer context is getting destroyed. *)
    BGFX_RENDER_FRAME_COUNT = 4);
  Pbgfx_render_frame = ^bgfx_render_frame_t;

  (* *)
  bgfx_view_id_t = UInt16;
  Pbgfx_view_id_t = ^bgfx_view_id_t;

  (* *)
  bgfx_allocator_interface_s = record
    vtbl: Pbgfx_allocator_vtbl_s;
  end;

  (* *)
  bgfx_allocator_interface_t = bgfx_allocator_interface_s;
  Pbgfx_allocator_interface_t = ^bgfx_allocator_interface_t;

  (* *)
  bgfx_allocator_vtbl_s = record
    realloc: function(_this: Pbgfx_allocator_interface_t; _ptr: Pointer; _size: NativeUInt; _align: NativeUInt; _file: PUTF8Char; _line: UInt32): Pointer; cdecl;
  end;

  (* *)
  bgfx_allocator_vtbl_t = bgfx_allocator_vtbl_s;

  (* *)
  bgfx_callback_interface_s = record
    vtbl: Pbgfx_callback_vtbl_s;
  end;

  (* *)
  bgfx_callback_interface_t = bgfx_callback_interface_s;
  Pbgfx_callback_interface_t = ^bgfx_callback_interface_t;

  (* *)
  bgfx_callback_vtbl_s = record
    fatal: procedure(_this: Pbgfx_callback_interface_t; _filePath: PUTF8Char; _line: UInt16; _code: bgfx_fatal_t; _str: PUTF8Char); cdecl;
    trace_vargs: procedure(_this: Pbgfx_callback_interface_t; _filePath: PUTF8Char; _line: UInt16; _format: PUTF8Char; _argList: Pointer); cdecl;
    profiler_begin: procedure(_this: Pbgfx_callback_interface_t; _name: PUTF8Char; _abgr: UInt32; _filePath: PUTF8Char; _line: UInt16); cdecl;
    profiler_begin_literal: procedure(_this: Pbgfx_callback_interface_t; _name: PUTF8Char; _abgr: UInt32; _filePath: PUTF8Char; _line: UInt16); cdecl;
    profiler_end: procedure(_this: Pbgfx_callback_interface_t); cdecl;
    cache_read_size: function(_this: Pbgfx_callback_interface_t; _id: UInt64): UInt32; cdecl;
    cache_read: function(_this: Pbgfx_callback_interface_t; _id: UInt64; _data: Pointer; _size: UInt32): Boolean; cdecl;
    cache_write: procedure(_this: Pbgfx_callback_interface_t; _id: UInt64; _data: Pointer; _size: UInt32); cdecl;
    screen_shot: procedure(_this: Pbgfx_callback_interface_t; _filePath: PUTF8Char; _width: UInt32; _height: UInt32; _pitch: UInt32; _data: Pointer; _size: UInt32; _yflip: Boolean); cdecl;
    capture_begin: procedure(_this: Pbgfx_callback_interface_t; _width: UInt32; _height: UInt32; _pitch: UInt32; _format: bgfx_texture_format_t; _yflip: Boolean); cdecl;
    capture_end: procedure(_this: Pbgfx_callback_interface_t); cdecl;
    capture_frame: procedure(_this: Pbgfx_callback_interface_t; _data: Pointer; _size: UInt32); cdecl;
  end;

  (* *)
  bgfx_callback_vtbl_t = bgfx_callback_vtbl_s;

  bgfx_dynamic_index_buffer_handle_s = record
    idx: UInt16;
  end;

  bgfx_dynamic_index_buffer_handle_t = bgfx_dynamic_index_buffer_handle_s;

  bgfx_dynamic_vertex_buffer_handle_s = record
    idx: UInt16;
  end;

  bgfx_dynamic_vertex_buffer_handle_t = bgfx_dynamic_vertex_buffer_handle_s;

  bgfx_frame_buffer_handle_s = record
    idx: UInt16;
  end;

  bgfx_frame_buffer_handle_t = bgfx_frame_buffer_handle_s;

  bgfx_index_buffer_handle_s = record
    idx: UInt16;
  end;

  bgfx_index_buffer_handle_t = bgfx_index_buffer_handle_s;

  bgfx_indirect_buffer_handle_s = record
    idx: UInt16;
  end;

  bgfx_indirect_buffer_handle_t = bgfx_indirect_buffer_handle_s;

  bgfx_occlusion_query_handle_s = record
    idx: UInt16;
  end;

  bgfx_occlusion_query_handle_t = bgfx_occlusion_query_handle_s;

  bgfx_program_handle_s = record
    idx: UInt16;
  end;

  bgfx_program_handle_t = bgfx_program_handle_s;

  bgfx_shader_handle_s = record
    idx: UInt16;
  end;

  bgfx_shader_handle_t = bgfx_shader_handle_s;

  bgfx_texture_handle_s = record
    idx: UInt16;
  end;

  bgfx_texture_handle_t = bgfx_texture_handle_s;
  Pbgfx_texture_handle_t = ^bgfx_texture_handle_t;

  bgfx_uniform_handle_s = record
    idx: UInt16;
  end;

  bgfx_uniform_handle_t = bgfx_uniform_handle_s;
  Pbgfx_uniform_handle_t = ^bgfx_uniform_handle_t;

  bgfx_vertex_buffer_handle_s = record
    idx: UInt16;
  end;

  bgfx_vertex_buffer_handle_t = bgfx_vertex_buffer_handle_s;

  bgfx_vertex_layout_handle_s = record
    idx: UInt16;
  end;

  bgfx_vertex_layout_handle_t = bgfx_vertex_layout_handle_s;

  (* Memory release callback.
     @param(_ptr [in] Pointer to allocated data.)
     @param(_userData [in] User defined data if needed.) *)
  bgfx_release_fn_t = procedure(_ptr: Pointer; _userData: Pointer); cdecl;

  (* GPU info. *)
  bgfx_caps_gpu_s = record
    vendorId: UInt16;
    (* Vendor PCI id. See `BGFX_PCI_ID_*`. *)
    deviceId: UInt16;
  end;

  (* GPU info. *)
  bgfx_caps_gpu_t = bgfx_caps_gpu_s;

  (* Renderer capabilities limits. *)
  bgfx_caps_limits_s = record
    maxDrawCalls: UInt32;
    (* Maximum number of draw calls. *)
    maxBlits: UInt32;
    (* Maximum number of blit calls. *)
    maxTextureSize: UInt32;
    (* Maximum texture size. *)
    maxTextureLayers: UInt32;
    (* Maximum texture layers. *)
    maxViews: UInt32;
    (* Maximum number of views. *)
    maxFrameBuffers: UInt32;
    (* Maximum number of frame buffer handles. *)
    maxFBAttachments: UInt32;
    (* Maximum number of frame buffer attachments. *)
    maxPrograms: UInt32;
    (* Maximum number of program handles. *)
    maxShaders: UInt32;
    (* Maximum number of shader handles. *)
    maxTextures: UInt32;
    (* Maximum number of texture handles. *)
    maxTextureSamplers: UInt32;
    (* Maximum number of texture samplers. *)
    maxComputeBindings: UInt32;
    (* Maximum number of compute bindings. *)
    maxVertexLayouts: UInt32;
    (* Maximum number of vertex format layouts. *)
    maxVertexStreams: UInt32;
    (* Maximum number of vertex streams. *)
    maxIndexBuffers: UInt32;
    (* Maximum number of index buffer handles. *)
    maxVertexBuffers: UInt32;
    (* Maximum number of vertex buffer handles. *)
    maxDynamicIndexBuffers: UInt32;
    (* Maximum number of dynamic index buffer handles. *)
    maxDynamicVertexBuffers: UInt32;
    (* Maximum number of dynamic vertex buffer handles. *)
    maxUniforms: UInt32;
    (* Maximum number of uniform handles. *)
    maxOcclusionQueries: UInt32;
    (* Maximum number of occlusion query handles. *)
    maxEncoders: UInt32;
    (* Maximum number of encoder threads. *)
    transientVbSize: UInt32;
    (* Maximum transient vertex buffer size. *)
    transientIbSize: UInt32;
  end;

  (* Renderer capabilities limits. *)
  bgfx_caps_limits_t = bgfx_caps_limits_s;

  (* Renderer capabilities. *)
  bgfx_caps_s = record
    rendererType: bgfx_renderer_type_t;
    (* Supported functionality.

       See BGFX_CAPS_* flags at https://bkaradzic.github.io/bgfx/bgfx.html#available-caps *)
    supported: UInt64;
    vendorId: UInt16;
    (* Selected GPU vendor PCI id. *)
    deviceId: UInt16;
    (* Selected GPU device id. *)
    homogeneousDepth: Boolean;
    (* True when NDC depth is in [-1, 1] range, otherwise its [0, 1]. *)
    originBottomLeft: Boolean;
    (* True when NDC origin is at bottom left. *)
    numGPUs: UInt8;
    (* Number of enumerated GPUs. *)
    gpu: array [0..3] of bgfx_caps_gpu_t;
    (* Enumerated GPUs. *)
    limits: bgfx_caps_limits_t;
    (* Supported texture format capabilities flags:
       - `BGFX_CAPS_FORMAT_TEXTURE_NONE` - Texture format is not supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_2D` - Texture format is supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_2D_SRGB` - Texture as sRGB format is supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_2D_EMULATED` - Texture format is emulated.
       - `BGFX_CAPS_FORMAT_TEXTURE_3D` - Texture format is supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_3D_SRGB` - Texture as sRGB format is supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_3D_EMULATED` - Texture format is emulated.
       - `BGFX_CAPS_FORMAT_TEXTURE_CUBE` - Texture format is supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_CUBE_SRGB` - Texture as sRGB format is supported.
       - `BGFX_CAPS_FORMAT_TEXTURE_CUBE_EMULATED` - Texture format is emulated.
       - `BGFX_CAPS_FORMAT_TEXTURE_VERTEX` - Texture format can be used from vertex shader.
       - `BGFX_CAPS_FORMAT_TEXTURE_IMAGE` - Texture format can be used as image from compute
       shader.
       - `BGFX_CAPS_FORMAT_TEXTURE_FRAMEBUFFER` - Texture format can be used as frame
       buffer.
       - `BGFX_CAPS_FORMAT_TEXTURE_FRAMEBUFFER_MSAA` - Texture format can be used as MSAA
       frame buffer.
       - `BGFX_CAPS_FORMAT_TEXTURE_MSAA` - Texture can be sampled as MSAA.
       - `BGFX_CAPS_FORMAT_TEXTURE_MIP_AUTOGEN` - Texture format supports auto-generated
       mips. *)
    formats: array [0..84] of UInt16;
  end;

  (* Renderer capabilities. *)
  bgfx_caps_t = bgfx_caps_s;
  Pbgfx_caps_t = ^bgfx_caps_t;

  (* Internal data. *)
  bgfx_internal_data_s = record
    caps: Pbgfx_caps_t;
    (* Renderer capabilities. *)
    context: Pointer;
  end;

  (* Internal data. *)
  bgfx_internal_data_t = bgfx_internal_data_s;
  Pbgfx_internal_data_t = ^bgfx_internal_data_t;

  (* Platform data. *)
  bgfx_platform_data_s = record
    ndt: Pointer;
    (* Native display type. *)
    nwh: Pointer;
    (* Native window handle. *)
    context: Pointer;
    (* GL context, or D3D device. *)
    backBuffer: Pointer;
    (* GL backbuffer, or D3D render target view. *)
    backBufferDS: Pointer;
  end;

  (* Platform data. *)
  bgfx_platform_data_t = bgfx_platform_data_s;
  Pbgfx_platform_data_t = ^bgfx_platform_data_t;

  (* Backbuffer resolution and reset parameters. *)
  bgfx_resolution_s = record
    format: bgfx_texture_format_t;
    (* Backbuffer format. *)
    width: UInt32;
    (* Backbuffer width. *)
    height: UInt32;
    (* Backbuffer height. *)
    reset: UInt32;
    (* Reset parameters. *)
    numBackBuffers: UInt8;
    (* Number of back buffers. *)
    maxFrameLatency: UInt8;
  end;

  (* Backbuffer resolution and reset parameters. *)
  bgfx_resolution_t = bgfx_resolution_s;

  bgfx_init_limits_s = record
    maxEncoders: UInt16;
    (* Maximum number of encoder threads. *)
    transientVbSize: UInt32;
    (* Maximum transient vertex buffer size. *)
    transientIbSize: UInt32;
  end;

  bgfx_init_limits_t = bgfx_init_limits_s;

  (* Initialization parameters used by `bgfx::init`. *)
  bgfx_init_s = record
    (* Select rendering backend. When set to RendererType::Count
       a default rendering backend will be selected appropriate to the platform.
       See: `bgfx::RendererType` *)
    _type: bgfx_renderer_type_t;
    (* Vendor PCI id. If set to `BGFX_PCI_ID_NONE` it will select the first
       device.
       - `BGFX_PCI_ID_NONE` - Autoselect adapter.
       - `BGFX_PCI_ID_SOFTWARE_RASTERIZER` - Software rasterizer.
       - `BGFX_PCI_ID_AMD` - AMD adapter.
       - `BGFX_PCI_ID_INTEL` - Intel adapter.
       - `BGFX_PCI_ID_NVIDIA` - nVidia adapter. *)
    vendorId: UInt16;
    (* Device id. If set to 0 it will select first device, or device with
       matching id. *)
    deviceId: UInt16;
    debug: Boolean;
    (* Enable device for debuging. *)
    profile: Boolean;
    (* Enable device for profiling. *)
    platformData: bgfx_platform_data_t;
    (* Platform data. *)
    resolution: bgfx_resolution_t;
    (* Backbuffer resolution and reset parameters. See: `bgfx::Resolution`. *)
    limits: bgfx_init_limits_t;
    (* Provide application specific callback interface.
       See: `bgfx::CallbackI` *)
    callback: Pbgfx_callback_interface_t;
    (* Custom allocator. When a custom allocator is not
       specified, bgfx uses the CRT allocator. Bgfx assumes
       custom allocator is thread safe. *)
    allocator: Pbgfx_allocator_interface_t;
  end;

  (* Initialization parameters used by `bgfx::init`. *)
  bgfx_init_t = bgfx_init_s;
  Pbgfx_init_t = ^bgfx_init_t;

  (* Memory must be obtained by calling `bgfx::alloc`, `bgfx::copy`, or `bgfx::makeRef`.

     It is illegal to create this structure on stack and pass it to any bgfx API. *)
  bgfx_memory_s = record
    data: PUInt8;
    (* Pointer to data. *)
    size: UInt32;
  end;

  (* Memory must be obtained by calling `bgfx::alloc`, `bgfx::copy`, or `bgfx::makeRef`.

     It is illegal to create this structure on stack and pass it to any bgfx API. *)
  bgfx_memory_t = bgfx_memory_s;
  Pbgfx_memory_t = ^bgfx_memory_t;

  (* Transient index buffer. *)
  bgfx_transient_index_buffer_s = record
    data: PUInt8;
    (* Pointer to data. *)
    size: UInt32;
    (* Data size. *)
    startIndex: UInt32;
    (* First index. *)
    handle: bgfx_index_buffer_handle_t;
  end;

  (* Transient index buffer. *)
  bgfx_transient_index_buffer_t = bgfx_transient_index_buffer_s;
  Pbgfx_transient_index_buffer_t = ^bgfx_transient_index_buffer_t;

  (* Transient vertex buffer. *)
  bgfx_transient_vertex_buffer_s = record
    data: PUInt8;
    (* Pointer to data. *)
    size: UInt32;
    (* Data size. *)
    startVertex: UInt32;
    (* First vertex. *)
    stride: UInt16;
    (* Vertex stride. *)
    handle: bgfx_vertex_buffer_handle_t;
    (* Vertex buffer handle. *)
    layoutHandle: bgfx_vertex_layout_handle_t;
  end;

  (* Transient vertex buffer. *)
  bgfx_transient_vertex_buffer_t = bgfx_transient_vertex_buffer_s;
  Pbgfx_transient_vertex_buffer_t = ^bgfx_transient_vertex_buffer_t;

  (* Instance data buffer info. *)
  bgfx_instance_data_buffer_s = record
    data: PUInt8;
    (* Pointer to data. *)
    size: UInt32;
    (* Data size. *)
    offset: UInt32;
    (* Offset in vertex buffer. *)
    num: UInt32;
    (* Number of instances. *)
    stride: UInt16;
    (* Vertex buffer stride. *)
    handle: bgfx_vertex_buffer_handle_t;
  end;

  (* Instance data buffer info. *)
  bgfx_instance_data_buffer_t = bgfx_instance_data_buffer_s;
  Pbgfx_instance_data_buffer_t = ^bgfx_instance_data_buffer_t;

  (* Texture info. *)
  bgfx_texture_info_s = record
    format: bgfx_texture_format_t;
    (* Texture format. *)
    storageSize: UInt32;
    (* Total amount of bytes required to store texture. *)
    width: UInt16;
    (* Texture width. *)
    height: UInt16;
    (* Texture height. *)
    depth: UInt16;
    (* Texture depth. *)
    numLayers: UInt16;
    (* Number of layers in texture array. *)
    numMips: UInt8;
    (* Number of MIP maps. *)
    bitsPerPixel: UInt8;
    (* Format bits per pixel. *)
    cubeMap: Boolean;
  end;

  (* Texture info. *)
  bgfx_texture_info_t = bgfx_texture_info_s;
  Pbgfx_texture_info_t = ^bgfx_texture_info_t;

  (* Uniform info. *)
  bgfx_uniform_info_s = record
    name: array [0..255] of UTF8Char;
    (* Uniform name. *)
    _type: bgfx_uniform_type_t;
    (* Uniform type. *)
    num: UInt16;
  end;

  (* Uniform info. *)
  bgfx_uniform_info_t = bgfx_uniform_info_s;
  Pbgfx_uniform_info_t = ^bgfx_uniform_info_t;

  (* Frame buffer texture attachment info. *)
  bgfx_attachment_s = record
    access: bgfx_access_t;
    (* Attachement access. See `Access::Enum`. *)
    handle: bgfx_texture_handle_t;
    (* Render target texture handle. *)
    mip: UInt16;
    (* Mip level. *)
    layer: UInt16;
    (* Cubemap side or depth layer/slice. *)
    resolve: UInt8;
  end;

  (* Frame buffer texture attachment info. *)
  bgfx_attachment_t = bgfx_attachment_s;
  Pbgfx_attachment_t = ^bgfx_attachment_t;

  (* Transform data. *)
  bgfx_transform_s = record
    data: PSingle;
    (* Pointer to first 4x4 matrix. *)
    num: UInt16;
  end;

  (* Transform data. *)
  bgfx_transform_t = bgfx_transform_s;
  Pbgfx_transform_t = ^bgfx_transform_t;

  (* View stats. *)
  bgfx_view_stats_s = record
    name: array [0..255] of UTF8Char;
    (* View name. *)
    view: bgfx_view_id_t;
    (* View id. *)
    cpuTimeBegin: Int64;
    (* CPU (submit) begin time. *)
    cpuTimeEnd: Int64;
    (* CPU (submit) end time. *)
    gpuTimeBegin: Int64;
    (* GPU begin time. *)
    gpuTimeEnd: Int64;
  end;

  (* View stats. *)
  bgfx_view_stats_t = bgfx_view_stats_s;
  Pbgfx_view_stats_t = ^bgfx_view_stats_t;

  (* Encoder stats. *)
  bgfx_encoder_stats_s = record
    cpuTimeBegin: Int64;
    (* Encoder thread CPU submit begin time. *)
    cpuTimeEnd: Int64;
  end;

  (* Encoder stats. *)
  bgfx_encoder_stats_t = bgfx_encoder_stats_s;
  Pbgfx_encoder_stats_t = ^bgfx_encoder_stats_t;

  (* Renderer statistics data.

     All time values are high-resolution timestamps, while
     time frequencies define timestamps-per-second for that hardware. *)
  bgfx_stats_s = record
    cpuTimeFrame: Int64;
    (* CPU time between two `bgfx::frame` calls. *)
    cpuTimeBegin: Int64;
    (* Render thread CPU submit begin time. *)
    cpuTimeEnd: Int64;
    (* Render thread CPU submit end time. *)
    cpuTimerFreq: Int64;
    (* CPU timer frequency. Timestamps-per-second *)
    gpuTimeBegin: Int64;
    (* GPU frame begin time. *)
    gpuTimeEnd: Int64;
    (* GPU frame end time. *)
    gpuTimerFreq: Int64;
    (* GPU timer frequency. *)
    waitRender: Int64;
    (* Time spent waiting for render backend thread to finish issuing draw commands to underlying graphics API. *)
    waitSubmit: Int64;
    (* Time spent waiting for submit thread to advance to next frame. *)
    numDraw: UInt32;
    (* Number of draw calls submitted. *)
    numCompute: UInt32;
    (* Number of compute calls submitted. *)
    numBlit: UInt32;
    (* Number of blit calls submitted. *)
    maxGpuLatency: UInt32;
    (* GPU driver latency. *)
    numDynamicIndexBuffers: UInt16;
    (* Number of used dynamic index buffers. *)
    numDynamicVertexBuffers: UInt16;
    (* Number of used dynamic vertex buffers. *)
    numFrameBuffers: UInt16;
    (* Number of used frame buffers. *)
    numIndexBuffers: UInt16;
    (* Number of used index buffers. *)
    numOcclusionQueries: UInt16;
    (* Number of used occlusion queries. *)
    numPrograms: UInt16;
    (* Number of used programs. *)
    numShaders: UInt16;
    (* Number of used shaders. *)
    numTextures: UInt16;
    (* Number of used textures. *)
    numUniforms: UInt16;
    (* Number of used uniforms. *)
    numVertexBuffers: UInt16;
    (* Number of used vertex buffers. *)
    numVertexLayouts: UInt16;
    (* Number of used vertex layouts. *)
    textureMemoryUsed: Int64;
    (* Estimate of texture memory used. *)
    rtMemoryUsed: Int64;
    (* Estimate of render target memory used. *)
    transientVbUsed: Int32;
    (* Amount of transient vertex buffer used. *)
    transientIbUsed: Int32;
    (* Amount of transient index buffer used. *)
    numPrims: array [0..4] of UInt32;
    (* Number of primitives rendered. *)
    gpuMemoryMax: Int64;
    (* Maximum available GPU memory for application. *)
    gpuMemoryUsed: Int64;
    (* Amount of GPU memory used by the application. *)
    width: UInt16;
    (* Backbuffer width in pixels. *)
    height: UInt16;
    (* Backbuffer height in pixels. *)
    textWidth: UInt16;
    (* Debug text width in characters. *)
    textHeight: UInt16;
    (* Debug text height in characters. *)
    numViews: UInt16;
    (* Number of view stats. *)
    viewStats: Pbgfx_view_stats_t;
    (* Array of View stats. *)
    numEncoders: UInt8;
    (* Number of encoders used during frame. *)
    encoderStats: Pbgfx_encoder_stats_t;
  end;

  (* Renderer statistics data.

     All time values are high-resolution timestamps, while
     time frequencies define timestamps-per-second for that hardware. *)
  bgfx_stats_t = bgfx_stats_s;
  Pbgfx_stats_t = ^bgfx_stats_t;

  (* Vertex layout. *)
  bgfx_vertex_layout_s = record
    hash: UInt32;
    (* Hash. *)
    stride: UInt16;
    (* Stride. *)
    offset: array [0..17] of UInt16;
    (* Attribute offsets. *)
    attributes: array [0..17] of UInt16;
  end;

  (* Vertex layout. *)
  bgfx_vertex_layout_t = bgfx_vertex_layout_s;
  Pbgfx_vertex_layout_t = ^bgfx_vertex_layout_t;
  Pbgfx_encoder_t = Pointer;
  PPbgfx_encoder_t = ^Pbgfx_encoder_t;

  (* *)
  bgfx_function_id = (
    BGFX_FUNCTION_ID_ATTACHMENT_INIT = 0,
    BGFX_FUNCTION_ID_VERTEX_LAYOUT_BEGIN = 1,
    BGFX_FUNCTION_ID_VERTEX_LAYOUT_ADD = 2,
    BGFX_FUNCTION_ID_VERTEX_LAYOUT_DECODE = 3,
    BGFX_FUNCTION_ID_VERTEX_LAYOUT_HAS = 4,
    BGFX_FUNCTION_ID_VERTEX_LAYOUT_SKIP = 5,
    BGFX_FUNCTION_ID_VERTEX_LAYOUT_END = 6,
    BGFX_FUNCTION_ID_VERTEX_PACK = 7,
    BGFX_FUNCTION_ID_VERTEX_UNPACK = 8,
    BGFX_FUNCTION_ID_VERTEX_CONVERT = 9,
    BGFX_FUNCTION_ID_WELD_VERTICES = 10,
    BGFX_FUNCTION_ID_TOPOLOGY_CONVERT = 11,
    BGFX_FUNCTION_ID_TOPOLOGY_SORT_TRI_LIST = 12,
    BGFX_FUNCTION_ID_GET_SUPPORTED_RENDERERS = 13,
    BGFX_FUNCTION_ID_GET_RENDERER_NAME = 14,
    BGFX_FUNCTION_ID_INIT_CTOR = 15,
    BGFX_FUNCTION_ID_INIT = 16,
    BGFX_FUNCTION_ID_SHUTDOWN = 17,
    BGFX_FUNCTION_ID_RESET = 18,
    BGFX_FUNCTION_ID_FRAME = 19,
    BGFX_FUNCTION_ID_GET_RENDERER_TYPE = 20,
    BGFX_FUNCTION_ID_GET_CAPS = 21,
    BGFX_FUNCTION_ID_GET_STATS = 22,
    BGFX_FUNCTION_ID_ALLOC = 23,
    BGFX_FUNCTION_ID_COPY = 24,
    BGFX_FUNCTION_ID_MAKE_REF = 25,
    BGFX_FUNCTION_ID_MAKE_REF_RELEASE = 26,
    BGFX_FUNCTION_ID_SET_DEBUG = 27,
    BGFX_FUNCTION_ID_DBG_TEXT_CLEAR = 28,
    BGFX_FUNCTION_ID_DBG_TEXT_PRINTF = 29,
    BGFX_FUNCTION_ID_DBG_TEXT_VPRINTF = 30,
    BGFX_FUNCTION_ID_DBG_TEXT_IMAGE = 31,
    BGFX_FUNCTION_ID_CREATE_INDEX_BUFFER = 32,
    BGFX_FUNCTION_ID_SET_INDEX_BUFFER_NAME = 33,
    BGFX_FUNCTION_ID_DESTROY_INDEX_BUFFER = 34,
    BGFX_FUNCTION_ID_CREATE_VERTEX_LAYOUT = 35,
    BGFX_FUNCTION_ID_DESTROY_VERTEX_LAYOUT = 36,
    BGFX_FUNCTION_ID_CREATE_VERTEX_BUFFER = 37,
    BGFX_FUNCTION_ID_SET_VERTEX_BUFFER_NAME = 38,
    BGFX_FUNCTION_ID_DESTROY_VERTEX_BUFFER = 39,
    BGFX_FUNCTION_ID_CREATE_DYNAMIC_INDEX_BUFFER = 40,
    BGFX_FUNCTION_ID_CREATE_DYNAMIC_INDEX_BUFFER_MEM = 41,
    BGFX_FUNCTION_ID_UPDATE_DYNAMIC_INDEX_BUFFER = 42,
    BGFX_FUNCTION_ID_DESTROY_DYNAMIC_INDEX_BUFFER = 43,
    BGFX_FUNCTION_ID_CREATE_DYNAMIC_VERTEX_BUFFER = 44,
    BGFX_FUNCTION_ID_CREATE_DYNAMIC_VERTEX_BUFFER_MEM = 45,
    BGFX_FUNCTION_ID_UPDATE_DYNAMIC_VERTEX_BUFFER = 46,
    BGFX_FUNCTION_ID_DESTROY_DYNAMIC_VERTEX_BUFFER = 47,
    BGFX_FUNCTION_ID_GET_AVAIL_TRANSIENT_INDEX_BUFFER = 48,
    BGFX_FUNCTION_ID_GET_AVAIL_TRANSIENT_VERTEX_BUFFER = 49,
    BGFX_FUNCTION_ID_GET_AVAIL_INSTANCE_DATA_BUFFER = 50,
    BGFX_FUNCTION_ID_ALLOC_TRANSIENT_INDEX_BUFFER = 51,
    BGFX_FUNCTION_ID_ALLOC_TRANSIENT_VERTEX_BUFFER = 52,
    BGFX_FUNCTION_ID_ALLOC_TRANSIENT_BUFFERS = 53,
    BGFX_FUNCTION_ID_ALLOC_INSTANCE_DATA_BUFFER = 54,
    BGFX_FUNCTION_ID_CREATE_INDIRECT_BUFFER = 55,
    BGFX_FUNCTION_ID_DESTROY_INDIRECT_BUFFER = 56,
    BGFX_FUNCTION_ID_CREATE_SHADER = 57,
    BGFX_FUNCTION_ID_GET_SHADER_UNIFORMS = 58,
    BGFX_FUNCTION_ID_SET_SHADER_NAME = 59,
    BGFX_FUNCTION_ID_DESTROY_SHADER = 60,
    BGFX_FUNCTION_ID_CREATE_PROGRAM = 61,
    BGFX_FUNCTION_ID_CREATE_COMPUTE_PROGRAM = 62,
    BGFX_FUNCTION_ID_DESTROY_PROGRAM = 63,
    BGFX_FUNCTION_ID_IS_TEXTURE_VALID = 64,
    BGFX_FUNCTION_ID_CALC_TEXTURE_SIZE = 65,
    BGFX_FUNCTION_ID_CREATE_TEXTURE = 66,
    BGFX_FUNCTION_ID_CREATE_TEXTURE_2D = 67,
    BGFX_FUNCTION_ID_CREATE_TEXTURE_2D_SCALED = 68,
    BGFX_FUNCTION_ID_CREATE_TEXTURE_3D = 69,
    BGFX_FUNCTION_ID_CREATE_TEXTURE_CUBE = 70,
    BGFX_FUNCTION_ID_UPDATE_TEXTURE_2D = 71,
    BGFX_FUNCTION_ID_UPDATE_TEXTURE_3D = 72,
    BGFX_FUNCTION_ID_UPDATE_TEXTURE_CUBE = 73,
    BGFX_FUNCTION_ID_READ_TEXTURE = 74,
    BGFX_FUNCTION_ID_SET_TEXTURE_NAME = 75,
    BGFX_FUNCTION_ID_GET_DIRECT_ACCESS_PTR = 76,
    BGFX_FUNCTION_ID_DESTROY_TEXTURE = 77,
    BGFX_FUNCTION_ID_CREATE_FRAME_BUFFER = 78,
    BGFX_FUNCTION_ID_CREATE_FRAME_BUFFER_SCALED = 79,
    BGFX_FUNCTION_ID_CREATE_FRAME_BUFFER_FROM_HANDLES = 80,
    BGFX_FUNCTION_ID_CREATE_FRAME_BUFFER_FROM_ATTACHMENT = 81,
    BGFX_FUNCTION_ID_CREATE_FRAME_BUFFER_FROM_NWH = 82,
    BGFX_FUNCTION_ID_SET_FRAME_BUFFER_NAME = 83,
    BGFX_FUNCTION_ID_GET_TEXTURE = 84,
    BGFX_FUNCTION_ID_DESTROY_FRAME_BUFFER = 85,
    BGFX_FUNCTION_ID_CREATE_UNIFORM = 86,
    BGFX_FUNCTION_ID_GET_UNIFORM_INFO = 87,
    BGFX_FUNCTION_ID_DESTROY_UNIFORM = 88,
    BGFX_FUNCTION_ID_CREATE_OCCLUSION_QUERY = 89,
    BGFX_FUNCTION_ID_GET_RESULT = 90,
    BGFX_FUNCTION_ID_DESTROY_OCCLUSION_QUERY = 91,
    BGFX_FUNCTION_ID_SET_PALETTE_COLOR = 92,
    BGFX_FUNCTION_ID_SET_PALETTE_COLOR_RGBA8 = 93,
    BGFX_FUNCTION_ID_SET_VIEW_NAME = 94,
    BGFX_FUNCTION_ID_SET_VIEW_RECT = 95,
    BGFX_FUNCTION_ID_SET_VIEW_RECT_RATIO = 96,
    BGFX_FUNCTION_ID_SET_VIEW_SCISSOR = 97,
    BGFX_FUNCTION_ID_SET_VIEW_CLEAR = 98,
    BGFX_FUNCTION_ID_SET_VIEW_CLEAR_MRT = 99,
    BGFX_FUNCTION_ID_SET_VIEW_MODE = 100,
    BGFX_FUNCTION_ID_SET_VIEW_FRAME_BUFFER = 101,
    BGFX_FUNCTION_ID_SET_VIEW_TRANSFORM = 102,
    BGFX_FUNCTION_ID_SET_VIEW_ORDER = 103,
    BGFX_FUNCTION_ID_ENCODER_BEGIN = 104,
    BGFX_FUNCTION_ID_ENCODER_END = 105,
    BGFX_FUNCTION_ID_ENCODER_SET_MARKER = 106,
    BGFX_FUNCTION_ID_ENCODER_SET_STATE = 107,
    BGFX_FUNCTION_ID_ENCODER_SET_CONDITION = 108,
    BGFX_FUNCTION_ID_ENCODER_SET_STENCIL = 109,
    BGFX_FUNCTION_ID_ENCODER_SET_SCISSOR = 110,
    BGFX_FUNCTION_ID_ENCODER_SET_SCISSOR_CACHED = 111,
    BGFX_FUNCTION_ID_ENCODER_SET_TRANSFORM = 112,
    BGFX_FUNCTION_ID_ENCODER_SET_TRANSFORM_CACHED = 113,
    BGFX_FUNCTION_ID_ENCODER_ALLOC_TRANSFORM = 114,
    BGFX_FUNCTION_ID_ENCODER_SET_UNIFORM = 115,
    BGFX_FUNCTION_ID_ENCODER_SET_INDEX_BUFFER = 116,
    BGFX_FUNCTION_ID_ENCODER_SET_DYNAMIC_INDEX_BUFFER = 117,
    BGFX_FUNCTION_ID_ENCODER_SET_TRANSIENT_INDEX_BUFFER = 118,
    BGFX_FUNCTION_ID_ENCODER_SET_VERTEX_BUFFER = 119,
    BGFX_FUNCTION_ID_ENCODER_SET_DYNAMIC_VERTEX_BUFFER = 120,
    BGFX_FUNCTION_ID_ENCODER_SET_TRANSIENT_VERTEX_BUFFER = 121,
    BGFX_FUNCTION_ID_ENCODER_SET_VERTEX_COUNT = 122,
    BGFX_FUNCTION_ID_ENCODER_SET_INSTANCE_DATA_BUFFER = 123,
    BGFX_FUNCTION_ID_ENCODER_SET_INSTANCE_DATA_FROM_VERTEX_BUFFER = 124,
    BGFX_FUNCTION_ID_ENCODER_SET_INSTANCE_DATA_FROM_DYNAMIC_VERTEX_BUFFER = 125,
    BGFX_FUNCTION_ID_ENCODER_SET_INSTANCE_COUNT = 126,
    BGFX_FUNCTION_ID_ENCODER_SET_TEXTURE = 127,
    BGFX_FUNCTION_ID_ENCODER_TOUCH = 128,
    BGFX_FUNCTION_ID_ENCODER_SUBMIT = 129,
    BGFX_FUNCTION_ID_ENCODER_SUBMIT_OCCLUSION_QUERY = 130,
    BGFX_FUNCTION_ID_ENCODER_SUBMIT_INDIRECT = 131,
    BGFX_FUNCTION_ID_ENCODER_SET_COMPUTE_INDEX_BUFFER = 132,
    BGFX_FUNCTION_ID_ENCODER_SET_COMPUTE_VERTEX_BUFFER = 133,
    BGFX_FUNCTION_ID_ENCODER_SET_COMPUTE_DYNAMIC_INDEX_BUFFER = 134,
    BGFX_FUNCTION_ID_ENCODER_SET_COMPUTE_DYNAMIC_VERTEX_BUFFER = 135,
    BGFX_FUNCTION_ID_ENCODER_SET_COMPUTE_INDIRECT_BUFFER = 136,
    BGFX_FUNCTION_ID_ENCODER_SET_IMAGE = 137,
    BGFX_FUNCTION_ID_ENCODER_DISPATCH = 138,
    BGFX_FUNCTION_ID_ENCODER_DISPATCH_INDIRECT = 139,
    BGFX_FUNCTION_ID_ENCODER_DISCARD = 140,
    BGFX_FUNCTION_ID_ENCODER_BLIT = 141,
    BGFX_FUNCTION_ID_REQUEST_SCREEN_SHOT = 142,
    BGFX_FUNCTION_ID_RENDER_FRAME = 143,
    BGFX_FUNCTION_ID_SET_PLATFORM_DATA = 144,
    BGFX_FUNCTION_ID_GET_INTERNAL_DATA = 145,
    BGFX_FUNCTION_ID_OVERRIDE_INTERNAL_TEXTURE_PTR = 146,
    BGFX_FUNCTION_ID_OVERRIDE_INTERNAL_TEXTURE = 147,
    BGFX_FUNCTION_ID_SET_MARKER = 148,
    BGFX_FUNCTION_ID_SET_STATE = 149,
    BGFX_FUNCTION_ID_SET_CONDITION = 150,
    BGFX_FUNCTION_ID_SET_STENCIL = 151,
    BGFX_FUNCTION_ID_SET_SCISSOR = 152,
    BGFX_FUNCTION_ID_SET_SCISSOR_CACHED = 153,
    BGFX_FUNCTION_ID_SET_TRANSFORM = 154,
    BGFX_FUNCTION_ID_SET_TRANSFORM_CACHED = 155,
    BGFX_FUNCTION_ID_ALLOC_TRANSFORM = 156,
    BGFX_FUNCTION_ID_SET_UNIFORM = 157,
    BGFX_FUNCTION_ID_SET_INDEX_BUFFER = 158,
    BGFX_FUNCTION_ID_SET_DYNAMIC_INDEX_BUFFER = 159,
    BGFX_FUNCTION_ID_SET_TRANSIENT_INDEX_BUFFER = 160,
    BGFX_FUNCTION_ID_SET_VERTEX_BUFFER = 161,
    BGFX_FUNCTION_ID_SET_DYNAMIC_VERTEX_BUFFER = 162,
    BGFX_FUNCTION_ID_SET_TRANSIENT_VERTEX_BUFFER = 163,
    BGFX_FUNCTION_ID_SET_VERTEX_COUNT = 164,
    BGFX_FUNCTION_ID_SET_INSTANCE_DATA_BUFFER = 165,
    BGFX_FUNCTION_ID_SET_INSTANCE_DATA_FROM_VERTEX_BUFFER = 166,
    BGFX_FUNCTION_ID_SET_INSTANCE_DATA_FROM_DYNAMIC_VERTEX_BUFFER = 167,
    BGFX_FUNCTION_ID_SET_INSTANCE_COUNT = 168,
    BGFX_FUNCTION_ID_SET_TEXTURE = 169,
    BGFX_FUNCTION_ID_TOUCH = 170,
    BGFX_FUNCTION_ID_SUBMIT = 171,
    BGFX_FUNCTION_ID_SUBMIT_OCCLUSION_QUERY = 172,
    BGFX_FUNCTION_ID_SUBMIT_INDIRECT = 173,
    BGFX_FUNCTION_ID_SET_COMPUTE_INDEX_BUFFER = 174,
    BGFX_FUNCTION_ID_SET_COMPUTE_VERTEX_BUFFER = 175,
    BGFX_FUNCTION_ID_SET_COMPUTE_DYNAMIC_INDEX_BUFFER = 176,
    BGFX_FUNCTION_ID_SET_COMPUTE_DYNAMIC_VERTEX_BUFFER = 177,
    BGFX_FUNCTION_ID_SET_COMPUTE_INDIRECT_BUFFER = 178,
    BGFX_FUNCTION_ID_SET_IMAGE = 179,
    BGFX_FUNCTION_ID_DISPATCH = 180,
    BGFX_FUNCTION_ID_DISPATCH_INDIRECT = 181,
    BGFX_FUNCTION_ID_DISCARD = 182,
    BGFX_FUNCTION_ID_BLIT = 183,
    BGFX_FUNCTION_ID_COUNT = 184);
  Pbgfx_function_id = ^bgfx_function_id;
  (* *)
  bgfx_function_id_t = bgfx_function_id;

  (* *)
  bgfx_interface_vtbl = record
    attachment_init: procedure(_this: Pbgfx_attachment_t; _handle: bgfx_texture_handle_t; _access: bgfx_access_t; _layer: UInt16; _mip: UInt16; _resolve: UInt8); cdecl;
    vertex_layout_begin: function(_this: Pbgfx_vertex_layout_t; _rendererType: bgfx_renderer_type_t): Pbgfx_vertex_layout_t; cdecl;
    vertex_layout_add: function(_this: Pbgfx_vertex_layout_t; _attrib: bgfx_attrib_t; _num: UInt8; _type: bgfx_attrib_type_t; _normalized: Boolean; _asInt: Boolean): Pbgfx_vertex_layout_t; cdecl;
    vertex_layout_decode: procedure(_this: Pbgfx_vertex_layout_t; _attrib: bgfx_attrib_t; _num: PUInt8; _type: Pbgfx_attrib_type_t; _normalized: PBoolean; _asInt: PBoolean); cdecl;
    vertex_layout_has: function(_this: Pbgfx_vertex_layout_t; _attrib: bgfx_attrib_t): Boolean; cdecl;
    vertex_layout_skip: function(_this: Pbgfx_vertex_layout_t; _num: UInt8): Pbgfx_vertex_layout_t; cdecl;
    vertex_layout_end: procedure(_this: Pbgfx_vertex_layout_t); cdecl;
    vertex_pack: procedure(_input: PSingle; _inputNormalized: Boolean; _attr: bgfx_attrib_t; _layout: Pbgfx_vertex_layout_t; _data: Pointer; _index: UInt32); cdecl;
    vertex_unpack: procedure(_output: PSingle; _attr: bgfx_attrib_t; _layout: Pbgfx_vertex_layout_t; _data: Pointer; _index: UInt32); cdecl;
    vertex_convert: procedure(_dstLayout: Pbgfx_vertex_layout_t; _dstData: Pointer; _srcLayout: Pbgfx_vertex_layout_t; _srcData: Pointer; _num: UInt32); cdecl;
    weld_vertices: function(_output: PUInt16; _layout: Pbgfx_vertex_layout_t; _data: Pointer; _num: UInt16; _epsilon: Single): UInt16; cdecl;
    topology_convert: function(_conversion: bgfx_topology_convert_t; _dst: Pointer; _dstSize: UInt32; _indices: Pointer; _numIndices: UInt32; _index32: Boolean): UInt32; cdecl;
    topology_sort_tri_list: procedure(_sort: bgfx_topology_sort_t; _dst: Pointer; _dstSize: UInt32; _dir: PSingle; _pos: PSingle; _vertices: Pointer; _stride: UInt32; _indices: Pointer; _numIndices: UInt32; _index32: Boolean); cdecl;
    get_supported_renderers: function(_max: UInt8; _enum: Pbgfx_renderer_type_t): UInt8; cdecl;
    get_renderer_name: function(_type: bgfx_renderer_type_t): PUTF8Char; cdecl;
    init_ctor: procedure(_init: Pbgfx_init_t); cdecl;
    init: function(_init: Pbgfx_init_t): Boolean; cdecl;
    shutdown: procedure(); cdecl;
    reset: procedure(_width: UInt32; _height: UInt32; _flags: UInt32; _format: bgfx_texture_format_t); cdecl;
    frame: function(_capture: Boolean): UInt32; cdecl;
    get_renderer_type: function(): bgfx_renderer_type_t; cdecl;
    get_caps: function(): Pbgfx_caps_t; cdecl;
    get_stats: function(): Pbgfx_stats_t; cdecl;
    alloc: function(_size: UInt32): Pbgfx_memory_t; cdecl;
    copy: function(_data: Pointer; _size: UInt32): Pbgfx_memory_t; cdecl;
    make_ref: function(_data: Pointer; _size: UInt32): Pbgfx_memory_t; cdecl;
    make_ref_release: function(_data: Pointer; _size: UInt32; _releaseFn: bgfx_release_fn_t; _userData: Pointer): Pbgfx_memory_t; cdecl;
    set_debug: procedure(_debug: UInt32); cdecl;
    dbg_text_clear: procedure(_attr: UInt8; _small: Boolean); cdecl;
    dbg_text_printf: procedure(_x: UInt16; _y: UInt16; _attr: UInt8; _format: PUTF8Char) varargs; cdecl;
    dbg_text_vprintf: procedure(_x: UInt16; _y: UInt16; _attr: UInt8; _format: PUTF8Char; _argList: Pointer); cdecl;
    dbg_text_image: procedure(_x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16; _data: Pointer; _pitch: UInt16); cdecl;
    create_index_buffer: function(_mem: Pbgfx_memory_t; _flags: UInt16): bgfx_index_buffer_handle_t; cdecl;
    set_index_buffer_name: procedure(_handle: bgfx_index_buffer_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
    destroy_index_buffer: procedure(_handle: bgfx_index_buffer_handle_t); cdecl;
    create_vertex_layout: function(_layout: Pbgfx_vertex_layout_t): bgfx_vertex_layout_handle_t; cdecl;
    destroy_vertex_layout: procedure(_layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
    create_vertex_buffer: function(_mem: Pbgfx_memory_t; _layout: Pbgfx_vertex_layout_t; _flags: UInt16): bgfx_vertex_buffer_handle_t; cdecl;
    set_vertex_buffer_name: procedure(_handle: bgfx_vertex_buffer_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
    destroy_vertex_buffer: procedure(_handle: bgfx_vertex_buffer_handle_t); cdecl;
    create_dynamic_index_buffer: function(_num: UInt32; _flags: UInt16): bgfx_dynamic_index_buffer_handle_t; cdecl;
    create_dynamic_index_buffer_mem: function(_mem: Pbgfx_memory_t; _flags: UInt16): bgfx_dynamic_index_buffer_handle_t; cdecl;
    update_dynamic_index_buffer: procedure(_handle: bgfx_dynamic_index_buffer_handle_t; _startIndex: UInt32; _mem: Pbgfx_memory_t); cdecl;
    destroy_dynamic_index_buffer: procedure(_handle: bgfx_dynamic_index_buffer_handle_t); cdecl;
    create_dynamic_vertex_buffer: function(_num: UInt32; _layout: Pbgfx_vertex_layout_t; _flags: UInt16): bgfx_dynamic_vertex_buffer_handle_t; cdecl;
    create_dynamic_vertex_buffer_mem: function(_mem: Pbgfx_memory_t; _layout: Pbgfx_vertex_layout_t; _flags: UInt16): bgfx_dynamic_vertex_buffer_handle_t; cdecl;
    update_dynamic_vertex_buffer: procedure(_handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _mem: Pbgfx_memory_t); cdecl;
    destroy_dynamic_vertex_buffer: procedure(_handle: bgfx_dynamic_vertex_buffer_handle_t); cdecl;
    get_avail_transient_index_buffer: function(_num: UInt32): UInt32; cdecl;
    get_avail_transient_vertex_buffer: function(_num: UInt32; _layout: Pbgfx_vertex_layout_t): UInt32; cdecl;
    get_avail_instance_data_buffer: function(_num: UInt32; _stride: UInt16): UInt32; cdecl;
    alloc_transient_index_buffer: procedure(_tib: Pbgfx_transient_index_buffer_t; _num: UInt32); cdecl;
    alloc_transient_vertex_buffer: procedure(_tvb: Pbgfx_transient_vertex_buffer_t; _num: UInt32; _layout: Pbgfx_vertex_layout_t); cdecl;
    alloc_transient_buffers: function(_tvb: Pbgfx_transient_vertex_buffer_t; _layout: Pbgfx_vertex_layout_t; _numVertices: UInt32; _tib: Pbgfx_transient_index_buffer_t; _numIndices: UInt32): Boolean; cdecl;
    alloc_instance_data_buffer: procedure(_idb: Pbgfx_instance_data_buffer_t; _num: UInt32; _stride: UInt16); cdecl;
    create_indirect_buffer: function(_num: UInt32): bgfx_indirect_buffer_handle_t; cdecl;
    destroy_indirect_buffer: procedure(_handle: bgfx_indirect_buffer_handle_t); cdecl;
    create_shader: function(_mem: Pbgfx_memory_t): bgfx_shader_handle_t; cdecl;
    get_shader_uniforms: function(_handle: bgfx_shader_handle_t; _uniforms: Pbgfx_uniform_handle_t; _max: UInt16): UInt16; cdecl;
    set_shader_name: procedure(_handle: bgfx_shader_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
    destroy_shader: procedure(_handle: bgfx_shader_handle_t); cdecl;
    create_program: function(_vsh: bgfx_shader_handle_t; _fsh: bgfx_shader_handle_t; _destroyShaders: Boolean): bgfx_program_handle_t; cdecl;
    create_compute_program: function(_csh: bgfx_shader_handle_t; _destroyShaders: Boolean): bgfx_program_handle_t; cdecl;
    destroy_program: procedure(_handle: bgfx_program_handle_t); cdecl;
    is_texture_valid: function(_depth: UInt16; _cubeMap: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64): Boolean; cdecl;
    calc_texture_size: procedure(_info: Pbgfx_texture_info_t; _width: UInt16; _height: UInt16; _depth: UInt16; _cubeMap: Boolean; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t); cdecl;
    create_texture: function(_mem: Pbgfx_memory_t; _flags: UInt64; _skip: UInt8; _info: Pbgfx_texture_info_t): bgfx_texture_handle_t; cdecl;
    create_texture_2d: function(_width: UInt16; _height: UInt16; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64; _mem: Pbgfx_memory_t): bgfx_texture_handle_t; cdecl;
    create_texture_2d_scaled: function(_ratio: bgfx_backbuffer_ratio_t; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64): bgfx_texture_handle_t; cdecl;
    create_texture_3d: function(_width: UInt16; _height: UInt16; _depth: UInt16; _hasMips: Boolean; _format: bgfx_texture_format_t; _flags: UInt64; _mem: Pbgfx_memory_t): bgfx_texture_handle_t; cdecl;
    create_texture_cube: function(_size: UInt16; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64; _mem: Pbgfx_memory_t): bgfx_texture_handle_t; cdecl;
    update_texture_2d: procedure(_handle: bgfx_texture_handle_t; _layer: UInt16; _mip: UInt8; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16; _mem: Pbgfx_memory_t; _pitch: UInt16); cdecl;
    update_texture_3d: procedure(_handle: bgfx_texture_handle_t; _mip: UInt8; _x: UInt16; _y: UInt16; _z: UInt16; _width: UInt16; _height: UInt16; _depth: UInt16; _mem: Pbgfx_memory_t); cdecl;
    update_texture_cube: procedure(_handle: bgfx_texture_handle_t; _layer: UInt16; _side: UInt8; _mip: UInt8; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16; _mem: Pbgfx_memory_t; _pitch: UInt16); cdecl;
    read_texture: function(_handle: bgfx_texture_handle_t; _data: Pointer; _mip: UInt8): UInt32; cdecl;
    set_texture_name: procedure(_handle: bgfx_texture_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
    get_direct_access_ptr: function(_handle: bgfx_texture_handle_t): Pointer; cdecl;
    destroy_texture: procedure(_handle: bgfx_texture_handle_t); cdecl;
    create_frame_buffer: function(_width: UInt16; _height: UInt16; _format: bgfx_texture_format_t; _textureFlags: UInt64): bgfx_frame_buffer_handle_t; cdecl;
    create_frame_buffer_scaled: function(_ratio: bgfx_backbuffer_ratio_t; _format: bgfx_texture_format_t; _textureFlags: UInt64): bgfx_frame_buffer_handle_t; cdecl;
    create_frame_buffer_from_handles: function(_num: UInt8; _handles: Pbgfx_texture_handle_t; _destroyTexture: Boolean): bgfx_frame_buffer_handle_t; cdecl;
    create_frame_buffer_from_attachment: function(_num: UInt8; _attachment: Pbgfx_attachment_t; _destroyTexture: Boolean): bgfx_frame_buffer_handle_t; cdecl;
    create_frame_buffer_from_nwh: function(_nwh: Pointer; _width: UInt16; _height: UInt16; _format: bgfx_texture_format_t; _depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t; cdecl;
    set_frame_buffer_name: procedure(_handle: bgfx_frame_buffer_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
    get_texture: function(_handle: bgfx_frame_buffer_handle_t; _attachment: UInt8): bgfx_texture_handle_t; cdecl;
    destroy_frame_buffer: procedure(_handle: bgfx_frame_buffer_handle_t); cdecl;
    create_uniform: function(_name: PUTF8Char; _type: bgfx_uniform_type_t; _num: UInt16): bgfx_uniform_handle_t; cdecl;
    get_uniform_info: procedure(_handle: bgfx_uniform_handle_t; _info: Pbgfx_uniform_info_t); cdecl;
    destroy_uniform: procedure(_handle: bgfx_uniform_handle_t); cdecl;
    create_occlusion_query: function(): bgfx_occlusion_query_handle_t; cdecl;
    get_result: function(_handle: bgfx_occlusion_query_handle_t; _result: PInt32): bgfx_occlusion_query_result_t; cdecl;
    destroy_occlusion_query: procedure(_handle: bgfx_occlusion_query_handle_t); cdecl;
    set_palette_color: procedure(_index: UInt8; _rgba: PSingle); cdecl;
    set_palette_color_rgba8: procedure(_index: UInt8; _rgba: UInt32); cdecl;
    set_view_name: procedure(_id: bgfx_view_id_t; _name: PUTF8Char); cdecl;
    set_view_rect: procedure(_id: bgfx_view_id_t; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16); cdecl;
    set_view_rect_ratio: procedure(_id: bgfx_view_id_t; _x: UInt16; _y: UInt16; _ratio: bgfx_backbuffer_ratio_t); cdecl;
    set_view_scissor: procedure(_id: bgfx_view_id_t; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16); cdecl;
    set_view_clear: procedure(_id: bgfx_view_id_t; _flags: UInt16; _rgba: UInt32; _depth: Single; _stencil: UInt8); cdecl;
    set_view_clear_mrt: procedure(_id: bgfx_view_id_t; _flags: UInt16; _depth: Single; _stencil: UInt8; _c0: UInt8; _c1: UInt8; _c2: UInt8; _c3: UInt8; _c4: UInt8; _c5: UInt8; _c6: UInt8; _c7: UInt8); cdecl;
    set_view_mode: procedure(_id: bgfx_view_id_t; _mode: bgfx_view_mode_t); cdecl;
    set_view_frame_buffer: procedure(_id: bgfx_view_id_t; _handle: bgfx_frame_buffer_handle_t); cdecl;
    set_view_transform: procedure(_id: bgfx_view_id_t; _view: Pointer; _proj: Pointer); cdecl;
    set_view_order: procedure(_id: bgfx_view_id_t; _num: UInt16; _order: Pbgfx_view_id_t); cdecl;
    encoder_begin: function(_forThread: Boolean): Pbgfx_encoder_t; cdecl;
    encoder_end: procedure(_encoder: Pbgfx_encoder_t); cdecl;
    encoder_set_marker: procedure(_this: Pbgfx_encoder_t; _marker: PUTF8Char); cdecl;
    encoder_set_state: procedure(_this: Pbgfx_encoder_t; _state: UInt64; _rgba: UInt32); cdecl;
    encoder_set_condition: procedure(_this: Pbgfx_encoder_t; _handle: bgfx_occlusion_query_handle_t; _visible: Boolean); cdecl;
    encoder_set_stencil: procedure(_this: Pbgfx_encoder_t; _fstencil: UInt32; _bstencil: UInt32); cdecl;
    encoder_set_scissor: function(_this: Pbgfx_encoder_t; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16): UInt16; cdecl;
    encoder_set_scissor_cached: procedure(_this: Pbgfx_encoder_t; _cache: UInt16); cdecl;
    encoder_set_transform: function(_this: Pbgfx_encoder_t; _mtx: Pointer; _num: UInt16): UInt32; cdecl;
    encoder_set_transform_cached: procedure(_this: Pbgfx_encoder_t; _cache: UInt32; _num: UInt16); cdecl;
    encoder_alloc_transform: function(_this: Pbgfx_encoder_t; _transform: Pbgfx_transform_t; _num: UInt16): UInt32; cdecl;
    encoder_set_uniform: procedure(_this: Pbgfx_encoder_t; _handle: bgfx_uniform_handle_t; _value: Pointer; _num: UInt16); cdecl;
    encoder_set_index_buffer: procedure(_this: Pbgfx_encoder_t; _handle: bgfx_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
    encoder_set_dynamic_index_buffer: procedure(_this: Pbgfx_encoder_t; _handle: bgfx_dynamic_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
    encoder_set_transient_index_buffer: procedure(_this: Pbgfx_encoder_t; _tib: Pbgfx_transient_index_buffer_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
    encoder_set_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _stream: UInt8; _handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32; _layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
    encoder_set_dynamic_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _stream: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32; _layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
    encoder_set_transient_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _stream: UInt8; _tvb: Pbgfx_transient_vertex_buffer_t; _startVertex: UInt32; _numVertices: UInt32; _layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
    encoder_set_vertex_count: procedure(_this: Pbgfx_encoder_t; _numVertices: UInt32); cdecl;
    encoder_set_instance_data_buffer: procedure(_this: Pbgfx_encoder_t; _idb: Pbgfx_instance_data_buffer_t; _start: UInt32; _num: UInt32); cdecl;
    encoder_set_instance_data_from_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
    encoder_set_instance_data_from_dynamic_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
    encoder_set_instance_count: procedure(_this: Pbgfx_encoder_t; _numInstances: UInt32); cdecl;
    encoder_set_texture: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _sampler: bgfx_uniform_handle_t; _handle: bgfx_texture_handle_t; _flags: UInt32); cdecl;
    encoder_touch: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t); cdecl;
    encoder_submit: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
    encoder_submit_occlusion_query: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _occlusionQuery: bgfx_occlusion_query_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
    encoder_submit_indirect: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16; _depth: UInt32; _preserveState: Boolean); cdecl;
    encoder_set_compute_index_buffer: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
    encoder_set_compute_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
    encoder_set_compute_dynamic_index_buffer: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_dynamic_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
    encoder_set_compute_dynamic_vertex_buffer: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
    encoder_set_compute_indirect_buffer: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_indirect_buffer_handle_t; _access: bgfx_access_t); cdecl;
    encoder_set_image: procedure(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_texture_handle_t; _mip: UInt8; _access: bgfx_access_t; _format: bgfx_texture_format_t); cdecl;
    encoder_dispatch: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _numX: UInt32; _numY: UInt32; _numZ: UInt32); cdecl;
    encoder_dispatch_indirect: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16); cdecl;
    encoder_discard: procedure(_this: Pbgfx_encoder_t; _flags: UInt8); cdecl;
    encoder_blit: procedure(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _dst: bgfx_texture_handle_t; _dstMip: UInt8; _dstX: UInt16; _dstY: UInt16; _dstZ: UInt16; _src: bgfx_texture_handle_t; _srcMip: UInt8; _srcX: UInt16; _srcY: UInt16; _srcZ: UInt16; _width: UInt16; _height: UInt16; _depth: UInt16); cdecl;
    request_screen_shot: procedure(_handle: bgfx_frame_buffer_handle_t; _filePath: PUTF8Char); cdecl;
    render_frame: function(_msecs: Int32): bgfx_render_frame_t; cdecl;
    set_platform_data: procedure(_data: Pbgfx_platform_data_t); cdecl;
    get_internal_data: function(): Pbgfx_internal_data_t; cdecl;
    override_internal_texture_ptr: function(_handle: bgfx_texture_handle_t; _ptr: UIntPtr): UIntPtr; cdecl;
    override_internal_texture: function(_handle: bgfx_texture_handle_t; _width: UInt16; _height: UInt16; _numMips: UInt8; _format: bgfx_texture_format_t; _flags: UInt64): UIntPtr; cdecl;
    set_marker: procedure(_marker: PUTF8Char); cdecl;
    set_state: procedure(_state: UInt64; _rgba: UInt32); cdecl;
    set_condition: procedure(_handle: bgfx_occlusion_query_handle_t; _visible: Boolean); cdecl;
    set_stencil: procedure(_fstencil: UInt32; _bstencil: UInt32); cdecl;
    set_scissor: function(_x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16): UInt16; cdecl;
    set_scissor_cached: procedure(_cache: UInt16); cdecl;
    set_transform: function(_mtx: Pointer; _num: UInt16): UInt32; cdecl;
    set_transform_cached: procedure(_cache: UInt32; _num: UInt16); cdecl;
    alloc_transform: function(_transform: Pbgfx_transform_t; _num: UInt16): UInt32; cdecl;
    set_uniform: procedure(_handle: bgfx_uniform_handle_t; _value: Pointer; _num: UInt16); cdecl;
    set_index_buffer: procedure(_handle: bgfx_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
    set_dynamic_index_buffer: procedure(_handle: bgfx_dynamic_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
    set_transient_index_buffer: procedure(_tib: Pbgfx_transient_index_buffer_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
    set_vertex_buffer: procedure(_stream: UInt8; _handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32); cdecl;
    set_dynamic_vertex_buffer: procedure(_stream: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32); cdecl;
    set_transient_vertex_buffer: procedure(_stream: UInt8; _tvb: Pbgfx_transient_vertex_buffer_t; _startVertex: UInt32; _numVertices: UInt32); cdecl;
    set_vertex_count: procedure(_numVertices: UInt32); cdecl;
    set_instance_data_buffer: procedure(_idb: Pbgfx_instance_data_buffer_t; _start: UInt32; _num: UInt32); cdecl;
    set_instance_data_from_vertex_buffer: procedure(_handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
    set_instance_data_from_dynamic_vertex_buffer: procedure(_handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
    set_instance_count: procedure(_numInstances: UInt32); cdecl;
    set_texture: procedure(_stage: UInt8; _sampler: bgfx_uniform_handle_t; _handle: bgfx_texture_handle_t; _flags: UInt32); cdecl;
    touch: procedure(_id: bgfx_view_id_t); cdecl;
    submit: procedure(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
    submit_occlusion_query: procedure(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _occlusionQuery: bgfx_occlusion_query_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
    submit_indirect: procedure(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16; _depth: UInt32; _preserveState: Boolean); cdecl;
    set_compute_index_buffer: procedure(_stage: UInt8; _handle: bgfx_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
    set_compute_vertex_buffer: procedure(_stage: UInt8; _handle: bgfx_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
    set_compute_dynamic_index_buffer: procedure(_stage: UInt8; _handle: bgfx_dynamic_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
    set_compute_dynamic_vertex_buffer: procedure(_stage: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
    set_compute_indirect_buffer: procedure(_stage: UInt8; _handle: bgfx_indirect_buffer_handle_t; _access: bgfx_access_t); cdecl;
    set_image: procedure(_stage: UInt8; _handle: bgfx_texture_handle_t; _mip: UInt8; _access: bgfx_access_t; _format: bgfx_texture_format_t); cdecl;
    dispatch: procedure(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _numX: UInt32; _numY: UInt32; _numZ: UInt32); cdecl;
    dispatch_indirect: procedure(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16); cdecl;
    discard: procedure(_flags: UInt8); cdecl;
    blit: procedure(_id: bgfx_view_id_t; _dst: bgfx_texture_handle_t; _dstMip: UInt8; _dstX: UInt16; _dstY: UInt16; _dstZ: UInt16; _src: bgfx_texture_handle_t; _srcMip: UInt8; _srcX: UInt16; _srcY: UInt16; _srcZ: UInt16; _width: UInt16; _height: UInt16; _depth: UInt16); cdecl;
  end;

  bgfx_interface_vtbl_t = bgfx_interface_vtbl;
  Pbgfx_interface_vtbl_t = ^bgfx_interface_vtbl_t;

  (* *)
  PFN_BGFX_GET_INTERFACE = function(_version: UInt32): Pbgfx_interface_vtbl_t; cdecl;

(* Init attachment.
   @param(_handle [in] Render target texture handle.)
   @param(_access [in] Access. See `Access::Enum`.)
   @param(_layer [in] Cubemap side or depth layer/slice.)
   @param(_mip [in] Mip level.)
   @param(_resolve [in] Resolve flags. See: `BGFX_RESOLVE_*`) *)
procedure bgfx_attachment_init(_this: Pbgfx_attachment_t; _handle: bgfx_texture_handle_t; _access: bgfx_access_t; _layer: UInt16; _mip: UInt16; _resolve: UInt8); cdecl;
  external LIB_BGFX name 'bgfx_attachment_init';

(* Start VertexLayout.
   @param(_rendererType [in]) *)
function bgfx_vertex_layout_begin(_this: Pbgfx_vertex_layout_t; _rendererType: bgfx_renderer_type_t): Pbgfx_vertex_layout_t; cdecl;
  external LIB_BGFX name 'bgfx_vertex_layout_begin';

(* Add attribute to VertexLayout.

   Must be called between begin/end.
   @param(_attrib [in] Attribute semantics. See: `bgfx::Attrib`)
   @param(_num [in] Number of elements 1, 2, 3 or 4.)
   @param(_type [in] Element type.)
   @param(_normalized [in] When using fixed point AttribType (f.e. Uint8)
     value will be normalized for vertex shader usage. When normalized
     is set to true, AttribType::Uint8 value in range 0-255 will be
     in range 0.0-1.0 in vertex shader.)
   @param(_asInt [in] Packaging rule for vertexPack, vertexUnpack, and
     vertexConvert for AttribType::Uint8 and AttribType::Int16.
     Unpacking code must be implemented inside vertex shader.) *)
function bgfx_vertex_layout_add(_this: Pbgfx_vertex_layout_t; _attrib: bgfx_attrib_t; _num: UInt8; _type: bgfx_attrib_type_t; _normalized: Boolean; _asInt: Boolean): Pbgfx_vertex_layout_t; cdecl;
  external LIB_BGFX name 'bgfx_vertex_layout_add';

(* Decode attribute.
   @param(_attrib [in] Attribute semantics. See: `bgfx::Attrib`)
   @param(_num [out] Number of elements.)
   @param(_type [out] Element type.)
   @param(_normalized [out] Attribute is normalized.)
   @param(_asInt [out] Attribute is packed as int.) *)
procedure bgfx_vertex_layout_decode(_this: Pbgfx_vertex_layout_t; _attrib: bgfx_attrib_t; _num: PUInt8; _type: Pbgfx_attrib_type_t; _normalized: PBoolean; _asInt: PBoolean); cdecl;
  external LIB_BGFX name 'bgfx_vertex_layout_decode';

(* Returns true if VertexLayout contains attribute.
   @param(_attrib [in] Attribute semantics. See: `bgfx::Attrib`) *)
function bgfx_vertex_layout_has(_this: Pbgfx_vertex_layout_t; _attrib: bgfx_attrib_t): Boolean; cdecl;
  external LIB_BGFX name 'bgfx_vertex_layout_has';

(* Skip `_num` bytes in vertex stream.
   @param(_num [in]) *)
function bgfx_vertex_layout_skip(_this: Pbgfx_vertex_layout_t; _num: UInt8): Pbgfx_vertex_layout_t; cdecl;
  external LIB_BGFX name 'bgfx_vertex_layout_skip';

(* End VertexLayout. *)
procedure bgfx_vertex_layout_end(_this: Pbgfx_vertex_layout_t); cdecl;
  external LIB_BGFX name 'bgfx_vertex_layout_end';

(* Pack vertex attribute into vertex stream format.
   @param(_input [in] Value to be packed into vertex stream.)
   @param(_inputNormalized [in] `true` if input value is already normalized.)
   @param(_attr [in] Attribute to pack.)
   @param(_layout [in] Vertex stream layout.)
   @param(_data [in] Destination vertex stream where data will be packed.)
   @param(_index [in] Vertex index that will be modified.) *)
procedure bgfx_vertex_pack(_input: PSingle; _inputNormalized: Boolean; _attr: bgfx_attrib_t; _layout: Pbgfx_vertex_layout_t; _data: Pointer; _index: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_vertex_pack';

(* Unpack vertex attribute from vertex stream format.
   @param(_output [out] Result of unpacking.)
   @param(_attr [in] Attribute to unpack.)
   @param(_layout [in] Vertex stream layout.)
   @param(_data [in] Source vertex stream from where data will be unpacked.)
   @param(_index [in] Vertex index that will be unpacked.) *)
procedure bgfx_vertex_unpack(_output: PSingle; _attr: bgfx_attrib_t; _layout: Pbgfx_vertex_layout_t; _data: Pointer; _index: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_vertex_unpack';

(* Converts vertex stream data from one vertex stream format to another.
   @param(_dstLayout [in] Destination vertex stream layout.)
   @param(_dstData [in] Destination vertex stream.)
   @param(_srcLayout [in] Source vertex stream layout.)
   @param(_srcData [in] Source vertex stream data.)
   @param(_num [in] Number of vertices to convert from source to destination.) *)
procedure bgfx_vertex_convert(_dstLayout: Pbgfx_vertex_layout_t; _dstData: Pointer; _srcLayout: Pbgfx_vertex_layout_t; _srcData: Pointer; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_vertex_convert';

(* Weld vertices.
   @param(_output [in] Welded vertices remapping table. The size of buffer
     must be the same as number of vertices.)
   @param(_layout [in] Vertex stream layout.)
   @param(_data [in] Vertex stream.)
   @param(_num [in] Number of vertices in vertex stream.)
   @param(_epsilon [in] Error tolerance for vertex position comparison.)
   @returns(Number of unique vertices after vertex welding.) *)
function bgfx_weld_vertices(_output: PUInt16; _layout: Pbgfx_vertex_layout_t; _data: Pointer; _num: UInt16; _epsilon: Single): UInt16; cdecl;
  external LIB_BGFX name 'bgfx_weld_vertices';

(* Convert index buffer for use with different primitive topologies.
   @param(_conversion [in] Conversion type, see `TopologyConvert::Enum`.)
   @param(_dst [out] Destination index buffer. If this argument is NULL
     function will return number of indices after conversion.)
   @param(_dstSize [in] Destination index buffer in bytes. It must be
     large enough to contain output indices. If destination size is
     insufficient index buffer will be truncated.)
   @param(_indices [in] Source indices.)
   @param(_numIndices [in] Number of input indices.)
   @param(_index32 [in] Set to `true` if input indices are 32-bit.)
   @returns(Number of output indices after conversion.) *)
function bgfx_topology_convert(_conversion: bgfx_topology_convert_t; _dst: Pointer; _dstSize: UInt32; _indices: Pointer; _numIndices: UInt32; _index32: Boolean): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_topology_convert';

(* Sort indices.
   @param(_sort [in] Sort order, see `TopologySort::Enum`.)
   @param(_dst [out] Destination index buffer.)
   @param(_dstSize [in] Destination index buffer in bytes. It must be
     large enough to contain output indices. If destination size is
     insufficient index buffer will be truncated.)
   @param(_dir [in] Direction (vector must be normalized).)
   @param(_pos [in] Position.)
   @param(_vertices [in] Pointer to first vertex represented as
     float x, y, z. Must contain at least number of vertices
     referencende by index buffer.)
   @param(_stride [in] Vertex stride.)
   @param(_indices [in] Source indices.)
   @param(_numIndices [in] Number of input indices.)
   @param(_index32 [in] Set to `true` if input indices are 32-bit.) *)
procedure bgfx_topology_sort_tri_list(_sort: bgfx_topology_sort_t; _dst: Pointer; _dstSize: UInt32; _dir: PSingle; _pos: PSingle; _vertices: Pointer; _stride: UInt32; _indices: Pointer; _numIndices: UInt32; _index32: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_topology_sort_tri_list';

(* Returns supported backend API renderers.
   @param(_max [in] Maximum number of elements in _enum array.)
   @param(_enum [in] Array where supported renderers will be written.)
   @returns(Number of supported renderers.) *)
function bgfx_get_supported_renderers(_max: UInt8; _enum: Pbgfx_renderer_type_t): UInt8; cdecl;
  external LIB_BGFX name 'bgfx_get_supported_renderers';

(* Returns name of renderer.
   @param(_type [in] Renderer backend type. See: `bgfx::RendererType`)
   @returns(Name of renderer.) *)
function bgfx_get_renderer_name(_type: bgfx_renderer_type_t): PUTF8Char; cdecl;
  external LIB_BGFX name 'bgfx_get_renderer_name';

procedure bgfx_init_ctor(_init: Pbgfx_init_t); cdecl;
  external LIB_BGFX name 'bgfx_init_ctor';

(* Initialize bgfx library.
   @param(_init [in] Initialization parameters. See: `bgfx::Init` for more info.)
   @returns(`true` if initialization was successful.) *)
function bgfx_init(_init: Pbgfx_init_t): Boolean; cdecl;
  external LIB_BGFX name 'bgfx_init';

(* Shutdown bgfx library. *)
procedure bgfx_shutdown(); cdecl;
  external LIB_BGFX name 'bgfx_shutdown';

(* Reset graphic settings and back-buffer size.

   This call doesn't actually change window size, it just
   resizes back-buffer. Windowing code has to change window size.
   @param(_width [in] Back-buffer width.)
   @param(_height [in] Back-buffer height.)
   @param(_flags [in] See: `BGFX_RESET_*` for more info.
     - `BGFX_RESET_NONE` - No reset flags.
     - `BGFX_RESET_FULLSCREEN` - Not supported yet.
     - `BGFX_RESET_MSAA_X[2/4/8/16]` - Enable 2, 4, 8 or 16 x MSAA.
     - `BGFX_RESET_VSYNC` - Enable V-Sync.
     - `BGFX_RESET_MAXANISOTROPY` - Turn on/off max anisotropy.
     - `BGFX_RESET_CAPTURE` - Begin screen capture.
     - `BGFX_RESET_FLUSH_AFTER_RENDER` - Flush rendering after submitting to GPU.
     - `BGFX_RESET_FLIP_AFTER_RENDER` - This flag  specifies where flip
     occurs. Default behavior is that flip occurs before rendering new
     frame. This flag only has effect when `BGFX_CONFIG_MULTITHREADED=0`.
     - `BGFX_RESET_SRGB_BACKBUFFER` - Enable sRGB backbuffer.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.) *)
procedure bgfx_reset(_width: UInt32; _height: UInt32; _flags: UInt32; _format: bgfx_texture_format_t); cdecl;
  external LIB_BGFX name 'bgfx_reset';

(* Advance to next frame. When using multithreaded renderer, this call
   just swaps internal buffers, kicks render thread, and returns. In
   singlethreaded renderer this call does frame rendering.
   @param(_capture [in] Capture frame with graphics debugger.)
   @returns(Current frame number. This might be used in conjunction with
     double/multi buffering data outside the library and passing it to
     library via `bgfx::makeRef` calls.) *)
function bgfx_frame(_capture: Boolean): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_frame';

(* Returns current renderer backend API type.

   Library must be initialized. *)
function bgfx_get_renderer_type(): bgfx_renderer_type_t; cdecl;
  external LIB_BGFX name 'bgfx_get_renderer_type';

(* Returns renderer capabilities.

   Library must be initialized. *)
function bgfx_get_caps(): Pbgfx_caps_t; cdecl;
  external LIB_BGFX name 'bgfx_get_caps';

(* Returns performance counters.

   Pointer returned is valid until `bgfx::frame` is called. *)
function bgfx_get_stats(): Pbgfx_stats_t; cdecl;
  external LIB_BGFX name 'bgfx_get_stats';

(* Allocate buffer to pass to bgfx calls. Data will be freed inside bgfx.
   @param(_size [in] Size to allocate.)
   @returns(Allocated memory.) *)
function bgfx_alloc(_size: UInt32): Pbgfx_memory_t; cdecl;
  external LIB_BGFX name 'bgfx_alloc';

(* Allocate buffer and copy data into it. Data will be freed inside bgfx.
   @param(_data [in] Pointer to data to be copied.)
   @param(_size [in] Size of data to be copied.)
   @returns(Allocated memory.) *)
function bgfx_copy(_data: Pointer; _size: UInt32): Pbgfx_memory_t; cdecl;
  external LIB_BGFX name 'bgfx_copy';

(* Make reference to data to pass to bgfx. Unlike `bgfx::alloc`, this call
   doesn't allocate memory for data. It just copies the _data pointer. You
   can pass `ReleaseFn` function pointer to release this memory after it's
   consumed, otherwise you must make sure _data is available for at least 2
   `bgfx::frame` calls. `ReleaseFn` function must be able to be called
   from any thread.

   Data passed must be available for at least 2 `bgfx::frame` calls.
   @param(_data [in] Pointer to data.)
   @param(_size [in] Size of data.)
   @returns(Referenced memory.) *)
function bgfx_make_ref(_data: Pointer; _size: UInt32): Pbgfx_memory_t; cdecl;
  external LIB_BGFX name 'bgfx_make_ref';

(* Make reference to data to pass to bgfx. Unlike `bgfx::alloc`, this call
   doesn't allocate memory for data. It just copies the _data pointer. You
   can pass `ReleaseFn` function pointer to release this memory after it's
   consumed, otherwise you must make sure _data is available for at least 2
   `bgfx::frame` calls. `ReleaseFn` function must be able to be called
   from any thread.

   Data passed must be available for at least 2 `bgfx::frame` calls.
   @param(_data [in] Pointer to data.)
   @param(_size [in] Size of data.)
   @param(_releaseFn [in] Callback function to release memory after use.)
   @param(_userData [in] User data to be passed to callback function.)
   @returns(Referenced memory.) *)
function bgfx_make_ref_release(_data: Pointer; _size: UInt32; _releaseFn: bgfx_release_fn_t; _userData: Pointer): Pbgfx_memory_t; cdecl;
  external LIB_BGFX name 'bgfx_make_ref_release';

(* Set debug flags.
   @param(_debug [in] Available flags:
     - `BGFX_DEBUG_IFH` - Infinitely fast hardware. When this flag is set
     all rendering calls will be skipped. This is useful when profiling
     to quickly assess potential bottlenecks between CPU and GPU.
     - `BGFX_DEBUG_PROFILER` - Enable profiler.
     - `BGFX_DEBUG_STATS` - Display internal statistics.
     - `BGFX_DEBUG_TEXT` - Display debug text.
     - `BGFX_DEBUG_WIREFRAME` - Wireframe rendering. All rendering
     primitives will be rendered as lines.) *)
procedure bgfx_set_debug(_debug: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_debug';

(* Clear internal debug text buffer.
   @param(_attr [in] Background color.)
   @param(_small [in] Default 8x16 or 8x8 font.) *)
procedure bgfx_dbg_text_clear(_attr: UInt8; _small: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_dbg_text_clear';

(* Print formatted data to internal debug text character-buffer (VGA-compatible text mode).
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_attr [in] Color palette. Where top 4-bits represent index of background, and bottom
     4-bits represent foreground color from standard VGA text palette (ANSI escape codes).)
   @param(_format [in] `printf` style format.)
   @param( [in]) *)
procedure bgfx_dbg_text_printf(_x: UInt16; _y: UInt16; _attr: UInt8; _format: PUTF8Char) varargs; cdecl;
  external LIB_BGFX name 'bgfx_dbg_text_printf';

(* Print formatted data from variable argument list to internal debug text character-buffer (VGA-compatible text mode).
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_attr [in] Color palette. Where top 4-bits represent index of background, and bottom
     4-bits represent foreground color from standard VGA text palette (ANSI escape codes).)
   @param(_format [in] `printf` style format.)
   @param(_argList [in] Variable arguments list for format string.) *)
procedure bgfx_dbg_text_vprintf(_x: UInt16; _y: UInt16; _attr: UInt8; _format: PUTF8Char; _argList: Pointer); cdecl;
  external LIB_BGFX name 'bgfx_dbg_text_vprintf';

(* Draw image into internal debug text buffer.
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_width [in] Image width.)
   @param(_height [in] Image height.)
   @param(_data [in] Raw image data (character/attribute raw encoding).)
   @param(_pitch [in] Image pitch in bytes.) *)
procedure bgfx_dbg_text_image(_x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16; _data: Pointer; _pitch: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_dbg_text_image';

(* Create static index buffer.
   @param(_mem [in] Index buffer data.)
   @param(_flags [in] Buffer creation flags.
     - `BGFX_BUFFER_NONE` - No flags.
     - `BGFX_BUFFER_COMPUTE_READ` - Buffer will be read from by compute shader.
     - `BGFX_BUFFER_COMPUTE_WRITE` - Buffer will be written into by compute shader. When buffer
     is created with `BGFX_BUFFER_COMPUTE_WRITE` flag it cannot be updated from CPU.
     - `BGFX_BUFFER_COMPUTE_READ_WRITE` - Buffer will be used for read/write by compute shader.
     - `BGFX_BUFFER_ALLOW_RESIZE` - Buffer will resize on buffer update if a different amount of
     data is passed. If this flag is not specified, and more data is passed on update, the buffer
     will be trimmed to fit the existing buffer size. This flag has effect only on dynamic
     buffers.
     - `BGFX_BUFFER_INDEX32` - Buffer is using 32-bit indices. This flag has effect only on
     index buffers.) *)
function bgfx_create_index_buffer(_mem: Pbgfx_memory_t; _flags: UInt16): bgfx_index_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_index_buffer';

(* Set static index buffer debug name.
   @param(_handle [in] Static index buffer handle.)
   @param(_name [in] Static index buffer name.)
   @param(_len [in] Static index buffer name length (if length is INT32_MAX, it's expected
     that _name is zero terminated string.) ) *)
procedure bgfx_set_index_buffer_name(_handle: bgfx_index_buffer_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
  external LIB_BGFX name 'bgfx_set_index_buffer_name';

(* Destroy static index buffer.
   @param(_handle [in] Static index buffer handle.) *)
procedure bgfx_destroy_index_buffer(_handle: bgfx_index_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_index_buffer';

(* Create vertex layout.
   @param(_layout [in] Vertex layout.) *)
function bgfx_create_vertex_layout(_layout: Pbgfx_vertex_layout_t): bgfx_vertex_layout_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_vertex_layout';

(* Destroy vertex layout.
   @param(_layoutHandle [in] Vertex layout handle.) *)
procedure bgfx_destroy_vertex_layout(_layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_vertex_layout';

(* Create static vertex buffer.
   @param(_mem [in] Vertex buffer data.)
   @param(_layout [in] Vertex layout.)
   @param(_flags [in] Buffer creation flags.
     - `BGFX_BUFFER_NONE` - No flags.
     - `BGFX_BUFFER_COMPUTE_READ` - Buffer will be read from by compute shader.
     - `BGFX_BUFFER_COMPUTE_WRITE` - Buffer will be written into by compute shader. When buffer
     is created with `BGFX_BUFFER_COMPUTE_WRITE` flag it cannot be updated from CPU.
     - `BGFX_BUFFER_COMPUTE_READ_WRITE` - Buffer will be used for read/write by compute shader.
     - `BGFX_BUFFER_ALLOW_RESIZE` - Buffer will resize on buffer update if a different amount of
     data is passed. If this flag is not specified, and more data is passed on update, the buffer
     will be trimmed to fit the existing buffer size. This flag has effect only on dynamic buffers.
     - `BGFX_BUFFER_INDEX32` - Buffer is using 32-bit indices. This flag has effect only on index buffers.)
   @returns(Static vertex buffer handle.) *)
function bgfx_create_vertex_buffer(_mem: Pbgfx_memory_t; _layout: Pbgfx_vertex_layout_t; _flags: UInt16): bgfx_vertex_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_vertex_buffer';

(* Set static vertex buffer debug name.
   @param(_handle [in] Static vertex buffer handle.)
   @param(_name [in] Static vertex buffer name.)
   @param(_len [in] Static vertex buffer name length (if length is INT32_MAX, it's expected
     that _name is zero terminated string.) ) *)
procedure bgfx_set_vertex_buffer_name(_handle: bgfx_vertex_buffer_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
  external LIB_BGFX name 'bgfx_set_vertex_buffer_name';

(* Destroy static vertex buffer.
   @param(_handle [in] Static vertex buffer handle.) *)
procedure bgfx_destroy_vertex_buffer(_handle: bgfx_vertex_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_vertex_buffer';

(* Create empty dynamic index buffer.
   @param(_num [in] Number of indices.)
   @param(_flags [in] Buffer creation flags.
     - `BGFX_BUFFER_NONE` - No flags.
     - `BGFX_BUFFER_COMPUTE_READ` - Buffer will be read from by compute shader.
     - `BGFX_BUFFER_COMPUTE_WRITE` - Buffer will be written into by compute shader. When buffer
     is created with `BGFX_BUFFER_COMPUTE_WRITE` flag it cannot be updated from CPU.
     - `BGFX_BUFFER_COMPUTE_READ_WRITE` - Buffer will be used for read/write by compute shader.
     - `BGFX_BUFFER_ALLOW_RESIZE` - Buffer will resize on buffer update if a different amount of
     data is passed. If this flag is not specified, and more data is passed on update, the buffer
     will be trimmed to fit the existing buffer size. This flag has effect only on dynamic
     buffers.
     - `BGFX_BUFFER_INDEX32` - Buffer is using 32-bit indices. This flag has effect only on
     index buffers.)
   @returns(Dynamic index buffer handle.) *)
function bgfx_create_dynamic_index_buffer(_num: UInt32; _flags: UInt16): bgfx_dynamic_index_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_dynamic_index_buffer';

(* Create dynamic index buffer and initialized it.
   @param(_mem [in] Index buffer data.)
   @param(_flags [in] Buffer creation flags.
     - `BGFX_BUFFER_NONE` - No flags.
     - `BGFX_BUFFER_COMPUTE_READ` - Buffer will be read from by compute shader.
     - `BGFX_BUFFER_COMPUTE_WRITE` - Buffer will be written into by compute shader. When buffer
     is created with `BGFX_BUFFER_COMPUTE_WRITE` flag it cannot be updated from CPU.
     - `BGFX_BUFFER_COMPUTE_READ_WRITE` - Buffer will be used for read/write by compute shader.
     - `BGFX_BUFFER_ALLOW_RESIZE` - Buffer will resize on buffer update if a different amount of
     data is passed. If this flag is not specified, and more data is passed on update, the buffer
     will be trimmed to fit the existing buffer size. This flag has effect only on dynamic
     buffers.
     - `BGFX_BUFFER_INDEX32` - Buffer is using 32-bit indices. This flag has effect only on
     index buffers.)
   @returns(Dynamic index buffer handle.) *)
function bgfx_create_dynamic_index_buffer_mem(_mem: Pbgfx_memory_t; _flags: UInt16): bgfx_dynamic_index_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_dynamic_index_buffer_mem';

(* Update dynamic index buffer.
   @param(_handle [in] Dynamic index buffer handle.)
   @param(_startIndex [in] Start index.)
   @param(_mem [in] Index buffer data.) *)
procedure bgfx_update_dynamic_index_buffer(_handle: bgfx_dynamic_index_buffer_handle_t; _startIndex: UInt32; _mem: Pbgfx_memory_t); cdecl;
  external LIB_BGFX name 'bgfx_update_dynamic_index_buffer';

(* Destroy dynamic index buffer.
   @param(_handle [in] Dynamic index buffer handle.) *)
procedure bgfx_destroy_dynamic_index_buffer(_handle: bgfx_dynamic_index_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_dynamic_index_buffer';

(* Create empty dynamic vertex buffer.
   @param(_num [in] Number of vertices.)
   @param(_layout [in] Vertex layout.)
   @param(_flags [in] Buffer creation flags.
     - `BGFX_BUFFER_NONE` - No flags.
     - `BGFX_BUFFER_COMPUTE_READ` - Buffer will be read from by compute shader.
     - `BGFX_BUFFER_COMPUTE_WRITE` - Buffer will be written into by compute shader. When buffer
     is created with `BGFX_BUFFER_COMPUTE_WRITE` flag it cannot be updated from CPU.
     - `BGFX_BUFFER_COMPUTE_READ_WRITE` - Buffer will be used for read/write by compute shader.
     - `BGFX_BUFFER_ALLOW_RESIZE` - Buffer will resize on buffer update if a different amount of
     data is passed. If this flag is not specified, and more data is passed on update, the buffer
     will be trimmed to fit the existing buffer size. This flag has effect only on dynamic
     buffers.
     - `BGFX_BUFFER_INDEX32` - Buffer is using 32-bit indices. This flag has effect only on
     index buffers.)
   @returns(Dynamic vertex buffer handle.) *)
function bgfx_create_dynamic_vertex_buffer(_num: UInt32; _layout: Pbgfx_vertex_layout_t; _flags: UInt16): bgfx_dynamic_vertex_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_dynamic_vertex_buffer';

(* Create dynamic vertex buffer and initialize it.
   @param(_mem [in] Vertex buffer data.)
   @param(_layout [in] Vertex layout.)
   @param(_flags [in] Buffer creation flags.
     - `BGFX_BUFFER_NONE` - No flags.
     - `BGFX_BUFFER_COMPUTE_READ` - Buffer will be read from by compute shader.
     - `BGFX_BUFFER_COMPUTE_WRITE` - Buffer will be written into by compute shader. When buffer
     is created with `BGFX_BUFFER_COMPUTE_WRITE` flag it cannot be updated from CPU.
     - `BGFX_BUFFER_COMPUTE_READ_WRITE` - Buffer will be used for read/write by compute shader.
     - `BGFX_BUFFER_ALLOW_RESIZE` - Buffer will resize on buffer update if a different amount of
     data is passed. If this flag is not specified, and more data is passed on update, the buffer
     will be trimmed to fit the existing buffer size. This flag has effect only on dynamic
     buffers.
     - `BGFX_BUFFER_INDEX32` - Buffer is using 32-bit indices. This flag has effect only on
     index buffers.)
   @returns(Dynamic vertex buffer handle.) *)
function bgfx_create_dynamic_vertex_buffer_mem(_mem: Pbgfx_memory_t; _layout: Pbgfx_vertex_layout_t; _flags: UInt16): bgfx_dynamic_vertex_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_dynamic_vertex_buffer_mem';

(* Update dynamic vertex buffer.
   @param(_handle [in] Dynamic vertex buffer handle.)
   @param(_startVertex [in] Start vertex.)
   @param(_mem [in] Vertex buffer data.) *)
procedure bgfx_update_dynamic_vertex_buffer(_handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _mem: Pbgfx_memory_t); cdecl;
  external LIB_BGFX name 'bgfx_update_dynamic_vertex_buffer';

(* Destroy dynamic vertex buffer.
   @param(_handle [in] Dynamic vertex buffer handle.) *)
procedure bgfx_destroy_dynamic_vertex_buffer(_handle: bgfx_dynamic_vertex_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_dynamic_vertex_buffer';

(* Returns number of requested or maximum available indices.
   @param(_num [in] Number of required indices.)
   @returns(Number of requested or maximum available indices.) *)
function bgfx_get_avail_transient_index_buffer(_num: UInt32): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_get_avail_transient_index_buffer';

(* Returns number of requested or maximum available vertices.
   @param(_num [in] Number of required vertices.)
   @param(_layout [in] Vertex layout.)
   @returns(Number of requested or maximum available vertices.) *)
function bgfx_get_avail_transient_vertex_buffer(_num: UInt32; _layout: Pbgfx_vertex_layout_t): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_get_avail_transient_vertex_buffer';

(* Returns number of requested or maximum available instance buffer slots.
   @param(_num [in] Number of required instances.)
   @param(_stride [in] Stride per instance.)
   @returns(Number of requested or maximum available instance buffer slots.) *)
function bgfx_get_avail_instance_data_buffer(_num: UInt32; _stride: UInt16): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_get_avail_instance_data_buffer';

(* Allocate transient index buffer.

   Only 16-bit index buffer is supported.
   @param(_tib [out] TransientIndexBuffer structure is filled and is valid
     for the duration of frame, and it can be reused for multiple draw
     calls.)
   @param(_num [in] Number of indices to allocate.) *)
procedure bgfx_alloc_transient_index_buffer(_tib: Pbgfx_transient_index_buffer_t; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_alloc_transient_index_buffer';

(* Allocate transient vertex buffer.
   @param(_tvb [out] TransientVertexBuffer structure is filled and is valid
     for the duration of frame, and it can be reused for multiple draw
     calls.)
   @param(_num [in] Number of vertices to allocate.)
   @param(_layout [in] Vertex layout.) *)
procedure bgfx_alloc_transient_vertex_buffer(_tvb: Pbgfx_transient_vertex_buffer_t; _num: UInt32; _layout: Pbgfx_vertex_layout_t); cdecl;
  external LIB_BGFX name 'bgfx_alloc_transient_vertex_buffer';

(* Check for required space and allocate transient vertex and index
   buffers. If both space requirements are satisfied function returns
   true.

   Only 16-bit index buffer is supported.
   @param(_tvb [out] TransientVertexBuffer structure is filled and is valid
     for the duration of frame, and it can be reused for multiple draw
     calls.)
   @param(_layout [in] Vertex layout.)
   @param(_numVertices [in] Number of vertices to allocate.)
   @param(_tib [out] TransientIndexBuffer structure is filled and is valid
     for the duration of frame, and it can be reused for multiple draw
     calls.)
   @param(_numIndices [in] Number of indices to allocate.) *)
function bgfx_alloc_transient_buffers(_tvb: Pbgfx_transient_vertex_buffer_t; _layout: Pbgfx_vertex_layout_t; _numVertices: UInt32; _tib: Pbgfx_transient_index_buffer_t; _numIndices: UInt32): Boolean; cdecl;
  external LIB_BGFX name 'bgfx_alloc_transient_buffers';

(* Allocate instance data buffer.
   @param(_idb [out] InstanceDataBuffer structure is filled and is valid
     for duration of frame, and it can be reused for multiple draw
     calls.)
   @param(_num [in] Number of instances.)
   @param(_stride [in] Instance stride. Must be multiple of 16.) *)
procedure bgfx_alloc_instance_data_buffer(_idb: Pbgfx_instance_data_buffer_t; _num: UInt32; _stride: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_alloc_instance_data_buffer';

(* Create draw indirect buffer.
   @param(_num [in] Number of indirect calls.)
   @returns(Indirect buffer handle.) *)
function bgfx_create_indirect_buffer(_num: UInt32): bgfx_indirect_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_indirect_buffer';

(* Destroy draw indirect buffer.
   @param(_handle [in] Indirect buffer handle.) *)
procedure bgfx_destroy_indirect_buffer(_handle: bgfx_indirect_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_indirect_buffer';

(* Create shader from memory buffer.
   @param(_mem [in] Shader binary.)
   @returns(Shader handle.) *)
function bgfx_create_shader(_mem: Pbgfx_memory_t): bgfx_shader_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_shader';

(* Returns the number of uniforms and uniform handles used inside a shader.

   Only non-predefined uniforms are returned.
   @param(_handle [in] Shader handle.)
   @param(_uniforms [out] UniformHandle array where data will be stored.)
   @param(_max [in] Maximum capacity of array.)
   @returns(Number of uniforms used by shader.) *)
function bgfx_get_shader_uniforms(_handle: bgfx_shader_handle_t; _uniforms: Pbgfx_uniform_handle_t; _max: UInt16): UInt16; cdecl;
  external LIB_BGFX name 'bgfx_get_shader_uniforms';

(* Set shader debug name.
   @param(_handle [in] Shader handle.)
   @param(_name [in] Shader name.)
   @param(_len [in] Shader name length (if length is INT32_MAX, it's expected
     that _name is zero terminated string).) *)
procedure bgfx_set_shader_name(_handle: bgfx_shader_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
  external LIB_BGFX name 'bgfx_set_shader_name';

(* Destroy shader.

   Once a shader program is created with _handle,
   it is safe to destroy that shader.
   @param(_handle [in] Shader handle.) *)
procedure bgfx_destroy_shader(_handle: bgfx_shader_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_shader';

(* Create program with vertex and fragment shaders.
   @param(_vsh [in] Vertex shader.)
   @param(_fsh [in] Fragment shader.)
   @param(_destroyShaders [in] If true, shaders will be destroyed when program is destroyed.)
   @returns(Program handle if vertex shader output and fragment shader
     input are matching, otherwise returns invalid program handle.) *)
function bgfx_create_program(_vsh: bgfx_shader_handle_t; _fsh: bgfx_shader_handle_t; _destroyShaders: Boolean): bgfx_program_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_program';

(* Create program with compute shader.
   @param(_csh [in] Compute shader.)
   @param(_destroyShaders [in] If true, shaders will be destroyed when program is destroyed.)
   @returns(Program handle.) *)
function bgfx_create_compute_program(_csh: bgfx_shader_handle_t; _destroyShaders: Boolean): bgfx_program_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_compute_program';

(* Destroy program.
   @param(_handle [in] Program handle.) *)
procedure bgfx_destroy_program(_handle: bgfx_program_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_program';

(* Validate texture parameters.
   @param(_depth [in] Depth dimension of volume texture.)
   @param(_cubeMap [in] Indicates that texture contains cubemap.)
   @param(_numLayers [in] Number of layers in texture array.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_flags [in] Texture flags. See `BGFX_TEXTURE_*`.)
   @returns(True if texture can be successfully created.) *)
function bgfx_is_texture_valid(_depth: UInt16; _cubeMap: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64): Boolean; cdecl;
  external LIB_BGFX name 'bgfx_is_texture_valid';

(* Calculate amount of memory required for texture.
   @param(_info [out] Resulting texture info structure. See: `TextureInfo`.)
   @param(_width [in] Width.)
   @param(_height [in] Height.)
   @param(_depth [in] Depth dimension of volume texture.)
   @param(_cubeMap [in] Indicates that texture contains cubemap.)
   @param(_hasMips [in] Indicates that texture contains full mip-map chain.)
   @param(_numLayers [in] Number of layers in texture array.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.) *)
procedure bgfx_calc_texture_size(_info: Pbgfx_texture_info_t; _width: UInt16; _height: UInt16; _depth: UInt16; _cubeMap: Boolean; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t); cdecl;
  external LIB_BGFX name 'bgfx_calc_texture_size';

(* Create texture from memory buffer.
   @param(_mem [in] DDS, KTX or PVR texture binary data.)
   @param(_flags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @param(_skip [in] Skip top level mips when parsing texture.)
   @param(_info [out] When non-`NULL` is specified it returns parsed texture information.)
   @returns(Texture handle.) *)
function bgfx_create_texture(_mem: Pbgfx_memory_t; _flags: UInt64; _skip: UInt8; _info: Pbgfx_texture_info_t): bgfx_texture_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_texture';

(* Create 2D texture.
   @param(_width [in] Width.)
   @param(_height [in] Height.)
   @param(_hasMips [in] Indicates that texture contains full mip-map chain.)
   @param(_numLayers [in] Number of layers in texture array. Must be 1 if caps
     `BGFX_CAPS_TEXTURE_2D_ARRAY` flag is not set.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_flags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @param(_mem [in] Texture data. If `_mem` is non-NULL, created texture will be immutable. If
     `_mem` is NULL content of the texture is uninitialized. When `_numLayers` is more than
     1, expected memory layout is texture and all mips together for each array element.)
   @returns(Texture handle.) *)
function bgfx_create_texture_2d(_width: UInt16; _height: UInt16; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64; _mem: Pbgfx_memory_t): bgfx_texture_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_texture_2d';

(* Create texture with size based on backbuffer ratio. Texture will maintain ratio
   if back buffer resolution changes.
   @param(_ratio [in] Texture size in respect to back-buffer size. See: `BackbufferRatio::Enum`.)
   @param(_hasMips [in] Indicates that texture contains full mip-map chain.)
   @param(_numLayers [in] Number of layers in texture array. Must be 1 if caps
     `BGFX_CAPS_TEXTURE_2D_ARRAY` flag is not set.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_flags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @returns(Texture handle.) *)
function bgfx_create_texture_2d_scaled(_ratio: bgfx_backbuffer_ratio_t; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64): bgfx_texture_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_texture_2d_scaled';

(* Create 3D texture.
   @param(_width [in] Width.)
   @param(_height [in] Height.)
   @param(_depth [in] Depth.)
   @param(_hasMips [in] Indicates that texture contains full mip-map chain.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_flags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @param(_mem [in] Texture data. If `_mem` is non-NULL, created texture will be immutable. If
     `_mem` is NULL content of the texture is uninitialized. When `_numLayers` is more than
     1, expected memory layout is texture and all mips together for each array element.)
   @returns(Texture handle.) *)
function bgfx_create_texture_3d(_width: UInt16; _height: UInt16; _depth: UInt16; _hasMips: Boolean; _format: bgfx_texture_format_t; _flags: UInt64; _mem: Pbgfx_memory_t): bgfx_texture_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_texture_3d';

(* Create Cube texture.
   @param(_size [in] Cube side size.)
   @param(_hasMips [in] Indicates that texture contains full mip-map chain.)
   @param(_numLayers [in] Number of layers in texture array. Must be 1 if caps
     `BGFX_CAPS_TEXTURE_2D_ARRAY` flag is not set.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_flags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @param(_mem [in] Texture data. If `_mem` is non-NULL, created texture will be immutable. If
     `_mem` is NULL content of the texture is uninitialized. When `_numLayers` is more than
     1, expected memory layout is texture and all mips together for each array element.)
   @returns(Texture handle.) *)
function bgfx_create_texture_cube(_size: UInt16; _hasMips: Boolean; _numLayers: UInt16; _format: bgfx_texture_format_t; _flags: UInt64; _mem: Pbgfx_memory_t): bgfx_texture_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_texture_cube';

(* Update 2D texture.

   It's valid to update only mutable texture. See `bgfx::createTexture2D` for more info.
   @param(_handle [in] Texture handle.)
   @param(_layer [in] Layer in texture array.)
   @param(_mip [in] Mip level.)
   @param(_x [in] X offset in texture.)
   @param(_y [in] Y offset in texture.)
   @param(_width [in] Width of texture block.)
   @param(_height [in] Height of texture block.)
   @param(_mem [in] Texture update data.)
   @param(_pitch [in] Pitch of input image (bytes). When _pitch is set to
     UINT16_MAX, it will be calculated internally based on _width.) *)
procedure bgfx_update_texture_2d(_handle: bgfx_texture_handle_t; _layer: UInt16; _mip: UInt8; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16; _mem: Pbgfx_memory_t; _pitch: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_update_texture_2d';

(* Update 3D texture.

   It's valid to update only mutable texture. See `bgfx::createTexture3D` for more info.
   @param(_handle [in] Texture handle.)
   @param(_mip [in] Mip level.)
   @param(_x [in] X offset in texture.)
   @param(_y [in] Y offset in texture.)
   @param(_z [in] Z offset in texture.)
   @param(_width [in] Width of texture block.)
   @param(_height [in] Height of texture block.)
   @param(_depth [in] Depth of texture block.)
   @param(_mem [in] Texture update data.) *)
procedure bgfx_update_texture_3d(_handle: bgfx_texture_handle_t; _mip: UInt8; _x: UInt16; _y: UInt16; _z: UInt16; _width: UInt16; _height: UInt16; _depth: UInt16; _mem: Pbgfx_memory_t); cdecl;
  external LIB_BGFX name 'bgfx_update_texture_3d';

(* Update Cube texture.

   It's valid to update only mutable texture. See `bgfx::createTextureCube` for more info.
   @param(_handle [in] Texture handle.)
   @param(_layer [in] Layer in texture array.)
   @param(_side [in] Cubemap side `BGFX_CUBE_MAP_<POSITIVE or NEGATIVE>_<X, Y or Z>`,
     where 0 is +X, 1 is -X, 2 is +Y, 3 is -Y, 4 is +Z, and 5 is -Z.
     +----------+
     |-z       2|
     | ^  +y    |
     | |        |    Unfolded cube:
     | +---->+x |
     +----------+----------+----------+----------+
     |+y       1|+y       4|+y       0|+y       5|
     | ^  -x    | ^  +z    | ^  +x    | ^  -z    |
     | |        | |        | |        | |        |
     | +---->+z | +---->+x | +---->-z | +---->-x |
     +----------+----------+----------+----------+
     |+z       3|
     | ^  -y    |
     | |        |
     | +---->+x |
     +----------+)
   @param(_mip [in] Mip level.)
   @param(_x [in] X offset in texture.)
   @param(_y [in] Y offset in texture.)
   @param(_width [in] Width of texture block.)
   @param(_height [in] Height of texture block.)
   @param(_mem [in] Texture update data.)
   @param(_pitch [in] Pitch of input image (bytes). When _pitch is set to
     UINT16_MAX, it will be calculated internally based on _width.) *)
procedure bgfx_update_texture_cube(_handle: bgfx_texture_handle_t; _layer: UInt16; _side: UInt8; _mip: UInt8; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16; _mem: Pbgfx_memory_t; _pitch: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_update_texture_cube';

(* Read back texture content.

   Texture must be created with `BGFX_TEXTURE_READ_BACK` flag.

   Availability depends on: `BGFX_CAPS_TEXTURE_READ_BACK`.
   @param(_handle [in] Texture handle.)
   @param(_data [in] Destination buffer.)
   @param(_mip [in] Mip level.)
   @returns(Frame number when the result will be available. See: `bgfx::frame`.) *)
function bgfx_read_texture(_handle: bgfx_texture_handle_t; _data: Pointer; _mip: UInt8): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_read_texture';

(* Set texture debug name.
   @param(_handle [in] Texture handle.)
   @param(_name [in] Texture name.)
   @param(_len [in] Texture name length (if length is INT32_MAX, it's expected
     that _name is zero terminated string.) ) *)
procedure bgfx_set_texture_name(_handle: bgfx_texture_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
  external LIB_BGFX name 'bgfx_set_texture_name';

(* Returns texture direct access pointer.

   Availability depends on: `BGFX_CAPS_TEXTURE_DIRECT_ACCESS`. This feature
   is available on GPUs that have unified memory architecture (UMA) support.
   @param(_handle [in] Texture handle.)
   @returns(Pointer to texture memory. If returned pointer is `NULL` direct access
     is not available for this texture. If pointer is `UINTPTR_MAX` sentinel value
     it means texture is pending creation. Pointer returned can be cached and it
     will be valid until texture is destroyed.) *)
function bgfx_get_direct_access_ptr(_handle: bgfx_texture_handle_t): Pointer; cdecl;
  external LIB_BGFX name 'bgfx_get_direct_access_ptr';

(* Destroy texture.
   @param(_handle [in] Texture handle.) *)
procedure bgfx_destroy_texture(_handle: bgfx_texture_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_texture';

(* Create frame buffer (simple).
   @param(_width [in] Texture width.)
   @param(_height [in] Texture height.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_textureFlags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @returns(Frame buffer handle.) *)
function bgfx_create_frame_buffer(_width: UInt16; _height: UInt16; _format: bgfx_texture_format_t; _textureFlags: UInt64): bgfx_frame_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_frame_buffer';

(* Create frame buffer with size based on backbuffer ratio. Frame buffer will maintain ratio
   if back buffer resolution changes.
   @param(_ratio [in] Frame buffer size in respect to back-buffer size. See:
     `BackbufferRatio::Enum`.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_textureFlags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @returns(Frame buffer handle.) *)
function bgfx_create_frame_buffer_scaled(_ratio: bgfx_backbuffer_ratio_t; _format: bgfx_texture_format_t; _textureFlags: UInt64): bgfx_frame_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_frame_buffer_scaled';

(* Create MRT frame buffer from texture handles (simple).
   @param(_num [in] Number of texture handles.)
   @param(_handles [in] Texture attachments.)
   @param(_destroyTexture [in] If true, textures will be destroyed when
     frame buffer is destroyed.)
   @returns(Frame buffer handle.) *)
function bgfx_create_frame_buffer_from_handles(_num: UInt8; _handles: Pbgfx_texture_handle_t; _destroyTexture: Boolean): bgfx_frame_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_frame_buffer_from_handles';

(* Create MRT frame buffer from texture handles with specific layer and
   mip level.
   @param(_num [in] Number of attachements.)
   @param(_attachment [in] Attachment texture info. See: `bgfx::Attachment`.)
   @param(_destroyTexture [in] If true, textures will be destroyed when
     frame buffer is destroyed.)
   @returns(Frame buffer handle.) *)
function bgfx_create_frame_buffer_from_attachment(_num: UInt8; _attachment: Pbgfx_attachment_t; _destroyTexture: Boolean): bgfx_frame_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_frame_buffer_from_attachment';

(* Create frame buffer for multiple window rendering.

   Frame buffer cannot be used for sampling.

   Availability depends on: `BGFX_CAPS_SWAP_CHAIN`.
   @param(_nwh [in] OS' target native window handle.)
   @param(_width [in] Window back buffer width.)
   @param(_height [in] Window back buffer height.)
   @param(_format [in] Window back buffer color format.)
   @param(_depthFormat [in] Window back buffer depth format.)
   @returns(Frame buffer handle.) *)
function bgfx_create_frame_buffer_from_nwh(_nwh: Pointer; _width: UInt16; _height: UInt16; _format: bgfx_texture_format_t; _depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_frame_buffer_from_nwh';

(* Set frame buffer debug name.
   @param(_handle [in] Frame buffer handle.)
   @param(_name [in] Frame buffer name.)
   @param(_len [in] Frame buffer name length (if length is INT32_MAX, it's expected
     that _name is zero terminated string.) ) *)
procedure bgfx_set_frame_buffer_name(_handle: bgfx_frame_buffer_handle_t; _name: PUTF8Char; _len: Int32); cdecl;
  external LIB_BGFX name 'bgfx_set_frame_buffer_name';

(* Obtain texture handle of frame buffer attachment.
   @param(_handle [in] Frame buffer handle.)
   @param(_attachment [in]) *)
function bgfx_get_texture(_handle: bgfx_frame_buffer_handle_t; _attachment: UInt8): bgfx_texture_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_get_texture';

(* Destroy frame buffer.
   @param(_handle [in] Frame buffer handle.) *)
procedure bgfx_destroy_frame_buffer(_handle: bgfx_frame_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_frame_buffer';

(* Create shader uniform parameter.

   1. Uniform names are unique. It's valid to call `bgfx::createUniform`
   multiple times with the same uniform name. The library will always
   return the same handle, but the handle reference count will be
   incremented. This means that the same number of `bgfx::destroyUniform`
   must be called to properly destroy the uniform.
   2. Predefined uniforms (declared in `bgfx_shader.sh`):
   - `u_viewRect vec4(x, y, width, height)` - view rectangle for current
   view, in pixels.
   - `u_viewTexel vec4(1.0/width, 1.0/height, undef, undef)` - inverse
   width and height
   - `u_view mat4` - view matrix
   - `u_invView mat4` - inverted view matrix
   - `u_proj mat4` - projection matrix
   - `u_invProj mat4` - inverted projection matrix
   - `u_viewProj mat4` - concatenated view projection matrix
   - `u_invViewProj mat4` - concatenated inverted view projection matrix
   - `u_model mat4[BGFX_CONFIG_MAX_BONES]` - array of model matrices.
   - `u_modelView mat4` - concatenated model view matrix, only first
   model matrix from array is used.
   - `u_modelViewProj mat4` - concatenated model view projection matrix.
   - `u_alphaRef float` - alpha reference value for alpha test.
   @param(_name [in] Uniform name in shader.)
   @param(_type [in] Type of uniform (See: `bgfx::UniformType`).)
   @param(_num [in] Number of elements in array.)
   @returns(Handle to uniform object.) *)
function bgfx_create_uniform(_name: PUTF8Char; _type: bgfx_uniform_type_t; _num: UInt16): bgfx_uniform_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_uniform';

(* Retrieve uniform info.
   @param(_handle [in] Handle to uniform object.)
   @param(_info [out] Uniform info.) *)
procedure bgfx_get_uniform_info(_handle: bgfx_uniform_handle_t; _info: Pbgfx_uniform_info_t); cdecl;
  external LIB_BGFX name 'bgfx_get_uniform_info';

(* Destroy shader uniform parameter.
   @param(_handle [in] Handle to uniform object.) *)
procedure bgfx_destroy_uniform(_handle: bgfx_uniform_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_uniform';

(* Create occlusion query. *)
function bgfx_create_occlusion_query(): bgfx_occlusion_query_handle_t; cdecl;
  external LIB_BGFX name 'bgfx_create_occlusion_query';

(* Retrieve occlusion query result from previous frame.
   @param(_handle [in] Handle to occlusion query object.)
   @param(_result [out] Number of pixels that passed test. This argument
     can be `NULL` if result of occlusion query is not needed.)
   @returns(Occlusion query result.) *)
function bgfx_get_result(_handle: bgfx_occlusion_query_handle_t; _result: PInt32): bgfx_occlusion_query_result_t; cdecl;
  external LIB_BGFX name 'bgfx_get_result';

(* Destroy occlusion query.
   @param(_handle [in] Handle to occlusion query object.) *)
procedure bgfx_destroy_occlusion_query(_handle: bgfx_occlusion_query_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_destroy_occlusion_query';

(* Set palette color value.
   @param(_index [in] Index into palette.)
   @param(_rgba [in] RGBA floating point values.) *)
procedure bgfx_set_palette_color(_index: UInt8; _rgba: PSingle); cdecl;
  external LIB_BGFX name 'bgfx_set_palette_color';

(* Set palette color value.
   @param(_index [in] Index into palette.)
   @param(_rgba [in] Packed 32-bit RGBA value.) *)
procedure bgfx_set_palette_color_rgba8(_index: UInt8; _rgba: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_palette_color_rgba8';

(* Set view name.

   This is debug only feature.
   In graphics debugger view name will appear as:
   "nnnc <view name>"
   ^  ^ ^
   |  +--- compute (C)
   +------ view id
   @param(_id [in] View id.)
   @param(_name [in] View name.) *)
procedure bgfx_set_view_name(_id: bgfx_view_id_t; _name: PUTF8Char); cdecl;
  external LIB_BGFX name 'bgfx_set_view_name';

(* Set view rectangle. Draw primitive outside view will be clipped.
   @param(_id [in] View id.)
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_width [in] Width of view port region.)
   @param(_height [in] Height of view port region.) *)
procedure bgfx_set_view_rect(_id: bgfx_view_id_t; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_set_view_rect';

(* Set view rectangle. Draw primitive outside view will be clipped.
   @param(_id [in] View id.)
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_ratio [in] Width and height will be set in respect to back-buffer size.
     See: `BackbufferRatio::Enum`.) *)
procedure bgfx_set_view_rect_ratio(_id: bgfx_view_id_t; _x: UInt16; _y: UInt16; _ratio: bgfx_backbuffer_ratio_t); cdecl;
  external LIB_BGFX name 'bgfx_set_view_rect_ratio';

(* Set view scissor. Draw primitive outside view will be clipped. When
   _x, _y, _width and _height are set to 0, scissor will be disabled.
   @param(_id [in] View id.)
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_width [in] Width of view scissor region.)
   @param(_height [in] Height of view scissor region.) *)
procedure bgfx_set_view_scissor(_id: bgfx_view_id_t; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_set_view_scissor';

(* Set view clear flags.
   @param(_id [in] View id.)
   @param(_flags [in] Clear flags. Use `BGFX_CLEAR_NONE` to remove any clear
     operation. See: `BGFX_CLEAR_*`.)
   @param(_rgba [in] Color clear value.)
   @param(_depth [in] Depth clear value.)
   @param(_stencil [in] Stencil clear value.) *)
procedure bgfx_set_view_clear(_id: bgfx_view_id_t; _flags: UInt16; _rgba: UInt32; _depth: Single; _stencil: UInt8); cdecl;
  external LIB_BGFX name 'bgfx_set_view_clear';

(* Set view clear flags with different clear color for each
   frame buffer texture. Must use `bgfx::setPaletteColor` to setup clear color
   palette.
   @param(_id [in] View id.)
   @param(_flags [in] Clear flags. Use `BGFX_CLEAR_NONE` to remove any clear
     operation. See: `BGFX_CLEAR_*`.)
   @param(_depth [in] Depth clear value.)
   @param(_stencil [in] Stencil clear value.)
   @param(_c0 [in] Palette index for frame buffer attachment 0.)
   @param(_c1 [in] Palette index for frame buffer attachment 1.)
   @param(_c2 [in] Palette index for frame buffer attachment 2.)
   @param(_c3 [in] Palette index for frame buffer attachment 3.)
   @param(_c4 [in] Palette index for frame buffer attachment 4.)
   @param(_c5 [in] Palette index for frame buffer attachment 5.)
   @param(_c6 [in] Palette index for frame buffer attachment 6.)
   @param(_c7 [in] Palette index for frame buffer attachment 7.) *)
procedure bgfx_set_view_clear_mrt(_id: bgfx_view_id_t; _flags: UInt16; _depth: Single; _stencil: UInt8; _c0: UInt8; _c1: UInt8; _c2: UInt8; _c3: UInt8; _c4: UInt8; _c5: UInt8; _c6: UInt8; _c7: UInt8); cdecl;
  external LIB_BGFX name 'bgfx_set_view_clear_mrt';

(* Set view sorting mode.

   View mode must be set prior calling `bgfx::submit` for the view.
   @param(_id [in] View id.)
   @param(_mode [in] View sort mode. See `ViewMode::Enum`.) *)
procedure bgfx_set_view_mode(_id: bgfx_view_id_t; _mode: bgfx_view_mode_t); cdecl;
  external LIB_BGFX name 'bgfx_set_view_mode';

(* Set view frame buffer.

   Not persistent after `bgfx::reset` call.
   @param(_id [in] View id.)
   @param(_handle [in] Frame buffer handle. Passing `BGFX_INVALID_HANDLE` as
     frame buffer handle will draw primitives from this view into
     default back buffer.) *)
procedure bgfx_set_view_frame_buffer(_id: bgfx_view_id_t; _handle: bgfx_frame_buffer_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_set_view_frame_buffer';

(* Set view view and projection matrices, all draw primitives in this
   view will use these matrices.
   @param(_id [in] View id.)
   @param(_view [in] View matrix.)
   @param(_proj [in] Projection matrix.) *)
procedure bgfx_set_view_transform(_id: bgfx_view_id_t; _view: Pointer; _proj: Pointer); cdecl;
  external LIB_BGFX name 'bgfx_set_view_transform';

(* Post submit view reordering.
   @param(_id [in] First view id.)
   @param(_num [in] Number of views to remap.)
   @param(_order [in] View remap id table. Passing `NULL` will reset view ids
     to default state.) *)
procedure bgfx_set_view_order(_id: bgfx_view_id_t; _num: UInt16; _order: Pbgfx_view_id_t); cdecl;
  external LIB_BGFX name 'bgfx_set_view_order';

(* Begin submitting draw calls from thread.
   @param(_forThread [in] Explicitly request an encoder for a worker thread.)
   @returns(Encoder.) *)
function bgfx_encoder_begin(_forThread: Boolean): Pbgfx_encoder_t; cdecl;
  external LIB_BGFX name 'bgfx_encoder_begin';

(* End submitting draw calls from thread.
   @param(_encoder [in] Encoder.) *)
procedure bgfx_encoder_end(_encoder: Pbgfx_encoder_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_end';

(* Sets a debug marker. This allows you to group graphics calls together for easy browsing in
   graphics debugging tools.
   @param(_marker [in] Marker string.) *)
procedure bgfx_encoder_set_marker(_this: Pbgfx_encoder_t; _marker: PUTF8Char); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_marker';

(* Set render states for draw primitive.

   1. To setup more complex states use:
   `BGFX_STATE_ALPHA_REF(_ref)`,
   `BGFX_STATE_POINT_SIZE(_size)`,
   `BGFX_STATE_BLEND_FUNC(_src, _dst)`,
   `BGFX_STATE_BLEND_FUNC_SEPARATE(_srcRGB, _dstRGB, _srcA, _dstA)`,
   `BGFX_STATE_BLEND_EQUATION(_equation)`,
   `BGFX_STATE_BLEND_EQUATION_SEPARATE(_equationRGB, _equationA)`
   2. `BGFX_STATE_BLEND_EQUATION_ADD` is set when no other blend
   equation is specified.
   @param(_state [in] State flags. Default state for primitive type is
     triangles. See: `BGFX_STATE_DEFAULT`.
     - `BGFX_STATE_DEPTH_TEST_*` - Depth test function.
     - `BGFX_STATE_BLEND_*` - See remark 1 about BGFX_STATE_BLEND_FUNC.
     - `BGFX_STATE_BLEND_EQUATION_*` - See remark 2.
     - `BGFX_STATE_CULL_*` - Backface culling mode.
     - `BGFX_STATE_WRITE_*` - Enable R, G, B, A or Z write.
     - `BGFX_STATE_MSAA` - Enable hardware multisample antialiasing.
     - `BGFX_STATE_PT_[TRISTRIP/LINES/POINTS]` - Primitive type.)
   @param(_rgba [in] Sets blend factor used by `BGFX_STATE_BLEND_FACTOR` and
     `BGFX_STATE_BLEND_INV_FACTOR` blend modes.) *)
procedure bgfx_encoder_set_state(_this: Pbgfx_encoder_t; _state: UInt64; _rgba: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_state';

(* Set condition for rendering.
   @param(_handle [in] Occlusion query handle.)
   @param(_visible [in] Render if occlusion query is visible.) *)
procedure bgfx_encoder_set_condition(_this: Pbgfx_encoder_t; _handle: bgfx_occlusion_query_handle_t; _visible: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_condition';

(* Set stencil test state.
   @param(_fstencil [in] Front stencil state.)
   @param(_bstencil [in] Back stencil state. If back is set to `BGFX_STENCIL_NONE`
     _fstencil is applied to both front and back facing primitives.) *)
procedure bgfx_encoder_set_stencil(_this: Pbgfx_encoder_t; _fstencil: UInt32; _bstencil: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_stencil';

(* Set scissor for draw primitive.

   To scissor for all primitives in view see `bgfx::setViewScissor`.
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_width [in] Width of view scissor region.)
   @param(_height [in] Height of view scissor region.)
   @returns(Scissor cache index.) *)
function bgfx_encoder_set_scissor(_this: Pbgfx_encoder_t; _x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16): UInt16; cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_scissor';

(* Set scissor from cache for draw primitive.

   To scissor for all primitives in view see `bgfx::setViewScissor`.
   @param(_cache [in] Index in scissor cache.) *)
procedure bgfx_encoder_set_scissor_cached(_this: Pbgfx_encoder_t; _cache: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_scissor_cached';

(* Set model matrix for draw primitive. If it is not called,
   the model will be rendered with an identity model matrix.
   @param(_mtx [in] Pointer to first matrix in array.)
   @param(_num [in] Number of matrices in array.)
   @returns(Index into matrix cache in case the same model matrix has
     to be used for other draw primitive call.) *)
function bgfx_encoder_set_transform(_this: Pbgfx_encoder_t; _mtx: Pointer; _num: UInt16): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_transform';

(* Set model matrix from matrix cache for draw primitive.
   @param(_cache [in] Index in matrix cache.)
   @param(_num [in] Number of matrices from cache.) *)
procedure bgfx_encoder_set_transform_cached(_this: Pbgfx_encoder_t; _cache: UInt32; _num: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_transform_cached';

(* Reserve matrices in internal matrix cache.

   Pointer returned can be modifed until `bgfx::frame` is called.
   @param(_transform [out] Pointer to `Transform` structure.)
   @param(_num [in] Number of matrices.)
   @returns(Index in matrix cache.) *)
function bgfx_encoder_alloc_transform(_this: Pbgfx_encoder_t; _transform: Pbgfx_transform_t; _num: UInt16): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_encoder_alloc_transform';

(* Set shader uniform parameter for draw primitive.
   @param(_handle [in] Uniform.)
   @param(_value [in] Pointer to uniform data.)
   @param(_num [in] Number of elements. Passing `UINT16_MAX` will
     use the _num passed on uniform creation.) *)
procedure bgfx_encoder_set_uniform(_this: Pbgfx_encoder_t; _handle: bgfx_uniform_handle_t; _value: Pointer; _num: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_uniform';

(* Set index buffer for draw primitive.
   @param(_handle [in] Index buffer.)
   @param(_firstIndex [in] First index to render.)
   @param(_numIndices [in] Number of indices to render.) *)
procedure bgfx_encoder_set_index_buffer(_this: Pbgfx_encoder_t; _handle: bgfx_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_index_buffer';

(* Set index buffer for draw primitive.
   @param(_handle [in] Dynamic index buffer.)
   @param(_firstIndex [in] First index to render.)
   @param(_numIndices [in] Number of indices to render.) *)
procedure bgfx_encoder_set_dynamic_index_buffer(_this: Pbgfx_encoder_t; _handle: bgfx_dynamic_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_dynamic_index_buffer';

(* Set index buffer for draw primitive.
   @param(_tib [in] Transient index buffer.)
   @param(_firstIndex [in] First index to render.)
   @param(_numIndices [in] Number of indices to render.) *)
procedure bgfx_encoder_set_transient_index_buffer(_this: Pbgfx_encoder_t; _tib: Pbgfx_transient_index_buffer_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_transient_index_buffer';

(* Set vertex buffer for draw primitive.
   @param(_stream [in] Vertex stream.)
   @param(_handle [in] Vertex buffer.)
   @param(_startVertex [in] First vertex to render.)
   @param(_numVertices [in] Number of vertices to render.)
   @param(_layoutHandle [in] Vertex layout for aliasing vertex buffer.) *)
procedure bgfx_encoder_set_vertex_buffer(_this: Pbgfx_encoder_t; _stream: UInt8; _handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32; _layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_vertex_buffer';

(* Set vertex buffer for draw primitive.
   @param(_stream [in] Vertex stream.)
   @param(_handle [in] Dynamic vertex buffer.)
   @param(_startVertex [in] First vertex to render.)
   @param(_numVertices [in] Number of vertices to render.)
   @param(_layoutHandle [in] Vertex layout for aliasing vertex buffer.) *)
procedure bgfx_encoder_set_dynamic_vertex_buffer(_this: Pbgfx_encoder_t; _stream: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32; _layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_dynamic_vertex_buffer';

(* Set vertex buffer for draw primitive.
   @param(_stream [in] Vertex stream.)
   @param(_tvb [in] Transient vertex buffer.)
   @param(_startVertex [in] First vertex to render.)
   @param(_numVertices [in] Number of vertices to render.)
   @param(_layoutHandle [in] Vertex layout for aliasing vertex buffer.) *)
procedure bgfx_encoder_set_transient_vertex_buffer(_this: Pbgfx_encoder_t; _stream: UInt8; _tvb: Pbgfx_transient_vertex_buffer_t; _startVertex: UInt32; _numVertices: UInt32; _layoutHandle: bgfx_vertex_layout_handle_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_transient_vertex_buffer';

(* Set number of vertices for auto generated vertices use in conjuction
   with gl_VertexID.

   Availability depends on: `BGFX_CAPS_VERTEX_ID`.
   @param(_numVertices [in] Number of vertices.) *)
procedure bgfx_encoder_set_vertex_count(_this: Pbgfx_encoder_t; _numVertices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_vertex_count';

(* Set instance data buffer for draw primitive.
   @param(_idb [in] Transient instance data buffer.)
   @param(_start [in] First instance data.)
   @param(_num [in] Number of data instances.) *)
procedure bgfx_encoder_set_instance_data_buffer(_this: Pbgfx_encoder_t; _idb: Pbgfx_instance_data_buffer_t; _start: UInt32; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_instance_data_buffer';

(* Set instance data buffer for draw primitive.
   @param(_handle [in] Vertex buffer.)
   @param(_startVertex [in] First instance data.)
   @param(_num [in] Number of data instances.
     Set instance data buffer for draw primitive.) *)
procedure bgfx_encoder_set_instance_data_from_vertex_buffer(_this: Pbgfx_encoder_t; _handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_instance_data_from_vertex_buffer';

(* Set instance data buffer for draw primitive.
   @param(_handle [in] Dynamic vertex buffer.)
   @param(_startVertex [in] First instance data.)
   @param(_num [in] Number of data instances.) *)
procedure bgfx_encoder_set_instance_data_from_dynamic_vertex_buffer(_this: Pbgfx_encoder_t; _handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_instance_data_from_dynamic_vertex_buffer';

(* Set number of instances for auto generated instances use in conjuction
   with gl_InstanceID.

   Availability depends on: `BGFX_CAPS_VERTEX_ID`.
   @param(_numInstances [in]) *)
procedure bgfx_encoder_set_instance_count(_this: Pbgfx_encoder_t; _numInstances: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_instance_count';

(* Set texture stage for draw primitive.
   @param(_stage [in] Texture unit.)
   @param(_sampler [in] Program sampler.)
   @param(_handle [in] Texture handle.)
   @param(_flags [in] Texture sampling mode. Default value UINT32_MAX uses
     texture sampling settings from the texture.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.) *)
procedure bgfx_encoder_set_texture(_this: Pbgfx_encoder_t; _stage: UInt8; _sampler: bgfx_uniform_handle_t; _handle: bgfx_texture_handle_t; _flags: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_texture';

(* Submit an empty primitive for rendering. Uniforms and draw state
   will be applied but no geometry will be submitted.

   These empty draw calls will sort before ordinary draw calls.
   @param(_id [in] View id.) *)
procedure bgfx_encoder_touch(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_touch';

(* Submit primitive for rendering.
   @param(_id [in] View id.)
   @param(_program [in] Program.)
   @param(_depth [in] Depth for sorting.)
   @param(_preserveState [in] Preserve internal draw state for next draw call submit.) *)
procedure bgfx_encoder_submit(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_encoder_submit';

(* Submit primitive with occlusion query for rendering.
   @param(_id [in] View id.)
   @param(_program [in] Program.)
   @param(_occlusionQuery [in] Occlusion query.)
   @param(_depth [in] Depth for sorting.)
   @param(_preserveState [in] Preserve internal draw state for next draw call submit.) *)
procedure bgfx_encoder_submit_occlusion_query(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _occlusionQuery: bgfx_occlusion_query_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_encoder_submit_occlusion_query';

(* Submit primitive for rendering with index and instance data info from
   indirect buffer.
   @param(_id [in] View id.)
   @param(_program [in] Program.)
   @param(_indirectHandle [in] Indirect buffer.)
   @param(_start [in] First element in indirect buffer.)
   @param(_num [in] Number of dispatches.)
   @param(_depth [in] Depth for sorting.)
   @param(_preserveState [in] Preserve internal draw state for next draw call submit.) *)
procedure bgfx_encoder_submit_indirect(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16; _depth: UInt32; _preserveState: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_encoder_submit_indirect';

(* Set compute index buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Index buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_encoder_set_compute_index_buffer(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_compute_index_buffer';

(* Set compute vertex buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Vertex buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_encoder_set_compute_vertex_buffer(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_compute_vertex_buffer';

(* Set compute dynamic index buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Dynamic index buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_encoder_set_compute_dynamic_index_buffer(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_dynamic_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_compute_dynamic_index_buffer';

(* Set compute dynamic vertex buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Dynamic vertex buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_encoder_set_compute_dynamic_vertex_buffer(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_compute_dynamic_vertex_buffer';

(* Set compute indirect buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Indirect buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_encoder_set_compute_indirect_buffer(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_indirect_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_compute_indirect_buffer';

(* Set compute image from texture.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Texture handle.)
   @param(_mip [in] Mip level.)
   @param(_access [in] Image access. See `Access::Enum`.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.) *)
procedure bgfx_encoder_set_image(_this: Pbgfx_encoder_t; _stage: UInt8; _handle: bgfx_texture_handle_t; _mip: UInt8; _access: bgfx_access_t; _format: bgfx_texture_format_t); cdecl;
  external LIB_BGFX name 'bgfx_encoder_set_image';

(* Dispatch compute.
   @param(_id [in] View id.)
   @param(_program [in] Compute program.)
   @param(_numX [in] Number of groups X.)
   @param(_numY [in] Number of groups Y.)
   @param(_numZ [in] Number of groups Z.) *)
procedure bgfx_encoder_dispatch(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _numX: UInt32; _numY: UInt32; _numZ: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_encoder_dispatch';

(* Dispatch compute indirect.
   @param(_id [in] View id.)
   @param(_program [in] Compute program.)
   @param(_indirectHandle [in] Indirect buffer.)
   @param(_start [in] First element in indirect buffer.)
   @param(_num [in] Number of dispatches.) *)
procedure bgfx_encoder_dispatch_indirect(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_encoder_dispatch_indirect';

(* Discard previously set state for draw or compute call.
   @param(_flags [in] Draw/compute states to discard.) *)
procedure bgfx_encoder_discard(_this: Pbgfx_encoder_t; _flags: UInt8); cdecl;
  external LIB_BGFX name 'bgfx_encoder_discard';

(* Blit 2D texture region between two 2D textures.

   Destination texture must be created with `BGFX_TEXTURE_BLIT_DST` flag.

   Availability depends on: `BGFX_CAPS_TEXTURE_BLIT`.
   @param(_id [in] View id.)
   @param(_dst [in] Destination texture handle.)
   @param(_dstMip [in] Destination texture mip level.)
   @param(_dstX [in] Destination texture X position.)
   @param(_dstY [in] Destination texture Y position.)
   @param(_dstZ [in] If texture is 2D this argument should be 0. If destination texture is cube
     this argument represents destination texture cube face. For 3D texture this argument
     represents destination texture Z position.)
   @param(_src [in] Source texture handle.)
   @param(_srcMip [in] Source texture mip level.)
   @param(_srcX [in] Source texture X position.)
   @param(_srcY [in] Source texture Y position.)
   @param(_srcZ [in] If texture is 2D this argument should be 0. If source texture is cube
     this argument represents source texture cube face. For 3D texture this argument
     represents source texture Z position.)
   @param(_width [in] Width of region.)
   @param(_height [in] Height of region.)
   @param(_depth [in] If texture is 3D this argument represents depth of region, otherwise it's
     unused.) *)
procedure bgfx_encoder_blit(_this: Pbgfx_encoder_t; _id: bgfx_view_id_t; _dst: bgfx_texture_handle_t; _dstMip: UInt8; _dstX: UInt16; _dstY: UInt16; _dstZ: UInt16; _src: bgfx_texture_handle_t; _srcMip: UInt8; _srcX: UInt16; _srcY: UInt16; _srcZ: UInt16; _width: UInt16; _height: UInt16; _depth: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_encoder_blit';

(* Request screen shot of window back buffer.

   `bgfx::CallbackI::screenShot` must be implemented.

   Frame buffer handle must be created with OS' target native window handle.
   @param(_handle [in] Frame buffer handle. If handle is `BGFX_INVALID_HANDLE` request will be
     made for main window back buffer.)
   @param(_filePath [in] Will be passed to `bgfx::CallbackI::screenShot` callback.) *)
procedure bgfx_request_screen_shot(_handle: bgfx_frame_buffer_handle_t; _filePath: PUTF8Char); cdecl;
  external LIB_BGFX name 'bgfx_request_screen_shot';

(* Render frame.

   `bgfx::renderFrame` is blocking call. It waits for
   `bgfx::frame` to be called from API thread to process frame.
   If timeout value is passed call will timeout and return even
   if `bgfx::frame` is not called.

   This call should be only used on platforms that don't
   allow creating separate rendering thread. If it is called before
   to bgfx::init, render thread won't be created by bgfx::init call.
   @param(_msecs [in] Timeout in milliseconds.)
   @returns(Current renderer context state. See: `bgfx::RenderFrame`.) *)
function bgfx_render_frame(_msecs: Int32): bgfx_render_frame_t; cdecl;
  external LIB_BGFX name 'bgfx_render_frame';

(* Set platform data.

   Must be called before `bgfx::init`.
   @param(_data [in] Platform data.) *)
procedure bgfx_set_platform_data(_data: Pbgfx_platform_data_t); cdecl;
  external LIB_BGFX name 'bgfx_set_platform_data';

(* Get internal data for interop.

   It's expected you understand some bgfx internals before you
   use this call.

   Must be called only on render thread. *)
function bgfx_get_internal_data(): Pbgfx_internal_data_t; cdecl;
  external LIB_BGFX name 'bgfx_get_internal_data';

(* Override internal texture with externally created texture. Previously
   created internal texture will released.

   It's expected you understand some bgfx internals before you
   use this call.

   Must be called only on render thread.
   @param(_handle [in] Texture handle.)
   @param(_ptr [in] Native API pointer to texture.)
   @returns(Native API pointer to texture. If result is 0, texture is not created
     yet from the main thread.) *)
function bgfx_override_internal_texture_ptr(_handle: bgfx_texture_handle_t; _ptr: UIntPtr): UIntPtr; cdecl;
  external LIB_BGFX name 'bgfx_override_internal_texture_ptr';

(* Override internal texture by creating new texture. Previously created
   internal texture will released.

   It's expected you understand some bgfx internals before you
   use this call.

   @returns(Native API pointer to texture. If result is 0, texture is not created yet from the
     main thread.)
   Must be called only on render thread.
   @param(_handle [in] Texture handle.)
   @param(_width [in] Width.)
   @param(_height [in] Height.)
   @param(_numMips [in] Number of mip-maps.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.)
   @param(_flags [in] Texture creation (see `BGFX_TEXTURE_*`.), and sampler (see `BGFX_SAMPLER_*`)
     flags. Default texture sampling mode is linear, and wrap mode is repeat.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.)
   @returns(Native API pointer to texture. If result is 0, texture is not created
     yet from the main thread.) *)
function bgfx_override_internal_texture(_handle: bgfx_texture_handle_t; _width: UInt16; _height: UInt16; _numMips: UInt8; _format: bgfx_texture_format_t; _flags: UInt64): UIntPtr; cdecl;
  external LIB_BGFX name 'bgfx_override_internal_texture';

(* Sets a debug marker. This allows you to group graphics calls together for easy browsing in
   graphics debugging tools.
   @param(_marker [in] Marker string.) *)
procedure bgfx_set_marker(_marker: PUTF8Char); cdecl;
  external LIB_BGFX name 'bgfx_set_marker';

(* Set render states for draw primitive.

   1. To setup more complex states use:
   `BGFX_STATE_ALPHA_REF(_ref)`,
   `BGFX_STATE_POINT_SIZE(_size)`,
   `BGFX_STATE_BLEND_FUNC(_src, _dst)`,
   `BGFX_STATE_BLEND_FUNC_SEPARATE(_srcRGB, _dstRGB, _srcA, _dstA)`,
   `BGFX_STATE_BLEND_EQUATION(_equation)`,
   `BGFX_STATE_BLEND_EQUATION_SEPARATE(_equationRGB, _equationA)`
   2. `BGFX_STATE_BLEND_EQUATION_ADD` is set when no other blend
   equation is specified.
   @param(_state [in] State flags. Default state for primitive type is
     triangles. See: `BGFX_STATE_DEFAULT`.
     - `BGFX_STATE_DEPTH_TEST_*` - Depth test function.
     - `BGFX_STATE_BLEND_*` - See remark 1 about BGFX_STATE_BLEND_FUNC.
     - `BGFX_STATE_BLEND_EQUATION_*` - See remark 2.
     - `BGFX_STATE_CULL_*` - Backface culling mode.
     - `BGFX_STATE_WRITE_*` - Enable R, G, B, A or Z write.
     - `BGFX_STATE_MSAA` - Enable hardware multisample antialiasing.
     - `BGFX_STATE_PT_[TRISTRIP/LINES/POINTS]` - Primitive type.)
   @param(_rgba [in] Sets blend factor used by `BGFX_STATE_BLEND_FACTOR` and
     `BGFX_STATE_BLEND_INV_FACTOR` blend modes.) *)
procedure bgfx_set_state(_state: UInt64; _rgba: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_state';

(* Set condition for rendering.
   @param(_handle [in] Occlusion query handle.)
   @param(_visible [in] Render if occlusion query is visible.) *)
procedure bgfx_set_condition(_handle: bgfx_occlusion_query_handle_t; _visible: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_set_condition';

(* Set stencil test state.
   @param(_fstencil [in] Front stencil state.)
   @param(_bstencil [in] Back stencil state. If back is set to `BGFX_STENCIL_NONE`
     _fstencil is applied to both front and back facing primitives.) *)
procedure bgfx_set_stencil(_fstencil: UInt32; _bstencil: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_stencil';

(* Set scissor for draw primitive.

   To scissor for all primitives in view see `bgfx::setViewScissor`.
   @param(_x [in] Position x from the left corner of the window.)
   @param(_y [in] Position y from the top corner of the window.)
   @param(_width [in] Width of view scissor region.)
   @param(_height [in] Height of view scissor region.)
   @returns(Scissor cache index.) *)
function bgfx_set_scissor(_x: UInt16; _y: UInt16; _width: UInt16; _height: UInt16): UInt16; cdecl;
  external LIB_BGFX name 'bgfx_set_scissor';

(* Set scissor from cache for draw primitive.

   To scissor for all primitives in view see `bgfx::setViewScissor`.
   @param(_cache [in] Index in scissor cache.) *)
procedure bgfx_set_scissor_cached(_cache: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_set_scissor_cached';

(* Set model matrix for draw primitive. If it is not called,
   the model will be rendered with an identity model matrix.
   @param(_mtx [in] Pointer to first matrix in array.)
   @param(_num [in] Number of matrices in array.)
   @returns(Index into matrix cache in case the same model matrix has
     to be used for other draw primitive call.) *)
function bgfx_set_transform(_mtx: Pointer; _num: UInt16): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_set_transform';

(* Set model matrix from matrix cache for draw primitive.
   @param(_cache [in] Index in matrix cache.)
   @param(_num [in] Number of matrices from cache.) *)
procedure bgfx_set_transform_cached(_cache: UInt32; _num: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_set_transform_cached';

(* Reserve matrices in internal matrix cache.

   Pointer returned can be modifed until `bgfx::frame` is called.
   @param(_transform [out] Pointer to `Transform` structure.)
   @param(_num [in] Number of matrices.)
   @returns(Index in matrix cache.) *)
function bgfx_alloc_transform(_transform: Pbgfx_transform_t; _num: UInt16): UInt32; cdecl;
  external LIB_BGFX name 'bgfx_alloc_transform';

(* Set shader uniform parameter for draw primitive.
   @param(_handle [in] Uniform.)
   @param(_value [in] Pointer to uniform data.)
   @param(_num [in] Number of elements. Passing `UINT16_MAX` will
     use the _num passed on uniform creation.) *)
procedure bgfx_set_uniform(_handle: bgfx_uniform_handle_t; _value: Pointer; _num: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_set_uniform';

(* Set index buffer for draw primitive.
   @param(_handle [in] Index buffer.)
   @param(_firstIndex [in] First index to render.)
   @param(_numIndices [in] Number of indices to render.) *)
procedure bgfx_set_index_buffer(_handle: bgfx_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_index_buffer';

(* Set index buffer for draw primitive.
   @param(_handle [in] Dynamic index buffer.)
   @param(_firstIndex [in] First index to render.)
   @param(_numIndices [in] Number of indices to render.) *)
procedure bgfx_set_dynamic_index_buffer(_handle: bgfx_dynamic_index_buffer_handle_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_dynamic_index_buffer';

(* Set index buffer for draw primitive.
   @param(_tib [in] Transient index buffer.)
   @param(_firstIndex [in] First index to render.)
   @param(_numIndices [in] Number of indices to render.) *)
procedure bgfx_set_transient_index_buffer(_tib: Pbgfx_transient_index_buffer_t; _firstIndex: UInt32; _numIndices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_transient_index_buffer';

(* Set vertex buffer for draw primitive.
   @param(_stream [in] Vertex stream.)
   @param(_handle [in] Vertex buffer.)
   @param(_startVertex [in] First vertex to render.)
   @param(_numVertices [in] Number of vertices to render.) *)
procedure bgfx_set_vertex_buffer(_stream: UInt8; _handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_vertex_buffer';

(* Set vertex buffer for draw primitive.
   @param(_stream [in] Vertex stream.)
   @param(_handle [in] Dynamic vertex buffer.)
   @param(_startVertex [in] First vertex to render.)
   @param(_numVertices [in] Number of vertices to render.) *)
procedure bgfx_set_dynamic_vertex_buffer(_stream: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _numVertices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_dynamic_vertex_buffer';

(* Set vertex buffer for draw primitive.
   @param(_stream [in] Vertex stream.)
   @param(_tvb [in] Transient vertex buffer.)
   @param(_startVertex [in] First vertex to render.)
   @param(_numVertices [in] Number of vertices to render.) *)
procedure bgfx_set_transient_vertex_buffer(_stream: UInt8; _tvb: Pbgfx_transient_vertex_buffer_t; _startVertex: UInt32; _numVertices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_transient_vertex_buffer';

(* Set number of vertices for auto generated vertices use in conjuction
   with gl_VertexID.

   Availability depends on: `BGFX_CAPS_VERTEX_ID`.
   @param(_numVertices [in] Number of vertices.) *)
procedure bgfx_set_vertex_count(_numVertices: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_vertex_count';

(* Set instance data buffer for draw primitive.
   @param(_idb [in] Transient instance data buffer.)
   @param(_start [in] First instance data.)
   @param(_num [in] Number of data instances.) *)
procedure bgfx_set_instance_data_buffer(_idb: Pbgfx_instance_data_buffer_t; _start: UInt32; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_instance_data_buffer';

(* Set instance data buffer for draw primitive.
   @param(_handle [in] Vertex buffer.)
   @param(_startVertex [in] First instance data.)
   @param(_num [in] Number of data instances.
     Set instance data buffer for draw primitive.) *)
procedure bgfx_set_instance_data_from_vertex_buffer(_handle: bgfx_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_instance_data_from_vertex_buffer';

(* Set instance data buffer for draw primitive.
   @param(_handle [in] Dynamic vertex buffer.)
   @param(_startVertex [in] First instance data.)
   @param(_num [in] Number of data instances.) *)
procedure bgfx_set_instance_data_from_dynamic_vertex_buffer(_handle: bgfx_dynamic_vertex_buffer_handle_t; _startVertex: UInt32; _num: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_instance_data_from_dynamic_vertex_buffer';

(* Set number of instances for auto generated instances use in conjuction
   with gl_InstanceID.

   Availability depends on: `BGFX_CAPS_VERTEX_ID`.
   @param(_numInstances [in]) *)
procedure bgfx_set_instance_count(_numInstances: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_instance_count';

(* Set texture stage for draw primitive.
   @param(_stage [in] Texture unit.)
   @param(_sampler [in] Program sampler.)
   @param(_handle [in] Texture handle.)
   @param(_flags [in] Texture sampling mode. Default value UINT32_MAX uses
     texture sampling settings from the texture.
     - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
     mode.
     - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
     sampling.) *)
procedure bgfx_set_texture(_stage: UInt8; _sampler: bgfx_uniform_handle_t; _handle: bgfx_texture_handle_t; _flags: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_set_texture';

(* Submit an empty primitive for rendering. Uniforms and draw state
   will be applied but no geometry will be submitted.

   These empty draw calls will sort before ordinary draw calls.
   @param(_id [in] View id.) *)
procedure bgfx_touch(_id: bgfx_view_id_t); cdecl;
  external LIB_BGFX name 'bgfx_touch';

(* Submit primitive for rendering.
   @param(_id [in] View id.)
   @param(_program [in] Program.)
   @param(_depth [in] Depth for sorting.)
   @param(_preserveState [in] Preserve internal draw state for next draw call submit.) *)
procedure bgfx_submit(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_submit';

(* Submit primitive with occlusion query for rendering.
   @param(_id [in] View id.)
   @param(_program [in] Program.)
   @param(_occlusionQuery [in] Occlusion query.)
   @param(_depth [in] Depth for sorting.)
   @param(_preserveState [in] Preserve internal draw state for next draw call submit.) *)
procedure bgfx_submit_occlusion_query(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _occlusionQuery: bgfx_occlusion_query_handle_t; _depth: UInt32; _preserveState: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_submit_occlusion_query';

(* Submit primitive for rendering with index and instance data info from
   indirect buffer.
   @param(_id [in] View id.)
   @param(_program [in] Program.)
   @param(_indirectHandle [in] Indirect buffer.)
   @param(_start [in] First element in indirect buffer.)
   @param(_num [in] Number of dispatches.)
   @param(_depth [in] Depth for sorting.)
   @param(_preserveState [in] Preserve internal draw state for next draw call submit.) *)
procedure bgfx_submit_indirect(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16; _depth: UInt32; _preserveState: Boolean); cdecl;
  external LIB_BGFX name 'bgfx_submit_indirect';

(* Set compute index buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Index buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_set_compute_index_buffer(_stage: UInt8; _handle: bgfx_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_set_compute_index_buffer';

(* Set compute vertex buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Vertex buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_set_compute_vertex_buffer(_stage: UInt8; _handle: bgfx_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_set_compute_vertex_buffer';

(* Set compute dynamic index buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Dynamic index buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_set_compute_dynamic_index_buffer(_stage: UInt8; _handle: bgfx_dynamic_index_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_set_compute_dynamic_index_buffer';

(* Set compute dynamic vertex buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Dynamic vertex buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_set_compute_dynamic_vertex_buffer(_stage: UInt8; _handle: bgfx_dynamic_vertex_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_set_compute_dynamic_vertex_buffer';

(* Set compute indirect buffer.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Indirect buffer handle.)
   @param(_access [in] Buffer access. See `Access::Enum`.) *)
procedure bgfx_set_compute_indirect_buffer(_stage: UInt8; _handle: bgfx_indirect_buffer_handle_t; _access: bgfx_access_t); cdecl;
  external LIB_BGFX name 'bgfx_set_compute_indirect_buffer';

(* Set compute image from texture.
   @param(_stage [in] Compute stage.)
   @param(_handle [in] Texture handle.)
   @param(_mip [in] Mip level.)
   @param(_access [in] Image access. See `Access::Enum`.)
   @param(_format [in] Texture format. See: `TextureFormat::Enum`.) *)
procedure bgfx_set_image(_stage: UInt8; _handle: bgfx_texture_handle_t; _mip: UInt8; _access: bgfx_access_t; _format: bgfx_texture_format_t); cdecl;
  external LIB_BGFX name 'bgfx_set_image';

(* Dispatch compute.
   @param(_id [in] View id.)
   @param(_program [in] Compute program.)
   @param(_numX [in] Number of groups X.)
   @param(_numY [in] Number of groups Y.)
   @param(_numZ [in] Number of groups Z.) *)
procedure bgfx_dispatch(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _numX: UInt32; _numY: UInt32; _numZ: UInt32); cdecl;
  external LIB_BGFX name 'bgfx_dispatch';

(* Dispatch compute indirect.
   @param(_id [in] View id.)
   @param(_program [in] Compute program.)
   @param(_indirectHandle [in] Indirect buffer.)
   @param(_start [in] First element in indirect buffer.)
   @param(_num [in] Number of dispatches.) *)
procedure bgfx_dispatch_indirect(_id: bgfx_view_id_t; _program: bgfx_program_handle_t; _indirectHandle: bgfx_indirect_buffer_handle_t; _start: UInt16; _num: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_dispatch_indirect';

(* Discard previously set state for draw or compute call.
   @param(_flags [in] Draw/compute states to discard.) *)
procedure bgfx_discard(_flags: UInt8); cdecl;
  external LIB_BGFX name 'bgfx_discard';

(* Blit 2D texture region between two 2D textures.

   Destination texture must be created with `BGFX_TEXTURE_BLIT_DST` flag.

   Availability depends on: `BGFX_CAPS_TEXTURE_BLIT`.
   @param(_id [in] View id.)
   @param(_dst [in] Destination texture handle.)
   @param(_dstMip [in] Destination texture mip level.)
   @param(_dstX [in] Destination texture X position.)
   @param(_dstY [in] Destination texture Y position.)
   @param(_dstZ [in] If texture is 2D this argument should be 0. If destination texture is cube
     this argument represents destination texture cube face. For 3D texture this argument
     represents destination texture Z position.)
   @param(_src [in] Source texture handle.)
   @param(_srcMip [in] Source texture mip level.)
   @param(_srcX [in] Source texture X position.)
   @param(_srcY [in] Source texture Y position.)
   @param(_srcZ [in] If texture is 2D this argument should be 0. If source texture is cube
     this argument represents source texture cube face. For 3D texture this argument
     represents source texture Z position.)
   @param(_width [in] Width of region.)
   @param(_height [in] Height of region.)
   @param(_depth [in] If texture is 3D this argument represents depth of region, otherwise it's
     unused.) *)
procedure bgfx_blit(_id: bgfx_view_id_t; _dst: bgfx_texture_handle_t; _dstMip: UInt8; _dstX: UInt16; _dstY: UInt16; _dstZ: UInt16; _src: bgfx_texture_handle_t; _srcMip: UInt8; _srcX: UInt16; _srcY: UInt16; _srcZ: UInt16; _width: UInt16; _height: UInt16; _depth: UInt16); cdecl;
  external LIB_BGFX name 'bgfx_blit';

(* *)
function bgfx_get_interface(_version: UInt32): Pbgfx_interface_vtbl_t; cdecl;
  external LIB_BGFX name 'bgfx_get_interface';

implementation

end.