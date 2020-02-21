{**********************************************************************
                PilotLogic Software House.

 Package pl_SDL2
 This file is part of CodeTyphon Studio (https://www.pilotlogic.com/)

 -------

  Reference to SDL2 version 2.0.9 stable
  https://www.libsdl.org


 //----------------------------------------------
  For Debian, Ubuntu
    install : apt-get install libsdl2-dev
    position: /usr/lib/x86_64-linux-gnu/libSDL2.so
    position: /usr/lib/i386-linux-gnu/libSDL2.so

  For Fedora, RedHat
    install : dnf install sdl2-devel
    position: /usr/lib64/libSDL2.so
    position: /usr/lib/libSDL2.so

  For Mageia
    install : urpmi lib64sdl2.0-devel
    position: /usr/lib64/libSDL2.so
    position: /usr/lib/libSDL2.so

  For FreeBSD
    install : pkg install sdl2
    position: \usr\local\lib\libSDL2.so

***********************************************************************}


unit sdl2lib;

{$mode ObjFPC}

interface

uses
  {$IFDEF WINDOWS}
   Windows,
  {$ENDIF}
  {$IF DEFINED(UNIX) AND NOT DEFINED(ANDROID)}
      {$IFDEF DARWIN}
      CocoaAll,
      {$ENDIF}
      X, XLib,
  {$ENDIF}
   dynlibs;

const
  {$if defined(MSWINDOWS)}
     SDL_LibName = 'SDL2.dll';
  {$elseif defined(DARWIN)}
     SDL_LibName = 'libSDL2.dylib';
  {$ELSE}
     SDL_LibName = 'libSDL2.so';
  {$ENDIF}

  {$IFDEF MACOS}
    SDL_LibName = 'SDL2';
      {$linklib libSDL2}
  {$ENDIF}

//-------- SDLtype_s.h, SDL_stdinc.h --------------
  type

    TSDL_Bool = (SDL_FALSE,SDL_TRUE);

    DWord = LongWord;

    PUInt8Array = ^TUInt8Array;
    PUInt8 = ^UInt8;
    PPUInt8 = ^PUInt8;
    UInt8 = Byte;
    TUInt8Array = array [0..MAXINT shr 1] of UInt8;

    PUInt16 = ^UInt16;
    UInt16 = word;

    PSInt8 = ^SInt8;
    SInt8 = Shortint;

    PSInt16 = ^SInt16;
    SInt16 = smallint;

    PUInt32 = ^UInt32;
    UInt32 = Cardinal;

    PSInt32 = ^SInt32;
    SInt32 = LongInt;

    PFloat = ^Float;
    PInt = ^LongInt;

    PShortInt = ^ShortInt;

    PSInt64 = ^SInt64;
    SInt64 = Int64;

    size_t = PtrUInt;

    Float = Single;


//-------- sdl_version.h -------------------

    const
      SDL_MAJOR_VERSION = 2;
      SDL_MINOR_VERSION = 0;
      SDL_PATCHLEVEL    = 4;

    type
      PSDL_Version = ^TSDL_Version;
      TSDL_Version = record
        major,
        minor,
        patch: UInt8;
      end;

    TTSDL_GetVersion = procedure(ver: PSDL_Version); cdecl;
    TTSDL_GetRevision = function: PAnsiChar; cdecl;
    TTSDL_GetRevisionNumber = function: SInt32; cdecl;

    procedure SDL_VERSION(Out x: TSDL_Version);
    function  SDL_VERSIONNUM(X,Y,Z: UInt32): Cardinal;
    function  SDL_COMPILEDVERSION: Cardinal;
    function  SDL_VERSION_ATLEAST(X,Y,Z: Cardinal): Boolean;

//--------sdl_error.h -------------------
    const
      ERR_MAX_STRLEN = 128;
      ERR_MAX_ARGS   = 5;

    type
      TSDL_ErrorCode = (SDL_ENOMEM,
                        SDL_EFREAD,
                        SDL_EFWRITE,
                        SDL_EFSEEK,
                        SDL_UNSUPPORTED,
                        SDL_LASTERROR);

      TSDL_Error = record
        error: SInt32;
        key: String[ERR_MAX_STRLEN];
        argc: SInt32;
        case SInt32 of
          0: (value_c: Byte;);
          1: (value_ptr: Pointer;);
          2: (value_i: SInt32;);
          3: (value_f: Double;);
          4: (buf: String[ERR_MAX_STRLEN];);
      end;

    TTSDL_SetError= function(const fmt: PAnsiChar): SInt32; cdecl;
    TTSDL_GetError= function: PAnsiChar; cdecl;
    TTSDL_ClearError= procedure; cdecl;
    TTSDL_Error= function(code: TSDL_ErrorCode): SInt32; cdecl;
    TTSDL_GetPlatform= function: PAnsiChar; cdecl;


//------------- sdl_power.h ---------------------------
    type
      TSDL_PowerState = (SDL_POWERSTATE_UNKNOWN,
                         SDL_POWERSTATE_ON_BATTERY,
                         SDL_POWERSTATE_NO_BATTERY,
                         SDL_POWERSTATE_CHARGING,
                         SDL_POWERSTATE_CHARGED);

    TTSDL_GetPowerInfo= function(secs: PInt; pct: PInt): TSDL_PowerState; cdecl;


//------------- sdl_thread.h --------------------------

    type
      TSDL_ThreadPriority = (SDL_THREAD_PRIORITY_LOW,
                             SDL_THREAD_PRIORITY_NORMAL,
                             SDL_THREAD_PRIORITY_HIGH);

      PSDL_ThreadFunction = ^TSDL_ThreadFunction;
      TSDL_ThreadFunction = function(data: Pointer): Integer; cdecl;

      TSDL_ThreadID = LongWord;

      PSDL_Thread = ^TSDL_Thread;
      TSDL_Thread = record
        threadid: TSDL_ThreadID;
        handle: THandle;
        status: SInt32;
        errbuf: TSDL_Error;
        name: PAnsiChar;
        data: Pointer;
      end;

      TSDL_TLSID = Cardinal;

{$IFDEF WINDOWS}
    type
        TThreadID = Cardinal;

      TpfnSDL_CurrentBeginThread = function(SecurityAttributes: Pointer; StackSize: LongWord; ThreadFunc: TThreadFunc; Parameter: Pointer; CreationFlags: LongWord; var ThreadId: TThreadID): Integer;
      TpfnSDL_CurrentEndThread = procedure(ExitCode: Integer);

  TTSDL_CreateThread= function(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer; pfnBeginThread: TpfnSDL_CurrentBeginThread; pfnEndThread: TpfnSDL_CurrentEndThread): PSDL_Thread; stdcall;

  function SDL_CreateThread2(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer): PSDL_Thread; overload;
{$ELSE}
  TTSDL_CreateThread= function(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer): PSDL_Thread; cdecl;
{$ENDIF}

type

  TTSDL_GetThreadName=function(thread: PSDL_Thread): PAnsiChar; cdecl;
  TTSDL_ThreadID=function: TSDL_ThreadID; cdecl;
  TTSDL_GetThreadID=function(thread: PSDL_Thread): TSDL_ThreadID; cdecl;
  TTSDL_SetThreadPriority=function(priority: TSDL_ThreadPriority): SInt32; cdecl;
  TTSDL_WaitThread= procedure(thread: PSDL_Thread; status: PInt); cdecl;
  TTSDL_DetachThread=procedure(thread:TSDL_Thread); cdecl;
  TTSDL_TLSCreate=function: TSDL_TLSID; cdecl;
  TTSDL_TLSGet=function(id: TSDL_TLSID): Pointer; cdecl;
  TTSDL_TLSSet=function(id: TSDL_TLSID; value: Pointer; destructor_: Pointer): SInt32; cdecl;


//---------- sdl_mutex.h ---------------------------------

    const
      SDL_MUTEX_TIMEDOUT = 1;

    type
      PSDL_Mutex = Pointer;
      PSDL_Sem = Pointer;
      PSDL_Cond = Pointer;

  TTSDL_CreateMutex=function: PSDL_Mutex; cdecl;
  TTSDL_LockMutex=function(mutex: PSDL_Mutex): SInt32; cdecl;
  TTSDL_TryLockMutex=function(mutex: PSDL_Mutex): SInt32; cdecl;
  TTSDL_UnlockMutex=function(mutex: PSDL_Mutex): SInt32; cdecl;
  TTSDL_DestroyMutex= procedure(mutex: PSDL_Mutex); cdecl;
  TTSDL_CreateSemaphore=function(initial_value: UInt32): PSDL_sem; cdecl;
  TTSDL_DestroySemaphore= procedure(sem: PSDL_Sem); cdecl;
  TTSDL_SemWait=function(sem: PSDL_Sem): SInt32; cdecl;
  TTSDL_SemTryWait=function(sem: PSDL_Sem): SInt32; cdecl;
  TTSDL_SemWaitTimeout=function(sem: PSDL_Sem; ms: UInt32): SInt32; cdecl;
  TTSDL_SemPost=function(sem: PSDL_Sem): SInt32; cdecl;
  TTSDL_SemValue=function(sem: PSDL_Sem): UInt32; cdecl;
  TTSDL_CreateCond=function: PSDL_Cond; cdecl;
  TTSDL_DestroyCond= procedure(cond: PSDL_Cond); cdecl;
  TTSDL_CondSignal=function(cond: PSDL_Cond): SInt32; cdecl;
  TTSDL_CondBroadcast=function(cond: PSDL_Cond): SInt32; cdecl;
  TTSDL_CondWait=function(cond: PSDL_Cond; mutex: PSDL_Mutex): SInt32; cdecl;
  TTSDL_CondWaitTimeout=function(cond: PSDL_Cond; mutex: PSDL_Mutex; ms: UInt32): SInt32; cdecl;


//--------------- sdl_timer.h -----------------------------

    type
      TSDL_TimerCallback = function(interval: UInt32; param: Pointer): UInt32; cdecl;
      TSDL_TimerID = SInt32;

  TTSDL_GetTicks= function: UInt32; cdecl;
  TTSDL_GetPerformanceCounter= function: UInt64; cdecl;
  TTSDL_GetPerformanceFrequency= function: UInt64; cdecl;
  TTSDL_Delay= procedure(ms: UInt32); cdecl;
  TTSDL_AddTimer= function(interval: UInt32; callback: TSDL_TimerCallback; param: Pointer): TSDL_TimerID; cdecl;
  TTSDL_RemoveTimer= function(id: TSDL_TimerID): Boolean; cdecl;

  function SDL_TICKS_PASSED(Const A, B:UInt32):Boolean;


//--------- sdl_pixels.h ----------------

      const
        SDL_ALPHA_OPAQUE = 255;
        SDL_ALPHA_TRANSPARENT = 0;

        {** Pixel type. *}
        SDL_PIXELTYPE_UNKNOWN = 0;
        SDL_PIXELTYPE_INDEX1 = 1;
        SDL_PIXELTYPE_INDEX4 = 2;
        SDL_PIXELTYPE_INDEX8 = 3;
        SDL_PIXELTYPE_PACKED8 = 4;
        SDL_PIXELTYPE_PACKED16 = 5;
        SDL_PIXELTYPE_PACKED32 = 6;
        SDL_PIXELTYPE_ARRAYU8 = 7;
        SDL_PIXELTYPE_ARRAYU16 = 8;
        SDL_PIXELTYPE_ARRAYU32 = 9;
        SDL_PIXELTYPE_ARRAYF16 = 10;
        SDL_PIXELTYPE_ARRAYF32 = 11;

        {** Bitmap pixel order, high bit -> low bit. *}
        SDL_BITMAPORDER_NONE = 0;
        SDL_BITMAPORDER_4321 = 1;
        SDL_BITMAPORDER_1234 = 2;

        {** Packed component order, high bit -> low bit. *}

        SDL_PACKEDORDER_NONE = 0;
        SDL_PACKEDORDER_XRGB = 1;
        SDL_PACKEDORDER_RGBX = 2;
        SDL_PACKEDORDER_ARGB = 3;
        SDL_PACKEDORDER_RGBA = 4;
        SDL_PACKEDORDER_XBGR = 5;
        SDL_PACKEDORDER_BGRX = 6;
        SDL_PACKEDORDER_ABGR = 7;
        SDL_PACKEDORDER_BGRA = 8;

        {** Array component order, low byte -> high byte. *}
        SDL_ARRAYORDER_NONE = 0;
        SDL_ARRAYORDER_RGB  = 1;
        SDL_ARRAYORDER_RGBA = 2;
        SDL_ARRAYORDER_ARGB = 3;
        SDL_ARRAYORDER_BGR  = 4;
        SDL_ARRAYORDER_BGRA = 5;
        SDL_ARRAYORDER_ABGR = 6;

        {** Packed component layout. *}
        SDL_PACKEDLAYOUT_NONE = 0;
        SDL_PACKEDLAYOUT_332  = 1;
        SDL_PACKEDLAYOUT_4444 = 2;
        SDL_PACKEDLAYOUT_1555 = 3;
        SDL_PACKEDLAYOUT_5551 = 4;
        SDL_PACKEDLAYOUT_565  = 5;
        SDL_PACKEDLAYOUT_8888 = 6;
        SDL_PACKEDLAYOUT_2101010 = 7;
        SDL_PACKEDLAYOUT_1010102 = 8;


    const
        SDL_PIXELFORMAT_UNKNOWN = 0;
        SDL_PIXELFORMAT_INDEX1LSB = (1 shl 28)                    or
                                    (SDL_PIXELTYPE_INDEX1 shl 24) or
                                    (SDL_BITMAPORDER_4321 shl 20) or
                                    (0 shl 16)                    or
                                    (1 shl 8)                     or
                                    (0 shl 0);

        SDL_PIXELFORMAT_INDEX1MSB = (1 shl 28)                    or
                                    (SDL_PIXELTYPE_INDEX1 shl 24) or
                                    (SDL_BITMAPORDER_1234 shl 20) or
                                    (0 shl 16)                    or
                                    (1 shl 8)                     or
                                    (0 shl 0);

        SDL_PIXELFORMAT_INDEX4LSB = (1 shl 28)                    or
                                    (SDL_PIXELTYPE_INDEX4 shl 24) or
                                    (SDL_BITMAPORDER_4321 shl 20) or
                                    (0 shl 16)                    or
                                    (4 shl 8)                     or
                                    (0 shl 0);

        SDL_PIXELFORMAT_INDEX4MSB = (1 shl 28)                    or
                                    (SDL_PIXELTYPE_INDEX4 shl 24) or
                                    (SDL_BITMAPORDER_1234 shl 20) or
                                    (0 shl 16)                    or
                                    (4 shl 8)                     or
                                    (0 shl 0);

        SDL_PIXELFORMAT_INDEX8 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED8 shl 24)  or
                                    (0 shl 20)                      or
                                    (0 shl 16)                      or
                                    (8 shl 8)                       or
                                    (1 shl 0);

        SDL_PIXELFORMAT_RGB332 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED8 shl 24)  or
                                    (SDL_PACKEDORDER_XRGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_332 shl 16)   or
                                    (8 shl 8)                       or
                                    (1 shl 0);

        SDL_PIXELFORMAT_RGB444 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_XRGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                    (12 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_RGB555 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_XRGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                    (15 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_BGR555 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_XBGR shl 20)   or
                                    (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                    (15 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_ARGB4444 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_ARGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_RGBA4444 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_RGBA shl 20)   or
                                    (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_ABGR4444 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_ABGR shl 20)   or
                                    (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_BGRA4444 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_BGRA shl 20)   or
                                    (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_ARGB1555 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_ARGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_RGBA5551 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_RGBA shl 20)   or
                                    (SDL_PACKEDLAYOUT_5551 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_ABGR1555 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_ABGR shl 20)   or
                                    (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_BGRA5551 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_BGRA shl 20)   or
                                    (SDL_PACKEDLAYOUT_5551 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_RGB565 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_XRGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_565 shl 16)   or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_BGR565 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED16 shl 24) or
                                    (SDL_PACKEDORDER_XBGR shl 20)   or
                                    (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                    (16 shl 8)                      or
                                    (2 shl 0);

        SDL_PIXELFORMAT_RGB24 =     (1 shl 28)                      or
                                    (SDL_PIXELTYPE_ARRAYU8 shl 24)  or
                                    (SDL_ARRAYORDER_RGB shl 20)     or
                                    (0 shl 16)                      or
                                    (24 shl 8)                      or
                                    (3 shl 0);

        SDL_PIXELFORMAT_BGR24 =     (1 shl 28)                      or
                                    (SDL_PIXELTYPE_ARRAYU8 shl 24)  or
                                    (SDL_ARRAYORDER_BGR shl 20)     or
                                    (0 shl 16)                      or
                                    (24 shl 8)                      or
                                    (3 shl 0);

        SDL_PIXELFORMAT_RGB888 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_XRGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (24 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_RGBX8888 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_RGBX shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (24 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_BGR888 =    (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_XBGR shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (24 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_BGRX8888 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_BGRX shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (24 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_ARGB8888 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_ARGB shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (32 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_RGBA8888 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_RGBA shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (32 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_ABGR8888 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_ABGR shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (32 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_BGRA8888 =  (1 shl 28)                      or
                                    (SDL_PIXELTYPE_PACKED32 shl 24) or
                                    (SDL_PACKEDORDER_RGBX shl 20)   or
                                    (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                    (32 shl 8)                      or
                                    (4 shl 0);

        SDL_PIXELFORMAT_ARGB2101010 = (1 shl 28)                       or
                                      (SDL_PIXELTYPE_PACKED32 shl 24)  or
                                      (SDL_PACKEDORDER_ARGB shl 20)    or
                                      (SDL_PACKEDLAYOUT_2101010 shl 16)or
                                      (32 shl 8)                       or
                                      (4 shl 0);



          {$IF DEFINED(ENDIAN_LITTLE)}
            SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888;
            SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888;
            SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888;
            SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888;
          {$ELSEIF DEFINED(ENDIAN_BIG)}
            SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_RGBA8888;
            SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_ARGB8888;
            SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_BGRA8888;
            SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_ABGR8888;
          {$ELSE}
            {$FATAL Cannot determine endianness.}
          {$IFEND}



        SDL_PIXELFORMAT_YV12 = (Integer('Y')       ) or
                               (Integer('V') shl  8) or
                               (Integer('1') shl 16) or
                               (Integer('2') shl 24);

        SDL_PIXELFORMAT_IYUV = (Integer('I')       ) or
                               (Integer('Y') shl  8) or
                               (Integer('U') shl 16) or
                               (Integer('V') shl 24);

        SDL_PIXELFORMAT_YUY2 = (Integer('Y')       ) or
                               (Integer('U') shl  8) or
                               (Integer('Y') shl 16) or
                               (Integer('2') shl 24);

        SDL_PIXELFORMAT_UYVY = (Integer('U')       ) or
                               (Integer('Y') shl  8) or
                               (Integer('V') shl 16) or
                               (Integer('Y') shl 24);

        SDL_PIXELFORMAT_YVYU = (Integer('Y')       ) or
                               (Integer('V') shl  8) or
                               (Integer('Y') shl 16) or
                               (Integer('U') shl 24);

    type
      PSDL_Color = ^TSDL_Color;
      TSDL_Color = record
        r: UInt8;
        g: UInt8;
        b: UInt8;
        a: UInt8;
      end;

      TSDL_Colour = TSDL_Color;
      PSDL_Colour = ^TSDL_Colour;

      PSDL_Palette = ^TSDL_Palette;
      TSDL_Palette = record
        ncolors: SInt32;
        colors: PSDL_Color;
        version: UInt32;
        refcount: SInt32;
      end;


      PSDL_PixelFormat = ^TSDL_PixelFormat;
      TSDL_PixelFormat = record
        format: UInt32;
        palette: PSDL_Palette;
        BitsPerPixel: UInt8;
        BytesPerPixel: UInt8;
        padding: array[0..1] of UInt8;
        Rmask: UInt32;
        Gmask: UInt32;
        Bmask: UInt32;
        Amask: UInt32;
        Rloss: UInt8;
        Gloss: UInt8;
        Bloss: UInt8;
        Aloss: UInt8;
        Rshift: UInt8;
        Gshift: UInt8;
        Bshift: UInt8;
        Ashift: UInt8;
        refcount: SInt32;
        next: PSDL_PixelFormat;
      end;


  TTSDL_GetPixelFormatName= function(format: UInt32): PAnsiChar; cdecl;
  TTSDL_PixelFormatEnumToMasks= function(format: UInt32; bpp: PInt; Rmask: PUInt32; Gmask: PUInt32; Bmask: PUInt32; Amask: PUInt32): TSDL_Bool; cdecl;
  TTSDL_MasksToPixelFormatEnum= function(bpp: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): UInt32; cdecl;
  TTSDL_AllocFormat= function(pixel_format: UInt32): PSDL_PixelFormat; cdecl;
  TTSDL_FreeFormat= procedure(format: PSDL_PixelFormat); cdecl;
  TTSDL_AllocPalette= function(ncolors: SInt32): PSDL_Palette; cdecl;
  TTSDL_SetPixelFormatPalette= function(format: PSDL_PixelFormat; palette: PSDL_Palette): SInt32; cdecl;
  TTSDL_SetPaletteColors= function(palette: PSDL_Palette; const colors: PSDL_Color; firstcolor: SInt32; ncolors: SInt32): SInt32; cdecl;
  TTSDL_FreePalette= procedure(palette: PSDL_Palette); cdecl;
  TTSDL_MapRGB= function(const format: PSDL_PixelFormat; r: UInt8; g: UInt8; b: UInt8): UInt32; cdecl;
  TTSDL_MapRGBA= function(const format: PSDL_PixelFormat; r: UInt8; g: UInt8; b: UInt8; a: UInt8): UInt32; cdecl;
  TTSDL_GetRGB= procedure(pixel: UInt32; const format: PSDL_PixelFormat; r: PUInt8; g: PUInt8; b: PUInt8); cdecl;
  TTSDL_GetRGBA= procedure(pixel: UInt32; const format: PSDL_PixelFormat; r: PUInt8; g: PUInt8; b: PUInt8; a: PUInt8); cdecl;
  TTSDL_CalculateGammaRamp= procedure(gamma: Float; ramp: PUInt16); cdecl;

  function SDL_PIXELFLAG(X: Cardinal): Cardinal;
  function SDL_PIXELTYPE(X: Cardinal): Cardinal;
  function SDL_PIXELORDER(X: Cardinal): Cardinal;
  function SDL_PIXELLAYOUT(X: Cardinal): Cardinal;
  function SDL_BITSPERPIXEL(X: Cardinal): Cardinal;


//----------- sdl_rect.h ------------------------------

    type
      PSDL_Point = ^TSDL_Point;
      TSDL_Point = record
        x: SInt32;
        y: SInt32;
      end;


      PSDL_Rect = ^TSDL_Rect;
      TSDL_Rect = record
        x,y: SInt32;
        w,h: SInt32;
      end;

  TTSDL_HasIntersection= function(const a, b: PSDL_Rect): TSDL_Bool; cdecl;
  TTSDL_IntersectRect= function(const A, B: PSDL_Rect; result: PSDL_Rect): TSDL_Bool; cdecl;
  TTSDL_UnionRect= procedure(const A, B: PSDL_Rect; result: PSDL_Rect); cdecl;
  TTSDL_EnclosePoints= function(const points: PSDL_Point; count: SInt32; const clip: PSDL_Rect; result: PSDL_Rect): TSDL_Bool; cdecl;
  TTSDL_IntersectRectAndLine= function(const rect: PSDL_Rect; X1, Y1, X2, Y2: PInt): TSDL_Bool; cdecl;

  function SDL_PointInRect(const p: PSDL_Point; const r: PSDL_Rect): Boolean; Inline;
  function SDL_RectEmpty(const r: PSDL_Rect): Boolean; inline;
  function SDL_RectEquals(const a, b: PSDL_Rect): Boolean; inline;


//----------- sdl_rwops.h ------------------------------

    const
      SDL_RWOPS_UNKNOWN   = 0;  {* Unknown stream type *}
      SDL_RWOPS_WINFILE   = 1;  {* Win32 file *}
      SDL_RWOPS_STDFILE   = 2;  {* Stdio file *}
      SDL_RWOPS_JNIFILE   = 3;  {* Android asset *}
      SDL_RWOPS_MEMORY    = 4;  {* Memory stream *}
      SDL_RWOPS_MEMORY_RO = 5;  {* Read-Only memory stream *}

      RW_SEEK_SET = 0;       {**< Seek from the beginning of data *}
      RW_SEEK_CUR = 1;       {**< Seek relative to current read point *}
      RW_SEEK_END = 2;       {**< Seek relative to the end of data *}

    type
      PSDL_RWops = ^TSDL_RWops;
      TSize = function(context: PSDL_RWops): SInt64; {$IFNDEF GPC} cdecl; {$ENDIF}
      TSeek = function(context: PSDL_RWops; offset: SInt64; whence: SInt32): SInt64; {$IFNDEF GPC} cdecl; {$ENDIF}
      TRead = function(context: PSDL_RWops; ptr: Pointer; size: size_t; maxnum: size_t): size_t; {$IFNDEF GPC} cdecl; {$ENDIF}
      TWrite = function(context: PSDL_RWops; const ptr: Pointer; size: size_t; num: size_t): size_t; {$IFNDEF GPC} cdecl; {$ENDIF}
      TClose =  function(context: PSDL_RWops): SInt32; {$IFNDEF GPC} cdecl; {$ENDIF}

      TStdio = record
        autoclose: TSDL_Bool;
      fp: file;
      end;

      TMem = record
        base: PUInt8;
      here: PUInt8;
      stop: PUInt8;
      end;

      TUnknown = record
        data1: Pointer;
      end;

      TAndroidIO = record
        fileNameRef: Pointer;
        inputStreamRef: Pointer;
        readableByteChannelRef: Pointer;
        readMethod: Pointer;
        assetFileDescriptorRef: Pointer;
        position: LongInt;
        size: LongInt;
        offset: LongInt;
        fd: SInt32;
      end;

      TWindowsIOBuffer = record
        data: Pointer;
      size: size_t;
      left: size_t;
      end;

      TWindowsIO = record
        append: TSDL_Bool;
        h: Pointer;
        buffer: TWindowsIOBuffer;
      end;

      TSDL_RWops = packed record
        size: TSize;
        seek: TSeek;
        read: TRead;
        write: TWrite;
        close: TClose;

        _type: UInt32;

      case Integer of
        0: (stdio: TStdio);
        1: (mem: TMem);
        2: (unknown: TUnknown);
        {$IFDEF ANDROID}
        3: (androidio: TAndroidIO);
        {$ENDIF}
        {$IFDEF WINDOWS}
        3: (windowsio: TWindowsIO);
        {$ENDIF}
      end;


  TTSDL_RWFromFile= function(const _file: PAnsiChar; const mode: PAnsiChar): PSDL_RWops; cdecl;
  TTSDL_RWFromFP= function(fp: Pointer; autoclose: TSDL_Bool): PSDL_RWops; cdecl;
  TTSDL_RWFromMem= function(mem: Pointer; size: SInt32): PSDL_RWops; cdecl;
  TTSDL_RWFromConstMem= function(const mem: Pointer; size: SInt32): PSDL_RWops; cdecl;
  TTSDL_AllocRW= function: PSDL_RWops; cdecl;
  TTSDL_FreeRW= procedure(area: PSDL_RWops); cdecl;
  TTSDL_ReadU8= function(src: PSDL_RWops): UInt8; cdecl;
  TTSDL_ReadLE16= function(src: PSDL_RWops): UInt16; cdecl;
  TTSDL_ReadBE16= function(src: PSDL_RWops): UInt16; cdecl;
  TTSDL_ReadLE32= function(src: PSDL_RWops): UInt32; cdecl;
  TTSDL_ReadBE32= function(src: PSDL_RWops): UInt32; cdecl;
  TTSDL_ReadLE64= function(src: PSDL_RWops): UInt64; cdecl;
  TTSDL_ReadBE64= function(src: PSDL_RWops): UInt64; cdecl;
  TTSDL_WriteU8= function(dst: PSDL_RWops; value: UInt8): size_t; cdecl;
  TTSDL_WriteLE16= function(dst: PSDL_RWops; value: UInt16): size_t; cdecl;
  TTSDL_WriteBE16= function(dst: PSDL_RWops; value: UInt16): size_t; cdecl;
  TTSDL_WriteLE32= function(dst: PSDL_RWops; value: UInt32): size_t; cdecl;
  TTSDL_WriteBE32= function(dst: PSDL_RWops; value: UInt32): size_t; cdecl;
  TTSDL_WriteLE64= function(dst: PSDL_RWops; value: UInt64): size_t; cdecl;
  TTSDL_WriteBE64= function(dst: PSDL_RWops; value: UInt64): size_t; cdecl;

  function SDL_RWsize(ctx: PSDL_RWops): SInt64;
  function SDL_RWseek(ctx: PSDL_RWops; offset: SInt64; whence: SInt32): SInt64;
  function SDL_RWtell(ctx: PSDL_RWops): SInt64;
  function SDL_RWread(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t;
  function SDL_RWwrite(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t;
  function SDL_RWclose(ctx: PSDL_RWops): SInt32;


//---------------- sdl_audio.h ------------------------------------

      const
        SDL_AUDIO_MASK_BITSIZE      = ($FF);
        SDL_AUDIO_MASK_DATATYPE     = (1 shl 8);
        SDL_AUDIO_MASK_ENDIAN       = (1 shl 12);
        SDL_AUDIO_MASK_SIGNED       = (1 shl 15);

        AUDIO_U8      = $0008;  {**< Unsigned 8-bit samples *}
        AUDIO_S8      = $8008;  {**< Signed 8-bit samples *}
        AUDIO_U16LSB  = $0010;  {**< Unsigned 16-bit samples *}
        AUDIO_S16LSB  = $8010;  {**< Signed 16-bit samples *}
        AUDIO_U16MSB  = $1010;  {**< As above, but big-endian byte order *}
        AUDIO_S16MSB  = $9010;  {**< As above, but big-endian byte order *}
        AUDIO_U16     = AUDIO_U16LSB;
        AUDIO_S16     = AUDIO_S16LSB;

        AUDIO_S32LSB  = $8020;  {**< 32-bit integer samples *}
        AUDIO_S32MSB  = $9020;  {**< As above, but big-endian byte order *}
        AUDIO_S32     = AUDIO_S32LSB;


        AUDIO_F32LSB  = $8120;  {**< 32-bit floating point samples *}
        AUDIO_F32MSB  = $9120;  {**< As above, but big-endian byte order *}
        AUDIO_F32     = AUDIO_F32LSB;

         {$IF DEFINED(ENDIAN_LITTLE)}
            AUDIO_U16SYS = AUDIO_U16LSB;
            AUDIO_S16SYS = AUDIO_S16LSB;
            AUDIO_S32SYS = AUDIO_S32LSB;
            AUDIO_F32SYS = AUDIO_F32LSB;
         {$ELSEIF DEFINED(ENDIAN_BIG)}
            AUDIO_U16SYS = AUDIO_U16MSB;
            AUDIO_S16SYS = AUDIO_S16MSB;
            AUDIO_S32SYS = AUDIO_S32MSB;
            AUDIO_F32SYS = AUDIO_F32MSB;
         {$ELSE}
            {$FATAL Cannot determine endianness.}
         {$IFEND}



        SDL_AUDIO_ALLOW_FREQUENCY_CHANGE  = $00000001;
        SDL_AUDIO_ALLOW_FORMAT_CHANGE     = $00000002;
        SDL_AUDIO_ALLOW_CHANNELS_CHANGE   = $00000004;
        SDL_AUDIO_ALLOW_ANY_CHANGE        = (SDL_AUDIO_ALLOW_FREQUENCY_CHANGE or
                                             SDL_AUDIO_ALLOW_FORMAT_CHANGE or
                                             SDL_AUDIO_ALLOW_CHANNELS_CHANGE);


        SDL_MIX_MAXVOLUME = 128;

      type
        TSDL_AudioFormat = UInt16;

        TSDL_AudioCallback = procedure(userdata: Pointer; stream: PUInt8; len: Integer) cdecl;

        PSDL_AudioSpec = ^TSDL_AudioSpec;
        TSDL_AudioSpec = record
          freq: Integer;                {**< DSP frequency -- samples per second *}
          format: TSDL_AudioFormat;     {**< Audio data format *}
          channels: UInt8;              {**< Number of channels: 1 mono, 2 stereo *}
          silence: UInt8;               {**< Audio buffer silence value (calculated) *}
          samples: UInt16;              {**< Audio buffer size in samples (power of 2) *}
          padding: UInt16;              {**< Necessary for some compile environments *}
          size: UInt32;                 {**< Audio buffer size in bytes (calculated) *}
          callback: TSDL_AudioCallback;
          userdata: Pointer;
        end;

        PSDL_AudioCVT = ^TSDL_AudioCVT;
        TSDL_AudioFilter = procedure(cvt: PSDL_AudioCVT; format: TSDL_AudioFormat) cdecl;

        TSDL_AudioCVT = record
          needed: Integer;                           {**< Set to 1 if conversion possible *}
          src_format: TSDL_AudioFormat;              {**< Source audio format *}
          dst_format: TSDL_AudioFormat;                {**< Target audio format *}
          rate_incr: Double;                        {**< Rate conversion increment *}
          buf: PUInt8;                             {**< Buffer to hold entire audio data *}
          len: Integer;                               {**< Length of original audio buffer *}
          len_cvt: Integer;                           {**< Length of converted audio buffer *}
          len_mult: Integer;                          {**< buffer must be len*len_mult big *}
          len_ratio: Double;                        {**< Given len, final size is len*len_ratio *}
          filters: array[0..9] of TSDL_AudioFilter; {**< Filter list *}
          filter_index: Integer;                      {**< Current audio conversion function *}
        end;

        TSDL_AudioDeviceID = UInt32;
        TSDL_AudioStatus = (SDL_AUDIO_STOPPED,SDL_AUDIO_PLAYING,SDL_AUDIO_PAUSED);


  TTSDL_GetNumAudioDrivers= function: Integer; cdecl;
  TTSDL_GetAudioDriver= function(index: Integer): PAnsiChar; cdecl;
  TTSDL_AudioInit= function(driver_name: PAnsiChar): Integer; cdecl;
  TTSDL_AudioQuit= procedure; cdecl;
  TTSDL_GetCurrentAudioDriver= function: PAnsiChar; cdecl;
  TTSDL_OpenAudio= function(desired: PSDL_AudioSpec; obtained: PSDL_AudioSpec): Integer; cdecl;
  TTSDL_GetNumAudioDevices= function(iscapture: Integer): Integer; cdecl;
  TTSDL_GetAudioDeviceName= function(index: Integer; iscapture: Integer): PAnsiChar; cdecl;
  TTSDL_OpenAudioDevice= function(device: PAnsiChar; iscapture: Integer; desired: PSDL_AudioSpec;obtained: PSDL_AudioSpec; allowed_changes: Integer): TSDL_AudioDeviceID; cdecl;
  TTSDL_GetAudioStatus= function: TSDL_AudioStatus; cdecl;
  TTSDL_GetAudioDeviceStatus= function(dev: TSDL_AudioDeviceID): TSDL_AudioStatus; cdecl;
  TTSDL_PauseAudio= procedure(pause_on: Integer); cdecl;
  TTSDL_PauseAudioDevice= procedure(dev: TSDL_AudioDeviceID; pause_on: Integer); cdecl;
  TTSDL_LoadWAV_RW= function(src: PSDL_RWops; freesrc: Integer; spec: PSDL_AudioSpec; audio_buf: PPUInt8; audio_len: PUInt32): PSDL_AudioSpec; cdecl;
  TTSDL_FreeWAV= procedure(audio_buf: PUInt8); cdecl;
  TTSDL_BuildAudioCVT= function(cvt: PSDL_AudioCVT; src_format: TSDL_AudioFormat; src_channels: UInt8;src_rate: Integer; dst_format: TSDL_AudioFormat;dst_channels: UInt8; dst_rate: Integer): Integer; cdecl;
  TTSDL_ConvertAudio= function(cvt: PSDL_AudioCVT): Integer; cdecl;
  TTSDL_MixAudio= procedure(dst: PUInt8; src: PUInt8; len: UInt32; volume: Integer); cdecl;
  TTSDL_MixAudioFormat= procedure(dst: PUInt8; src: PUInt8; format: TSDL_AudioFormat; len: UInt32; volume: Integer); cdecl;
  TTSDL_QueueAudio= function(dev: TSDL_AudioDeviceID; data: Pointer; len: UInt32): SInt32; cdecl;
  TTSDL_DequeueAudio= function(dev: TSDL_AudioDeviceID; data: Pointer; len:Uint32):Uint32; cdecl;
  TTSDL_GetQueuedAudioSize= function(dev: TSDL_AudioDeviceID): UInt32; cdecl;
  TTSDL_ClearQueuedAudio= procedure(dev: TSDL_AudioDeviceID); cdecl;
  TTSDL_LockAudio= procedure; cdecl;
  TTSDL_LockAudioDevice= procedure(dev: TSDL_AudioDeviceID); cdecl;
  TTSDL_UnlockAudio= procedure; cdecl;
  TTSDL_UnlockAudioDevice= procedure(dev: TSDL_AudioDeviceID); cdecl;
  TTSDL_CloseAudio= procedure; cdecl;
  TTSDL_CloseAudioDevice= procedure(dev: TSDL_AudioDeviceID); cdecl;


  function SDL_AUDIO_BITSIZE(x: Cardinal): Cardinal;
  function SDL_AUDIO_ISFLOAT(x: Cardinal): Cardinal;
  function SDL_AUDIO_ISBIGENDIAN(x: Cardinal): Cardinal;
  function SDL_AUDIO_ISSIGNED(x: Cardinal): Cardinal;
  function SDL_AUDIO_ISINT(x: Cardinal): Cardinal;
  function SDL_AUDIO_ISLITTLEENDIAN(x: Cardinal): Cardinal;
  function SDL_AUDIO_ISUNSIGNED(x: Cardinal): Cardinal;
  function SDL_LoadWAV(_file: PAnsiChar; spec: PSDL_AudioSpec; audio_buf: PPUInt8; audio_len: PUInt32): PSDL_AudioSpec;

//----------- sdl_blendmode.h -----------------------------

      const
        SDL_BLENDMODE_NONE  = $00000000;    {**< No blending *}
        SDL_BLENDMODE_BLEND = $00000001;    {**< dst = (src * A) + (dst * (1-A)) *}
        SDL_BLENDMODE_ADD   = $00000002;    {**< dst = (src * A) + dst *}
        SDL_BLENDMODE_MOD   = $00000004;    {**< dst = src * dst *}

      type
        PSDL_BlendMode = ^TSDL_BlendMode;
        TSDL_BlendMode = DWord;


//----------- sdl_surface.h -------------------------------

        const
          SDL_SWSURFACE = 0;          {**< Just here for compatibility *}
          SDL_PREALLOC  = $00000001;  {**< Surface uses preallocated memory *}
          SDL_RLEACCEL  = $00000002;  {**< Surface is RLE encoded *}
          SDL_DONTFREE  = $00000004;  {**< Surface is referenced internally *}

        type
          PSDL_BlitMap = ^TSDL_BlitMap;
          TSDL_BlitMap = record
            map: Pointer;
          end;

          PSDL_Surface = ^TSDL_Surface;
          TSDL_Surface = record
            flags: UInt32;              {**< Read-only *}
            format: PSDL_PixelFormat;   {**< Read-only *}
            w, h: SInt32;               {**< Read-only *}
            pitch: SInt32;              {**< Read-only *}
            pixels: Pointer;            {**< Read-write *}
            userdata: Pointer;          {**< Read-write *}
            locked: SInt32;             {**< Read-only *}
            lock_data: Pointer;         {**< Read-only *}
            clip_rect: PSDL_Rect;       {**< Read-only *}
            map: Pointer;               {**< Private *} //SDL_BlitMap
            refcount: SInt32;           {**< Read-mostly *}
          end;

          TSDL_Blit = function(src: PSDL_Surface; srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32;


  TTSDL_CreateRGBSurface=function(flags: UInt32; width: SInt32; height: SInt32; depth: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): PSDL_Surface; cdecl;
  TTSDL_CreateRGBSurfaceWithFormat=function(flags: Uint32; width, height, depth: sInt32; format: Uint32):PSDL_Surface; cdecl;
  TTSDL_CreateRGBSurfaceFrom=function(pixels: Pointer; width: SInt32; height: SInt32; depth: SInt32; pitch: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): PSDL_Surface; cdecl;
  TTSDL_CreateRGBSurfaceWithFormatFrom=function(pixels: Pointer; width, height, depth, pitch: sInt32; format: Uint32):PSDL_Surface; cdecl;
  TTSDL_FreeSurface=procedure(surface: PSDL_Surface); cdecl;
  TTSDL_SetSurfacePalette=function(surface: PSDL_Surface; palette: PSDL_Palette): SInt32; cdecl;
  TTSDL_LockSurface=function(surface: PSDL_Surface): SInt32; cdecl;
  TTSDL_UnlockSurface=procedure(surface: PSDL_Surface); cdecl;
  TTSDL_LoadBMP_RW=function(src: PSDL_RWops; freesrc: SInt32): PSDL_Surface; cdecl;
  TTSDL_SaveBMP_RW=function(surface: PSDL_Surface; dst: PSDL_RWops; freedst: SInt32): SInt32; cdecl;
  TTSDL_SetSurfaceRLE=function(surface: PSDL_Surface; flag: SInt32): SInt32; cdecl;
  TTSDL_SetColorKey=function(surface: PSDL_Surface; flag: SInt32; key: UInt32): SInt32; cdecl;
  TTSDL_GetColorKey=function(surface: PSDL_Surface; key: PUInt32): SInt32; cdecl;
  TTSDL_SetSurfaceColorMod=function(surface: PSDL_Surface; r: UInt8; g: UInt8; b: UInt8): SInt32; cdecl;
  TTSDL_GetSurfaceColorMod=function(surface: PSDL_Surface; r: PUInt8; g: PUInt8; b: PUInt8): SInt32; cdecl;
  TTSDL_SetSurfaceAlphaMod=function(surface: PSDL_Surface; alpha: UInt8): SInt32; cdecl;
  TTSDL_GetSurfaceAlphaMod=function(surface: PSDL_Surface; alpha: PUInt8): SInt32; cdecl;
  TTSDL_SetSurfaceBlendMode=function(surface: PSDL_Surface; blendMode: TSDL_BlendMode): SInt32; cdecl;
  TTSDL_GetSurfaceBlendMode=function(surface: PSDL_Surface; blendMode: PSDL_BlendMode): SInt32; cdecl;
  TTSDL_SetClipRect=function(surface: PSDL_Surface; const rect: PSDL_Rect): TSDL_Bool; cdecl;
  TTSDL_GetClipRect=procedure(surface: PSDL_Surface; rect: PSDL_Rect); cdecl;
  TTSDL_ConvertSurface=function(src: PSDL_Surface; fmt: PSDL_PixelFormat; flags: UInt32): PSDL_Surface; cdecl;
  TTSDL_ConvertSurfaceFormat=function(src: PSDL_Surface; pixel_format: UInt32; flags: UInt32): PSDL_Surface; cdecl;
  TTSDL_ConvertPixels=function(width: SInt32; height: SInt32; src_format: UInt32; const src: Pointer; src_pitch: SInt32; dst_format: UInt32; dst: Pointer; dst_pitch: SInt32): SInt32; cdecl;
  TTSDL_FillRect=function(dst: PSDL_Surface; const rect: PSDL_Rect; color: UInt32): SInt32; cdecl;
  TTSDL_UpperBlit=function(src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32; cdecl;
  TTSDL_LowerBlit=function(src: PSDL_Surface; srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32; cdecl;
  TTSDL_SoftStretch=function(src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; const dstrect: PSDL_Surface): SInt32; cdecl;
  TTSDL_UpperBlitScaled=function(src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32; cdecl;
  TTSDL_LowerBlitScaled=function(src: PSDL_Surface; srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32; cdecl;

  function SDL_MUSTLOCK(Const S:PSDL_Surface):Boolean;
  function SDL_LoadBMP(_file: PAnsiChar): PSDL_Surface;
  function SDL_SaveBMP(Const surface:PSDL_Surface; Const filename:AnsiString):sInt32;

//----------- sdl_shape.h ------------------------

        const
          SDL_NONSHAPEABLE_WINDOW = -1;
          SDL_INVALID_SHAPE_ARGUMENT = -2;
          SDL_WINDOW_LACKS_SHAPE = -3;

        type
          TWindowShapeMode = (ShapeModeDefault,
                              ShapeModeBinarizeAlpha,
                              ShapeModeReverseBinarizeAlpha,
                              ShapeModeColorKey);

          TSDL_WindowShapeParams = record
            case Integer of
              0: (binarizationCutoff: UInt8;);
              1: (colorKey: TSDL_Color;);
          end;

          PSDL_WindowShapeMode = ^TSDL_WindowShapeMode;
          TSDL_WindowShapeMode = record
            mode: TWindowShapeMode;
            parameters: TSDL_WindowShapeParams;
          end;


//----------- sdl_video, sdl_sysvideo.h ----------------------------

          const

            SDL_WINDOW_FULLSCREEN = $00000001;         {**< fullscreen window *}
            SDL_WINDOW_OPENGL = $00000002;             {**< window usable with OpenGL context *}
            SDL_WINDOW_SHOWN = $00000004;              {**< window is visible *}
            SDL_WINDOW_HIDDEN = $00000008;             {**< window is not visible *}
            SDL_WINDOW_BORDERLESS = $00000010;         {**< no window decoration *}
            SDL_WINDOW_RESIZABLE = $00000020;          {**< window can be resized *}
            SDL_WINDOW_MINIMIZED = $00000040;          {**< window is minimized *}
            SDL_WINDOW_MAXIMIZED = $00000080;          {**< window is maximized *}
            SDL_WINDOW_INPUT_GRABBED = $00000100;      {**< window has grabbed input focus *}
            SDL_WINDOW_INPUT_FOCUS = $00000200;        {**< window has input focus *}
            SDL_WINDOW_MOUSE_FOCUS = $00000400;        {**< window has mouse focus *}
            SDL_WINDOW_FULLSCREEN_DESKTOP = SDL_WINDOW_FULLSCREEN or $00001000;
            SDL_WINDOW_FOREIGN = $00000800;            {**< window not created by SDL *}
            SDL_WINDOW_ALLOW_HIGHDPI = $00002000;      {**< window should be created in high-DPI mode if supported *}
            SDL_WINDOW_ALWAYS_ON_TOP = $00008000;      {**< window should always be above others *}
            SDL_WINDOW_SKIP_TASKBAR  = $00010000;      {**< window should not be added to the taskbar *}
            SDL_WINDOW_UTILITY       = $00020000;      {**< window should be treated as a utility window *}
            SDL_WINDOW_TOOLTIP       = $00040000;      {**< window should be treated as a tooltip *}
            SDL_WINDOW_POPUP_MENU    = $00080000;      {**< window should be treated as a popup menu *}

            SDL_WINDOWPOS_UNDEFINED_MASK = $1FFF0000;
            SDL_WINDOWPOS_UNDEFINED = SDL_WINDOWPOS_UNDEFINED_MASK or 0;
            SDL_WINDOWPOS_CENTERED_MASK = $2FFF0000;
            SDL_WINDOWPOS_CENTERED = SDL_WINDOWPOS_CENTERED_MASK or 0;
            SDL_WINDOWEVENT_NONE = 0;           {**< Never used *}
            SDL_WINDOWEVENT_SHOWN = 1;          {**< Window has been shown *}
            SDL_WINDOWEVENT_HIDDEN = 2;         {**< Window has been hidden *}
            SDL_WINDOWEVENT_EXPOSED = 3;        {**< Window has been exposed and should be redrawn *}
            SDL_WINDOWEVENT_MOVED = 4;          {**< Window has been moved to data1; data2 *}
            SDL_WINDOWEVENT_RESIZED = 5;        {**< Window has been resized to data1xdata2 *}
            SDL_WINDOWEVENT_SIZE_CHANGED = 6;   {**< The window size has changed; either as a result of an API call or through the system or user changing the window size. *}
            SDL_WINDOWEVENT_MINIMIZED = 7;      {**< Window has been minimized *}
            SDL_WINDOWEVENT_MAXIMIZED = 8;      {**< Window has been maximized *}
            SDL_WINDOWEVENT_RESTORED = 9;       {**< Window has been restored to normal size and position *}
            SDL_WINDOWEVENT_ENTER = 10;          {**< Window has gained mouse focus *}
            SDL_WINDOWEVENT_LEAVE = 11;          {**< Window has lost mouse focus *}
            SDL_WINDOWEVENT_FOCUS_GAINED = 12;   {**< Window has gained keyboard focus *}
            SDL_WINDOWEVENT_FOCUS_LOST = 13;     {**< Window has lost keyboard focus *}
            SDL_WINDOWEVENT_CLOSE = 14;          {**< The window manager requests that the window be closed *}
            SDL_WINDOWEVENT_TAKE_FOCUS = 15;     {**< Window is being offered a focus (should SetWindowInputFocus() on itself or a subwindow, or ignore) *}
            SDL_WINDOWEVENT_HIT_TEST = 16;       {**< Window had a hit test that wasn't SDL_HITTEST_NORMAL. *}

            SDL_GL_RED_SIZE = 0;
            SDL_GL_GREEN_SIZE = 1;
            SDL_GL_BLUE_SIZE = 2;
            SDL_GL_ALPHA_SIZE = 3;
            SDL_GL_BUFFER_SIZE = 4;
            SDL_GL_DOUBLEBUFFER = 5;
            SDL_GL_DEPTH_SIZE = 6;
            SDL_GL_STENCIL_SIZE = 7;
            SDL_GL_ACCUM_RED_SIZE = 8;
            SDL_GL_ACCUM_GREEN_SIZE = 9;
            SDL_GL_ACCUM_BLUE_SIZE = 10;
            SDL_GL_ACCUM_ALPHA_SIZE = 11;
            SDL_GL_STEREO = 12;
            SDL_GL_MULTISAMPLEBUFFERS = 13;
            SDL_GL_MULTISAMPLESAMPLES = 14;
            SDL_GL_ACCELERATED_VISUAL = 15;
            SDL_GL_RETAINED_BACKING = 16;
            SDL_GL_CONTEXT_MAJOR_VERSION = 17;
            SDL_GL_CONTEXT_MINOR_VERSION = 18;
            SDL_GL_CONTEXT_EGL = 19;
            SDL_GL_CONTEXT_FLAGS = 20;
            SDL_GL_CONTEXT_PROFILE_MASK = 21;
            SDL_GL_SHARE_WITH_CURRENT_CONTEXT = 22;
            SDL_GL_FRAMEBUFFER_SRGB_CAPABLE = 23;
            SDL_GL_CONTEXT_RELEASE_BEHAVIOR = 24;

            SDL_GL_CONTEXT_PROFILE_CORE           = $0001;
            SDL_GL_CONTEXT_PROFILE_COMPATIBILITY  = $0002;
            SDL_GL_CONTEXT_PROFILE_ES             = $0004;

            SDL_GL_CONTEXT_DEBUG_FLAG              = $0001;
            SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = $0002;
            SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG      = $0004;
            SDL_GL_CONTEXT_RESET_ISOLATION_FLAG    = $0008;

            SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE   = $0000;
            SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH  = $0001;

      type

          PPSDL_Window = ^PSDL_Window;
          PSDL_Window = ^TSDL_Window;

            PSDL_DisplayMode = ^TSDL_DisplayMode;
            TSDL_DisplayMode = record
              format: UInt32;              {**< pixel format *}
              w: SInt32;                   {**< width *}
              h: SInt32;                   {**< height *}
              refresh_rate: SInt32;        {**< refresh rate (or zero for unspecified) *}
              driverdata: Pointer;         {**< driver-specific data, initialize to 0 *}
            end;

            PSDL_WindowShaper = ^TSDL_WindowShaper;
            TSDL_WindowShaper = record
              window: PSDL_Window;
              userx,usery: UInt32;
              mode: TSDL_WindowShapeMode;
              hasshape: TSDL_Bool;
              driverdata: Pointer;
            end;

            PSDL_WindowUserData = ^TSDL_WindowUserData;
            TSDL_WindowUserData = record
              name: PAnsiChar;
              data: Pointer;
              next: PSDL_WindowUserData;
            end;

            TSDL_Window = record
              magic: Pointer;
              id: UInt32;
              title: PAnsiChar;
              icon: PSDL_Surface;
              x,y: SInt32;
              w,h: SInt32;
              min_w, min_h: SInt32;
              max_w, max_h: SInt32;
              flags: UInt32;
              last_fullscreen_flags: UInt32;
              windowed: TSDL_Rect;
              fullscreen_mode: TSDL_DisplayMode;
              brightness: Float;
              gamma: PUInt16;
              saved_gamma: PUInt16;
              surface: PSDL_Surface;
              surface_valid: TSDL_Bool;
              shaper: PSDL_WindowShaper;
              data: PSDL_WindowUserData;
              driverdata: Pointer;
              prev: PSDL_Window;
              next: PSDL_Window;
            end;

            TSDL_WindowFlags = DWord;
            TSDL_WindowEventID = DWord;
            TSDL_GLContext = Pointer;
            TSDL_GLattr = DWord;
            TSDL_GLprofile = DWord;
            TSDL_GLcontextFlag = DWord;

            TSDL_GLcontextReleaseFlag = DWord;

            TSDL_HitTestResult = (
              SDL_HITTEST_NORMAL,     {**< Region is normal. No special properties. *}
              SDL_HITTEST_DRAGGABLE,  {**< Region can drag entire window. *}
              SDL_HITTEST_RESIZE_TOPLEFT,
              SDL_HITTEST_RESIZE_TOP,
              SDL_HITTEST_RESIZE_TOPRIGHT,
              SDL_HITTEST_RESIZE_RIGHT,
              SDL_HITTEST_RESIZE_BOTTOMRIGHT,
              SDL_HITTEST_RESIZE_BOTTOM,
              SDL_HITTEST_RESIZE_BOTTOMLEFT,
              SDL_HITTEST_RESIZE_LEFT
            );

            TSDL_HitTest = Function(win: PSDL_Window; const area: PSDL_Point; data: Pointer): TSDL_HitTestResult; cdecl;


  TTSDL_GetShapedWindowMode=function(window: PSDL_Window; shape_mode: TSDL_WindowShapeMode): SInt32; cdecl;
  TTSDL_SetWindowShape=function(window: PSDL_Window; shape: PSDL_Surface; shape_mode: PSDL_WindowShapeMode): SInt32; cdecl;
  TTSDL_CreateShapedWindow=function(title: PAnsiChar; x: UInt32; y: UInt32; w: UInt32; h: UInt32; flags: UInt32): PSDL_Window; cdecl;
  TTSDL_IsShapedWindow=function(window: PSDL_Window): TSDL_Bool; cdecl;

  TTSDL_GetNumVideoDrivers=function: SInt32; cdecl;
  TTSDL_GetVideoDriver=function(index: SInt32): PAnsiChar; cdecl;
  TTSDL_VideoInit=function(const driver_name: PAnsiChar): SInt32; cdecl;
  TTSDL_VideoQuit=procedure; cdecl;
  TTSDL_GetCurrentVideoDriver=function: PAnsiChar; cdecl;
  TTSDL_GetNumVideoDisplays=function: SInt32; cdecl;
  TTSDL_GetDisplayName=function(displayIndex: SInt32): PAnsiChar; cdecl;
  TTSDL_GetDisplayBounds=function(displayIndex: SInt32; rect: PSDL_Rect): SInt32; cdecl;
  TTSDL_GetDisplayDPI=function(displayIndex: SInt32; ddpi, hdpi, vdpi: PSingle): SInt32; cdecl;
  TTSDL_GetDisplayUsableBounds=function(displayIndex: sInt32; rect: PSDL_Rect):sInt32; cdecl;
  TTSDL_GetNumDisplayModes=function(displayIndex: SInt32): SInt32; cdecl;
  TTSDL_GetDisplayMode=function(displayIndex: SInt32; modeIndex: SInt32; mode: PSDL_DisplayMode): SInt32; cdecl;
  TTSDL_GetDesktopDisplayMode=function(displayIndex: SInt32; mode: PSDL_DisplayMode): SInt32; cdecl;
  TTSDL_GetCurrentDisplayMode=function(displayIndex: SInt32; mode: PSDL_DisplayMode): SInt32; cdecl;
  TTSDL_GetClosestDisplayMode=function(displayIndex: SInt32; const mode: PSDL_DisplayMode; closest: PSDL_DisplayMode): PSDL_DisplayMode; cdecl;
  TTSDL_GetWindowDisplayIndex=function(window: PSDL_Window): SInt32; cdecl;
  TTSDL_SetWindowDisplayMode=function(window: PSDL_Window; const mode: PSDL_DisplayMode): SInt32; cdecl;
  TTSDL_GetWindowDisplayMode=function(window: PSDL_Window; mode: PSDL_DisplayMode): SInt32; cdecl;
  TTSDL_GetWindowPixelFormat=function(window: PSDL_Window): UInt32; cdecl;
  TTSDL_CreateWindow=function(const title: PAnsiChar; x: SInt32; y: SInt32; w: SInt32; h: SInt32; flags: UInt32): PSDL_Window; cdecl;
  TTSDL_CreateWindowFrom=function(const data: Pointer): PSDL_Window; cdecl;
  TTSDL_GetWindowID=function(window: PSDL_Window): UInt32; cdecl;
  TTSDL_GetWindowFromID=function(id: UInt32): PSDL_Window; cdecl;
  TTSDL_GetWindowFlags=function(window: PSDL_Window): UInt32; cdecl;
  TTSDL_SetWindowTitle=procedure(window: PSDL_Window; const title: PAnsiChar); cdecl;
  TTSDL_GetWindowTitle=function(window: PSDL_Window): PAnsiChar; cdecl;
  TTSDL_SetWindowIcon=procedure(window: PSDL_Window; icon: PSDL_Surface); cdecl;
  TTSDL_SetWindowData=function(window: PSDL_Window; const name: PAnsiChar; userdata: Pointer): Pointer; cdecl;
  TTSDL_GetWindowData=function(window: PSDL_Window; const name: PAnsiChar): Pointer; cdecl;
  TTSDL_SetWindowPosition=procedure(window: PSDL_Window; x: SInt32; y: SInt32); cdecl;
  TTSDL_GetWindowPosition=procedure(window: PSDL_Window; x: PInt; y: PInt); cdecl;
  TTSDL_SetWindowSize=procedure(window: PSDL_Window; w: SInt32; h: SInt32); cdecl;
  TTSDL_GetWindowSize=procedure(window: PSDL_Window; w: PInt; h: PInt); cdecl;
  TTSDL_GetWindowBordersSize=function(window: PSDL_Window; top, left, bottom, right: PsInt32):sInt32; cdecl;
  TTSDL_SetWindowMinimumSize=procedure(window: PSDL_Window; min_w: SInt32; min_h: SInt32); cdecl;
  TTSDL_GetWindowMinimumSize=procedure(window: PSDL_Window; w: PInt; h: PInt); cdecl;
  TTSDL_SetWindowMaximumSize=procedure(window: PSDL_Window; max_w: SInt32; max_h: SInt32); cdecl;
  TTSDL_GetWindowMaximumSize=procedure(window: PSDL_Window; w: PInt; h: PInt); cdecl;
  TTSDL_SetWindowBordered=procedure(window: PSDL_Window; bordered: TSDL_Bool); cdecl;
  TTSDL_SetWindowResizable=procedure(window: PSDL_Window; resizable: TSDL_Bool); cdecl;
  TTSDL_ShowWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_HideWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_RaiseWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_MaximizeWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_MinimizeWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_RestoreWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_SetWindowFullscreen=function(window: PSDL_Window; flags: UInt32): SInt32; cdecl;
  TTSDL_GetWindowSurface=function(window: PSDL_Window): PSDL_Surface; cdecl;
  TTSDL_UpdateWindowSurface=function(window: PSDL_Window): SInt32; cdecl;
  TTSDL_UpdateWindowSurfaceRects=function(window: PSDL_Window; rects: PSDL_Rect; numrects: SInt32): SInt32; cdecl;
  TTSDL_SetWindowGrab=procedure(window: PSDL_Window; grabbed: TSDL_Bool); cdecl;
  TTSDL_GetWindowGrab=function(window: PSDL_Window): TSDL_Bool; cdecl;
  TTSDL_GetGrabbedWindow=function(): PSDL_Window; cdecl;
  TTSDL_SetWindowBrightness=function(window: PSDL_Window; brightness: Float): SInt32; cdecl;
  TTSDL_GetWindowBrightness=function(window: PSDL_Window): Float; cdecl;
  TTSDL_SetWindowOpacity=function(window: PSDL_Window; opacity: Float):sInt32; cdecl;
  TTSDL_GetWindowOpacity=function(window: PSDL_Window; out_opacity: PFloat):sInt32; cdecl;
  TTSDL_SetWindowModalFor=function(modal_window, parent_window: PSDL_Window):sInt32; cdecl;
  TTSDL_SetWindowInputFocus=function(window: PSDL_Window):sInt32; cdecl;
  TTSDL_SetWindowGammaRamp=function(window: PSDL_Window; const red: PUInt16; const green: PUInt16; const blue: PUInt16): SInt32; cdecl;
  TTSDL_GetWindowGammaRamp=function(window: PSDL_Window; red: PUInt16; green: PUInt16; blue: PUInt16): SInt32; cdecl;
  TTSDL_SetWindowHitTest=function(window: PSDL_Window; callback: TSDL_HitTest; callback_data: Pointer): SInt32; cdecl;
  TTSDL_DestroyWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_IsScreenSaverEnabled=function: TSDL_Bool; cdecl;
  TTSDL_EnableScreenSaver=procedure; cdecl;
  TTSDL_DisableScreenSaver=procedure; cdecl;
  TTSDL_GL_LoadLibrary=function(const path: PAnsiChar): SInt32; cdecl;
  TTSDL_GL_GetProcAddress=function(const proc: PAnsiChar): Pointer; cdecl;
  TTSDL_GL_UnloadLibrary=procedure; cdecl;
  TTSDL_GL_ExtensionSupported=function(const extension: PAnsiChar): TSDL_Bool; cdecl;
  TTSDL_GL_ResetAttributes=procedure(); cdecl;
  TTSDL_GL_SetAttribute=function(attr: TSDL_GLattr; value: SInt32): SInt32; cdecl;
  TTSDL_GL_GetAttribute=function(attr: TSDL_GLattr; value: PInt): SInt32; cdecl;
  TTSDL_GL_CreateContext=function(window: PSDL_Window): TSDL_GLContext; cdecl;
  TTSDL_GL_MakeCurrent=function(window: PSDL_Window; context: TSDL_GLContext): SInt32; cdecl;
  TTSDL_GL_GetCurrentWindow=function: PSDL_Window; cdecl;
  TTSDL_GL_GetCurrentContext=function: TSDL_GLContext; cdecl;
  TTSDL_GL_GetDrawableSize=procedure(window: PSDL_Window; w: PInt; h: PInt); cdecl;
  TTSDL_GL_SetSwapInterval=function(interval: SInt32): SInt32; cdecl;
  TTSDL_GL_GetSwapInterval=function: SInt32; cdecl;
  TTSDL_GL_SwapWindow=procedure(window: PSDL_Window); cdecl;
  TTSDL_GL_DeleteContext=procedure(context: TSDL_GLContext); cdecl;

  function SDL_WindowPos_IsUndefined(X: Variant): Variant;
  function SDL_WindowPos_IsCentered(X: Variant): Variant;

//-------------------SDL_hints.h -------------------


            const
            SDL_HINT_FRAMEBUFFER_ACCELERATION  = 'SDL_FRAMEBUFFER_ACCELERATION';
            SDL_HINT_RENDER_DRIVER = 'SDL_RENDER_DRIVER';
            SDL_HINT_RENDER_OPENGL_SHADERS = 'SDL_RENDER_OPENGL_SHADERS';
            SDL_HINT_RENDER_DIRECT3D_THREADSAFE = 'SDL_RENDER_DIRECT3D_THREADSAFE';
            SDL_HINT_RENDER_DIRECT3D11_DEBUG = 'SDL_RENDER_DIRECT3D11_DEBUG';
            SDL_HINT_RENDER_SCALE_QUALITY = 'SDL_RENDER_SCALE_QUALITY';
            SDL_HINT_RENDER_VSYNC = 'SDL_RENDER_VSYNC';
            SDL_HINT_VIDEO_ALLOW_SCREENSAVER = 'SDL_VIDEO_ALLOW_SCREENSAVER';
            SDL_HINT_VIDEO_X11_XVIDMODE = 'SDL_VIDEO_X11_XVIDMODE';
            SDL_HINT_VIDEO_X11_XINERAMA = 'SDL_VIDEO_X11_XINERAMA';
            SDL_HINT_VIDEO_X11_XRANDR = 'SDL_VIDEO_X11_XRANDR';
            SDL_HINT_VIDEO_X11_NET_WM_PING = 'SDL_VIDEO_X11_NET_WM_PING';
            SDL_HINT_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN = 'SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN';
            SDL_HINT_WINDOWS_ENABLE_MESSAGELOOP = 'SDL_WINDOWS_ENABLE_MESSAGELOOP';
            SDL_HINT_GRAB_KEYBOARD = 'SDL_GRAB_KEYBOARD';
            SDL_HINT_MOUSE_RELATIVE_MODE_WARP = 'SDL_MOUSE_RELATIVE_MODE_WARP';
            SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH = 'SDL_MOUSE_FOCUS_CLICKTHROUGH';
            SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS = 'SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS';
            SDL_HINT_IDLE_TIMER_DISABLED = 'SDL_IOS_IDLE_TIMER_DISABLED';
            SDL_HINT_ORIENTATIONS = 'SDL_IOS_ORIENTATIONS';
            SDL_HINT_APPLE_TV_CONTROLLER_UI_EVENTS = 'SDL_APPLE_TV_CONTROLLER_UI_EVENTS';
            SDL_HINT_APPLE_TV_REMOTE_ALLOW_ROTATION = 'SDL_APPLE_TV_REMOTE_ALLOW_ROTATION';
            SDL_HINT_ACCELEROMETER_AS_JOYSTICK = 'SDL_ACCELEROMETER_AS_JOYSTICK';
            SDL_HINT_XINPUT_ENABLED = 'SDL_XINPUT_ENABLED';
            SDL_HINT_XINPUT_USE_OLD_JOYSTICK_MAPPING = 'SDL_XINPUT_USE_OLD_JOYSTICK_MAPPING';
            SDL_HINT_GAMECONTROLLERCONFIG = 'SDL_GAMECONTROLLERCONFIG';
            SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS = 'SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS';
            SDL_HINT_ALLOW_TOPMOST = 'SDL_ALLOW_TOPMOST';
            SDL_HINT_TIMER_RESOLUTION = 'SDL_TIMER_RESOLUTION';
            SDL_HINT_THREAD_STACK_SIZE = 'SDL_THREAD_STACK_SIZE';
            SDL_HINT_VIDEO_HIGHDPI_DISABLED = 'SDL_VIDEO_HIGHDPI_DISABLED';
            SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK = 'SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK';
            SDL_HINT_VIDEO_WIN_D3DCOMPILER = 'SDL_VIDEO_WIN_D3DCOMPILER';
            SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT = 'SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT';
            SDL_HINT_WINRT_PRIVACY_POLICY_URL = 'SDL_WINRT_PRIVACY_POLICY_URL';
            SDL_HINT_WINRT_PRIVACY_POLICY_LABEL = 'SDL_WINRT_PRIVACY_POLICY_LABEL';
            SDL_HINT_WINRT_HANDLE_BACK_BUTTON = 'SDL_WINRT_HANDLE_BACK_BUTTON';
            SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES = 'SDL_VIDEO_MAC_FULLSCREEN_SPACES';
            SDL_HINT_MAC_BACKGROUND_APP = 'SDL_MAC_BACKGROUND_APP';
            SDL_HINT_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION = 'SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION';
            SDL_HINT_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION = 'SDL_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION';
            SDL_HINT_IME_INTERNAL_EDITING = 'SDL_IME_INTERNAL_EDITING';
            SDL_HINT_ANDROID_SEPARATE_MOUSE_AND_TOUCH = 'SDL_ANDROID_SEPARATE_MOUSE_AND_TOUCH';
            SDL_HINT_EMSCRIPTEN_KEYBOARD_ELEMENT = 'SDL_EMSCRIPTEN_KEYBOARD_ELEMENT';
            SDL_HINT_NO_SIGNAL_HANDLERS = 'SDL_NO_SIGNAL_HANDLERS';
            SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4 = 'SDL_WINDOWS_NO_CLOSE_ON_ALT_F4';
            SDL_HINT_BMP_SAVE_LEGACY_FORMAT = 'SDL_BMP_SAVE_LEGACY_FORMAT';
            SDL_HINT_WINDOWS_DISABLE_THREAD_NAMING = 'SDL_WINDOWS_DISABLE_THREAD_NAMING';
            SDL_HINT_RPI_VIDEO_LAYER = 'SDL_RPI_VIDEO_LAYER';

      type
            SDL_HintPriority = (SDL_HINT_DEFAULT, SDL_HINT_NORMAL, SDL_HINT_OVERRIDE);
            TSDL_HintCallback = procedure(userdata: Pointer; const name: PChar; const oldValue: PChar; const newValue: PChar);

  TTSDL_SetHintWithPriority= function(const name: PChar; const value: PChar; priority: SDL_HintPriority) : boolean; cdecl;
  TTSDL_SetHint= function(const name: PChar; const value: PChar): boolean; cdecl;
  TTSDL_GetHint= function(const name: PChar): PChar; cdecl;
  TTSDL_GetHintBoolean= function(const name: PChar; default_value: boolean): boolean; cdecl;
  TTSDL_AddHintCallback= procedure(const name: PChar; callback: TSDL_HintCallback; userdata: Pointer); cdecl;
  TTSDL_DelHintCallback= procedure(const name: PChar; callback: TSDL_HintCallback; userdata: Pointer); cdecl;
  TTSDL_ClearHints= procedure(); cdecl;
  TTSDL_LoadObject= function(Const sofile: PAnsiChar): Pointer; cdecl;
  TTSDL_LoadFunction= function(handle: Pointer; Const name: PAnsiChar): Pointer; cdecl;
  TTSDL_UnloadObject= procedure(handle: Pointer); cdecl;


//----------- sdl_messagebox.h -------------------

            const
              SDL_MESSAGEBOX_ERROR        = $00000010;   {**< error dialog *}
              SDL_MESSAGEBOX_WARNING      = $00000020;   {**< warning dialog *}
              SDL_MESSAGEBOX_INFORMATION  = $00000040;   {**< informational dialog *}

              SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = $00000001;  {**< Marks the default button when return is hit *}
              SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = $00000002;   {**< Marks the default button when escape is hit *}

            type
              TSDL_MessageBoxFlags = Byte;
              TSDL_MessageBoxButtonFlags = Byte;

              PSDL_MessageBoxButtonData = ^TSDL_MessageBoxButtonData;
              TSDL_MessageBoxButtonData = record
                flags: UInt32;     {**< ::SDL_MessageBoxButtonFlags *}
                buttonid: Integer; {**< User defined button id (value returned via SDL_ShowMessageBox) *}
                text: PAnsiChar;   {**< The UTF-8 button text *}
              end;

              PSDL_MessageBoxColor = ^TSDL_MessageBoxColor;
              TSDL_MessageBoxColor = record
                r, g, b: UInt8;
              end;

              PSDL_MessageBoxColorType = ^TSDL_MessageBoxColorType;
              TSDL_MessageBoxColorType = (SDL_MESSAGEBOX_COLOR_BACKGROUND,
                                          SDL_MESSAGEBOX_COLOR_TEXT,
                                          SDL_MESSAGEBOX_COLOR_BUTTON_BORDER,
                                          SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
                                          SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED,
                                          SDL_MESSAGEBOX_COLOR_MAX);

              PSDL_MessageBoxColorScheme = ^TSDL_MessageBoxColorScheme;
              TSDL_MessageBoxColorScheme = record
                colors: array[0..4] of TSDL_MessageBoxColor;
              end;

              PSDL_MessageBoxData = ^TSDL_MessageBoxData;
              TSDL_MessageBoxData = record
                flags: UInt32;             {**< SDL_MessageBoxFlags *}
                window: PSDL_Window;       {**< Parent window, can be NULL *}
                title: PAnsiChar;          {**< UTF-8 title *}
                _message: PAnsiChar;       {**< UTF-8 message text *}
                numbuttons: Integer;
                buttons: PSDL_MessageBoxButtonData;
                colorScheme: PSDL_MessageBoxColorScheme;
              end;


  TTSDL_ShowMessageBox= function(messageboxdata: PSDL_MessageBoxData; buttonid: PInt): Integer; cdecl;
  TTSDL_ShowSimpleMessageBox=function(flags: UInt32; title: PAnsiChar; _message: PAnsiChar; window: PSDL_Window): Integer; cdecl;



//----------- sdl_renderer.h -------------------

            const
              SDL_RENDERER_SOFTWARE = $00000001;          {**< The renderer is a software fallback *}
              SDL_RENDERER_ACCELERATED = $00000002;       {**< The renderer uses hardware
                                                               acceleration *}
              SDL_RENDERER_PRESENTVSYNC = $00000004;      {**< Present is synchronized
                                                               with the refresh rate *}
              SDL_RENDERER_TARGETTEXTURE = $00000008;     {**< The renderer supports
                                                               rendering to texture *}

              SDL_TEXTUREACCESS_STATIC    = 0; {**< Changes rarely, not lockable *}
              SDL_TEXTUREACCESS_STREAMING = 1; {**< Changes frequently, lockable *}
              SDL_TEXTUREACCESS_TARGET    = 2; {**< Texture can be used as a render target *}

              SDL_FLIP_NONE       = $0; {**< Do not flip *}
              SDL_FLIP_HORIZONTAL = $1; {**< flip horizontally *}
              SDL_FLIP_VERTICAL   = $2; {**< flip vertically *}

            type
              PSDL_RendererFlags = ^TSDL_RendererFlags;
              TSDL_RendererFlags = Word;

              PSDL_RendererInfo = ^TSDL_RendererInfo;
              TSDL_RendererInfo = record
                name: PAnsiChar;                         {**< The name of the renderer *}
                flags: UInt32;                           {**< Supported ::SDL_RendererFlags *}
                num_texture_formats: UInt32;             {**< The number of available texture formats *}
                texture_formats: array[0..15] of UInt32; {**< The available texture formats *}
                max_texture_width: SInt32;               {**< The maximimum texture width *}
                max_texture_height: SInt32;              {**< The maximimum texture height *}
              end;

              PSDL_TextureAccess = ^TSDL_TextureAccess;
              TSDL_TextureAccess = SInt32;

              PSDL_TextureModulate = ^TSDL_TextureModulate;
              TSDL_TextureModulate = (SDL_TEXTUREMODULATE_NONE,     {**< No modulation *}
                                      SDL_TEXTUREMODULATE_COLOR,    {**< srcC = srcC * color *}
                                      SDL_TEXTUREMODULATE_ALPHA     {**< srcA = srcA * alpha *}
                                      );

              PPSDL_Renderer = ^PSDL_Renderer;
              PSDL_Renderer = ^TSDL_Renderer;
              TSDL_Renderer = record
                end;

              PSDL_Texture = ^TSDL_Texture;
              TSDL_Texture = record
                end;


  TTSDL_GetNumRenderDrivers=function: SInt32; cdecl;
  TTSDL_GetRenderDriverInfo=function(index: SInt32; info: PSDL_RendererInfo): SInt32; cdecl;
  TTSDL_CreateWindowAndRenderer=function(width: SInt32; height: SInt32; window_flags: UInt32; window: PPSDL_Window; renderer: PPSDL_Renderer): SInt32; cdecl;
  TTSDL_CreateRenderer=function(window: PSDL_Window; index: SInt32; flags: UInt32): PSDL_Renderer; cdecl;
  TTSDL_CreateSoftwareRenderer=function(surface: PSDL_Surface): PSDL_Renderer; cdecl;
  TTSDL_GetRenderer=function(window: PSDL_Window): PSDL_Renderer; cdecl;
  TTSDL_GetRendererInfo=function(renderer: PSDL_Renderer; info: PSDL_RendererInfo): SInt32; cdecl;
  TTSDL_GetRendererOutputSize=function(renderer: PSDL_Renderer; w: PInt; h: PInt): SInt32; cdecl;
  TTSDL_CreateTexture=function(renderer: PSDL_Renderer; format: UInt32; access: SInt32; w: SInt32; h: SInt32): PSDL_Texture; cdecl;
  TTSDL_CreateTextureFromSurface=function(renderer: PSDL_Renderer; surface: PSDL_Surface): PSDL_Texture; cdecl;
  TTSDL_QueryTexture=function(texture: PSDL_Texture; format: PUInt32; access: PInt; w: PInt; h: PInt): SInt32; cdecl;
  TTSDL_SetTextureColorMod=function(texture: PSDL_Texture; r: UInt8; g: UInt8; b: UInt8): SInt32; cdecl;
  TTSDL_GetTextureColorMod=function(texture: PSDL_Texture; r: PUInt8; g: PUInt8; b: PUInt8): SInt32; cdecl;
  TTSDL_SetTextureAlphaMod=function(texture: PSDL_Texture; alpha: UInt8): SInt32; cdecl;
  TTSDL_GetTextureAlphaMod=function(texture: PSDL_Texture; alpha: PUInt8): SInt32; cdecl;
  TTSDL_SetTextureBlendMode=function(texture: PSDL_Texture; blendMode: TSDL_BlendMode): SInt32; cdecl;
  TTSDL_GetTextureBlendMode=function(texture: PSDL_Texture; blendMode: PSDL_BlendMode): SInt32; cdecl;
  TTSDL_UpdateTexture=function(texture: PSDL_Texture; rect: PSDL_Rect; pixels: Pointer; pitch: SInt32): SInt32; cdecl;
  TTSDL_LockTexture=function(texture: PSDL_Texture; rect: PSDL_Rect; pixels: PPointer; pitch: PInt): SInt32; cdecl;
  TTSDL_UnlockTexture=procedure(texture: PSDL_Texture); cdecl;
  TTSDL_RenderTargetSupported=function(renderer: PSDL_Renderer): Boolean; cdecl;
  TTSDL_SetRenderTarget=function(renderer: PSDL_Renderer; texture: PSDL_Texture): SInt32; cdecl;
  TTSDL_GetRenderTarget=function(renderer: PSDL_Renderer): PSDL_Texture; cdecl;
  TTSDL_RenderSetLogicalSize=function(renderer: PSDL_Renderer; w: SInt32; h: SInt32): SInt32; cdecl;
  TTSDL_RenderGetLogicalSize=procedure(renderer: PSDL_Renderer; w: PInt; h: PInt); cdecl;
  TTSDL_RenderSetViewport=function(renderer: PSDL_Renderer; const rect: PSDL_Rect): SInt32; cdecl;
  TTSDL_RenderGetViewport=procedure(renderer: PSDL_Renderer; rect: PSDL_Rect); cdecl;
  TTSDL_RenderSetClipRect=function(renderer: PSDL_Renderer; rect: PSDL_Rect): SInt32; cdecl;
  TTSDL_RenderGetClipRect=procedure(renderer: PSDL_Renderer; rect: PSDL_Rect); cdecl;
  TTSDL_RenderIsClipEnabled=function(renderer: PSDL_Renderer): TSDL_Bool; cdecl;
  TTSDL_RenderSetScale=function(renderer: PSDL_Renderer; scaleX: Float; scaleY: Float): SInt32; cdecl;
  TTSDL_RenderGetScale=procedure(renderer: PSDL_Renderer; scaleX: PFloat; scaleY: PFloat); cdecl;
  TTSDL_SetRenderDrawColor=function(renderer: PSDL_Renderer; r: UInt8; g: UInt8; b: UInt8; a: UInt8): SInt32; cdecl;
  TTSDL_GetRenderDrawColor=function(renderer: PSDL_Renderer; r: PUInt8; g: PUInt8; b: PUInt8; a: PUInt8): SInt32; cdecl;
  TTSDL_SetRenderDrawBlendMode=function(renderer: PSDL_Renderer; blendMode: TSDL_BlendMode): SInt32; cdecl;
  TTSDL_GetRenderDrawBlendMode=function(renderer: PSDL_Renderer; blendMode: PSDL_BlendMode): SInt32; cdecl;
  TTSDL_RenderClear=function(renderer: PSDL_Renderer): SInt32; cdecl;
  TTSDL_RenderDrawPoint=function(renderer: PSDL_Renderer; x: SInt32; y: SInt32): SInt32; cdecl;
  TTSDL_RenderDrawPoints=function(renderer: PSDL_Renderer; points: PSDL_Point; count: SInt32): SInt32; cdecl;
  TTSDL_RenderDrawLine=function(renderer: PSDL_Renderer; x1: SInt32; y1: SInt32; x2: SInt32; y2: SInt32): SInt32; cdecl;
  TTSDL_RenderDrawLines=function(renderer: PSDL_Renderer; points: PSDL_Point; count: SInt32): SInt32; cdecl;
  TTSDL_RenderDrawRect=function(renderer: PSDL_Renderer; rect: PSDL_Rect): SInt32; cdecl;
  TTSDL_RenderDrawRects=function(renderer: PSDL_Renderer; rects: PSDL_Rect; count: SInt32): SInt32; cdecl;
  TTSDL_RenderFillRect=function(renderer: PSDL_Renderer; rect: PSDL_Rect): SInt32; cdecl;
  TTSDL_RenderFillRects=function(renderer: PSDL_Renderer; rects: PSDL_Rect; count: SInt32): SInt32; cdecl;
  TTSDL_RenderCopy=function(renderer: PSDL_Renderer; texture: PSDL_Texture; srcrect: PSDL_Rect; dstrect: PSDL_Rect): SInt32; cdecl;
  TTSDL_RenderCopyEx=function(renderer: PSDL_Renderer; texture: PSDL_Texture; const srcrect: PSDL_Rect; dstrect: PSDL_Rect; angle: Double; center: PSDL_Point; flip: Integer): SInt32; cdecl;
  TTSDL_RenderReadPixels=function(renderer: PSDL_Renderer; rect: PSDL_Rect; format: UInt32; pixels: Pointer; pitch: SInt32): SInt32; cdecl;
  TTSDL_RenderPresent=procedure(renderer: PSDL_Renderer); cdecl;
  TTSDL_DestroyTexture=procedure(texture: PSDL_Texture); cdecl;
  TTSDL_DestroyRenderer=procedure(renderer: PSDL_Renderer); cdecl;
  TTSDL_GL_BindTexture=function(texture: PSDL_Texture; texw: PFloat; texh: PFloat): SInt32; cdecl;
  TTSDL_GL_UnbindTexture=function(texture: PSDL_Texture): SInt32; cdecl;
  TTSDL_UpdateYUVTexture=function(texture: PSDL_Texture; rect: PSDL_Rect; Yplane: PUInt8; Ypitch: SInt32; Uplane: PUInt8; UPitch: SInt32; Vplane: UInt8; VPitch: SInt32):SInt32; cdecl;


//----------- sdl_scancode.h -------------------

            const
              SDL_SCANCODE_UNKNOWN = 0;

              SDL_SCANCODE_A = 4;
              SDL_SCANCODE_B = 5;
              SDL_SCANCODE_C = 6;
              SDL_SCANCODE_D = 7;
              SDL_SCANCODE_E = 8;
              SDL_SCANCODE_F = 9;
              SDL_SCANCODE_G = 10;
              SDL_SCANCODE_H = 11;
              SDL_SCANCODE_I = 12;
              SDL_SCANCODE_J = 13;
              SDL_SCANCODE_K = 14;
              SDL_SCANCODE_L = 15;
              SDL_SCANCODE_M = 16;
              SDL_SCANCODE_N = 17;
              SDL_SCANCODE_O = 18;
              SDL_SCANCODE_P = 19;
              SDL_SCANCODE_Q = 20;
              SDL_SCANCODE_R = 21;
              SDL_SCANCODE_S = 22;
              SDL_SCANCODE_T = 23;
              SDL_SCANCODE_U = 24;
              SDL_SCANCODE_V = 25;
              SDL_SCANCODE_W = 26;
              SDL_SCANCODE_X = 27;
              SDL_SCANCODE_Y = 28;
              SDL_SCANCODE_Z = 29;

              SDL_SCANCODE_1 = 30;
              SDL_SCANCODE_2 = 31;
              SDL_SCANCODE_3 = 32;
              SDL_SCANCODE_4 = 33;
              SDL_SCANCODE_5 = 34;
              SDL_SCANCODE_6 = 35;
              SDL_SCANCODE_7 = 36;
              SDL_SCANCODE_8 = 37;
              SDL_SCANCODE_9 = 38;
              SDL_SCANCODE_0 = 39;

              SDL_SCANCODE_RETURN = 40;
              SDL_SCANCODE_ESCAPE = 41;
              SDL_SCANCODE_BACKSPACE = 42;
              SDL_SCANCODE_TAB = 43;
              SDL_SCANCODE_SPACE = 44;

              SDL_SCANCODE_MINUS = 45;
              SDL_SCANCODE_EQUALS = 46;
              SDL_SCANCODE_LEFTBRACKET = 47;
              SDL_SCANCODE_RIGHTBRACKET = 48;
              SDL_SCANCODE_BACKSLASH = 49;
              SDL_SCANCODE_NONUSHASH = 50;
              SDL_SCANCODE_SEMICOLON = 51;
              SDL_SCANCODE_APOSTROPHE = 52;
              SDL_SCANCODE_GRAVE = 53;
              SDL_SCANCODE_COMMA = 54;
              SDL_SCANCODE_PERIOD = 55;
              SDL_SCANCODE_SLASH = 56;

              SDL_SCANCODE_CAPSLOCK = 57;

              SDL_SCANCODE_F1 = 58;
              SDL_SCANCODE_F2 = 59;
              SDL_SCANCODE_F3 = 60;
              SDL_SCANCODE_F4 = 61;
              SDL_SCANCODE_F5 = 62;
              SDL_SCANCODE_F6 = 63;
              SDL_SCANCODE_F7 = 64;
              SDL_SCANCODE_F8 = 65;
              SDL_SCANCODE_F9 = 66;
              SDL_SCANCODE_F10 = 67;
              SDL_SCANCODE_F11 = 68;
              SDL_SCANCODE_F12 = 69;

              SDL_SCANCODE_PRINTSCREEN = 70;
              SDL_SCANCODE_SCROLLLOCK = 71;
              SDL_SCANCODE_PAUSE = 72;
              SDL_SCANCODE_INSERT = 73;
              SDL_SCANCODE_HOME = 74;
              SDL_SCANCODE_PAGEUP = 75;
              SDL_SCANCODE_DELETE = 76;
              SDL_SCANCODE_END = 77;
              SDL_SCANCODE_PAGEDOWN = 78;
              SDL_SCANCODE_RIGHT = 79;
              SDL_SCANCODE_LEFT = 80;
              SDL_SCANCODE_DOWN = 81;
              SDL_SCANCODE_UP = 82;

              SDL_SCANCODE_NUMLOCKCLEAR = 83;
              SDL_SCANCODE_KP_DIVIDE = 84;
              SDL_SCANCODE_KP_MULTIPLY = 85;
              SDL_SCANCODE_KP_MINUS = 86;
              SDL_SCANCODE_KP_PLUS = 87;
              SDL_SCANCODE_KP_ENTER = 88;
              SDL_SCANCODE_KP_1 = 89;
              SDL_SCANCODE_KP_2 = 90;
              SDL_SCANCODE_KP_3 = 91;
              SDL_SCANCODE_KP_4 = 92;
              SDL_SCANCODE_KP_5 = 93;
              SDL_SCANCODE_KP_6 = 94;
              SDL_SCANCODE_KP_7 = 95;
              SDL_SCANCODE_KP_8 = 96;
              SDL_SCANCODE_KP_9 = 97;
              SDL_SCANCODE_KP_0 = 98;
              SDL_SCANCODE_KP_PERIOD = 99;

              SDL_SCANCODE_NONUSBACKSLASH = 100; {**< This is the additional key that ISO
                                                  *   keyboards have over ANSI ones;
                                                  *   located between left shift and Y.
                                                  *   Produces GRAVE ACCENT and TILDE in a
                                                  *   US or UK Mac layout; REVERSE SOLIDUS
                                                  *   (backslash) and VERTICAL LINE in a
                                                  *   US or UK Windows layout; and
                                                  *   LESS-THAN SIGN and GREATER-THAN SIGN
                                                  *   in a Swiss German; German; or French
                                                  *   layout. *}
              SDL_SCANCODE_APPLICATION = 101;    {**< windows contextual menu; compose *}
              SDL_SCANCODE_POWER = 102;          {**< The USB document says this is a status flag;
                                                   *  not a physical key - but some Mac keyboards
                                                   *  do have a power key. *}
              SDL_SCANCODE_KP_EQUALS = 103;
              SDL_SCANCODE_F13 = 104;
              SDL_SCANCODE_F14 = 105;
              SDL_SCANCODE_F15 = 106;
              SDL_SCANCODE_F16 = 107;
              SDL_SCANCODE_F17 = 108;
              SDL_SCANCODE_F18 = 109;
              SDL_SCANCODE_F19 = 110;
              SDL_SCANCODE_F20 = 111;
              SDL_SCANCODE_F21 = 112;
              SDL_SCANCODE_F22 = 113;
              SDL_SCANCODE_F23 = 114;
              SDL_SCANCODE_F24 = 115;
              SDL_SCANCODE_EXECUTE = 116;
              SDL_SCANCODE_HELP = 117;
              SDL_SCANCODE_MENU = 118;
              SDL_SCANCODE_SELECT = 119;
              SDL_SCANCODE_STOP = 120;
              SDL_SCANCODE_AGAIN = 121;
              SDL_SCANCODE_UNDO = 122;
              SDL_SCANCODE_CUT = 123;
              SDL_SCANCODE_COPY = 124;
              SDL_SCANCODE_PASTE = 125;
              SDL_SCANCODE_FIND = 126;
              SDL_SCANCODE_MUTE = 127;
              SDL_SCANCODE_VOLUMEUP = 128;
              SDL_SCANCODE_VOLUMEDOWN = 129;
              {* not sure whether there's a reason to enable these *}
              {*     SDL_SCANCODE_LOCKINGCAPSLOCK = 130;  *}
              {*     SDL_SCANCODE_LOCKINGNUMLOCK = 131; *}
              {*     SDL_SCANCODE_LOCKINGSCROLLLOCK = 132; *}
              SDL_SCANCODE_KP_COMMA = 133;
              SDL_SCANCODE_KP_EQUALSAS400 = 134;

              SDL_SCANCODE_INTERNATIONAL1 = 135;
              SDL_SCANCODE_INTERNATIONAL2 = 136;
              SDL_SCANCODE_INTERNATIONAL3 = 137;
              SDL_SCANCODE_INTERNATIONAL4 = 138;
              SDL_SCANCODE_INTERNATIONAL5 = 139;
              SDL_SCANCODE_INTERNATIONAL6 = 140;
              SDL_SCANCODE_INTERNATIONAL7 = 141;
              SDL_SCANCODE_INTERNATIONAL8 = 142;
              SDL_SCANCODE_INTERNATIONAL9 = 143;
              SDL_SCANCODE_LANG1 = 144;
              SDL_SCANCODE_LANG2 = 145;
              SDL_SCANCODE_LANG3 = 146;
              SDL_SCANCODE_LANG4 = 147;
              SDL_SCANCODE_LANG5 = 148;
              SDL_SCANCODE_LANG6 = 149;
              SDL_SCANCODE_LANG7 = 150;
              SDL_SCANCODE_LANG8 = 151;
              SDL_SCANCODE_LANG9 = 152;

              SDL_SCANCODE_ALTERASE = 153;
              SDL_SCANCODE_SYSREQ = 154;
              SDL_SCANCODE_CANCEL = 155;
              SDL_SCANCODE_CLEAR = 156;
              SDL_SCANCODE_PRIOR = 157;
              SDL_SCANCODE_RETURN2 = 158;
              SDL_SCANCODE_SEPARATOR = 159;
              SDL_SCANCODE_OUT = 160;
              SDL_SCANCODE_OPER = 161;
              SDL_SCANCODE_CLEARAGAIN = 162;
              SDL_SCANCODE_CRSEL = 163;
              SDL_SCANCODE_EXSEL = 164;

              SDL_SCANCODE_KP_00 = 176;
              SDL_SCANCODE_KP_000 = 177;
              SDL_SCANCODE_THOUSANDSSEPARATOR = 178;
              SDL_SCANCODE_DECIMALSEPARATOR = 179;
              SDL_SCANCODE_CURRENCYUNIT = 180;
              SDL_SCANCODE_CURRENCYSUBUNIT = 181;
              SDL_SCANCODE_KP_LEFTPAREN = 182;
              SDL_SCANCODE_KP_RIGHTPAREN = 183;
              SDL_SCANCODE_KP_LEFTBRACE = 184;
              SDL_SCANCODE_KP_RIGHTBRACE = 185;
              SDL_SCANCODE_KP_TAB = 186;
              SDL_SCANCODE_KP_BACKSPACE = 187;
              SDL_SCANCODE_KP_A = 188;
              SDL_SCANCODE_KP_B = 189;
              SDL_SCANCODE_KP_C = 190;
              SDL_SCANCODE_KP_D = 191;
              SDL_SCANCODE_KP_E = 192;
              SDL_SCANCODE_KP_F = 193;
              SDL_SCANCODE_KP_XOR = 194;
              SDL_SCANCODE_KP_POWER = 195;
              SDL_SCANCODE_KP_PERCENT = 196;
              SDL_SCANCODE_KP_LESS = 197;
              SDL_SCANCODE_KP_GREATER = 198;
              SDL_SCANCODE_KP_AMPERSAND = 199;
              SDL_SCANCODE_KP_DBLAMPERSAND = 200;
              SDL_SCANCODE_KP_VERTICALBAR = 201;
              SDL_SCANCODE_KP_DBLVERTICALBAR = 202;
              SDL_SCANCODE_KP_COLON = 203;
              SDL_SCANCODE_KP_HASH = 204;
              SDL_SCANCODE_KP_SPACE = 205;
              SDL_SCANCODE_KP_AT = 206;
              SDL_SCANCODE_KP_EXCLAM = 207;
              SDL_SCANCODE_KP_MEMSTORE = 208;
              SDL_SCANCODE_KP_MEMRECALL = 209;
              SDL_SCANCODE_KP_MEMCLEAR = 210;
              SDL_SCANCODE_KP_MEMADD = 211;
              SDL_SCANCODE_KP_MEMSUBTRACT = 212;
              SDL_SCANCODE_KP_MEMMULTIPLY = 213;
              SDL_SCANCODE_KP_MEMDIVIDE = 214;
              SDL_SCANCODE_KP_PLUSMINUS = 215;
              SDL_SCANCODE_KP_CLEAR = 216;
              SDL_SCANCODE_KP_CLEARENTRY = 217;
              SDL_SCANCODE_KP_BINARY = 218;
              SDL_SCANCODE_KP_OCTAL = 219;
              SDL_SCANCODE_KP_DECIMAL = 220;
              SDL_SCANCODE_KP_HEXADECIMAL = 221;

              SDL_SCANCODE_LCTRL = 224;
              SDL_SCANCODE_LSHIFT = 225;
              SDL_SCANCODE_LALT = 226; {**< alt; option *}
              SDL_SCANCODE_LGUI = 227; {**< windows; command (apple); meta *}
              SDL_SCANCODE_RCTRL = 228;
              SDL_SCANCODE_RSHIFT = 229;
              SDL_SCANCODE_RALT = 230; {**< alt gr; option *}
              SDL_SCANCODE_RGUI = 231; {**< windows; command (apple); meta *}

              SDL_SCANCODE_MODE = 257;    {**< I'm not sure if this is really not covered
                                           *   by any of the above; but since there's a
                                           *   special KMOD_MODE for it I'm adding it here
                                           *}

              SDL_SCANCODE_AUDIONEXT = 258;
              SDL_SCANCODE_AUDIOPREV = 259;
              SDL_SCANCODE_AUDIOSTOP = 260;
              SDL_SCANCODE_AUDIOPLAY = 261;
              SDL_SCANCODE_AUDIOMUTE = 262;
              SDL_SCANCODE_MEDIASELECT = 263;
              SDL_SCANCODE_WWW = 264;
              SDL_SCANCODE_MAIL = 265;
              SDL_SCANCODE_CALCULATOR = 266;
              SDL_SCANCODE_COMPUTER = 267;
              SDL_SCANCODE_AC_SEARCH = 268;
              SDL_SCANCODE_AC_HOME = 269;
              SDL_SCANCODE_AC_BACK = 270;
              SDL_SCANCODE_AC_FORWARD = 271;
              SDL_SCANCODE_AC_STOP = 272;
              SDL_SCANCODE_AC_REFRESH = 273;
              SDL_SCANCODE_AC_BOOKMARKS = 274;


              SDL_SCANCODE_BRIGHTNESSDOWN = 275;
              SDL_SCANCODE_BRIGHTNESSUP = 276;
              SDL_SCANCODE_DISPLAYSWITCH = 277;
              SDL_SCANCODE_KBDILLUMTOGGLE = 278;
              SDL_SCANCODE_KBDILLUMDOWN = 279;
              SDL_SCANCODE_KBDILLUMUP = 280;
              SDL_SCANCODE_EJECT = 281;
              SDL_SCANCODE_SLEEP = 282;

              SDL_SCANCODE_APP1 = 283;
              SDL_SCANCODE_APP2 = 284;

              SDL_NUM_SCANCODES = 512; {**< not a key, just marks the number of scancodes
                                           for array bounds *}

            type
              PSDL_ScanCode = ^TSDL_ScanCode;
              TSDL_ScanCode = DWord;

              PSDL_KeyCode = ^TSDL_KeyCode;
              TSDL_KeyCode = SInt32;

            const
              SDLK_SCANCODE_MASK = 1 shl 30;

              SDLK_UNKNOWN = 0;

              SDLK_RETURN = SInt32(#13);   // C: '\r'
              SDLK_ESCAPE = SInt32(#27);   // C: '\033'
              SDLK_BACKSPACE = SInt32(#8); // C: '\b'
              SDLK_TAB = SInt32(#9);       // C: '\t'
              SDLK_SPACE = SInt32(' ');
              SDLK_EXCLAIM = SInt32('!');
              SDLK_QUOTEDBL = SInt32('"');
              SDLK_HASH = SInt32('#');
              SDLK_PERCENT = SInt32('%');
              SDLK_DOLLAR = SInt32('$');
              SDLK_AMPERSAND = SInt32('&');
              SDLK_QUOTE = SInt32('\');
              SDLK_LEFTPAREN = SInt32('(');
              SDLK_RIGHTPAREN = SInt32(')');
              SDLK_ASTERISK = SInt32('*');
              SDLK_PLUS = SInt32('+');
              SDLK_COMMA = SInt32(',');
              SDLK_MINUS = SInt32('-');
              SDLK_PERIOD = SInt32('.');
              SDLK_SLASH = SInt32('/');
              SDLK_0 = SInt32('0');
              SDLK_1 = SInt32('1');
              SDLK_2 = SInt32('2');
              SDLK_3 = SInt32('3');
              SDLK_4 = SInt32('4');
              SDLK_5 = SInt32('5');
              SDLK_6 = SInt32('6');
              SDLK_7 = SInt32('7');
              SDLK_8 = SInt32('8');
              SDLK_9 = SInt32('9');
              SDLK_COLON = SInt32(':');
              SDLK_SEMICOLON = SInt32(';');
              SDLK_LESS = SInt32('<');
              SDLK_EQUALS = SInt32('=');
              SDLK_GREATER = SInt32('>');
              SDLK_QUESTION = SInt32('?');
              SDLK_AT = SInt32('@');
              {*
                 Skip uppercase letters
               *}
              SDLK_LEFTBRACKET = SInt32('[');
              SDLK_BACKSLASH = SInt32('\');
              SDLK_RIGHTBRACKET = SInt32(']');
              SDLK_CARET = SInt32('^');
              SDLK_UNDERSCORE = SInt32('_');
              SDLK_BACKQUOTE = SInt32('`');
              SDLK_a = SInt32('a');
              SDLK_b = SInt32('b');
              SDLK_c = SInt32('c');
              SDLK_d = SInt32('d');
              SDLK_e = SInt32('e');
              SDLK_f = SInt32('f');
              SDLK_g = SInt32('g');
              SDLK_h = SInt32('h');
              SDLK_i = SInt32('i');
              SDLK_j = SInt32('j');
              SDLK_k = SInt32('k');
              SDLK_l = SInt32('l');
              SDLK_m = SInt32('m');
              SDLK_n = SInt32('n');
              SDLK_o = SInt32('o');
              SDLK_p = SInt32('p');
              SDLK_q = SInt32('q');
              SDLK_r = SInt32('r');
              SDLK_s = SInt32('s');
              SDLK_t = SInt32('t');
              SDLK_u = SInt32('u');
              SDLK_v = SInt32('v');
              SDLK_w = SInt32('w');
              SDLK_x = SInt32('x');
              SDLK_y = SInt32('y');
              SDLK_z = SInt32('z');

              SDLK_CAPSLOCK = SDL_SCANCODE_CAPSLOCK or SDLK_SCANCODE_MASK;

              SDLK_F1 = SDL_SCANCODE_F1 or SDLK_SCANCODE_MASK;
              SDLK_F2 = SDL_SCANCODE_F2 or SDLK_SCANCODE_MASK;
              SDLK_F3 = SDL_SCANCODE_F3 or SDLK_SCANCODE_MASK;
              SDLK_F4 = SDL_SCANCODE_F4 or SDLK_SCANCODE_MASK;
              SDLK_F5 = SDL_SCANCODE_F5 or SDLK_SCANCODE_MASK;
              SDLK_F6 = SDL_SCANCODE_F6 or SDLK_SCANCODE_MASK;
              SDLK_F7 = SDL_SCANCODE_F7 or SDLK_SCANCODE_MASK;
              SDLK_F8 = SDL_SCANCODE_F8 or SDLK_SCANCODE_MASK;
              SDLK_F9 = SDL_SCANCODE_F9 or SDLK_SCANCODE_MASK;
              SDLK_F10 = SDL_SCANCODE_F10 or SDLK_SCANCODE_MASK;
              SDLK_F11 = SDL_SCANCODE_F11 or SDLK_SCANCODE_MASK;
              SDLK_F12 = SDL_SCANCODE_F12 or SDLK_SCANCODE_MASK;

              SDLK_PRINTSCREEN = SDL_SCANCODE_PRINTSCREEN or SDLK_SCANCODE_MASK;
              SDLK_SCROLLLOCK = SDL_SCANCODE_SCROLLLOCK or SDLK_SCANCODE_MASK;
              SDLK_PAUSE = SDL_SCANCODE_PAUSE or SDLK_SCANCODE_MASK;
              SDLK_INSERT = SDL_SCANCODE_INSERT or SDLK_SCANCODE_MASK;
              SDLK_HOME = SDL_SCANCODE_HOME or SDLK_SCANCODE_MASK;
              SDLK_PAGEUP = SDL_SCANCODE_PAGEUP or SDLK_SCANCODE_MASK;
              SDLK_DELETE = SInt32(#127); // C: '\177'
              SDLK_END = SDL_SCANCODE_END or SDLK_SCANCODE_MASK;
              SDLK_PAGEDOWN = SDL_SCANCODE_PAGEDOWN or SDLK_SCANCODE_MASK;
              SDLK_RIGHT = SDL_SCANCODE_RIGHT or SDLK_SCANCODE_MASK;
              SDLK_LEFT = SDL_SCANCODE_LEFT or SDLK_SCANCODE_MASK;
              SDLK_DOWN = SDL_SCANCODE_DOWN or SDLK_SCANCODE_MASK;
              SDLK_UP = SDL_SCANCODE_UP or SDLK_SCANCODE_MASK;

              SDLK_NUMLOCKCLEAR = SDL_SCANCODE_NUMLOCKCLEAR or SDLK_SCANCODE_MASK;
              SDLK_KP_DIVIDE = SDL_SCANCODE_KP_DIVIDE or SDLK_SCANCODE_MASK;
              SDLK_KP_MULTIPLY = SDL_SCANCODE_KP_MULTIPLY or SDLK_SCANCODE_MASK;
              SDLK_KP_MINUS = SDL_SCANCODE_KP_MINUS or SDLK_SCANCODE_MASK;
              SDLK_KP_PLUS = SDL_SCANCODE_KP_PLUS or SDLK_SCANCODE_MASK;
              SDLK_KP_ENTER = SDL_SCANCODE_KP_ENTER or SDLK_SCANCODE_MASK;
              SDLK_KP_1 = SDL_SCANCODE_KP_1 or SDLK_SCANCODE_MASK;
              SDLK_KP_2 = SDL_SCANCODE_KP_2 or SDLK_SCANCODE_MASK;
              SDLK_KP_3 = SDL_SCANCODE_KP_3 or SDLK_SCANCODE_MASK;
              SDLK_KP_4 = SDL_SCANCODE_KP_4 or SDLK_SCANCODE_MASK;
              SDLK_KP_5 = SDL_SCANCODE_KP_5 or SDLK_SCANCODE_MASK;
              SDLK_KP_6 = SDL_SCANCODE_KP_6 or SDLK_SCANCODE_MASK;
              SDLK_KP_7 = SDL_SCANCODE_KP_7 or SDLK_SCANCODE_MASK;
              SDLK_KP_8 = SDL_SCANCODE_KP_8 or SDLK_SCANCODE_MASK;
              SDLK_KP_9 = SDL_SCANCODE_KP_9 or SDLK_SCANCODE_MASK;
              SDLK_KP_0 = SDL_SCANCODE_KP_0 or SDLK_SCANCODE_MASK;
              SDLK_KP_PERIOD = SDL_SCANCODE_KP_PERIOD or SDLK_SCANCODE_MASK;

              SDLK_APPLICATION = SDL_SCANCODE_APPLICATION or SDLK_SCANCODE_MASK;
              SDLK_POWER = SDL_SCANCODE_POWER or SDLK_SCANCODE_MASK;
              SDLK_KP_EQUALS = SDL_SCANCODE_KP_EQUALS or SDLK_SCANCODE_MASK;
              SDLK_F13 = SDL_SCANCODE_F13 or SDLK_SCANCODE_MASK;
              SDLK_F14 = SDL_SCANCODE_F14 or SDLK_SCANCODE_MASK;
              SDLK_F15 = SDL_SCANCODE_F15 or SDLK_SCANCODE_MASK;
              SDLK_F16 = SDL_SCANCODE_F16 or SDLK_SCANCODE_MASK;
              SDLK_F17 = SDL_SCANCODE_F17 or SDLK_SCANCODE_MASK;
              SDLK_F18 = SDL_SCANCODE_F18 or SDLK_SCANCODE_MASK;
              SDLK_F19 = SDL_SCANCODE_F19 or SDLK_SCANCODE_MASK;
              SDLK_F20 = SDL_SCANCODE_F20 or SDLK_SCANCODE_MASK;
              SDLK_F21 = SDL_SCANCODE_F21 or SDLK_SCANCODE_MASK;
              SDLK_F22 = SDL_SCANCODE_F22 or SDLK_SCANCODE_MASK;
              SDLK_F23 = SDL_SCANCODE_F23 or SDLK_SCANCODE_MASK;
              SDLK_F24 = SDL_SCANCODE_F24 or SDLK_SCANCODE_MASK;
              SDLK_EXECUTE = SDL_SCANCODE_EXECUTE or SDLK_SCANCODE_MASK;
              SDLK_HELP = SDL_SCANCODE_HELP or SDLK_SCANCODE_MASK;
              SDLK_MENU = SDL_SCANCODE_MENU or SDLK_SCANCODE_MASK;
              SDLK_SELECT = SDL_SCANCODE_SELECT or SDLK_SCANCODE_MASK;
              SDLK_STOP = SDL_SCANCODE_STOP or SDLK_SCANCODE_MASK;
              SDLK_AGAIN = SDL_SCANCODE_AGAIN or SDLK_SCANCODE_MASK;
              SDLK_UNDO = SDL_SCANCODE_UNDO or SDLK_SCANCODE_MASK;
              SDLK_CUT = SDL_SCANCODE_CUT or SDLK_SCANCODE_MASK;
              SDLK_COPY = SDL_SCANCODE_COPY or SDLK_SCANCODE_MASK;
              SDLK_PASTE = SDL_SCANCODE_PASTE or SDLK_SCANCODE_MASK;
              SDLK_FIND = SDL_SCANCODE_FIND or SDLK_SCANCODE_MASK;
              SDLK_MUTE = SDL_SCANCODE_MUTE or SDLK_SCANCODE_MASK;
              SDLK_VOLUMEUP = SDL_SCANCODE_VOLUMEUP or SDLK_SCANCODE_MASK;
              SDLK_VOLUMEDOWN = SDL_SCANCODE_VOLUMEDOWN or SDLK_SCANCODE_MASK;
              SDLK_KP_COMMA = SDL_SCANCODE_KP_COMMA or SDLK_SCANCODE_MASK;
              SDLK_KP_EQUALSAS400 = SDL_SCANCODE_KP_EQUALSAS400 or SDLK_SCANCODE_MASK;

              SDLK_ALTERASE = SDL_SCANCODE_ALTERASE or SDLK_SCANCODE_MASK;
              SDLK_SYSREQ = SDL_SCANCODE_SYSREQ or SDLK_SCANCODE_MASK;
              SDLK_CANCEL = SDL_SCANCODE_CANCEL or SDLK_SCANCODE_MASK;
              SDLK_CLEAR = SDL_SCANCODE_CLEAR or SDLK_SCANCODE_MASK;
              SDLK_PRIOR = SDL_SCANCODE_PRIOR or SDLK_SCANCODE_MASK;
              SDLK_RETURN2 = SDL_SCANCODE_RETURN2 or SDLK_SCANCODE_MASK;
              SDLK_SEPARATOR = SDL_SCANCODE_SEPARATOR or SDLK_SCANCODE_MASK;
              SDLK_OUT = SDL_SCANCODE_OUT or SDLK_SCANCODE_MASK;
              SDLK_OPER = SDL_SCANCODE_OPER or SDLK_SCANCODE_MASK;
              SDLK_CLEARAGAIN = SDL_SCANCODE_CLEARAGAIN or SDLK_SCANCODE_MASK;
              SDLK_CRSEL = SDL_SCANCODE_CRSEL or SDLK_SCANCODE_MASK;
              SDLK_EXSEL = SDL_SCANCODE_EXSEL or SDLK_SCANCODE_MASK;

              SDLK_KP_00 = SDL_SCANCODE_KP_00 or SDLK_SCANCODE_MASK;
              SDLK_KP_000 = SDL_SCANCODE_KP_000 or SDLK_SCANCODE_MASK;
              SDLK_THOUSANDSSEPARATOR = SDL_SCANCODE_THOUSANDSSEPARATOR or SDLK_SCANCODE_MASK;
              SDLK_DECIMALSEPARATOR = SDL_SCANCODE_DECIMALSEPARATOR or SDLK_SCANCODE_MASK;
              SDLK_CURRENCYUNIT = SDL_SCANCODE_CURRENCYUNIT or SDLK_SCANCODE_MASK;
              SDLK_CURRENCYSUBUNIT = SDL_SCANCODE_CURRENCYSUBUNIT or SDLK_SCANCODE_MASK;
              SDLK_KP_LEFTPAREN = SDL_SCANCODE_KP_LEFTPAREN or SDLK_SCANCODE_MASK;
              SDLK_KP_RIGHTPAREN = SDL_SCANCODE_KP_RIGHTPAREN or SDLK_SCANCODE_MASK;
              SDLK_KP_LEFTBRACE = SDL_SCANCODE_KP_LEFTBRACE or SDLK_SCANCODE_MASK;
              SDLK_KP_RIGHTBRACE = SDL_SCANCODE_KP_RIGHTBRACE or SDLK_SCANCODE_MASK;
              SDLK_KP_TAB = SDL_SCANCODE_KP_TAB or SDLK_SCANCODE_MASK;
              SDLK_KP_BACKSPACE = SDL_SCANCODE_KP_BACKSPACE or SDLK_SCANCODE_MASK;
              SDLK_KP_A = SDL_SCANCODE_KP_A or SDLK_SCANCODE_MASK;
              SDLK_KP_B = SDL_SCANCODE_KP_B or SDLK_SCANCODE_MASK;
              SDLK_KP_C = SDL_SCANCODE_KP_C or SDLK_SCANCODE_MASK;
              SDLK_KP_D = SDL_SCANCODE_KP_D or SDLK_SCANCODE_MASK;
              SDLK_KP_E = SDL_SCANCODE_KP_E or SDLK_SCANCODE_MASK;
              SDLK_KP_F = SDL_SCANCODE_KP_F or SDLK_SCANCODE_MASK;
              SDLK_KP_XOR = SDL_SCANCODE_KP_XOR or SDLK_SCANCODE_MASK;
              SDLK_KP_POWER = SDL_SCANCODE_KP_POWER or SDLK_SCANCODE_MASK;
              SDLK_KP_PERCENT = SDL_SCANCODE_KP_PERCENT or SDLK_SCANCODE_MASK;
              SDLK_KP_LESS = SDL_SCANCODE_KP_LESS or SDLK_SCANCODE_MASK;
              SDLK_KP_GREATER = SDL_SCANCODE_KP_GREATER or SDLK_SCANCODE_MASK;
              SDLK_KP_AMPERSAND = SDL_SCANCODE_KP_AMPERSAND or SDLK_SCANCODE_MASK;
              SDLK_KP_DBLAMPERSAND = SDL_SCANCODE_KP_DBLAMPERSAND or SDLK_SCANCODE_MASK;
              SDLK_KP_VERTICALBAR = SDL_SCANCODE_KP_VERTICALBAR or SDLK_SCANCODE_MASK;
              SDLK_KP_DBLVERTICALBAR = SDL_SCANCODE_KP_DBLVERTICALBAR or SDLK_SCANCODE_MASK;
              SDLK_KP_COLON = SDL_SCANCODE_KP_COLON or SDLK_SCANCODE_MASK;
              SDLK_KP_HASH = SDL_SCANCODE_KP_HASH or SDLK_SCANCODE_MASK;
              SDLK_KP_SPACE = SDL_SCANCODE_KP_SPACE or SDLK_SCANCODE_MASK;
              SDLK_KP_AT = SDL_SCANCODE_KP_AT or SDLK_SCANCODE_MASK;
              SDLK_KP_EXCLAM = SDL_SCANCODE_KP_EXCLAM or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMSTORE = SDL_SCANCODE_KP_MEMSTORE or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMRECALL = SDL_SCANCODE_KP_MEMRECALL or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMCLEAR = SDL_SCANCODE_KP_MEMCLEAR or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMADD = SDL_SCANCODE_KP_MEMADD or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMSUBTRACT = SDL_SCANCODE_KP_MEMSUBTRACT or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMMULTIPLY = SDL_SCANCODE_KP_MEMMULTIPLY or SDLK_SCANCODE_MASK;
              SDLK_KP_MEMDIVIDE = SDL_SCANCODE_KP_MEMDIVIDE or SDLK_SCANCODE_MASK;
              SDLK_KP_PLUSMINUS = SDL_SCANCODE_KP_PLUSMINUS or SDLK_SCANCODE_MASK;
              SDLK_KP_CLEAR = SDL_SCANCODE_KP_CLEAR or SDLK_SCANCODE_MASK;
              SDLK_KP_CLEARENTRY = SDL_SCANCODE_KP_CLEARENTRY or SDLK_SCANCODE_MASK;
              SDLK_KP_BINARY = SDL_SCANCODE_KP_BINARY or SDLK_SCANCODE_MASK;
              SDLK_KP_OCTAL = SDL_SCANCODE_KP_OCTAL or SDLK_SCANCODE_MASK;
              SDLK_KP_DECIMAL = SDL_SCANCODE_KP_DECIMAL or SDLK_SCANCODE_MASK;
              SDLK_KP_HEXADECIMAL = SDL_SCANCODE_KP_HEXADECIMAL or SDLK_SCANCODE_MASK;

              SDLK_LCTRL = SDL_SCANCODE_LCTRL or SDLK_SCANCODE_MASK;
              SDLK_LSHIFT = SDL_SCANCODE_LSHIFT or SDLK_SCANCODE_MASK;
              SDLK_LALT = SDL_SCANCODE_LALT or SDLK_SCANCODE_MASK;
              SDLK_LGUI = SDL_SCANCODE_LGUI or SDLK_SCANCODE_MASK;
              SDLK_RCTRL = SDL_SCANCODE_RCTRL or SDLK_SCANCODE_MASK;
              SDLK_RSHIFT = SDL_SCANCODE_RSHIFT or SDLK_SCANCODE_MASK;
              SDLK_RALT = SDL_SCANCODE_RALT or SDLK_SCANCODE_MASK;
              SDLK_RGUI = SDL_SCANCODE_RGUI or SDLK_SCANCODE_MASK;

              SDLK_MODE = SDL_SCANCODE_MODE or SDLK_SCANCODE_MASK;

              SDLK_AUDIONEXT = SDL_SCANCODE_AUDIONEXT or SDLK_SCANCODE_MASK;
              SDLK_AUDIOPREV = SDL_SCANCODE_AUDIOPREV or SDLK_SCANCODE_MASK;
              SDLK_AUDIOSTOP = SDL_SCANCODE_AUDIOSTOP or SDLK_SCANCODE_MASK;
              SDLK_AUDIOPLAY = SDL_SCANCODE_AUDIOPLAY or SDLK_SCANCODE_MASK;
              SDLK_AUDIOMUTE = SDL_SCANCODE_AUDIOMUTE or SDLK_SCANCODE_MASK;
              SDLK_MEDIASELECT = SDL_SCANCODE_MEDIASELECT or SDLK_SCANCODE_MASK;
              SDLK_WWW = SDL_SCANCODE_WWW or SDLK_SCANCODE_MASK;
              SDLK_MAIL = SDL_SCANCODE_MAIL or SDLK_SCANCODE_MASK;
              SDLK_CALCULATOR = SDL_SCANCODE_CALCULATOR or SDLK_SCANCODE_MASK;
              SDLK_COMPUTER = SDL_SCANCODE_COMPUTER or SDLK_SCANCODE_MASK;
              SDLK_AC_SEARCH = SDL_SCANCODE_AC_SEARCH or SDLK_SCANCODE_MASK;
              SDLK_AC_HOME = SDL_SCANCODE_AC_HOME or SDLK_SCANCODE_MASK;
              SDLK_AC_BACK = SDL_SCANCODE_AC_BACK or SDLK_SCANCODE_MASK;
              SDLK_AC_FORWARD = SDL_SCANCODE_AC_FORWARD or SDLK_SCANCODE_MASK;
              SDLK_AC_STOP = SDL_SCANCODE_AC_STOP or SDLK_SCANCODE_MASK;
              SDLK_AC_REFRESH = SDL_SCANCODE_AC_REFRESH or SDLK_SCANCODE_MASK;
              SDLK_AC_BOOKMARKS = SDL_SCANCODE_AC_BOOKMARKS or SDLK_SCANCODE_MASK;

              SDLK_BRIGHTNESSDOWN = SDL_SCANCODE_BRIGHTNESSDOWN or SDLK_SCANCODE_MASK;
              SDLK_BRIGHTNESSUP = SDL_SCANCODE_BRIGHTNESSUP or SDLK_SCANCODE_MASK;
              SDLK_DISPLAYSWITCH = SDL_SCANCODE_DISPLAYSWITCH or SDLK_SCANCODE_MASK;
              SDLK_KBDILLUMTOGGLE = SDL_SCANCODE_KBDILLUMTOGGLE or SDLK_SCANCODE_MASK;
              SDLK_KBDILLUMDOWN = SDL_SCANCODE_KBDILLUMDOWN or SDLK_SCANCODE_MASK;
              SDLK_KBDILLUMUP = SDL_SCANCODE_KBDILLUMUP or SDLK_SCANCODE_MASK;
              SDLK_EJECT = SDL_SCANCODE_EJECT or SDLK_SCANCODE_MASK;
              SDLK_SLEEP = SDL_SCANCODE_SLEEP or SDLK_SCANCODE_MASK;


              KMOD_NONE = $0000;
              KMOD_LSHIFT = $0001;
              KMOD_RSHIFT = $0002;
              KMOD_LCTRL = $0040;
              KMOD_RCTRL = $0080;
              KMOD_LALT = $0100;
              KMOD_RALT = $0200;
              KMOD_LGUI = $0400;
              KMOD_RGUI = $0800;
              KMOD_NUM = $1000;
              KMOD_CAPS = $2000;
              KMOD_MODE = $4000;
              KMOD_RESERVED = $8000;

              KMOD_CTRL  = KMOD_LCTRL  or KMOD_RCTRL;
              KMOD_SHIFT = KMOD_LSHIFT or KMOD_RSHIFT;
              KMOD_ALT   = KMOD_LALT   or KMOD_RALT;
              KMOD_GUI   = KMOD_LGUI   or KMOD_RGUI;


            type
              PSDL_KeyMod = ^TSDL_KeyMod;
              TSDL_KeyMod = Word;


//----------- sdl_keyboard.h -------------------

             type
                PKeyStateArr = ^TKeyStateArr;
                TKeyStateArr = array[0..65000] of UInt8;

                PSDL_Keysym = ^TSDL_Keysym;
                TSDL_Keysym = record
                  scancode: TSDL_ScanCode;      // SDL physical key code - see SDL_Scancode for details
                  sym: TSDL_KeyCode;            // SDL virtual key code - see SDL_Keycode for details
                  _mod: UInt16;                 // current key modifiers
                  unicode: UInt32;              // (deprecated) use SDL_TextInputEvent instead
                end;

  TTSDL_GetKeyboardFocus= function: PSDL_Window; cdecl;
  TTSDL_GetKeyboardState= function (numkeys: PInt): PUInt8; cdecl;
  TTSDL_GetModState= function: TSDL_KeyMod; cdecl;
  TTSDL_SetModState= procedure(modstate: TSDL_KeyMod); cdecl;
  TTSDL_GetKeyFromScancode= function(scancode: TSDL_ScanCode): TSDL_KeyCode; cdecl;
  TTSDL_GetScancodeFromKey= function(key: TSDL_KeyCode): TSDL_ScanCode; cdecl;
  TTSDL_GetScancodeName= function(scancode: TSDL_ScanCode): PAnsiChar; cdecl;
  TTSDL_GetScancodeFromName= function(const name: PAnsiChar): TSDL_ScanCode; cdecl;
  TTSDL_GetKeyName= function(key: TSDL_KeyCode): PAnsiChar; cdecl;
  TTSDL_GetKeyFromName= function(const name: PAnsiChar): TSDL_KeyCode; cdecl;
  TTSDL_StartTextInput= procedure; cdecl;
  TTSDL_IsTextInputActive= function: TSDL_Bool; cdecl;
  TTSDL_StopTextInput= procedure; cdecl;
  TTSDL_SetTextInputRect= procedure(rect: PSDL_Rect); cdecl;
  TTSDL_HasScreenKeyboardSupport= function: TSDL_Bool; cdecl;
  TTSDL_IsScreenKeyboardShown= function (window: PSDL_Window): TSDL_Bool; cdecl;


//----------- sdl_mouse.h -------------------

                const
                  SDL_SYSTEM_CURSOR_ARROW = 0;     // Arrow
                  SDL_SYSTEM_CURSOR_IBEAM = 1;     // I-beam
                  SDL_SYSTEM_CURSOR_WAIT = 2;      // Wait
                  SDL_SYSTEM_CURSOR_CROSSHAIR = 3; // Crosshair
                  SDL_SYSTEM_CURSOR_WAITARROW = 4; // Small wait cursor (or Wait if not available)
                  SDL_SYSTEM_CURSOR_SIZENWSE = 5;  // Double arrow pointing northwest and southeast
                  SDL_SYSTEM_CURSOR_SIZENESW = 6;  // Double arrow pointing northeast and southwest
                  SDL_SYSTEM_CURSOR_SIZEWE = 7;    // Double arrow pointing west and east
                  SDL_SYSTEM_CURSOR_SIZENS = 8;    // Double arrow pointing north and south
                  SDL_SYSTEM_CURSOR_SIZEALL = 9;   // Four pointed arrow pointing north, south, east, and west
                  SDL_SYSTEM_CURSOR_NO = 10;        // Slashed circle or crossbones
                  SDL_SYSTEM_CURSOR_HAND = 11;      // Hand
                  SDL_NUM_SYSTEM_CURSORS = 12;

                  SDL_BUTTON_LEFT = 1;
                  SDL_BUTTON_MIDDLE = 2;
                  SDL_BUTTON_RIGHT  = 3;
                  SDL_BUTTON_X1     = 4;
                  SDL_BUTTON_X2     = 5;
                  SDL_BUTTON_LMASK  = 1 shl ((SDL_BUTTON_LEFT) - 1);
                  SDL_BUTTON_MMASK  = 1 shl ((SDL_BUTTON_MIDDLE) - 1);
                  SDL_BUTTON_RMASK  = 1 shl ((SDL_BUTTON_RIGHT) - 1);
                  SDL_BUTTON_X1MASK = 1 shl ((SDL_BUTTON_X1) - 1);
                  SDL_BUTTON_X2MASK = 1 shl ((SDL_BUTTON_X2) - 1);

                type
                  PSDL_Cursor = Pointer;
                  PSDL_SystemCursor = ^TSDL_SystemCursor;
                  TSDL_SystemCursor = Word;

  TTSDL_GetMouseFocus= function: PSDL_Window; cdecl;
  TTSDL_GetMouseState= function(x: PInt; y: PInt): UInt32; cdecl;
  TTSDL_GetGlobalMouseState= function(x, y: PSInt32): UInt32; cdecl;
  TTSDL_GetRelativeMouseState= function(x: PInt; y: PInt): UInt32; cdecl;
  TTSDL_WarpMouseInWindow= procedure(window: PSDL_Window; x: SInt32; y: SInt32); cdecl;
  TTSDL_WarpMouseGlobal= Function(x, y: SInt32): SInt32; cdecl;
  TTSDL_SetRelativeMouseMode= function(enabled: TSDL_Bool): SInt32; cdecl;
  TTSDL_CaptureMouse= function(enabled: TSDL_Bool): SInt32; cdecl;
  TTSDL_GetRelativeMouseMode= function: TSDL_Bool; cdecl;
  TTSDL_CreateCursor= function(const data: PUInt8; const mask: PUInt8; w: SInt32; h: SInt32; hot_x: SInt32; hot_y: SInt32): PSDL_Cursor; cdecl;
  TTSDL_CreateColorCursor= function(surface: PSDL_Surface; hot_x: SInt32; hot_y: SInt32): PSDL_Cursor; cdecl;
  TTSDL_CreateSystemCursor= function(id: TSDL_SystemCursor): PSDL_Cursor; cdecl;
  TTSDL_SetCursor= procedure(cursor: PSDL_Cursor); cdecl;
  TTSDL_GetCursor= function: PSDL_Cursor; cdecl;
  TTSDL_GetDefaultCursor= function: PSDL_Cursor; cdecl;
  TTSDL_FreeCursor= procedure(cursor: PSDL_Cursor); cdecl;
  TTSDL_ShowCursor= function(toggle: SInt32): SInt32; cdecl;

  function SDL_Button(button: SInt32): SInt32;


//----------- sdl_joystick.h ------------------------------

                  const
                    SDL_HAT_CENTERED  = $00;
                    SDL_HAT_UP        = $01;
                    SDL_HAT_RIGHT     = $02;
                    SDL_HAT_DOWN      = $04;
                    SDL_HAT_LEFT      = $08;
                    SDL_HAT_RIGHTUP   = SDL_HAT_RIGHT or SDL_HAT_UP;
                    SDL_HAT_RIGHTDOWN = SDL_HAT_RIGHT or SDL_HAT_DOWN;
                    SDL_HAT_LEFTUP    = SDL_HAT_LEFT or SDL_HAT_UP;
                    SDL_HAT_LEFTDOWN  = SDL_HAT_LEFT or SDL_HAT_DOWN;

                  type

                    PSDL_Joystick = Pointer;

                    TSDL_JoystickGUID = record
                      data: array[0..15] of UInt8;
                    end;

                    TSDL_JoystickID = SInt32;

                    TSDL_JoystickPowerLevel = (
                      SDL_JOYSTICK_POWER_UNKNOWN = -1,
                      SDL_JOYSTICK_POWER_EMPTY,
                      SDL_JOYSTICK_POWER_LOW,
                      SDL_JOYSTICK_POWER_MEDIUM,
                      SDL_JOYSTICK_POWER_FULL,
                      SDL_JOYSTICK_POWER_WIRED,
                      SDL_JOYSTICK_POWER_MAX
                    );

  TTSDL_NumJoysticks=function: SInt32; cdecl;
  TTSDL_JoystickNameForIndex=function(device_index: SInt32): PAnsiChar; cdecl;
  TTSDL_JoystickOpen=function(device_index: SInt32): PSDL_Joystick; cdecl;
  TTSDL_JoystickFromInstanceID=function(joyid: TSDL_JoystickID): PSDL_Joystick; cdecl;
  TTSDL_JoystickName=function(joystick: PSDL_Joystick): PAnsiChar; cdecl;
  TTSDL_JoystickGetDeviceGUID=function(device_index: SInt32): TSDL_JoystickGUID; cdecl;
  TTSDL_JoystickGetGUID=function(joystick: PSDL_Joystick): TSDL_JoystickGUID; cdecl;
  TTSDL_JoystickGetGUIDString=procedure(guid: TSDL_JoystickGUID; pszGUID: PAnsiChar; cbGUID: SInt32); cdecl;
  TTSDL_JoystickGetGUIDFromString=function(const pchGUID: PAnsiChar): TSDL_JoystickGUID; cdecl;
  TTSDL_JoystickGetAttached=function(joystick: PSDL_Joystick): TSDL_Bool; cdecl;
  TTSDL_JoystickInstanceID=function(joystick: PSDL_Joystick): TSDL_JoystickID; cdecl;
  TTSDL_JoystickNumAxes=function(joystick: PSDL_Joystick): SInt32; cdecl;
  TTSDL_JoystickNumBalls=function(joystick: PSDL_Joystick): SInt32; cdecl;
  TTSDL_JoystickNumHats=function(joystick: PSDL_Joystick): SInt32; cdecl;
  TTSDL_JoystickNumButtons=function(joystick: PSDL_Joystick): SInt32; cdecl;
  TTSDL_JoystickUpdate=procedure; cdecl;
  TTSDL_JoystickEventState=function(state: SInt32): SInt32; cdecl;
  TTSDL_JoystickGetAxis=function(joystick: PSDL_Joystick; axis: SInt32): SInt16; cdecl;
  TTSDL_JoystickGetHat=function(joystick: PSDL_Joystick; hat: SInt32): UInt8; cdecl;
  TTSDL_JoystickGetBall=function(joystick: PSDL_Joystick; ball: SInt32; dx: PInt; dy: PInt): SInt32; cdecl;
  TTSDL_JoystickGetButton=function(joystick: PSDL_Joystick; button: SInt32): UInt8; cdecl;
  TTSDL_JoystickClose=procedure(joystick: PSDL_Joystick); cdecl;
  TTSDL_JoystickCurrentPowerLevel=function(joystick: PSDL_Joystick): TSDL_JoystickPowerLevel; cdecl;


//-------------- sdl_gamecontroller.h ----------------------------

                  const
                    SDL_CONTROLLER_AXIS_INVALID = -1;
                    SDL_CONTROLLER_AXIS_LEFTX = 0;
                    SDL_CONTROLLER_AXIS_LEFTY = 1;
                    SDL_CONTROLLER_AXIS_RIGHTX = 2;
                    SDL_CONTROLLER_AXIS_RIGHTY = 3;
                    SDL_CONTROLLER_AXIS_TRIGGERLEFT = 4;
                    SDL_CONTROLLER_AXIS_TRIGGERRIGHT = 5;
                    SDL_CONTROLLER_AXIS_MAX = 6;

                    SDL_CONTROLLER_BUTTON_INVALID = -1;
                    SDL_CONTROLLER_BUTTON_A = 0;
                    SDL_CONTROLLER_BUTTON_B = 1;
                    SDL_CONTROLLER_BUTTON_X = 2;
                    SDL_CONTROLLER_BUTTON_Y = 3;
                    SDL_CONTROLLER_BUTTON_BACK = 4;
                    SDL_CONTROLLER_BUTTON_GUIDE = 5;
                    SDL_CONTROLLER_BUTTON_START = 6;
                    SDL_CONTROLLER_BUTTON_LEFTSTICK = 7;
                    SDL_CONTROLLER_BUTTON_RIGHTSTICK = 8;
                    SDL_CONTROLLER_BUTTON_LEFTSHOULDER = 9;
                    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER = 10;
                    SDL_CONTROLLER_BUTTON_DPAD_UP = 11;
                    SDL_CONTROLLER_BUTTON_DPAD_DOWN = 12;
                    SDL_CONTROLLER_BUTTON_DPAD_LEFT = 13;
                    SDL_CONTROLLER_BUTTON_DPAD_RIGHT = 14;
                    SDL_CONTROLLER_BUTTON_MAX = 15;

                  type
                    TSDL_GameControllerButton = Byte;
                    TSDL_GameControllerAxis = Byte;


                    PSDL_GameController = ^TSDL_GameController;
                    TSDL_GameController = Pointer;

                    TSDL_GameControllerBindType = (SDL_CONTROLLER_BINDTYPE_NONE,
                                                   SDL_CONTROLLER_BINDTYPE_BUTTON,
                                                   SDL_CONTROLLER_BINDTYPE_AXIS,
                                                   SDL_CONTROLLER_BINDTYPE_HAT);

                    THat = record
                      hat: Integer;
                      hat_mask: Integer;
                    end;

                    TSDL_GameControllerButtonBind = record
                      bindType: TSDL_GameControllerBindType;
                      case Integer of
                        0: ( button: Integer; );
                        1: ( axis: Integer; );
                        2: ( hat: THat; );
                    end;



  TTSDL_GameControllerAddMapping=function( mappingString: PAnsiChar ): Integer; cdecl;
  TTSDL_GameControllerAddMappingsFromRW=function(rw: PSDL_RWops; freerw: SInt32):SInt32; cdecl;
  TTSDL_GameControllerMappingForGUID=function( guid: TSDL_JoystickGUID ): PAnsiChar; cdecl;
  TTSDL_GameControllerMapping=function( gamecontroller: PSDL_GameController ): PAnsiChar; cdecl;
  TTSDL_IsGameController=function(joystick_index: Integer): TSDL_Bool; cdecl;
  TTSDL_GameControllerNameForIndex=function(joystick_index: Integer): PAnsiChar; cdecl;
  TTSDL_GameControllerOpen=function(joystick_index: Integer): PSDL_GameController; cdecl;
  TTSDL_GameControllerFromInstanceID=function(joyid: TSDL_JoystickID): PSDL_GameController; cdecl;
  TTSDL_GameControllerName=function(gamecontroller: PSDL_GameController): PAnsiChar; cdecl;
  TTSDL_GameControllerGetAttached=function(gamecontroller: PSDL_GameController): TSDL_Bool; cdecl;
  TTSDL_GameControllerGetJoystick=function(gamecontroller: PSDL_GameController): PSDL_Joystick; cdecl;
  TTSDL_GameControllerEventState=function(state: Integer): Integer; cdecl;
  TTSDL_GameControllerUpdate=procedure(); cdecl;
  TTSDL_GameControllerGetAxisFromString=function(pchString: PAnsiChar): TSDL_GameControllerAxis; cdecl;
  TTSDL_GameControllerGetStringForAxis=function(axis: TSDL_GameControllerAxis): PAnsiChar; cdecl;
  TTSDL_GameControllerGetBindForAxis=function(gamecontroller: PSDL_GameController; axis: TSDL_GameControllerAxis): TSDL_GameControllerButtonBind; cdecl;
  TTSDL_GameControllerGetAxis=function(gamecontroller: PSDL_GameController; axis: TSDL_GameControllerAxis): SInt16; cdecl;
  TTSDL_GameControllerGetButtonFromString=function(pchString: PAnsiChar): TSDL_GameControllerButton; cdecl;
  TTSDL_GameControllerGetStringForButton=function(button: TSDL_GameControllerButton): PAnsiChar; cdecl;
  TTSDL_GameControllerGetBindForButton=function(gamecontroller: PSDL_GameController; button: TSDL_GameControllerButton): TSDL_GameControllerButtonBind; cdecl;
  TTSDL_GameControllerGetButton=function(gamecontroller: PSDL_GameController; button: TSDL_GameControllerButton): UInt8; cdecl;
  TTSDL_GameControllerClose=procedure(gamecontroller: PSDL_GameController); cdecl;


  function SDL_GameControllerAddMappingsFromFile(Const FilePath:PAnsiChar):SInt32;


//----------- sdl_haptic.h -------------------

                  const
                    SDL_HAPTIC_CONSTANT = (1 shl 0);
                    SDL_HAPTIC_SINE     = (1 shl 1);
                    SDL_HAPTIC_SQUARE   = (1 shl 2);
                    SDL_HAPTIC_TRIANGLE = (1 shl 3);
                    SDL_HAPTIC_SAWTOOTHUP = (1 shl 4);
                    SDL_HAPTIC_SAWTOOTHDOWN = (1 shl 5);
                    SDL_HAPTIC_RAMP = (1 shl 6);
                    SDL_HAPTIC_SPRING = (1 shl 7);
                    SDL_HAPTIC_DAMPER = (1 shl 8);
                    SDL_HAPTIC_INERTIA = (1 shl 9);
                    SDL_HAPTIC_FRICTION = (1 shl 10);
                    SDL_HAPTIC_CUSTOM = (1 shl 11);
                    SDL_HAPTIC_GAIN = (1 shl 12);
                    SDL_HAPTIC_AUTOCENTER = (1 shl 13);
                    SDL_HAPTIC_STATUS = (1 shl 14);
                    SDL_HAPTIC_PAUSE = (1 shl 15);
                    SDL_HAPTIC_POLAR = 0;
                    SDL_HAPTIC_CARTESIAN = 1;
                    SDL_HAPTIC_SPHERICAL = 2;
                    SDL_HAPTIC_INFINITY = 4294967295;

                  type
                    PSDL_Haptic = ^TSDL_Haptic;
                    TSDL_Haptic = record end;

                    TSDL_HapticDirection = record
                      _type: UInt8;               {**< The type of encoding. *}
                      dir: array[0..2] of SInt32; {**< The encoded direction. *}
                    end;

                    TSDL_HapticConstant = record
                      _type: UInt16;                   {**< SDL_HAPTIC_CONSTANT *}
                      direction: TSDL_HapticDirection; {**< Direction of the effect. *}
                      length: UInt32;          {**< Duration of the effect. *}
                      delay: UInt16;           {**< Delay before starting the effect. *}
                      button: UInt16;          {**< Button that triggers the effect. *}
                      interval: UInt16;        {**< How soon it can be triggered again after button. *}
                      level: SInt16;           {**< Strength of the constant effect. *}
                      attack_length: UInt16;   {**< Duration of the attack. *}
                      attack_level: UInt16;    {**< Level at the start of the attack. *}
                      fade_length: UInt16;     {**< Duration of the fade. *}
                      fade_level: UInt16;      {**< Level at the end of the fade. *}
                    end;

                    TSDL_HapticPeriodic = record
                      _type: UInt16;        {**< SDL_HAPTIC_SINE, SDL_HAPTIC_SQUARE,
                                                 SDL_HAPTIC_TRIANGLE, SDL_HAPTIC_SAWTOOTHUP or
                                                 SDL_HAPTIC_SAWTOOTHDOWN *}
                      direction: TSDL_HapticDirection;  {**< Direction of the effect. *}
                      length: UInt32;          {**< Duration of the effect. *}
                      delay: UInt16;           {**< Delay before starting the effect. *}
                      button: UInt16;          {**< Button that triggers the effect. *}
                      interval: UInt16;        {**< How soon it can be triggered again after button. *}
                      period: UInt16;          {**< Period of the wave. *}
                      magnitude: SInt16;       {**< Peak value. *}
                      offset: SInt16;          {**< Mean value of the wave. *}
                      phase: UInt16;           {**< Horizontal shift given by hundredth of a cycle. *}
                      attack_length: UInt16;   {**< Duration of the attack. *}
                      attack_level: UInt16;    {**< Level at the start of the attack. *}
                      fade_length: UInt16;     {**< Duration of the fade. *}
                      fade_level: UInt16;      {**< Level at the end of the fade. *}
                    end;

                    TSDL_HapticCondition = record
                      _type: UInt16;                    {**< SDL_HAPTIC_SPRING, SDL_HAPTIC_DAMPER,SDL_HAPTIC_INERTIA or SDL_HAPTIC_FRICTION *}
                      direction: TSDL_HapticDirection;  {**< Direction of the effect - Not used ATM. *}
                      length: UInt32;                   {**< Duration of the effect. *}
                      delay: UInt16;                    {**< Delay before starting the effect. *}
                      button: UInt16;                   {**< Button that triggers the effect. *}
                      interval: UInt16;                 {**< How soon it can be triggered again after button. *}
                      right_sat: array[0..2] of UInt16; {**< Level when joystick is to the positive side. *}
                      left_sat: array[0..2] of UInt16;  {**< Level when joystick is to the negative side. *}
                      right_coeff: array[0..2] of SInt16;  {**< How fast to increase the force towards the positive side. *}
                      left_coeff: array[0..2] of SInt16;   {**< How fast to increase the force towards the negative side. *}
                      deadband: array[0..2] of UInt16;     {**< Size of the dead zone. *}
                      center: array[0..2] of SInt16;       {**< Position of the dead zone. *}
                    end;

                    TSDL_HapticRamp = record
                      _type: UInt16;                    {**< SDL_HAPTIC_RAMP *}
                      direction: TSDL_HapticDirection;  {**< Direction of the effect. *}
                      length: UInt32;                   {**< Duration of the effect. *}
                      delay: UInt16;                    {**< Delay before starting the effect. *}
                      button: UInt16;                   {**< Button that triggers the effect. *}
                      interval: UInt16;                 {**< How soon it can be triggered again after button. *}
                      start: SInt16;                    {**< Beginning strength level. *}
                      _end: SInt16;                     {**< Ending strength level. *}
                      attack_length: UInt16;            {**< Duration of the attack. *}
                      attack_level: UInt16;             {**< Level at the start of the attack. *}
                      fade_length: UInt16;              {**< Duration of the fade. *}
                      fade_level: UInt16;               {**< Level at the end of the fade. *}
                    end;

                    TSDL_HapticCustom = record
                      _type: UInt16;                    {**< SDL_HAPTIC_CUSTOM *}
                      direction: TSDL_HapticDirection;  {**< Direction of the effect. *}
                      length: UInt32;                   {**< Duration of the effect. *}
                      delay: UInt16;                    {**< Delay before starting the effect. *}
                      button: UInt16;                   {**< Button that triggers the effect. *}
                      interval: UInt16;                 {**< How soon it can be triggered again after button. *}
                      channels: UInt8;                  {**< Axes to use, minimum of one. *}
                      period: UInt16;                   {**< Sample periods. *}
                      samples: UInt16;                  {**< Amount of samples. *}
                      data: PUInt16;                    {**< Should contain channels*samples items. *}
                      attack_length: UInt16;            {**< Duration of the attack. *}
                      attack_level: UInt16;             {**< Level at the start of the attack. *}
                      fade_length: UInt16;              {**< Duration of the fade. *}
                      fade_level: UInt16;               {**< Level at the end of the fade. *}
                    end;

                    PSDL_HapticEffect = ^TSDL_HapticEffect;
                    TSDL_HapticEffect = record
                      _type: UInt16;                  {**< Effect type. *}
                      case UInt16 of
                        0: (constant: TSDL_HapticConstant;);    {**< Constant effect. *}
                        1: (periodic: TSDL_HapticPeriodic;);    {**< Periodic effect. *}
                        2: (condition: TSDL_HapticCondition;);  {**< Condition effect. *}
                        3: (ramp: TSDL_HapticRamp;);            {**< Ramp effect. *}
                        4: (custom: TSDL_HapticCustom;);        {**< Custom effect. *}
                    end;


  TTSDL_NumHaptics=function: Integer; cdecl;
  TTSDL_HapticName=function(device_index: Integer): PAnsiChar; cdecl;
  TTSDL_HapticOpen=function(device_index: Integer): PSDL_Haptic; cdecl;
  TTSDL_HapticOpened=function(device_index: Integer): Integer; cdecl;
  TTSDL_HapticIndex=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_MouseIsHaptic=function: Integer; cdecl;
  TTSDL_HapticOpenFromMouse=function: PSDL_Haptic; cdecl;
  TTSDL_JoystickIsHaptic=function(joystick: PSDL_Joystick): Integer; cdecl;
  TTSDL_HapticOpenFromJoystick=function(joystick: PSDL_Joystick): PSDL_Haptic; cdecl;
  TTSDL_HapticClose=procedure(haptic: PSDL_Haptic); cdecl;
  TTSDL_HapticNumEffects=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticNumEffectsPlaying=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticQuery=function(haptic: PSDL_Haptic): UInt32; cdecl;
  TTSDL_HapticNumAxes=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticEffectSupported=function(haptic: PSDL_Haptic; effect: PSDL_HapticEffect): Integer; cdecl;
  TTSDL_HapticNewEffect=function(haptic: PSDL_Haptic; effect: PSDL_HapticEffect): Integer; cdecl;
  TTSDL_HapticUpdateEffect=function(haptic: PSDL_Haptic; effect: Integer; data: PSDL_HapticEffect): Integer; cdecl;
  TTSDL_HapticRunEffect=function(haptic: PSDL_Haptic; effect: Integer; iterations: UInt32): Integer; cdecl;
  TTSDL_HapticStopEffect=function(haptic: PSDL_Haptic; effect: Integer): Integer; cdecl;
  TTSDL_HapticDestroyEffect=procedure(haptic: PSDL_Haptic; effect: Integer); cdecl;
  TTSDL_HapticGetEffectStatus=function(haptic: PSDL_Haptic; effect: Integer): Integer; cdecl;
  TTSDL_HapticSetGain=function(haptic: PSDL_Haptic; gain: Integer): Integer; cdecl;
  TTSDL_HapticSetAutocenter=function(haptic: PSDL_Haptic; autocenter: Integer): Integer; cdecl;
  TTSDL_HapticPause=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticUnpause=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticStopAll=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticRumbleSupported=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticRumbleInit=function(haptic: PSDL_Haptic): Integer; cdecl;
  TTSDL_HapticRumblePlay=function(haptic: PSDL_Haptic; strength: Float; length: UInt32): Integer; cdecl;
  TTSDL_HapticRumbleStop=function(haptic: PSDL_Haptic): Integer; cdecl;



//----------- sdl_touch.h -------------------

                  const
                    SDL_TOUCH_MOUSEID = UInt32(-1);

                  type
                    PSDL_TouchID  = ^TSDL_TouchID;
                    TSDL_TouchID  = SInt64;

                    PSDL_FingerID = ^TSDL_FingerID;
                    TSDL_FingerID = SInt64;

                    PSDL_Finger = ^TSDL_Finger;
                    TSDL_Finger = record
                      id: TSDL_FingerID;
                      x: Float;
                      y: Float;
                      pressure: Float;
                    end;


 TTSDL_GetNumTouchDevices=function: SInt32; cdecl;
 TTSDL_GetTouchDevice=function(index: SInt32): TSDL_TouchID; cdecl;
 TTSDL_GetNumTouchFingers=function(touchID: TSDL_TouchID): SInt32; cdecl;
 TTSDL_GetTouchFinger=function(touchID: TSDL_TouchID; index: SInt32): PSDL_Finger; cdecl;


//----------- sdl_gesture.h -------------------

    type
      TSDL_GestureID = SInt64;

 TTSDL_RecordGesture=function(touchId: TSDL_TouchID): SInt32; cdecl;
 TTSDL_SaveAllDollarTemplates=function(src: PSDL_RWops): SInt32; cdecl;
 TTSDL_SaveDollarTemplate=function(gestureId: TSDL_GestureID; src: PSDL_RWops): SInt32; cdecl;
 TTSDL_LoadDollarTemplates=function(touchId: TSDL_TouchID; src: PSDL_RWops): SInt32; cdecl;


//------------ from sdl_syswm.h ----------------

                  {$IFDEF WINDOWS}
                     {$DEFINE SDL_VIDEO_DRIVER_WINDOWS}
                  {$ENDIF}

                  {$IF DEFINED (LINUX) OR DEFINED(UNIX) AND NOT DEFINED(ANDROID)}
                     {$DEFINE SDL_VIDEO_DRIVER_X11}
                  {$IFEND}

                  {$IFDEF DARWIN}
                     {$DEFINE SDL_VIDEO_DRIVER_COCOA}
                  {$ENDIF}

                  {$IFDEF ANDROID}
                     {$DEFINE SDL_VIDEO_DRIVER_ANDROID}
                  {$ENDIF}

                  {$IFDEF VIVANTE}
                    {$DEFINE SDL_VIDEO_DRIVER_VIVANTE}
                  {$ENDIF}

                  Type
                     TSDL_SYSWM_TYPE = (
                        SDL_SYSWM_UNKNOWN,
                        SDL_SYSWM_WINDOWS,
                        SDL_SYSWM_X11,
                        SDL_SYSWM_DIRECTFB,
                        SDL_SYSWM_COCOA,
                        SDL_SYSWM_UIKIT,
                        SDL_SYSWM_WAYLAND, // Since SDL 2.0.2
                        SDL_SYSWM_MIR,     // Since SDL 2.0.2
                        SDL_SYSWM_WINRT,   // Since SDL 2.0.3
                        SDL_SYSWM_ANDROID, // Since SDL 2.0.4
                        SDL_SYSWM_VIVANTE  // Since SDL 2.0.5
                     );

                  {$IFDEF SDL_VIDEO_DRIVER_WINDOWS}
                     __SYSWM_WINDOWS = record
                        hwnd:   HWND;   {**< The window for the message }
                        msg:     uInt;  {**< The type of message *}
                        wParam: WPARAM; {**< WORD message parameter *}
                        lParam: LPARAM; {**< WORD message parameter *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_X11}
                     __SYSWM_X11 = record
                        event: {$IFDEF FPC} TXEvent {$ELSE} XEvent {$ENDIF};
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}
                     __SYSWM_DIRECTFB = record
                        event: DFBEvent;
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_COCOA}
                     __SYSWM_COCOA = record
                        (* No Cocoa window events yet *)
                        dummy: integer;
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_UIKIT}
                     __SYSWM_UIKIT = record
                        (* No UIKit window events yet *)
                        dummy: integer;
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_VIVANTE}
                     __SYSWM_VIVANTE = record
                        (* No Vivante window events yet *)
                        dummy: integer;
                     end;
                  {$ENDIF}


                     PSDL_SysWMmsg = ^TSDL_SysWMmsg;
                     TSDL_SysWMmsg = record
                        version: TSDL_version;
                        subsystem: TSDL_SYSWM_TYPE;
                        {$IFDEF SDL_VIDEO_DRIVER_WINDOWS}
                          win: __SYSWM_WINDOWS;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_X11}
                          x11: __SYSWM_X11;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}
                          dfb: __SYSWM_DIRECTFB;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_COCOA}
                          cocoa: __SYSWM_COCOA;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_UIKIT}
                          uikit: __SYSWM_UIKIT;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_VIVANTE}
                          vivante: __SYSWM_VIVANTE;
                        {$ELSE}
                          (* Cannot have empty record case *)
                          dummy: integer;
                        {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF}
                     end;

                  {$IFDEF SDL_VIDEO_DRIVER_WINDOWS}
                     __WMINFO_WINDOWS = record
                        window: HWND; {**< The window handle *}
                        hdc:    HDC;  {**< The window device context *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_WINRT} // Since SDL 2.0.3
                     __WMINFO_WINRT = record
                        window: IInspectable;      {**< The WinRT CoreWindow *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_X11}
                     __WMINFO_X11 = record
                        display: PDisplay;  {**< The X11 display *}
                        window:  TWindow;   {**< The X11 window *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}
                     __WMINFO_DFB = record
                        dfb:     IDirectFB;         {**< The directfb main interface *}
                        window:  IDirectFBWindow;   {**< The directfb window handle *}
                        surface: IDirectFBSurface;  {**< The directfb client surface *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_COCOA}
                     __WMINFO_COCOA = record
                        window: NSWindow;           {* The Cocoa window *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_UIKIT}
                     __WMINFO_UIKIT = record
                        window: UIWindow;           {* The UIKit window *}
                        framebuffer: GLuint;        {* The GL view's Framebuffer Object. It must be bound when rendering to the screen using GL. *}
                        colorbuffer: GLuint;        {* The GL view's color Renderbuffer Object. It must be bound when SDL_GL_SwapWindow is called. *}
                        resolveFramebuffer: GLuint; {* The Framebuffer Object which holds the resolve color Renderbuffer, when MSAA is used. *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_WAYLAND} // Since SDL 2.0.2
                     __WMINFO_WAYLAND = record
                        display: wl_display;             {**< Wayland display *}
                        surface: wl_surface;             {**< Wayland surface *}
                        shell_surface: wl_shell_surface; {**< Wayland shell_surface (window manager handle) *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_MIR} // Since SDL 2.0.2
                     __WMINFO_MIR = record
                        connection: PMirConnection; {**< Mir display server connection *}
                        surface: PMirSurface;       {**< Mir surface *}
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_ANDROID}
                     __WMINFO_ANDROID = record
                        window:  Pointer; //PANativeWindow;
                        surface: Pointer; //PEGLSurface;
                     end;
                  {$ENDIF}
                  {$IFDEF SDL_VIDEO_DRIVER_VIVANTE}
                     __WMINFO_VIVANTE = record
                        display: EGLNativeDisplayType;
                        window:  EGLNativeWindowType;
                     end;
                  {$ENDIF}


                     PSDL_SysWMinfo = ^TSDL_SysWMinfo;
                     TSDL_SysWMinfo = record
                        version: TSDL_version;
                        subsystem: TSDL_SYSWM_TYPE;
                        {$IFDEF SDL_VIDEO_DRIVER_WINDOWS}
                          win : __WMINFO_WINDOWS;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_WINRT}
                          winrt : __WMINFO_WINRT;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_X11}
                          x11 : __WMINFO_X11;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}
                          dfb : __WMINFO_DFB;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_COCOA}
                          cocoa : __WMINFO_COCOA;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_UIKIT}
                          uikit : __WMINFO_UIKIT;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_WAYLAND}
                          wl : __WMINFO_WAYLAND;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_MIR}
                          mir : __WMINFO_MIR;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_ANDROID}
                          android: __WMINFO_ANDROID;
                        {$ELSE} {$IFDEF SDL_VIDEO_DRIVER_VIVANTE}
                          vivante: __WMINFO_VIVANTE;
                        {$ELSE}
                          dummy: integer;
                        {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF}
                     end;


 TTSDL_GetWindowWMInfo=function(window:PSDL_Window; info : PSDL_SysWMinfo):TSDL_bool; cdecl;


//----------- sdl_events.h -------------------

                  const

                    SDL_RELEASED         = 0;
                    SDL_PRESSED          = 1;
                    SDL_FIRSTEVENT       = 0;     // Unused (do not remove) (needed in pascal?)
                    SDL_COMMONEVENT      = 1;     //added for pascal-compatibility
                    SDL_QUITEV           = $100;  // User-requested quit (originally SDL_QUIT, but changed, cause theres a method called SDL_QUIT)
                    SDL_APP_TERMINATING  = $101;   {**< The application is being terminated by the OS
                                                        Called on iOS in applicationWillTerminate()
                                                        Called on Android in onDestroy()
                                                    *}
                    SDL_APP_LOWMEMORY    = $102;   {**< The application is low on memory, free memory if possible.
                                                        Called on iOS in applicationDidReceiveMemoryWarning()
                                                        Called on Android in onLowMemory()
                                                    *}
                    SDL_APP_WILLENTERBACKGROUND = $103; {**< The application is about to enter the background
                                                             Called on iOS in applicationWillResignActive()
                                                             Called on Android in onPause()
                                                         *}
                    SDL_APP_DIDENTERBACKGROUND = $104;  {**< The application did enter the background and may not get CPU for some time
                                                             Called on iOS in applicationDidEnterBackground()
                                                             Called on Android in onPause()
                                                         *}
                    SDL_APP_WILLENTERFOREGROUND = $105; {**< The application is about to enter the foreground
                                                             Called on iOS in applicationWillEnterForeground()
                                                             Called on Android in onResume()
                                                         *}
                    SDL_APP_DIDENTERFOREGROUND = $106;  {**< The application is now interactive
                                                             Called on iOS in applicationDidBecomeActive()
                                                             Called on Android in onResume()
                                                         *}

                    { Window events }
                    SDL_WINDOWEVENT      = $200;  // Window state change
                    SDL_SYSWMEVENT       = $201;  // System specific event

                    { Keyboard events }
                    SDL_KEYDOWN          = $300;  // Key pressed
                    SDL_KEYUP            = $301;  // Key released
                    SDL_TEXTEDITING      = $302;  // Keyboard text editing (composition)
                    SDL_TEXTINPUT        = $303;  // Keyboard text input
                    SDL_KEYMAPCHANGED    = $304;  // Keymap changed due to a system event such as an
                                                  // input language or keyboard layout change.

                    { Mouse events }
                    SDL_MOUSEMOTION      = $400;  // Mouse moved
                    SDL_MOUSEBUTTONDOWN  = $401;  // Mouse button pressed
                    SDL_MOUSEBUTTONUP    = $402;  // Mouse button released
                    SDL_MOUSEWHEEL       = $403;  // Mouse wheel motion

                    { Joystick events }
                    SDL_JOYAXISMOTION    = $600;  // Joystick axis motion
                    SDL_JOYBALLMOTION    = $601;  // Joystick trackball motion
                    SDL_JOYHATMOTION     = $602;  // Joystick hat position change
                    SDL_JOYBUTTONDOWN    = $603;  // Joystick button pressed
                    SDL_JOYBUTTONUP      = $604;  // Joystick button released
                    SDL_JOYDEVICEADDED   = $605;  // A new joystick has been inserted into the system
                    SDL_JOYDEVICEREMOVED = $606;  // An opened joystick has been removed

                    { Game controller events }
                    SDL_CONTROLLERAXISMOTION     = $650;  // Game controller axis motion
                    SDL_CONTROLLERBUTTONDOWN     = $651;  // Game controller button pressed
                    SDL_CONTROLLERBUTTONUP       = $652;  // Game controller button released
                    SDL_CONTROLLERDEVICEADDED    = $653;  // A new Game controller has been inserted into the system
                    SDL_CONTROLLERDEVICEREMOVED  = $654;  // An opened Game controller has been removed
                    SDL_CONTROLLERDEVICEREMAPPED = $655;  // The controller mapping was updated

                    { Touch events }
                    SDL_FINGERDOWN      = $700;
                    SDL_FINGERUP        = $701;
                    SDL_FINGERMOTION    = $702;

                    { Gesture events }
                    SDL_DOLLARGESTURE   = $800;
                    SDL_DOLLARRECORD    = $801;
                    SDL_MULTIGESTURE    = $802;

                    { Clipboard events }
                    SDL_CLIPBOARDUPDATE = $900; // The clipboard changed

                    { Drag and drop events }
                    SDL_DROPFILE        = $1000; // The system requests a file open
                    SDL_DROPTEXT        = $1001; // text/plain drag-and-drop event
                    SDL_DROPBEGIN       = $1002; // A new set of drops is beginning (NULL filename)
                    SDL_DROPCOMPLETE    = $1003; // Current set of drops is now complete (NULL filename)

                    { Audio hotplug events }
                    SDL_AUDIODEVICEADDED     = $1100; // A new audio device is available
                    SDL_AUDIODEVICEREMOVED   = $1101; // An audio device has been removed.

                    { Render events }
                    SDL_RENDER_TARGETS_RESET = $2000; // The render targets have been reset
                    SDL_RENDER_DEVICE_RESET  = $2001; // The device has been reset and all textures need to be recreated

                    {** Events SDL_USEREVENT through SDL_LASTEVENT are for your use,
                     *  and should be allocated with SDL_RegisterEvents()
                     *}
                    SDL_USEREVENT    = $8000;


                    // This last event is only for bounding internal arrays

                    SDL_LASTEVENT    = $FFFF;

                    SDL_TEXTEDITINGEVENT_TEXT_SIZE = 32;
                    SDL_TEXTINPUTEVENT_TEXT_SIZE = 32;

                    SDL_ADDEVENT = 0;
                    SDL_PEEKEVENT = 1;
                    SDL_GETEVENT = 2;

                    SDL_QUERY   =   -1;
                    SDL_IGNORE  =    0;
                    SDL_DISABLE =    0;
                    SDL_ENABLE  =  1;

                    SDL_CACHELINE_SIZE = 128;

                    SDL_MAX_LOG_MESSAGE = 4096;

                    SDL_LOG_PRIORITY_VERBOSE = 1;
                    SDL_LOG_PRIORITY_DEBUG = 2;
                    SDL_LOG_PRIORITY_INFO = 3;
                    SDL_LOG_PRIORITY_WARN = 4;
                    SDL_LOG_PRIORITY_ERROR = 5;
                    SDL_LOG_PRIORITY_CRITICAL = 6;
                    SDL_NUM_LOG_PRIORITIES = 7;

                    type
                      TSDL_LogCategory = (SDL_LOG_CATEGORY_APPLICATION,
                                SDL_LOG_CATEGORY_ERROR,
                                SDL_LOG_CATEGORY_ASSERT,
                                SDL_LOG_CATEGORY_SYSTEM,
                                SDL_LOG_CATEGORY_AUDIO,
                                  SDL_LOG_CATEGORY_VIDEO,
                                SDL_LOG_CATEGORY_RENDER,
                                SDL_LOG_CATEGORY_INPUT,
                                SDL_LOG_CATEGORY_TEST,

                                {* Reserved for future SDL library use *}
                                SDL_LOG_CATEGORY_RESERVED1,
                                SDL_LOG_CATEGORY_RESERVED2,
                                SDL_LOG_CATEGORY_RESERVED3,
                                SDL_LOG_CATEGORY_RESERVED4,
                                SDL_LOG_CATEGORY_RESERVED5,
                                SDL_LOG_CATEGORY_RESERVED6,
                                SDL_LOG_CATEGORY_RESERVED7,
                                SDL_LOG_CATEGORY_RESERVED8,
                                SDL_LOG_CATEGORY_RESERVED9,
                                SDL_LOG_CATEGORY_RESERVED10,

                                {* Beyond this point is reserved for application use *}
                                SDL_LOG_CATEGORY_CUSTOM);



                    TSDL_LogPriority = Integer;

                    TSDL_LogOutputFunction = procedure(userdata: Pointer; category: Integer; priority: TSDL_LogPriority; const msg: PAnsiChar);
                    PSDL_LogOutputFunction = ^TSDL_LogOutputFunction;


                    TSDL_EventAction = Word;

                    TSDL_EventType = Word;

                    TSDL_CommonEvent = record
                      type_: UInt32;
                      timestamp: UInt32;
                    end;

                    TSDL_WindowEvent = record
                      type_: UInt32;       // SDL_WINDOWEVENT
                      timestamp: UInt32;
                      windowID: UInt32;    // The associated window
                      event: UInt8;        // SDL_WindowEventID
                      padding1: UInt8;
                      padding2: UInt8;
                      padding3: UInt8;
                      data1: SInt32;       // event dependent data
                      data2: SInt32;       // event dependent data
                    end;

                    TSDL_KeyboardEvent = record
                      type_: UInt32;        // SDL_KEYDOWN or SDL_KEYUP
                      timestamp: UInt32;
                      windowID: UInt32;     // The window with keyboard focus, if any
                      state: UInt8;         // SDL_PRESSED or SDL_RELEASED
                      _repeat: UInt8;       // Non-zero if this is a key repeat
                      padding2: UInt8;
                      padding3: UInt8;
                      keysym: TSDL_KeySym;  // The key that was pressed or released
                    end;

                    TSDL_TextEditingEvent = record
                      type_: UInt32;                               // SDL_TEXTEDITING
                      timestamp: UInt32;
                      windowID: UInt32;                            // The window with keyboard focus, if any
                      text: array[0..SDL_TEXTEDITINGEVENT_TEXT_SIZE] of Char;  // The editing text
                      start: SInt32;                               // The start cursor of selected editing text
                      length: SInt32;                              // The length of selected editing text
                    end;

                    TSDL_TextInputEvent = record
                      type_: UInt32;                                          // SDL_TEXTINPUT
                      timestamp: UInt32;
                      windowID: UInt32;                                       // The window with keyboard focus, if any
                      text: array[0..SDL_TEXTINPUTEVENT_TEXT_SIZE] of Char;   // The input text
                    end;

                    TSDL_MouseMotionEvent = record
                      type_: UInt32;       // SDL_MOUSEMOTION
                      timestamp: UInt32;
                      windowID: UInt32;    // The window with mouse focus, if any
                      which: UInt32;       // The mouse instance id, or SDL_TOUCH_MOUSEID
                      state: UInt8;        // The current button state
                      padding1: UInt8;
                      padding2: UInt8;
                      padding3: UInt8;
                      x: SInt32;           // X coordinate, relative to window
                      y: SInt32;           // Y coordinate, relative to window
                      xrel: SInt32;        // The relative motion in the X direction
                      yrel: SInt32;        // The relative motion in the Y direction
                    end;

                    TSDL_MouseButtonEvent = record
                      type_: UInt32;       // SDL_MOUSEBUTTONDOWN or SDL_MOUSEBUTTONUP
                      timestamp: UInt32;
                      windowID: UInt32;    // The window with mouse focus, if any
                      which: UInt32;       // The mouse instance id, or SDL_TOUCH_MOUSEID
                      button: UInt8;       // The mouse button index
                      state: UInt8;        // SDL_PRESSED or SDL_RELEASED
                      clicks: UInt8;       // 1 for single-click, 2 for double-click, etc.
                      padding1: UInt8;
                      x: SInt32;           // X coordinate, relative to window
                      y: SInt32;           // Y coordinate, relative to window
                    end;

                    TSDL_MouseWheelEvent = record
                      type_: UInt32;        // SDL_MOUSEWHEEL
                      timestamp: UInt32;
                      windowID: UInt32;    // The window with mouse focus, if any
                      which: UInt32;       // The mouse instance id, or SDL_TOUCH_MOUSEID
                      x: SInt32;           // The amount scrolled horizontally
                      y: SInt32;           // The amount scrolled vertically
                      direction: UInt32;   // Set to one of the SDL_MOUSEWHEEL_* defines. When FLIPPED the values in X and Y will be opposite. Multiply by -1 to change them back
                    end;

                    TSDL_JoyAxisEvent = record
                      type_: UInt32;         // SDL_JOYAXISMOTION
                      timestamp: UInt32;
                      which: TSDL_JoystickID; // The joystick instance id
                      axis: UInt8;           // The joystick axis index
                      padding1: UInt8;
                      padding2: UInt8;
                      padding3: UInt8;
                      value: SInt16;         // The axis value (range: -32768 to 32767)
                      padding4: UInt16;
                    end;

                    TSDL_JoyBallEvent = record
                      type_: UInt32;         // SDL_JOYBALLMOTION
                      timestamp: UInt32;
                      which: TSDL_JoystickID; // The joystick instance id
                      ball: UInt8;           // The joystick trackball index
                      padding1: UInt8;
                      padding2: UInt8;
                      padding3: UInt8;
                      xrel: SInt16;          // The relative motion in the X direction
                      yrel: SInt16;          // The relative motion in the Y direction
                    end;

                    TSDL_JoyHatEvent = record
                      type_: UInt32;         // SDL_JOYHATMOTION
                      timestamp: UInt32;
                      which: TSDL_JoystickID; // The joystick instance id
                      hat: UInt8;            // The joystick hat index
                      value: UInt8;         {*  The hat position value.
                                             *  SDL_HAT_LEFTUP   SDL_HAT_UP       SDL_HAT_RIGHTUP
                                             *  SDL_HAT_LEFT     SDL_HAT_CENTERED SDL_HAT_RIGHT
                                             *  SDL_HAT_LEFTDOWN SDL_HAT_DOWN     SDL_HAT_RIGHTDOWN
                                             *
                                             *  Note that zero means the POV is centered.
                                             *}
                      padding1: UInt8;
                      padding2: UInt8;
                    end;

                    TSDL_JoyButtonEvent = record
                      type_: UInt32;        // SDL_JOYBUTTONDOWN or SDL_JOYBUTTONUP
                      timestamp: UInt32;
                      which: TSDL_JoystickID; // The joystick instance id
                      button: UInt8;         // The joystick button index
                      state: UInt8;          // SDL_PRESSED or SDL_RELEASED
                      padding1: UInt8;
                      padding2: UInt8;
                    end;

                    TSDL_JoyDeviceEvent = record
                      type_: UInt32;      // SDL_JOYDEVICEADDED or SDL_JOYDEVICEREMOVED
                      timestamp: UInt32;
                      which: SInt32;      // The joystick device index for the ADDED event, instance id for the REMOVED event
                    end;

                    TSDL_ControllerAxisEvent = record
                      type_: UInt32;         // SDL_CONTROLLERAXISMOTION
                      timestamp: UInt32;
                      which: TSDL_JoystickID; // The joystick instance id
                      axis: UInt8;           // The controller axis (SDL_GameControllerAxis)
                      padding1: UInt8;
                      padding2: UInt8;
                      padding3: UInt8;
                      value: SInt16;         // The axis value (range: -32768 to 32767)
                      padding4: UInt16;
                    end;

                    TSDL_ControllerButtonEvent = record
                      type_: UInt32;         // SDL_CONTROLLERBUTTONDOWN or SDL_CONTROLLERBUTTONUP
                      timestamp: UInt32;
                      which: TSDL_JoystickID; // The joystick instance id
                      button: UInt8;         // The controller button (SDL_GameControllerButton)
                      state: UInt8;          // SDL_PRESSED or SDL_RELEASED
                      padding1: UInt8;
                      padding2: UInt8;
                    end;

                    TSDL_ControllerDeviceEvent = record
                      type_: UInt32;       // SDL_CONTROLLERDEVICEADDED, SDL_CONTROLLERDEVICEREMOVED, or SDL_CONTROLLERDEVICEREMAPPED
                      timestamp: UInt32;
                      which: SInt32;       // The joystick device index for the ADDED event, instance id for the REMOVED or REMAPPED event
                    end;

                    TSDL_AudioDeviceEvent = record
                      type_: UInt32;        // ::SDL_AUDIODEVICEADDED, or ::SDL_AUDIODEVICEREMOVED
                      timestamp: UInt32;
                      which: UInt32;        // The audio device index for the ADDED event (valid until next SDL_GetNumAudioDevices() call), SDL_AudioDeviceID for the REMOVED event
                      iscapture: UInt8;     // zero if an output device, non-zero if a capture device.
                      padding1: UInt8;
                      padding2: UInt8;
                      padding3: UInt8;
                    end;

                    TSDL_TouchFingerEvent = record
                      type_: UInt32;         // SDL_FINGERMOTION or SDL_FINGERDOWN or SDL_FINGERUP
                      timestamp: UInt32;
                      touchId: TSDL_TouchID;  // The touch device id
                      fingerId: TSDL_FingerID;
                      x: Float;              // Normalized in the range 0...1
                      y: Float;              // Normalized in the range 0...1
                      dx: Float;             // Normalized in the range 0...1
                      dy: Float;             // Normalized in the range 0...1
                      pressure: Float;       // Normalized in the range 0...1
                    end;

                    TSDL_MultiGestureEvent = record
                      type_: UInt32;        // SDL_MULTIGESTURE
                      timestamp: UInt32;
                      touchId: TSDL_TouchID; // The touch device index
                      dTheta: Float;
                      dDist: Float;
                      x: Float;
                      y: Float;
                      numFingers: UInt16;
                      padding: UInt16;
                    end;

                    TSDL_DollarGestureEvent = record
                      type_: UInt32;         // SDL_DOLLARGESTURE
                      timestamp: UInt32;
                      touchId: TSDL_TouchID;  // The touch device id
                      gestureId: TSDL_GestureID;
                      numFingers: UInt32;
                      error: Float;
                      x: Float;              // Normalized center of gesture
                      y: Float;              // Normalized center of gesture
                    end;

                    TSDL_DropEvent = record
                      type_: UInt32;      // SDL_DROPFILE
                      timestamp: UInt32;
                      _file: PAnsiChar;   // The file name, which should be freed with SDL_free()
                    end;

                    TSDL_QuitEvent = record
                      type_: UInt32;        // SDL_QUIT
                      timestamp: UInt32;
                    end;

                    TSDL_UserEvent = record
                      type_: UInt32;       // SDL_USEREVENT through SDL_NUMEVENTS-1
                      timestamp: UInt32;
                      windowID: UInt32;    // The associated window if any
                      code: SInt32;        // User defined event code
                      data1: Pointer;      // User defined data pointer
                      data2: Pointer;      // User defined data pointer
                    end;

                    PSDL_SysWMEvent = ^TSDL_SysWMEvent;
                    TSDL_SysWMEvent = record
                      type_: UInt32;       // SDL_SYSWMEVENT
                      timestamp: UInt32;
                      msg: PSDL_SysWMmsg;  // driver dependent data (defined in SDL_syswm.h)
                    end;

                    PSDL_Event = ^TSDL_Event;
                    TSDL_Event = record
                      case Integer of
                        0:  (type_: UInt32);

                        SDL_COMMONEVENT:  (common: TSDL_CommonEvent);
                        SDL_WINDOWEVENT:  (window: TSDL_WindowEvent);

                        SDL_KEYUP,
                        SDL_KEYDOWN:  (key: TSDL_KeyboardEvent);
                        SDL_TEXTEDITING:  (edit: TSDL_TextEditingEvent);
                        SDL_TEXTINPUT:  (text: TSDL_TextInputEvent);

                        SDL_MOUSEMOTION:  (motion: TSDL_MouseMotionEvent);
                        SDL_MOUSEBUTTONUP,
                        SDL_MOUSEBUTTONDOWN:  (button: TSDL_MouseButtonEvent);
                        SDL_MOUSEWHEEL:  (wheel: TSDL_MouseWheelEvent);

                        SDL_JOYAXISMOTION:  (jaxis: TSDL_JoyAxisEvent);
                        SDL_JOYBALLMOTION: (jball: TSDL_JoyBallEvent);
                        SDL_JOYHATMOTION: (jhat: TSDL_JoyHatEvent);
                        SDL_JOYBUTTONDOWN,
                        SDL_JOYBUTTONUP: (jbutton: TSDL_JoyButtonEvent);
                        SDL_JOYDEVICEADDED,
                        SDL_JOYDEVICEREMOVED: (jdevice: TSDL_JoyDeviceEvent);

                        SDL_CONTROLLERAXISMOTION: (caxis: TSDL_ControllerAxisEvent);
                        SDL_CONTROLLERBUTTONUP,
                        SDL_CONTROLLERBUTTONDOWN: (cbutton: TSDL_ControllerButtonEvent);
                        SDL_CONTROLLERDEVICEADDED,
                        SDL_CONTROLLERDEVICEREMOVED,
                        SDL_CONTROLLERDEVICEREMAPPED: (cdevice: TSDL_ControllerDeviceEvent);

                        SDL_AUDIODEVICEADDED,
                        SDL_AUDIODEVICEREMOVED: (adevice: TSDL_AudioDeviceEvent);

                        SDL_QUITEV: (quit: TSDL_QuitEvent);

                        SDL_USEREVENT: (user: TSDL_UserEvent);
                        SDL_SYSWMEVENT: (syswm: TSDL_SysWMEvent);

                        SDL_FINGERDOWN,
                        SDL_FINGERUP,
                        SDL_FINGERMOTION: (tfinger: TSDL_TouchFingerEvent);
                        SDL_MULTIGESTURE: (mgesture: TSDL_MultiGestureEvent);
                        SDL_DOLLARGESTURE,SDL_DOLLARRECORD: (dgesture: TSDL_DollarGestureEvent);

                        SDL_DROPFILE: (drop: TSDL_DropEvent);
                    end;

                    PSDL_EventFilter = ^TSDL_EventFilter;
                    {$IFNDEF GPC}
                      TSDL_EventFilter = function( userdata: Pointer; event: PSDL_Event ): Integer; cdecl;
                    {$ELSE}
                      TSDL_EventFilter = function( userdata: Pointer; event: PSDL_Event ): Integer;
                    {$ENDIF}

  TTSDL_PumpEvents=procedure; cdecl;
  TTSDL_PeepEvents=function(events: PSDL_Event; numevents: SInt32; action: TSDL_EventAction; minType: UInt32; maxType: UInt32): SInt32; cdecl;
  TTSDL_HasEvent=function(type_: UInt32): TSDL_Bool; cdecl;
  TTSDL_HasEvents=function(minType: UInt32; maxType: UInt32): TSDL_Bool; cdecl;
  TTSDL_FlushEvent=procedure(type_: UInt32); cdecl;
  TTSDL_FlushEvents=procedure(minType: UInt32; maxType: UInt32); cdecl;
  TTSDL_PollEvent=function(event: PSDL_Event): SInt32; cdecl;
  TTSDL_WaitEvent=function(event: PSDL_Event): SInt32; cdecl;
  TTSDL_WaitEventTimeout=function(event: PSDL_Event; timeout: SInt32): SInt32; cdecl;
  TTSDL_PushEvent=function(event: PSDL_Event): SInt32; cdecl;
  TTSDL_SetEventFilter=procedure(filter: TSDL_EventFilter; userdata: Pointer); cdecl;
  TTSDL_GetEventFilter=function(var filter: PSDL_EventFilter; var userdata: PPointer): TSDL_Bool; cdecl;
  TTSDL_AddEventWatch=procedure(filter: TSDL_EventFilter; userdata: Pointer); cdecl;
  TTSDL_DelEventWatch=procedure(filter: TSDL_EventFilter; userdata: Pointer); cdecl;
  TTSDL_FilterEvents=procedure(filter: TSDL_EventFilter; userdata: Pointer); cdecl;
  TTSDL_EventState=function(type_: UInt32; state: SInt32): UInt8; cdecl;
  TTSDL_RegisterEvents=function(numevents: SInt32): UInt32; cdecl;
  TTSDL_SetClipboardText=function(const text: PAnsiChar): Integer; cdecl;
  TTSDL_GetClipboardText=function(): PAnsiChar; cdecl;
  TTSDL_HasClipboardText=function(): TSDL_Bool; cdecl;
  TTSDL_GetCPUCount=function(): Integer; cdecl;
  TTSDL_GetCPUCacheLineSize=function(): Integer; cdecl;
  TTSDL_HasRDTSC=function(): TSDL_Bool; cdecl;
  TTSDL_HasAltiVec=function(): TSDL_Bool; cdecl;
  TTSDL_HasMMX=function(): TSDL_Bool; cdecl;
  TTSDL_Has3DNow=function(): TSDL_Bool; cdecl;
  TTSDL_HasSSE=function(): TSDL_Bool; cdecl;
  TTSDL_HasSSE2=function(): TSDL_Bool; cdecl;
  TTSDL_HasSSE3=function(): TSDL_Bool; cdecl;
  TTSDL_HasSSE41=function(): TSDL_Bool; cdecl;
  TTSDL_HasSSE42=function(): TSDL_Bool; cdecl;
  TTSDL_HasAVX=function(): TSDL_Bool; cdecl;
  TTSDL_HasAVX2=function(): TSDL_Bool; cdecl;
  TTSDL_GetSystemRAM=function(): Integer; cdecl;
  TTSDL_GetBasePath=function(): PChar; cdecl;
  TTSDL_GetPrefPath=function(const org: PAnsiChar; const app: PAnsiChar): PChar; cdecl;
  TTSDL_LogSetAllPriority=procedure(priority: TSDL_LogPriority); cdecl;
  TTSDL_LogSetPriority=procedure(category: Integer; priority: TSDL_LogPriority); cdecl;
  TTSDL_LogGetPriority=function(category: Integer): TSDL_LogPriority; cdecl;
  TTSDL_LogResetPriorities=procedure(); cdecl;
  TTSDL_Log=procedure(const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogVerbose=procedure(category: Integer; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogDebug=procedure(category: Integer; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogInfo=procedure(category: Integer; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogWarn=procedure(category: Integer; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogError=procedure(category: Integer; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogCritical=procedure(category: Integer; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogMessage=procedure(category: Integer; priority: TSDL_LogPriority; const fmt: PAnsiChar; pars: array of const); cdecl;
  TTSDL_LogMessageV=procedure(category: Integer; priority: TSDL_LogPriority; const fmt: PAnsiChar; ap: array of const); cdecl;
  TTSDL_LogGetOutputFunction=procedure(callback: PSDL_LogOutputFunction; userdata: PPointer); cdecl;
  TTSDL_LogSetOutputFunction=procedure(callback: TSDL_LogOutputFunction; userdata: Pointer); cdecl;


  function SDL_GetEventState(type_: UInt32): UInt8;

//-------------------SDL_system.h -------------------

{$IFDEF WINDOWS}

                    Type PIDirect3DDevice9 = Pointer;

                      TSDL_WindowsMessageHook = Procedure(userdata, hWnd: Pointer; mesage: UInt32; wParam: UInt64; lParam: SInt64); stdcall;

  TTSDL_SetWindowsMessageHook= Procedure(callback: TSDL_WindowsMessageHook; userdata: Pointer); stdcall;
  TTSDL_Direct3D9GetAdapterIndex= Function (displayIndex:SInt32):SInt32; stdcall;
  TTSDL_RenderGetD3D9Device= Function(renderer:PSDL_Renderer):PIDirect3DDevice9; stdcall;
  TTSDL_DXGIGetOutputInfo=  function(displayIndex :SInt32; adapterIndex, outputIndex :PSInt32): TSDL_Bool; stdcall;

{$IFEND}
{$IFDEF WINCE}

                    Type
                      TSDL_WinRT_Path = (
                        SDL_WINRT_PATH_INSTALLED_LOCATION = 0,
                        SDL_WINRT_PATH_LOCAL_FOLDER = 1,
                        SDL_WINRT_PATH_ROAMING_FOLDER = 2,
                        SDL_WINRT_PATH_TEMP_FOLDER = 3
                      );

 TTSDL_WinRTGetFSPathUNICODE= Function(pathType :TSDL_WinRT_Path):PWideChar; cdecl;
 TTSDL_WinRTGetFSPathUTF8= Function(pathType :TSDL_WinRT_Path):PChar; cdecl;

 {$ENDIF}


 //----------- sdl.h -------------------

                    const

                      SDL_INIT_TIMER          = $00000001;
                      SDL_INIT_AUDIO          = $00000010;
                      SDL_INIT_VIDEO          = $00000020;
                      SDL_INIT_JOYSTICK       = $00000200;
                      SDL_INIT_HAPTIC         = $00001000;
                      SDL_INIT_GAMECONTROLLER = $00002000;
                      SDL_INIT_NOPARACHUTE    = $00100000;
                      SDL_INIT_EVERYTHING     = SDL_INIT_TIMER    or
                                                SDL_INIT_AUDIO    or
                            SDL_INIT_VIDEO    or
                            SDL_INIT_JOYSTICK or
                            SDL_INIT_HAPTIC   or
                            SDL_INIT_GAMECONTROLLER;

                     type

 TTSDL_Init= function(flags: UInt32): SInt32; cdecl;
 TTSDL_InitSubSystem= function(flags: UInt32): SInt32; cdecl;
 TTSDL_QuitSubSystem= procedure(flags: UInt32); cdecl;
 TTSDL_WasInit= function(flags: UInt32): UInt32; cdecl;
 TTSDL_Quit= procedure(); cdecl;


//========================================================================
//========================================================================
//================ Variables =============================================
Var


  SDL_GetVersion: TTSDL_GetVersion =nil;
  SDL_GetRevision: TTSDL_GetRevision =nil;
  SDL_GetRevisionNumber: TTSDL_GetRevisionNumber =nil;

  SDL_SetError: TTSDL_SetError =nil;
  SDL_GetError: TTSDL_GetError =nil;
  SDL_ClearError: TTSDL_ClearError =nil;
  SDL_Error: TTSDL_Error =nil;
  SDL_GetPlatform: TTSDL_GetPlatform =nil;

  SDL_CreateThread: TTSDL_CreateThread=nil;

  SDL_GetThreadName: TTSDL_GetThreadName =nil;
  SDL_ThreadID: TTSDL_ThreadID =nil;
  SDL_GetThreadID: TTSDL_GetThreadID =nil;
  SDL_SetThreadPriority: TTSDL_SetThreadPriority =nil;
  SDL_WaitThread: TTSDL_WaitThread =nil;
  SDL_DetachThread: TTSDL_DetachThread =nil;
  SDL_TLSCreate: TTSDL_TLSCreate =nil;
  SDL_TLSGet: TTSDL_TLSGet =nil;
  SDL_TLSSet: TTSDL_TLSSet =nil;

  SDL_CreateMutex: TTSDL_CreateMutex =nil;
  SDL_LockMutex: TTSDL_LockMutex =nil;
  SDL_TryLockMutex: TTSDL_TryLockMutex =nil;
  SDL_UnlockMutex: TTSDL_UnlockMutex =nil;
  SDL_DestroyMutex: TTSDL_DestroyMutex =nil;
  SDL_CreateSemaphore: TTSDL_CreateSemaphore =nil;
  SDL_DestroySemaphore: TTSDL_DestroySemaphore =nil;
  SDL_SemWait: TTSDL_SemWait =nil;
  SDL_SemTryWait: TTSDL_SemTryWait =nil;
  SDL_SemWaitTimeout: TTSDL_SemWaitTimeout =nil;
  SDL_SemPost: TTSDL_SemPost =nil;
  SDL_SemValue: TTSDL_SemValue =nil;
  SDL_CreateCond: TTSDL_CreateCond =nil;
  SDL_DestroyCond: TTSDL_DestroyCond =nil;
  SDL_CondSignal: TTSDL_CondSignal =nil;
  SDL_CondBroadcast: TTSDL_CondBroadcast =nil;
  SDL_CondWait: TTSDL_CondWait =nil;
  SDL_CondWaitTimeout: TTSDL_CondWaitTimeout =nil;

  SDL_GetTicks: TTSDL_GetTicks =nil;
  SDL_GetPerformanceCounter: TTSDL_GetPerformanceCounter =nil;
  SDL_GetPerformanceFrequency: TTSDL_GetPerformanceFrequency =nil;
  SDL_Delay: TTSDL_Delay =nil;
  SDL_AddTimer: TTSDL_AddTimer =nil;
  SDL_RemoveTimer: TTSDL_RemoveTimer =nil;

  SDL_GetPixelFormatName: TTSDL_GetPixelFormatName =nil;
  SDL_PixelFormatEnumToMasks: TTSDL_PixelFormatEnumToMasks =nil;
  SDL_MasksToPixelFormatEnum: TTSDL_MasksToPixelFormatEnum =nil;
  SDL_AllocFormat: TTSDL_AllocFormat =nil;
  SDL_FreeFormat: TTSDL_FreeFormat =nil;
  SDL_AllocPalette: TTSDL_AllocPalette =nil;
  SDL_SetPixelFormatPalette: TTSDL_SetPixelFormatPalette =nil;
  SDL_SetPaletteColors: TTSDL_SetPaletteColors =nil;
  SDL_FreePalette: TTSDL_FreePalette =nil;
  SDL_MapRGB: TTSDL_MapRGB =nil;
  SDL_MapRGBA: TTSDL_MapRGBA =nil;
  SDL_GetRGB: TTSDL_GetRGB =nil;
  SDL_GetRGBA: TTSDL_GetRGBA =nil;
  SDL_CalculateGammaRamp: TTSDL_CalculateGammaRamp =nil;

  SDL_HasIntersection: TTSDL_HasIntersection =nil;
  SDL_IntersectRect: TTSDL_IntersectRect =nil;
  SDL_UnionRect: TTSDL_UnionRect =nil;
  SDL_EnclosePoints: TTSDL_EnclosePoints =nil;
  SDL_IntersectRectAndLine: TTSDL_IntersectRectAndLine =nil;

  SDL_RWFromFile: TTSDL_RWFromFile=nil;
  SDL_RWFromFP: TTSDL_RWFromFP =nil;
  SDL_RWFromMem: TTSDL_RWFromMem =nil;
  SDL_RWFromConstMem: TTSDL_RWFromConstMem =nil;
  SDL_AllocRW: TTSDL_AllocRW =nil;
  SDL_FreeRW: TTSDL_FreeRW =nil;
  SDL_ReadU8: TTSDL_ReadU8 =nil;
  SDL_ReadLE16: TTSDL_ReadLE16 =nil;
  SDL_ReadBE16: TTSDL_ReadBE16 =nil;
  SDL_ReadLE32: TTSDL_ReadLE32 =nil;
  SDL_ReadBE32: TTSDL_ReadBE32 =nil;
  SDL_ReadLE64: TTSDL_ReadLE64 =nil;
  SDL_ReadBE64: TTSDL_ReadBE64 =nil;
  SDL_WriteU8: TTSDL_WriteU8 =nil;
  SDL_WriteLE16: TTSDL_WriteLE16 =nil;
  SDL_WriteBE16: TTSDL_WriteBE16 =nil;
  SDL_WriteLE32: TTSDL_WriteLE32 =nil;
  SDL_WriteBE32: TTSDL_WriteBE32 =nil;
  SDL_WriteLE64: TTSDL_WriteLE64 =nil;
  SDL_WriteBE64: TTSDL_WriteBE64 =nil;

  SDL_GetNumAudioDrivers: TTSDL_GetNumAudioDrivers =nil;
  SDL_GetAudioDriver: TTSDL_GetAudioDriver =nil;
  SDL_AudioInit: TTSDL_AudioInit =nil;
  SDL_AudioQuit: TTSDL_AudioQuit =nil;
  SDL_GetCurrentAudioDriver: TTSDL_GetCurrentAudioDriver =nil;
  SDL_OpenAudio: TTSDL_OpenAudio =nil;
  SDL_GetNumAudioDevices: TTSDL_GetNumAudioDevices =nil;
  SDL_GetAudioDeviceName: TTSDL_GetAudioDeviceName =nil;
  SDL_OpenAudioDevice: TTSDL_OpenAudioDevice =nil;
  SDL_GetAudioStatus: TTSDL_GetAudioStatus =nil;
  SDL_GetAudioDeviceStatus: TTSDL_GetAudioDeviceStatus =nil;
  SDL_PauseAudio: TTSDL_PauseAudio =nil;
  SDL_PauseAudioDevice: TTSDL_PauseAudioDevice =nil;
  SDL_LoadWAV_RW: TTSDL_LoadWAV_RW=nil;
  SDL_FreeWAV: TTSDL_FreeWAV =nil;
  SDL_BuildAudioCVT: TTSDL_BuildAudioCVT =nil;
  SDL_ConvertAudio: TTSDL_ConvertAudio =nil;
  SDL_MixAudio: TTSDL_MixAudio =nil;
  SDL_MixAudioFormat: TTSDL_MixAudioFormat =nil;
  SDL_QueueAudio: TTSDL_QueueAudio =nil;
  SDL_DequeueAudio: TTSDL_DequeueAudio =nil;
  SDL_GetQueuedAudioSize: TTSDL_GetQueuedAudioSize =nil;
  SDL_ClearQueuedAudio: TTSDL_ClearQueuedAudio =nil;
  SDL_LockAudio: TTSDL_LockAudio =nil;
  SDL_LockAudioDevice: TTSDL_LockAudioDevice=nil;
  SDL_UnlockAudio: TTSDL_UnlockAudio =nil;
  SDL_UnlockAudioDevice: TTSDL_UnlockAudioDevice =nil;
  SDL_CloseAudio: TTSDL_CloseAudio =nil;
  SDL_CloseAudioDevice: TTSDL_CloseAudioDevice =nil;

  SDL_CreateRGBSurface: TTSDL_CreateRGBSurface=nil;
  SDL_CreateRGBSurfaceWithFormat: TTSDL_CreateRGBSurfaceWithFormat=nil;
  SDL_CreateRGBSurfaceFrom: TTSDL_CreateRGBSurfaceFrom=nil;
  SDL_CreateRGBSurfaceWithFormatFrom: TTSDL_CreateRGBSurfaceWithFormatFrom=nil;
  SDL_FreeSurface: TTSDL_FreeSurface=nil;
  SDL_SetSurfacePalette: TTSDL_SetSurfacePalette=nil;
  SDL_LockSurface: TTSDL_LockSurface=nil;
  SDL_UnlockSurface: TTSDL_UnlockSurface=nil;
  SDL_LoadBMP_RW: TTSDL_LoadBMP_RW=nil;
  SDL_SaveBMP_RW: TTSDL_SaveBMP_RW=nil;
  SDL_SetSurfaceRLE: TTSDL_SetSurfaceRLE=nil;
  SDL_SetColorKey: TTSDL_SetColorKey =nil;
  SDL_GetColorKey: TTSDL_GetColorKey =nil;
  SDL_SetSurfaceColorMod: TTSDL_SetSurfaceColorMod =nil;
  SDL_GetSurfaceColorMod: TTSDL_GetSurfaceColorMod =nil;
  SDL_SetSurfaceAlphaMod: TTSDL_SetSurfaceAlphaMod =nil;
  SDL_GetSurfaceAlphaMod: TTSDL_GetSurfaceAlphaMod =nil;
  SDL_SetSurfaceBlendMode: TTSDL_SetSurfaceBlendMode =nil;
  SDL_GetSurfaceBlendMode: TTSDL_GetSurfaceBlendMode =nil;
  SDL_SetClipRect: TTSDL_SetClipRect =nil;
  SDL_GetClipRect: TTSDL_GetClipRect =nil;
  SDL_ConvertSurface: TTSDL_ConvertSurface =nil;
  SDL_ConvertSurfaceFormat: TTSDL_ConvertSurfaceFormat =nil;
  SDL_ConvertPixels: TTSDL_ConvertPixels =nil;
  SDL_FillRect: TTSDL_FillRect =nil;
  SDL_UpperBlit: TTSDL_UpperBlit =nil;
  SDL_LowerBlit: TTSDL_LowerBlit =nil;
  SDL_SoftStretch: TTSDL_SoftStretch =nil;
  SDL_UpperBlitScaled: TTSDL_UpperBlitScaled =nil;
  SDL_LowerBlitScaled: TTSDL_LowerBlitScaled =nil;

  SDL_GetShapedWindowMode: TTSDL_GetShapedWindowMode =nil;
  SDL_SetWindowShape: TTSDL_SetWindowShape =nil;
  SDL_CreateShapedWindow: TTSDL_CreateShapedWindow =nil;
  SDL_IsShapedWindow: TTSDL_IsShapedWindow =nil;

  SDL_GetNumVideoDrivers: TTSDL_GetNumVideoDrivers =nil;
  SDL_GetVideoDriver: TTSDL_GetVideoDriver =nil;
  SDL_VideoInit: TTSDL_VideoInit =nil;
  SDL_VideoQuit: TTSDL_VideoQuit =nil;
  SDL_GetCurrentVideoDriver: TTSDL_GetCurrentVideoDriver =nil;
  SDL_GetNumVideoDisplays: TTSDL_GetNumVideoDisplays =nil;
  SDL_GetDisplayName: TTSDL_GetDisplayName =nil;
  SDL_GetDisplayBounds: TTSDL_GetDisplayBounds =nil;
  SDL_GetDisplayDPI: TTSDL_GetDisplayDPI =nil;
  SDL_GetDisplayUsableBounds: TTSDL_GetDisplayUsableBounds =nil;
  SDL_GetNumDisplayModes: TTSDL_GetNumDisplayModes =nil;
  SDL_GetDisplayMode: TTSDL_GetDisplayMode =nil;
  SDL_GetDesktopDisplayMode: TTSDL_GetDesktopDisplayMode =nil;
  SDL_GetCurrentDisplayMode: TTSDL_GetCurrentDisplayMode =nil;
  SDL_GetClosestDisplayMode: TTSDL_GetClosestDisplayMode =nil;
  SDL_GetWindowDisplayIndex: TTSDL_GetWindowDisplayIndex =nil;
  SDL_SetWindowDisplayMode: TTSDL_SetWindowDisplayMode =nil;
  SDL_GetWindowDisplayMode: TTSDL_GetWindowDisplayMode =nil;
  SDL_GetWindowPixelFormat: TTSDL_GetWindowPixelFormat =nil;
  SDL_CreateWindow: TTSDL_CreateWindow =nil;
  SDL_CreateWindowFrom: TTSDL_CreateWindowFrom =nil;
  SDL_GetWindowID: TTSDL_GetWindowID =nil;
  SDL_GetWindowFromID: TTSDL_GetWindowFromID =nil;
  SDL_GetWindowFlags: TTSDL_GetWindowFlags =nil;
  SDL_SetWindowTitle: TTSDL_SetWindowTitle =nil;
  SDL_GetWindowTitle: TTSDL_GetWindowTitle =nil;
  SDL_SetWindowIcon: TTSDL_SetWindowIcon =nil;
  SDL_SetWindowData: TTSDL_SetWindowData =nil;
  SDL_GetWindowData: TTSDL_GetWindowData =nil;
  SDL_SetWindowPosition: TTSDL_SetWindowPosition =nil;
  SDL_GetWindowPosition: TTSDL_GetWindowPosition =nil;
  SDL_SetWindowSize: TTSDL_SetWindowSize =nil;
  SDL_GetWindowSize: TTSDL_GetWindowSize =nil;
  SDL_GetWindowBordersSize: TTSDL_GetWindowBordersSize =nil;
  SDL_SetWindowMinimumSize: TTSDL_SetWindowMinimumSize =nil;
  SDL_GetWindowMinimumSize: TTSDL_GetWindowMinimumSize =nil;
  SDL_SetWindowMaximumSize: TTSDL_SetWindowMaximumSize =nil;
  SDL_GetWindowMaximumSize: TTSDL_GetWindowMaximumSize =nil;
  SDL_SetWindowBordered: TTSDL_SetWindowBordered =nil;
  SDL_SetWindowResizable: TTSDL_SetWindowResizable =nil;
  SDL_ShowWindow: TTSDL_ShowWindow =nil;
  SDL_HideWindow: TTSDL_HideWindow =nil;
  SDL_RaiseWindow: TTSDL_RaiseWindow =nil;
  SDL_MaximizeWindow: TTSDL_MaximizeWindow =nil;
  SDL_MinimizeWindow: TTSDL_MinimizeWindow =nil;
  SDL_RestoreWindow: TTSDL_RestoreWindow =nil;
  SDL_SetWindowFullscreen: TTSDL_SetWindowFullscreen =nil;
  SDL_GetWindowSurface: TTSDL_GetWindowSurface =nil;
  SDL_UpdateWindowSurface: TTSDL_UpdateWindowSurface =nil;
  SDL_UpdateWindowSurfaceRects: TTSDL_UpdateWindowSurfaceRects =nil;
  SDL_SetWindowGrab: TTSDL_SetWindowGrab =nil;
  SDL_GetWindowGrab: TTSDL_GetWindowGrab =nil;
  SDL_GetGrabbedWindow: TTSDL_GetGrabbedWindow =nil;
  SDL_SetWindowBrightness: TTSDL_SetWindowBrightness =nil;
  SDL_GetWindowBrightness: TTSDL_GetWindowBrightness =nil;
  SDL_SetWindowOpacity: TTSDL_SetWindowOpacity =nil;
  SDL_GetWindowOpacity: TTSDL_GetWindowOpacity =nil;
  SDL_SetWindowModalFor: TTSDL_SetWindowModalFor =nil;
  SDL_SetWindowInputFocus: TTSDL_SetWindowInputFocus =nil;
  SDL_SetWindowGammaRamp: TTSDL_SetWindowGammaRamp =nil;
  SDL_GetWindowGammaRamp: TTSDL_GetWindowGammaRamp =nil;
  SDL_SetWindowHitTest: TTSDL_SetWindowHitTest =nil;
  SDL_DestroyWindow: TTSDL_DestroyWindow =nil;
  SDL_IsScreenSaverEnabled: TTSDL_IsScreenSaverEnabled =nil;
  SDL_EnableScreenSaver: TTSDL_EnableScreenSaver =nil;
  SDL_DisableScreenSaver: TTSDL_DisableScreenSaver =nil;

  SDL_GL_LoadLibrary: TTSDL_GL_LoadLibrary =nil;
  SDL_GL_GetProcAddress: TTSDL_GL_GetProcAddress =nil;
  SDL_GL_UnloadLibrary: TTSDL_GL_UnloadLibrary =nil;
  SDL_GL_ExtensionSupported: TTSDL_GL_ExtensionSupported =nil;
  SDL_GL_ResetAttributes: TTSDL_GL_ResetAttributes =nil;
  SDL_GL_SetAttribute: TTSDL_GL_SetAttribute =nil;
  SDL_GL_GetAttribute: TTSDL_GL_GetAttribute =nil;
  SDL_GL_CreateContext: TTSDL_GL_CreateContext =nil;
  SDL_GL_MakeCurrent: TTSDL_GL_MakeCurrent =nil;
  SDL_GL_GetCurrentWindow: TTSDL_GL_GetCurrentWindow =nil;
  SDL_GL_GetCurrentContext: TTSDL_GL_GetCurrentContext =nil;
  SDL_GL_GetDrawableSize: TTSDL_GL_GetDrawableSize =nil;
  SDL_GL_SetSwapInterval: TTSDL_GL_SetSwapInterval =nil;
  SDL_GL_GetSwapInterval: TTSDL_GL_GetSwapInterval =nil;
  SDL_GL_SwapWindow: TTSDL_GL_SwapWindow =nil;
  SDL_GL_DeleteContext: TTSDL_GL_DeleteContext =nil;

  SDL_SetHintWithPriority: TTSDL_SetHintWithPriority =nil;
  SDL_SetHint: TTSDL_SetHint =nil;
  SDL_GetHint: TTSDL_GetHint =nil;
  SDL_GetHintBoolean: TTSDL_GetHintBoolean =nil;
  SDL_AddHintCallback: TTSDL_AddHintCallback =nil;
  SDL_DelHintCallback: TTSDL_DelHintCallback =nil;
  SDL_ClearHints: TTSDL_ClearHints =nil;
  SDL_LoadObject: TTSDL_LoadObject =nil;
  SDL_LoadFunction: TTSDL_LoadFunction =nil;
  SDL_UnloadObject: TTSDL_UnloadObject =nil;

  SDL_ShowMessageBox: TTSDL_ShowMessageBox =nil;
  SDL_ShowSimpleMessageBox: TTSDL_ShowSimpleMessageBox =nil;

  SDL_GetNumRenderDrivers: TTSDL_GetNumRenderDrivers =nil;
  SDL_GetRenderDriverInfo: TTSDL_GetRenderDriverInfo =nil;
  SDL_CreateWindowAndRenderer: TTSDL_CreateWindowAndRenderer =nil;
  SDL_CreateRenderer: TTSDL_CreateRenderer =nil;
  SDL_CreateSoftwareRenderer: TTSDL_CreateSoftwareRenderer =nil;
  SDL_GetRenderer: TTSDL_GetRenderer =nil;
  SDL_GetRendererInfo: TTSDL_GetRendererInfo =nil;
  SDL_GetRendererOutputSize: TTSDL_GetRendererOutputSize =nil;
  SDL_CreateTexture: TTSDL_CreateTexture =nil;
  SDL_CreateTextureFromSurface: TTSDL_CreateTextureFromSurface =nil;
  SDL_QueryTexture: TTSDL_QueryTexture =nil;
  SDL_SetTextureColorMod: TTSDL_SetTextureColorMod =nil;
  SDL_GetTextureColorMod: TTSDL_GetTextureColorMod =nil;
  SDL_SetTextureAlphaMod: TTSDL_SetTextureAlphaMod =nil;
  SDL_GetTextureAlphaMod: TTSDL_GetTextureAlphaMod =nil;
  SDL_SetTextureBlendMode: TTSDL_SetTextureBlendMode =nil;
  SDL_GetTextureBlendMode: TTSDL_GetTextureBlendMode =nil;
  SDL_UpdateTexture: TTSDL_UpdateTexture =nil;
  SDL_LockTexture: TTSDL_LockTexture =nil;
  SDL_UnlockTexture: TTSDL_UnlockTexture =nil;
  SDL_RenderTargetSupported: TTSDL_RenderTargetSupported =nil;
  SDL_SetRenderTarget: TTSDL_SetRenderTarget =nil;
  SDL_GetRenderTarget: TTSDL_GetRenderTarget =nil;
  SDL_RenderSetLogicalSize: TTSDL_RenderSetLogicalSize =nil;
  SDL_RenderGetLogicalSize: TTSDL_RenderGetLogicalSize =nil;
  SDL_RenderSetViewport: TTSDL_RenderSetViewport =nil;
  SDL_RenderGetViewport: TTSDL_RenderGetViewport =nil;
  SDL_RenderSetClipRect: TTSDL_RenderSetClipRect =nil;
  SDL_RenderGetClipRect: TTSDL_RenderGetClipRect =nil;
  SDL_RenderIsClipEnabled: TTSDL_RenderIsClipEnabled =nil;
  SDL_RenderSetScale: TTSDL_RenderSetScale=nil;
  SDL_RenderGetScale: TTSDL_RenderGetScale =nil;
  SDL_SetRenderDrawColor: TTSDL_SetRenderDrawColor =nil;
  SDL_GetRenderDrawColor: TTSDL_GetRenderDrawColor =nil;
  SDL_SetRenderDrawBlendMode: TTSDL_SetRenderDrawBlendMode =nil;
  SDL_GetRenderDrawBlendMode: TTSDL_GetRenderDrawBlendMode =nil;
  SDL_RenderClear: TTSDL_RenderClear =nil;
  SDL_RenderDrawPoint: TTSDL_RenderDrawPoint =nil;
  SDL_RenderDrawPoints: TTSDL_RenderDrawPoints =nil;
  SDL_RenderDrawLine: TTSDL_RenderDrawLine =nil;
  SDL_RenderDrawLines: TTSDL_RenderDrawLines =nil;
  SDL_RenderDrawRect: TTSDL_RenderDrawRect =nil;
  SDL_RenderDrawRects: TTSDL_RenderDrawRects =nil;
  SDL_RenderFillRect: TTSDL_RenderFillRect =nil;
  SDL_RenderFillRects: TTSDL_RenderFillRects =nil;
  SDL_RenderCopy: TTSDL_RenderCopy =nil;
  SDL_RenderCopyEx: TTSDL_RenderCopyEx =nil;
  SDL_RenderReadPixels: TTSDL_RenderReadPixels =nil;
  SDL_RenderPresent: TTSDL_RenderPresent =nil;
  SDL_DestroyTexture: TTSDL_DestroyTexture =nil;
  SDL_DestroyRenderer: TTSDL_DestroyRenderer =nil;
  SDL_GL_BindTexture: TTSDL_GL_BindTexture =nil;
  SDL_GL_UnbindTexture: TTSDL_GL_UnbindTexture =nil;
  SDL_UpdateYUVTexture: TTSDL_UpdateYUVTexture =nil;

  SDL_GetKeyboardFocus: TTSDL_GetKeyboardFocus =nil;
  SDL_GetKeyboardState: TTSDL_GetKeyboardState =nil;
  SDL_GetModState: TTSDL_GetModState =nil;
  SDL_SetModState: TTSDL_SetModState =nil;
  SDL_GetKeyFromScancode: TTSDL_GetKeyFromScancode =nil;
  SDL_GetScancodeFromKey: TTSDL_GetScancodeFromKey =nil;
  SDL_GetScancodeName: TTSDL_GetScancodeName =nil;
  SDL_GetScancodeFromName: TTSDL_GetScancodeFromName =nil;
  SDL_GetKeyName: TTSDL_GetKeyName =nil;
  SDL_GetKeyFromName: TTSDL_GetKeyFromName =nil;
  SDL_StartTextInput: TTSDL_StartTextInput =nil;
  SDL_IsTextInputActive: TTSDL_IsTextInputActive =nil;
  SDL_StopTextInput: TTSDL_StopTextInput =nil;
  SDL_SetTextInputRect: TTSDL_SetTextInputRect =nil;
  SDL_HasScreenKeyboardSupport: TTSDL_HasScreenKeyboardSupport =nil;
  SDL_IsScreenKeyboardShown: TTSDL_IsScreenKeyboardShown =nil;

  SDL_GetMouseFocus: TTSDL_GetMouseFocus =nil;
  SDL_GetMouseState: TTSDL_GetMouseState =nil;
  SDL_GetGlobalMouseState: TTSDL_GetGlobalMouseState =nil;
  SDL_GetRelativeMouseState: TTSDL_GetRelativeMouseState =nil;
  SDL_WarpMouseInWindow: TTSDL_WarpMouseInWindow =nil;
  SDL_WarpMouseGlobal: TTSDL_WarpMouseGlobal =nil;
  SDL_SetRelativeMouseMode: TTSDL_SetRelativeMouseMode =nil;
  SDL_CaptureMouse: TTSDL_CaptureMouse =nil;
  SDL_GetRelativeMouseMode: TTSDL_GetRelativeMouseMode =nil;
  SDL_CreateCursor: TTSDL_CreateCursor =nil;
  SDL_CreateColorCursor: TTSDL_CreateColorCursor =nil;
  SDL_CreateSystemCursor: TTSDL_CreateSystemCursor =nil;
  SDL_SetCursor: TTSDL_SetCursor =nil;
  SDL_GetCursor: TTSDL_GetCursor =nil;
  SDL_GetDefaultCursor: TTSDL_GetDefaultCursor =nil;
  SDL_FreeCursor: TTSDL_FreeCursor =nil;
  SDL_ShowCursor: TTSDL_ShowCursor =nil;

  SDL_NumJoysticks: TTSDL_NumJoysticks =nil;
  SDL_JoystickNameForIndex: TTSDL_JoystickNameForIndex =nil;
  SDL_JoystickOpen: TTSDL_JoystickOpen =nil;
  SDL_JoystickFromInstanceID: TTSDL_JoystickFromInstanceID =nil;
  SDL_JoystickName: TTSDL_JoystickName =nil;
  SDL_JoystickGetDeviceGUID: TTSDL_JoystickGetDeviceGUID =nil;
  SDL_JoystickGetGUID: TTSDL_JoystickGetGUID =nil;
  SDL_JoystickGetGUIDString: TTSDL_JoystickGetGUIDString =nil;
  SDL_JoystickGetGUIDFromString: TTSDL_JoystickGetGUIDFromString =nil;
  SDL_JoystickGetAttached: TTSDL_JoystickGetAttached =nil;
  SDL_JoystickInstanceID: TTSDL_JoystickInstanceID =nil;
  SDL_JoystickNumAxes: TTSDL_JoystickNumAxes =nil;
  SDL_JoystickNumBalls: TTSDL_JoystickNumBalls =nil;
  SDL_JoystickNumHats: TTSDL_JoystickNumHats =nil;
  SDL_JoystickNumButtons: TTSDL_JoystickNumButtons =nil;
  SDL_JoystickUpdate: TTSDL_JoystickUpdate =nil;
  SDL_JoystickEventState: TTSDL_JoystickEventState =nil;
  SDL_JoystickGetAxis: TTSDL_JoystickGetAxis =nil;
  SDL_JoystickGetHat: TTSDL_JoystickGetHat =nil;
  SDL_JoystickGetBall: TTSDL_JoystickGetBall =nil;
  SDL_JoystickGetButton: TTSDL_JoystickGetButton =nil;
  SDL_JoystickClose: TTSDL_JoystickClose =nil;
  SDL_JoystickCurrentPowerLevel: TTSDL_JoystickCurrentPowerLevel =nil;

  SDL_GameControllerAddMapping: TTSDL_GameControllerAddMapping =nil;
  SDL_GameControllerAddMappingsFromRW: TTSDL_GameControllerAddMappingsFromRW =nil;
  SDL_GameControllerMappingForGUID: TTSDL_GameControllerMappingForGUID =nil;
  SDL_GameControllerMapping: TTSDL_GameControllerMapping =nil;
  SDL_IsGameController: TTSDL_IsGameController =nil;
  SDL_GameControllerNameForIndex: TTSDL_GameControllerNameForIndex =nil;
  SDL_GameControllerOpen: TTSDL_GameControllerOpen =nil;
  SDL_GameControllerFromInstanceID: TTSDL_GameControllerFromInstanceID =nil;
  SDL_GameControllerName: TTSDL_GameControllerName =nil;
  SDL_GameControllerGetAttached: TTSDL_GameControllerGetAttached =nil;
  SDL_GameControllerGetJoystick: TTSDL_GameControllerGetJoystick =nil;
  SDL_GameControllerEventState: TTSDL_GameControllerEventState =nil;
  SDL_GameControllerUpdate: TTSDL_GameControllerUpdate =nil;
  SDL_GameControllerGetAxisFromString: TTSDL_GameControllerGetAxisFromString =nil;
  SDL_GameControllerGetStringForAxis: TTSDL_GameControllerGetStringForAxis =nil;
  SDL_GameControllerGetBindForAxis: TTSDL_GameControllerGetBindForAxis =nil;
  SDL_GameControllerGetAxis: TTSDL_GameControllerGetAxis =nil;
  SDL_GameControllerGetButtonFromString: TTSDL_GameControllerGetButtonFromString =nil;
  SDL_GameControllerGetStringForButton: TTSDL_GameControllerGetStringForButton =nil;
  SDL_GameControllerGetBindForButton: TTSDL_GameControllerGetBindForButton =nil;
  SDL_GameControllerGetButton: TTSDL_GameControllerGetButton =nil;
  SDL_GameControllerClose: TTSDL_GameControllerClose =nil;


  SDL_NumHaptics: TTSDL_NumHaptics =nil;
  SDL_HapticName: TTSDL_HapticName =nil;
  SDL_HapticOpen: TTSDL_HapticOpen =nil;
  SDL_HapticOpened: TTSDL_HapticOpened =nil;
  SDL_HapticIndex: TTSDL_HapticIndex =nil;
  SDL_MouseIsHaptic: TTSDL_MouseIsHaptic =nil;
  SDL_HapticOpenFromMouse: TTSDL_HapticOpenFromMouse =nil;
  SDL_JoystickIsHaptic: TTSDL_JoystickIsHaptic =nil;
  SDL_HapticOpenFromJoystick: TTSDL_HapticOpenFromJoystick =nil;
  SDL_HapticClose: TTSDL_HapticClose =nil;
  SDL_HapticNumEffects: TTSDL_HapticNumEffects =nil;
  SDL_HapticNumEffectsPlaying: TTSDL_HapticNumEffectsPlaying =nil;
  SDL_HapticQuery: TTSDL_HapticQuery =nil;
  SDL_HapticNumAxes: TTSDL_HapticNumAxes =nil;
  SDL_HapticEffectSupported: TTSDL_HapticEffectSupported =nil;
  SDL_HapticNewEffect: TTSDL_HapticNewEffect =nil;
  SDL_HapticUpdateEffect: TTSDL_HapticUpdateEffect =nil;
  SDL_HapticRunEffect: TTSDL_HapticRunEffect =nil;
  SDL_HapticStopEffect: TTSDL_HapticStopEffect =nil;
  SDL_HapticDestroyEffect: TTSDL_HapticDestroyEffect =nil;
  SDL_HapticGetEffectStatus: TTSDL_HapticGetEffectStatus =nil;
  SDL_HapticSetGain: TTSDL_HapticSetGain =nil;
  SDL_HapticSetAutocenter: TTSDL_HapticSetAutocenter =nil;
  SDL_HapticPause: TTSDL_HapticPause =nil;
  SDL_HapticUnpause: TTSDL_HapticUnpause =nil;
  SDL_HapticStopAll: TTSDL_HapticStopAll =nil;
  SDL_HapticRumbleSupported: TTSDL_HapticRumbleSupported =nil;
  SDL_HapticRumbleInit: TTSDL_HapticRumbleInit =nil;
  SDL_HapticRumblePlay: TTSDL_HapticRumblePlay =nil;
  SDL_HapticRumbleStop: TTSDL_HapticRumbleStop =nil;

  SDL_GetNumTouchDevices: TTSDL_GetNumTouchDevices =nil;
  SDL_GetTouchDevice: TTSDL_GetTouchDevice =nil;
  SDL_GetNumTouchFingers: TTSDL_GetNumTouchFingers =nil;
  SDL_GetTouchFinger: TTSDL_GetTouchFinger =nil;

  SDL_RecordGesture: TTSDL_RecordGesture =nil;
  SDL_SaveAllDollarTemplates: TTSDL_SaveAllDollarTemplates =nil;
  SDL_SaveDollarTemplate: TTSDL_SaveDollarTemplate =nil;
  SDL_LoadDollarTemplates: TTSDL_LoadDollarTemplates =nil;

  SDL_GetWindowWMInfo: TTSDL_GetWindowWMInfo =nil;

  SDL_PumpEvents: TTSDL_PumpEvents =nil;
  SDL_PeepEvents: TTSDL_PeepEvents =nil;
  SDL_HasEvent: TTSDL_HasEvent =nil;
  SDL_HasEvents: TTSDL_HasEvents =nil;
  SDL_FlushEvent: TTSDL_FlushEvent =nil;
  SDL_FlushEvents: TTSDL_FlushEvents =nil;
  SDL_PollEvent: TTSDL_PollEvent =nil;
  SDL_WaitEvent: TTSDL_WaitEvent =nil;
  SDL_WaitEventTimeout: TTSDL_WaitEventTimeout=nil;
  SDL_PushEvent: TTSDL_PushEvent =nil;
  SDL_SetEventFilter: TTSDL_SetEventFilter =nil;
  SDL_GetEventFilter: TTSDL_GetEventFilter =nil;
  SDL_AddEventWatch: TTSDL_AddEventWatch =nil;
  SDL_DelEventWatch: TTSDL_DelEventWatch =nil;
  SDL_FilterEvents: TTSDL_FilterEvents =nil;
  SDL_EventState: TTSDL_EventState =nil;
  SDL_RegisterEvents: TTSDL_RegisterEvents =nil;
  SDL_SetClipboardText: TTSDL_SetClipboardText =nil;
  SDL_GetClipboardText: TTSDL_GetClipboardText =nil;
  SDL_HasClipboardText: TTSDL_HasClipboardText =nil;
  SDL_GetCPUCount: TTSDL_GetCPUCount =nil;
  SDL_GetCPUCacheLineSize: TTSDL_GetCPUCacheLineSize =nil;
  SDL_HasRDTSC: TTSDL_HasRDTSC =nil;
  SDL_HasAltiVec: TTSDL_HasAltiVec =nil;
  SDL_HasMMX: TTSDL_HasMMX =nil;
  SDL_Has3DNow: TTSDL_Has3DNow =nil;
  SDL_HasSSE: TTSDL_HasSSE =nil;
  SDL_HasSSE2: TTSDL_HasSSE2 =nil;
  SDL_HasSSE3: TTSDL_HasSSE3 =nil;
  SDL_HasSSE41: TTSDL_HasSSE41 =nil;
  SDL_HasSSE42: TTSDL_HasSSE42 =nil;
  SDL_HasAVX: TTSDL_HasAVX =nil;
  SDL_HasAVX2: TTSDL_HasAVX2 =nil;
  SDL_GetSystemRAM: TTSDL_GetSystemRAM =nil;
  SDL_GetBasePath: TTSDL_GetBasePath =nil;
  SDL_GetPrefPath: TTSDL_GetPrefPath =nil;
  SDL_LogSetAllPriority: TTSDL_LogSetAllPriority =nil;
  SDL_LogSetPriority: TTSDL_LogSetPriority =nil;
  SDL_LogGetPriority: TTSDL_LogGetPriority =nil;
  SDL_LogResetPriorities: TTSDL_LogResetPriorities =nil;
  SDL_Log: TTSDL_Log =nil;
  SDL_LogVerbose: TTSDL_LogVerbose =nil;
  SDL_LogDebug: TTSDL_LogDebug =nil;
  SDL_LogInfo: TTSDL_LogInfo =nil;
  SDL_LogWarn: TTSDL_LogWarn =nil;
  SDL_LogError: TTSDL_LogError =nil;
  SDL_LogCritical: TTSDL_LogCritical =nil;
  SDL_LogMessage: TTSDL_LogMessage =nil;
  SDL_LogMessageV: TTSDL_LogMessageV =nil;
  SDL_LogGetOutputFunction: TTSDL_LogGetOutputFunction =nil;
  SDL_LogSetOutputFunction: TTSDL_LogSetOutputFunction =nil;


{$IFDEF WINDOWS}
  SDL_SetWindowsMessageHook: TTSDL_SetWindowsMessageHook =nil;
  SDL_Direct3D9GetAdapterIndex: TTSDL_Direct3D9GetAdapterIndex =nil;
  SDL_RenderGetD3D9Device: TTSDL_RenderGetD3D9Device =nil;
  SDL_DXGIGetOutputInfo: TTSDL_DXGIGetOutputInfo =nil;
{$IFEND}
{$IFDEF WINCE}
 SDL_WinRTGetFSPathUNICODE: TTSDL_WinRTGetFSPathUNICODE =nil;
 SDL_WinRTGetFSPathUTF8: TTSDL_WinRTGetFSPathUTF8 =nil;
{$ENDIF}


 SDL_Init: TTSDL_Init =nil;
 SDL_InitSubSystem: TTSDL_InitSubSystem =nil;
 SDL_QuitSubSystem: TTSDL_QuitSubSystem =nil;
 SDL_WasInit: TTSDL_WasInit =nil;
 SDL_Quit: TTSDL_Quit =nil;


//...................................................

function  SDL2LIB_Initialize(const aLibName: String = SDL_LibName): Boolean;
procedure SDL2LIB_Finalize;

//========================================================================
//========================================================================
//========================================================================

implementation

//========================================================================
//========================================================================
//========================================================================

//----------- sdl_version.h -------------------

procedure SDL_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL_MAJOR_VERSION;
  x.minor := SDL_MINOR_VERSION;
  x.patch := SDL_PATCHLEVEL;
end;

function SDL_VERSIONNUM(X,Y,Z: UInt32): Cardinal;
begin
  Result := X*1000 + Y*100 + Z;
end;

function SDL_COMPILEDVERSION: Cardinal;
begin
  Result := SDL_VERSIONNUM(SDL_MAJOR_VERSION,
                           SDL_MINOR_VERSION,
                           SDL_PATCHLEVEL);
end;

function SDL_VERSION_ATLEAST(X,Y,Z: Cardinal): Boolean;
begin
  Result := SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X,Y,Z);
end;

//----------- sdl_mouse -------------------
function SDL_Button(button: SInt32): SInt32;
begin
  Result := 1 shl (button - 1);
end;

{$IFDEF WINDOWS}
//----------- sdl_thread -------------------

function SDL_CreateThread2(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer): PSDL_Thread; overload;
begin
  Result := SDL_CreateThread(fn,name,data,nil,nil);
end;

{$ENDIF}

//----------- sdl_rect -------------------
function SDL_RectEmpty(const r: PSDL_Rect): Boolean;
begin
  Result := (r^.w <= 0) or (r^.h <= 0);
end;

function SDL_RectEquals(const a, b: PSDL_Rect): Boolean;
begin
  Result := (a^.x = b^.x) and (a^.y = b^.y) and (a^.w = b^.w) and (a^.h = b^.h);
end;

function SDL_PointInRect(const p: PSDL_Point; const r: PSDL_Rect): Boolean;
begin
  Result :=
    (p^.x >= r^.x) and (p^.x < (r^.x + r^.w))
    and
    (p^.y >= r^.y) and (p^.y < (r^.y + r^.h))
end;

//----------- sdl_rwops -------------------

function SDL_RWsize(ctx: PSDL_RWops): SInt64;
begin
  Result := ctx^.size(ctx);
end;

function SDL_RWseek(ctx: PSDL_RWops; offset: SInt64; whence: SInt32): SInt64;
begin
  Result := ctx^.seek(ctx,offset,whence);
end;

function SDL_RWtell(ctx: PSDL_RWops): SInt64;
begin
  Result := ctx^.seek(ctx, 0, RW_SEEK_CUR);
end;

function SDL_RWread(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t;
begin
  Result := ctx^.read(ctx, ptr, size, n);
end;

function SDL_RWwrite(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t;
begin
  Result := ctx^.write(ctx, ptr, size, n);
end;

function SDL_RWclose(ctx: PSDL_RWops): SInt32;
begin
  Result := ctx^.close(ctx);
end;

//----------- sdl_audio -------------------

function SDL_LoadWAV(_file: PAnsiChar; spec: PSDL_AudioSpec; audio_buf: PPUInt8; audio_len: PUInt32): PSDL_AudioSpec;
begin
  Result := SDL_LoadWAV_RW(SDL_RWFromFile(_file, 'rb'), 1, spec, audio_buf, audio_len);
end;

function SDL_AUDIO_BITSIZE(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_BITSIZE;
end;

function SDL_AUDIO_ISFLOAT(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_DATATYPE;
end;

function SDL_AUDIO_ISBIGENDIAN(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_ENDIAN;
end;

function SDL_AUDIO_ISSIGNED(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_SIGNED;
end;

function SDL_AUDIO_ISINT(x: Cardinal): Cardinal;
begin
  Result := not SDL_AUDIO_ISFLOAT(x);
end;

function SDL_AUDIO_ISLITTLEENDIAN(x: Cardinal): Cardinal;
begin
  Result := not SDL_AUDIO_ISLITTLEENDIAN(x);
end;

function SDL_AUDIO_ISUNSIGNED(x: Cardinal): Cardinal;
begin
  Result := not SDL_AUDIO_ISSIGNED(x);
end;

//----------- sdl_pixels -------------------

function SDL_PIXELFLAG(X: Cardinal): Cardinal;
begin
  Result := (X shr 28) and $0F;
end;

function SDL_PIXELTYPE(X: Cardinal): Cardinal;
begin
  Result := (X shr 24) and $0F;
end;

function SDL_PIXELORDER(X: Cardinal): Cardinal;
begin
  Result := (X shr 20) and $0F;
end;

function SDL_PIXELLAYOUT(X: Cardinal): Cardinal;
begin
  Result := (X shr 16) and $0F;
end;

function SDL_BITSPERPIXEL(X: Cardinal): Cardinal;
begin
  Result := (X shr 8) and $FF;
end;

function SDL_IsPixelFormat_FOURCC(format: Variant): Boolean;
begin
  Result := format and SDL_PIXELFLAG(format) <> 1;
end;

//----------- sdl_surface -------------------
function SDL_LoadBMP(_file: PAnsiChar): PSDL_Surface;
begin
  Result := SDL_LoadBMP_RW(SDL_RWFromFile(_file, 'rb'), 1);
end;

function SDL_SaveBMP(Const surface:PSDL_Surface; Const filename:AnsiString):sInt32;
begin
   Result := SDL_SaveBMP_RW(surface, SDL_RWFromFile(PAnsiChar(filename), 'wb'), 1)
end;

function SDL_MUSTLOCK(Const S:PSDL_Surface):Boolean;
begin
  Result := ((S^.flags and SDL_RLEACCEL) <> 0)
end;

//----------- sdl_video -------------------
function SDL_WindowPos_IsUndefined(X: Variant): Variant;
begin
  Result := (X and QWord($FFFF0000)) = SDL_WINDOWPOS_UNDEFINED_MASK;
end;

function SDL_WindowPos_IsCentered(X: Variant): Variant;
begin
  Result := (X and QWord($FFFF0000)) = SDL_WINDOWPOS_CENTERED_MASK;
end;

//----------- sdl_events -------------------

function SDL_GetEventState(type_: UInt32): UInt8;
begin
  Result := SDL_EventState(type_, SDL_QUERY);
end;

//-------------------sdl_timer -------------------
function SDL_TICKS_PASSED(Const A, B:UInt32):Boolean;
begin
   Result := ((Int64(B) - Int64(A)) <= 0)
end;

//-------------------sdl_gamecontroller -------------------
function SDL_GameControllerAddMappingsFromFile(Const FilePath:PAnsiChar):SInt32;
begin
  Result := SDL_GameControllerAddMappingsFromRW(SDL_RWFromFile(FilePath, 'rb'), 1)
end;


//========================================================================
//========================================================================
//========================================================================

const
 InvalidLibHandle = 0;

var
  VarSDL2LibHandle: TLibHandle = InvalidLibHandle;


function SDL2LIB_Initialize(const aLibName: String = SDL_LibName): Boolean;
//.............................
function _GetProcAddress(const aProcName: String): {$ifdef cpui8086}FarPointer{$else}Pointer{$endif};
begin
  result := nil;
  if aProcName='' then exit;

  result := dynlibs.GetProcedureAddress(VarSDL2LibHandle, AnsiString(aProcName));
end;
//.....................................
  var xLibName: String;
begin
  if VarSDL2LibHandle>InvalidLibHandle then
    begin
      result:=true;
      exit;
    end;

  result:=false;
  xLibName:=aLibName;
  VarSDL2LibHandle := dynlibs.LoadLibrary(xLibName);

  if VarSDL2LibHandle=0 then Exit;

  //-------------------------------------------

  Pointer(SDL_GetVersion):= _GetProcAddress('SDL_GetVersion');
  Pointer(SDL_GetRevision):= _GetProcAddress('SDL_GetRevision');
  Pointer(SDL_GetRevisionNumber):= _GetProcAddress('SDL_GetRevisionNumber');

  Pointer(SDL_SetError):= _GetProcAddress('SDL_SetError');
  Pointer(SDL_GetError):= _GetProcAddress('SDL_GetError');
  Pointer(SDL_ClearError):= _GetProcAddress('SDL_ClearError');
  Pointer(SDL_Error):= _GetProcAddress('SDL_Error');
  Pointer(SDL_GetPlatform):= _GetProcAddress('SDL_GetPlatform');

  Pointer(SDL_CreateThread):= _GetProcAddress('SDL_CreateThread');

  Pointer(SDL_GetThreadName):= _GetProcAddress('SDL_GetThreadName');
  Pointer(SDL_ThreadID):= _GetProcAddress('SDL_ThreadID');
  Pointer(SDL_GetThreadID):= _GetProcAddress('SDL_GetThreadID');
  Pointer(SDL_SetThreadPriority):= _GetProcAddress('SDL_SetThreadPriority');
  Pointer(SDL_WaitThread):= _GetProcAddress('SDL_WaitThread');
  Pointer(SDL_DetachThread):= _GetProcAddress('SDL_DetachThread');
  Pointer(SDL_TLSCreate):= _GetProcAddress('SDL_TLSCreate');
  Pointer(SDL_TLSGet):= _GetProcAddress('SDL_TLSGet');
  Pointer(SDL_TLSSet):= _GetProcAddress('SDL_TLSSet');

  Pointer(SDL_CreateMutex):= _GetProcAddress('SDL_CreateMutex');
  Pointer(SDL_LockMutex):= _GetProcAddress('SDL_LockMutex');
  Pointer(SDL_TryLockMutex):= _GetProcAddress('SDL_TryLockMutex');
  Pointer(SDL_UnlockMutex):= _GetProcAddress('SDL_UnlockMutex');
  Pointer(SDL_DestroyMutex):= _GetProcAddress('SDL_DestroyMutex');
  Pointer(SDL_CreateSemaphore):= _GetProcAddress('SDL_CreateSemaphore');
  Pointer(SDL_DestroySemaphore):= _GetProcAddress('SDL_DestroySemaphore');
  Pointer(SDL_SemWait):= _GetProcAddress('SDL_SemWait');
  Pointer(SDL_SemTryWait):= _GetProcAddress('SDL_SemTryWait');
  Pointer(SDL_SemWaitTimeout):= _GetProcAddress('SDL_SemWaitTimeout');
  Pointer(SDL_SemPost):= _GetProcAddress('SDL_SemPost');
  Pointer(SDL_SemValue):= _GetProcAddress('SDL_SemValue');
  Pointer(SDL_CreateCond):= _GetProcAddress('SDL_CreateCond');
  Pointer(SDL_DestroyCond):= _GetProcAddress('SDL_DestroyCond');
  Pointer(SDL_CondSignal):= _GetProcAddress('SDL_CondSignal');
  Pointer(SDL_CondBroadcast):= _GetProcAddress('SDL_CondBroadcast');
  Pointer(SDL_CondWait):= _GetProcAddress('SDL_CondWait');
  Pointer(SDL_CondWaitTimeout):= _GetProcAddress('SDL_CondWaitTimeout');

  Pointer(SDL_GetTicks):= _GetProcAddress('SDL_GetTicks');
  Pointer(SDL_GetPerformanceCounter):= _GetProcAddress('SDL_GetPerformanceCounter');
  Pointer(SDL_GetPerformanceFrequency):= _GetProcAddress('SDL_GetPerformanceFrequency');
  Pointer(SDL_Delay):= _GetProcAddress('SDL_Delay');
  Pointer(SDL_AddTimer):= _GetProcAddress('SDL_AddTimer');
  Pointer(SDL_RemoveTimer):= _GetProcAddress('SDL_RemoveTimer');

  Pointer(SDL_GetPixelFormatName):= _GetProcAddress('SDL_GetPixelFormatName');
  Pointer(SDL_PixelFormatEnumToMasks):= _GetProcAddress('SDL_PixelFormatEnumToMasks');
  Pointer(SDL_MasksToPixelFormatEnum):= _GetProcAddress('SDL_MasksToPixelFormatEnum');
  Pointer(SDL_AllocFormat):= _GetProcAddress('SDL_AllocFormat');
  Pointer(SDL_FreeFormat):= _GetProcAddress('SDL_FreeFormat');
  Pointer(SDL_AllocPalette):= _GetProcAddress('SDL_AllocPalette');
  Pointer(SDL_SetPixelFormatPalette):= _GetProcAddress('SDL_SetPixelFormatPalette');
  Pointer(SDL_SetPaletteColors):= _GetProcAddress('SDL_SetPaletteColors');
  Pointer(SDL_FreePalette):= _GetProcAddress('SDL_FreePalette');
  Pointer(SDL_MapRGB):= _GetProcAddress('SDL_MapRGB');
  Pointer(SDL_MapRGBA):= _GetProcAddress('SDL_MapRGBA');
  Pointer(SDL_GetRGB):= _GetProcAddress('SDL_GetRGB');
  Pointer(SDL_GetRGBA):= _GetProcAddress('SDL_GetRGBA');
  Pointer(SDL_CalculateGammaRamp):= _GetProcAddress('SDL_CalculateGammaRamp');

  Pointer(SDL_HasIntersection):= _GetProcAddress('SDL_HasIntersection');
  Pointer(SDL_IntersectRect):= _GetProcAddress('SDL_IntersectRect');
  Pointer(SDL_UnionRect):= _GetProcAddress('SDL_UnionRect');
  Pointer(SDL_EnclosePoints):= _GetProcAddress('SDL_EnclosePoints');
  Pointer(SDL_IntersectRectAndLine):= _GetProcAddress('SDL_IntersectRectAndLine');

  Pointer(SDL_RWFromFile):= _GetProcAddress('SDL_RWFromFile');
  Pointer(SDL_RWFromFP):= _GetProcAddress('SDL_RWFromFP');
  Pointer(SDL_RWFromMem):= _GetProcAddress('SDL_RWFromMem');
  Pointer(SDL_RWFromConstMem):= _GetProcAddress('SDL_RWFromConstMem');
  Pointer(SDL_AllocRW):=_GetProcAddress('SDL_AllocRW');
  Pointer(SDL_FreeRW):= _GetProcAddress('SDL_FreeRW');
  Pointer(SDL_ReadU8):= _GetProcAddress('SDL_ReadU8');
  Pointer(SDL_ReadLE16):= _GetProcAddress('SDL_ReadLE16');
  Pointer(SDL_ReadBE16):= _GetProcAddress('SDL_ReadBE16');
  Pointer(SDL_ReadLE32):= _GetProcAddress('SDL_ReadLE32');
  Pointer(SDL_ReadBE32):= _GetProcAddress('SDL_ReadBE32');
  Pointer(SDL_ReadLE64):= _GetProcAddress('SDL_ReadLE64');
  Pointer(SDL_ReadBE64):= _GetProcAddress('SDL_ReadBE64');
  Pointer(SDL_WriteU8):= _GetProcAddress('SDL_WriteU8');
  Pointer(SDL_WriteLE16):= _GetProcAddress('SDL_WriteLE16');
  Pointer(SDL_WriteBE16):= _GetProcAddress('SDL_WriteBE16');
  Pointer(SDL_WriteLE32):= _GetProcAddress('SDL_WriteLE32');
  Pointer(SDL_WriteBE32):= _GetProcAddress('SDL_WriteBE32');
  Pointer(SDL_WriteLE64):= _GetProcAddress('SDL_WriteLE64');
  Pointer(SDL_WriteBE64):= _GetProcAddress('SDL_WriteBE64');

  Pointer(SDL_GetNumAudioDrivers):= _GetProcAddress('SDL_GetNumAudioDrivers');
  Pointer(SDL_GetAudioDriver):= _GetProcAddress('SDL_GetAudioDriver');
  Pointer(SDL_AudioInit):= _GetProcAddress('SDL_AudioInit');
  Pointer(SDL_AudioQuit):= _GetProcAddress('SDL_AudioQuit');
  Pointer(SDL_GetCurrentAudioDriver):= _GetProcAddress('SDL_GetCurrentAudioDriver');
  Pointer(SDL_OpenAudio):= _GetProcAddress('SDL_OpenAudio');
  Pointer(SDL_GetNumAudioDevices):= _GetProcAddress('SDL_GetNumAudioDevices');
  Pointer(SDL_GetAudioDeviceName):= _GetProcAddress('SDL_GetAudioDeviceName');
  Pointer(SDL_OpenAudioDevice):= _GetProcAddress('SDL_OpenAudioDevice');
  Pointer(SDL_GetAudioStatus):= _GetProcAddress('SDL_GetAudioStatus');
  Pointer(SDL_GetAudioDeviceStatus):= _GetProcAddress('SDL_GetAudioDeviceStatus');
  Pointer(SDL_PauseAudio):= _GetProcAddress('SDL_PauseAudio');
  Pointer(SDL_PauseAudioDevice):= _GetProcAddress('SDL_PauseAudioDevice');
  Pointer(SDL_LoadWAV_RW):= _GetProcAddress('SDL_LoadWAV_RW');
  Pointer(SDL_FreeWAV):= _GetProcAddress('SDL_FreeWAV');
  Pointer(SDL_BuildAudioCVT):= _GetProcAddress('SDL_BuildAudioCVT');
  Pointer(SDL_ConvertAudio):= _GetProcAddress('SDL_ConvertAudio');
  Pointer(SDL_MixAudio):= _GetProcAddress('SDL_MixAudio');
  Pointer(SDL_MixAudioFormat):= _GetProcAddress('SDL_MixAudioFormat');
  Pointer(SDL_QueueAudio):= _GetProcAddress('SDL_QueueAudio');
  Pointer(SDL_DequeueAudio):= _GetProcAddress('SDL_DequeueAudio');
  Pointer(SDL_GetQueuedAudioSize):= _GetProcAddress('SDL_GetQueuedAudioSize');
  Pointer(SDL_ClearQueuedAudio):= _GetProcAddress('SDL_ClearQueuedAudio');
  Pointer(SDL_LockAudio):= _GetProcAddress('SDL_LockAudio');
  Pointer(SDL_LockAudioDevice):= _GetProcAddress('SDL_LockAudioDevice');
  Pointer(SDL_UnlockAudio):= _GetProcAddress('SDL_UnlockAudio');
  Pointer(SDL_UnlockAudioDevice):= _GetProcAddress('SDL_UnlockAudioDevice');
  Pointer(SDL_CloseAudio):= _GetProcAddress('SDL_CloseAudio');
  Pointer(SDL_CloseAudioDevice):= _GetProcAddress('SDL_CloseAudioDevice');

  Pointer(SDL_CreateRGBSurface):= _GetProcAddress('SDL_CreateRGBSurface');
  Pointer(SDL_CreateRGBSurfaceWithFormat):= _GetProcAddress('SDL_CreateRGBSurfaceWithFormat');
  Pointer(SDL_CreateRGBSurfaceFrom):= _GetProcAddress('SDL_CreateRGBSurfaceFrom');
  Pointer(SDL_CreateRGBSurfaceWithFormatFrom):= _GetProcAddress('SDL_CreateRGBSurfaceWithFormatFrom');
  Pointer(SDL_FreeSurface):= _GetProcAddress('SDL_FreeSurface');
  Pointer(SDL_SetSurfacePalette):= _GetProcAddress('SDL_SetSurfacePalette');
  Pointer(SDL_LockSurface):= _GetProcAddress('SDL_LockSurface');
  Pointer(SDL_UnlockSurface):= _GetProcAddress('SDL_UnlockSurface');
  Pointer(SDL_LoadBMP_RW):= _GetProcAddress('SDL_LoadBMP_RW');
  Pointer(SDL_SaveBMP_RW):= _GetProcAddress('SDL_SaveBMP_RW');
  Pointer(SDL_SetSurfaceRLE):= _GetProcAddress('SDL_SetSurfaceRLE');
  Pointer(SDL_SetColorKey):= _GetProcAddress('SDL_SetColorKey');
  Pointer(SDL_GetColorKey):= _GetProcAddress('SDL_GetColorKey');
  Pointer(SDL_SetSurfaceColorMod):= _GetProcAddress('SDL_SetSurfaceColorMod');
  Pointer(SDL_GetSurfaceColorMod):= _GetProcAddress('SDL_GetSurfaceColorMod');
  Pointer(SDL_SetSurfaceAlphaMod):= _GetProcAddress('SDL_SetSurfaceAlphaMod');
  Pointer(SDL_GetSurfaceAlphaMod):= _GetProcAddress('SDL_GetSurfaceAlphaMod');
  Pointer(SDL_SetSurfaceBlendMode):= _GetProcAddress('SDL_SetSurfaceBlendMode');
  Pointer(SDL_GetSurfaceBlendMode):= _GetProcAddress('SDL_GetSurfaceBlendMode');
  Pointer(SDL_SetClipRect):= _GetProcAddress('SDL_SetClipRect');
  Pointer(SDL_GetClipRect):= _GetProcAddress('SDL_GetClipRect');
  Pointer(SDL_ConvertSurface):= _GetProcAddress('SDL_ConvertSurface');
  Pointer(SDL_ConvertSurfaceFormat):= _GetProcAddress('SDL_ConvertSurfaceFormat');
  Pointer(SDL_ConvertPixels):= _GetProcAddress('SDL_ConvertPixels');
  Pointer(SDL_FillRect):= _GetProcAddress('SDL_FillRect');
  Pointer(SDL_UpperBlit):= _GetProcAddress('SDL_UpperBlit');
  Pointer(SDL_LowerBlit):= _GetProcAddress('SDL_LowerBlit');
  Pointer(SDL_SoftStretch):= _GetProcAddress('SDL_SoftStretch');
  Pointer(SDL_UpperBlitScaled):= _GetProcAddress('SDL_UpperBlitScaled');
  Pointer(SDL_LowerBlitScaled):= _GetProcAddress('SDL_LowerBlitScaled');

  Pointer(SDL_GetShapedWindowMode):= _GetProcAddress('SDL_GetShapedWindowMode');
  Pointer(SDL_SetWindowShape):= _GetProcAddress('SDL_SetWindowShape');
  Pointer(SDL_CreateShapedWindow):= _GetProcAddress('SDL_CreateShapedWindow');
  Pointer(SDL_IsShapedWindow):= _GetProcAddress('SDL_IsShapedWindow');

  Pointer(SDL_GetNumVideoDrivers):= _GetProcAddress('SDL_GetNumVideoDrivers');
  Pointer(SDL_GetVideoDriver):= _GetProcAddress('SDL_GetVideoDriver');
  Pointer(SDL_VideoInit):= _GetProcAddress('SDL_VideoInit');
  Pointer(SDL_VideoQuit):= _GetProcAddress('SDL_VideoQuit');
  Pointer(SDL_GetCurrentVideoDriver):= _GetProcAddress('SDL_GetCurrentVideoDriver');
  Pointer(SDL_GetNumVideoDisplays):= _GetProcAddress('SDL_GetNumVideoDisplays');
  Pointer(SDL_GetDisplayName):= _GetProcAddress('SDL_GetDisplayName');
  Pointer(SDL_GetDisplayBounds):= _GetProcAddress('SDL_GetDisplayBounds');
  Pointer(SDL_GetDisplayDPI):= _GetProcAddress('SDL_GetDisplayDPI');
  Pointer(SDL_GetDisplayUsableBounds):= _GetProcAddress('SDL_GetDisplayUsableBounds');
  Pointer(SDL_GetNumDisplayModes):= _GetProcAddress('SDL_GetNumDisplayModes');
  Pointer(SDL_GetDisplayMode):= _GetProcAddress('SDL_GetDisplayMode');
  Pointer(SDL_GetDesktopDisplayMode):= _GetProcAddress('SDL_GetDesktopDisplayMode');
  Pointer(SDL_GetCurrentDisplayMode):= _GetProcAddress('SDL_GetCurrentDisplayMode');
  Pointer(SDL_GetClosestDisplayMode):= _GetProcAddress('SDL_GetClosestDisplayMode');
  Pointer(SDL_GetWindowDisplayIndex):= _GetProcAddress('SDL_GetWindowDisplayIndex');
  Pointer(SDL_SetWindowDisplayMode):= _GetProcAddress('SDL_SetWindowDisplayMode');
  Pointer(SDL_GetWindowDisplayMode):= _GetProcAddress('SDL_GetWindowDisplayMode');
  Pointer(SDL_GetWindowPixelFormat):= _GetProcAddress('SDL_GetWindowPixelFormat');
  Pointer(SDL_CreateWindow):= _GetProcAddress('SDL_CreateWindow');
  Pointer(SDL_CreateWindowFrom):= _GetProcAddress('SDL_CreateWindowFrom');
  Pointer(SDL_GetWindowID):= _GetProcAddress('SDL_GetWindowID');
  Pointer(SDL_GetWindowFromID):= _GetProcAddress('SDL_GetWindowFromID');
  Pointer(SDL_GetWindowFlags):= _GetProcAddress('SDL_GetWindowFlags');
  Pointer(SDL_SetWindowTitle):= _GetProcAddress('SDL_SetWindowTitle');
  Pointer(SDL_GetWindowTitle):= _GetProcAddress('SDL_GetWindowTitle');
  Pointer(SDL_SetWindowIcon):= _GetProcAddress('SDL_SetWindowIcon');
  Pointer(SDL_SetWindowData):= _GetProcAddress('SDL_SetWindowData');
  Pointer(SDL_GetWindowData):= _GetProcAddress('SDL_GetWindowData');
  Pointer(SDL_SetWindowPosition):= _GetProcAddress('SDL_SetWindowPosition');
  Pointer(SDL_GetWindowPosition):= _GetProcAddress('SDL_GetWindowPosition');
  Pointer(SDL_SetWindowSize):= _GetProcAddress('SDL_SetWindowSize');
  Pointer(SDL_GetWindowSize):= _GetProcAddress('SDL_GetWindowSize');
  Pointer(SDL_GetWindowBordersSize):= _GetProcAddress('SDL_GetWindowBordersSize');
  Pointer(SDL_SetWindowMinimumSize):= _GetProcAddress('SDL_SetWindowMinimumSize');
  Pointer(SDL_GetWindowMinimumSize):= _GetProcAddress('SDL_GetWindowMinimumSize');
  Pointer(SDL_SetWindowMaximumSize):= _GetProcAddress('SDL_SetWindowMaximumSize');
  Pointer(SDL_GetWindowMaximumSize):= _GetProcAddress('SDL_GetWindowMaximumSize');
  Pointer(SDL_SetWindowBordered):= _GetProcAddress('SDL_SetWindowBordered');
  Pointer(SDL_SetWindowResizable):= _GetProcAddress('SDL_SetWindowResizable');
  Pointer(SDL_ShowWindow):= _GetProcAddress('SDL_ShowWindow');
  Pointer(SDL_HideWindow):= _GetProcAddress('SDL_HideWindow');
  Pointer(SDL_RaiseWindow):= _GetProcAddress('SDL_RaiseWindow');
  Pointer(SDL_MaximizeWindow):= _GetProcAddress('SDL_MaximizeWindow');
  Pointer(SDL_MinimizeWindow):= _GetProcAddress('SDL_MinimizeWindow');
  Pointer(SDL_RestoreWindow):= _GetProcAddress('SDL_RestoreWindow');
  Pointer(SDL_SetWindowFullscreen):= _GetProcAddress('SDL_SetWindowFullscreen');
  Pointer(SDL_GetWindowSurface):= _GetProcAddress('SDL_GetWindowSurface');
  Pointer(SDL_UpdateWindowSurface):= _GetProcAddress('SDL_UpdateWindowSurface');
  Pointer(SDL_UpdateWindowSurfaceRects):= _GetProcAddress('SDL_UpdateWindowSurfaceRects');
  Pointer(SDL_SetWindowGrab):= _GetProcAddress('SDL_SetWindowGrab');
  Pointer(SDL_GetWindowGrab):= _GetProcAddress('SDL_GetWindowGrab');
  Pointer(SDL_GetGrabbedWindow):= _GetProcAddress('SDL_GetGrabbedWindow');
  Pointer(SDL_SetWindowBrightness):= _GetProcAddress('SDL_SetWindowBrightness');
  Pointer(SDL_GetWindowBrightness):= _GetProcAddress('SDL_GetWindowBrightness');
  Pointer(SDL_SetWindowOpacity):= _GetProcAddress('SDL_SetWindowOpacity');
  Pointer(SDL_GetWindowOpacity):= _GetProcAddress('SDL_GetWindowOpacity');
  Pointer(SDL_SetWindowModalFor):= _GetProcAddress('SDL_SetWindowModalFor');
  Pointer(SDL_SetWindowInputFocus):= _GetProcAddress('SDL_SetWindowInputFocus');
  Pointer(SDL_SetWindowGammaRamp):= _GetProcAddress('SDL_SetWindowGammaRamp');
  Pointer(SDL_GetWindowGammaRamp):= _GetProcAddress('SDL_GetWindowGammaRamp');
  Pointer(SDL_SetWindowHitTest):= _GetProcAddress('SDL_SetWindowHitTest');
  Pointer(SDL_DestroyWindow):= _GetProcAddress('SDL_DestroyWindow');
  Pointer(SDL_IsScreenSaverEnabled):= _GetProcAddress('SDL_IsScreenSaverEnabled');
  Pointer(SDL_EnableScreenSaver):= _GetProcAddress('SDL_EnableScreenSaver');
  Pointer(SDL_DisableScreenSaver):= _GetProcAddress('SDL_DisableScreenSaver');

  Pointer(SDL_GL_LoadLibrary):= _GetProcAddress('SDL_GL_LoadLibrary');
  Pointer(SDL_GL_GetProcAddress):= _GetProcAddress('SDL_GL_GetProcAddress');
  Pointer(SDL_GL_UnloadLibrary):= _GetProcAddress('SDL_GL_UnloadLibrary');
  Pointer(SDL_GL_ExtensionSupported):= _GetProcAddress('SDL_GL_ExtensionSupported');
  Pointer(SDL_GL_ResetAttributes):= _GetProcAddress('SDL_GL_ResetAttributes');
  Pointer(SDL_GL_SetAttribute):= _GetProcAddress('SDL_GL_SetAttribute');
  Pointer(SDL_GL_GetAttribute):= _GetProcAddress('SDL_GL_GetAttribute');
  Pointer(SDL_GL_CreateContext):= _GetProcAddress('SDL_GL_CreateContext');
  Pointer(SDL_GL_MakeCurrent):= _GetProcAddress('SDL_GL_MakeCurrent');
  Pointer(SDL_GL_GetCurrentWindow):= _GetProcAddress('SDL_GL_GetCurrentWindow');
  Pointer(SDL_GL_GetCurrentContext):= _GetProcAddress('SDL_GL_GetCurrentContext');
  Pointer(SDL_GL_GetDrawableSize):= _GetProcAddress('SDL_GL_GetDrawableSize');
  Pointer(SDL_GL_SetSwapInterval):= _GetProcAddress('SDL_GL_SetSwapInterval');
  Pointer(SDL_GL_GetSwapInterval):= _GetProcAddress('SDL_GL_GetSwapInterval');
  Pointer(SDL_GL_SwapWindow):= _GetProcAddress('SDL_GL_SwapWindow');
  Pointer(SDL_GL_DeleteContext):= _GetProcAddress('SDL_GL_DeleteContext');

  Pointer(SDL_SetHintWithPriority):= _GetProcAddress('SDL_SetHintWithPriority');
  Pointer(SDL_SetHint):= _GetProcAddress('SDL_SetHint');
  Pointer(SDL_GetHint):= _GetProcAddress('SDL_GetHint');
  Pointer(SDL_GetHintBoolean):= _GetProcAddress('SDL_GetHintBoolean');
  Pointer(SDL_AddHintCallback):= _GetProcAddress('SDL_AddHintCallback');
  Pointer(SDL_DelHintCallback):= _GetProcAddress('SDL_DelHintCallback');
  Pointer(SDL_ClearHints):= _GetProcAddress('SDL_ClearHints');
  Pointer(SDL_LoadObject):= _GetProcAddress('SDL_LoadObject');
  Pointer(SDL_LoadFunction):= _GetProcAddress('SDL_LoadFunction');
  Pointer(SDL_UnloadObject):= _GetProcAddress('SDL_UnloadObject');

  Pointer(SDL_ShowMessageBox):= _GetProcAddress('SDL_ShowMessageBox');
  Pointer(SDL_ShowSimpleMessageBox):= _GetProcAddress('SDL_ShowSimpleMessageBox');

  Pointer(SDL_GetNumRenderDrivers):= _GetProcAddress('SDL_GetNumRenderDrivers');
  Pointer(SDL_GetRenderDriverInfo):= _GetProcAddress('SDL_GetRenderDriverInfo');
  Pointer(SDL_CreateWindowAndRenderer):= _GetProcAddress('SDL_CreateWindowAndRenderer');
  Pointer(SDL_CreateRenderer):= _GetProcAddress('SDL_CreateRenderer');
  Pointer(SDL_CreateSoftwareRenderer):= _GetProcAddress('SDL_CreateSoftwareRenderer');
  Pointer(SDL_GetRenderer):= _GetProcAddress('SDL_GetRenderer');
  Pointer(SDL_GetRendererInfo):= _GetProcAddress('SDL_GetRendererInfo');
  Pointer(SDL_GetRendererOutputSize):= _GetProcAddress('SDL_GetRendererOutputSize');
  Pointer(SDL_CreateTexture):= _GetProcAddress('SDL_CreateTexture');
  Pointer(SDL_CreateTextureFromSurface):= _GetProcAddress('SDL_CreateTextureFromSurface');
  Pointer(SDL_QueryTexture):= _GetProcAddress('SDL_QueryTexture');
  Pointer(SDL_SetTextureColorMod):= _GetProcAddress('SDL_SetTextureColorMod');
  Pointer(SDL_GetTextureColorMod):= _GetProcAddress('SDL_GetTextureColorMod');
  Pointer(SDL_SetTextureAlphaMod):= _GetProcAddress('SDL_SetTextureAlphaMod');
  Pointer(SDL_GetTextureAlphaMod):= _GetProcAddress('SDL_GetTextureAlphaMod');
  Pointer(SDL_SetTextureBlendMode):= _GetProcAddress('SDL_SetTextureBlendMode');
  Pointer(SDL_GetTextureBlendMode):= _GetProcAddress('SDL_GetTextureBlendMode');
  Pointer(SDL_UpdateTexture):= _GetProcAddress('SDL_UpdateTexture');
  Pointer(SDL_LockTexture):= _GetProcAddress('SDL_LockTexture');
  Pointer(SDL_UnlockTexture):= _GetProcAddress('SDL_UnlockTexture');
  Pointer(SDL_RenderTargetSupported):= _GetProcAddress('SDL_RenderTargetSupported');
  Pointer(SDL_SetRenderTarget):= _GetProcAddress('SDL_SetRenderTarget');
  Pointer(SDL_GetRenderTarget):= _GetProcAddress('SDL_GetRenderTarget');
  Pointer(SDL_RenderSetLogicalSize):= _GetProcAddress('SDL_RenderSetLogicalSize');
  Pointer(SDL_RenderGetLogicalSize):= _GetProcAddress('SDL_RenderGetLogicalSize');
  Pointer(SDL_RenderSetViewport):= _GetProcAddress('SDL_RenderSetViewport');
  Pointer(SDL_RenderGetViewport):= _GetProcAddress('SDL_RenderGetViewport');
  Pointer(SDL_RenderSetClipRect):= _GetProcAddress('SDL_RenderSetClipRect');
  Pointer(SDL_RenderGetClipRect):= _GetProcAddress('SDL_RenderGetClipRect');
  Pointer(SDL_RenderIsClipEnabled):= _GetProcAddress('SDL_RenderIsClipEnabled');
  Pointer(SDL_RenderSetScale):= _GetProcAddress('SDL_RenderSetScale');
  Pointer(SDL_RenderGetScale):= _GetProcAddress('SDL_RenderGetScale');
  Pointer(SDL_SetRenderDrawColor):= _GetProcAddress('SDL_SetRenderDrawColor');
  Pointer(SDL_GetRenderDrawColor):= _GetProcAddress('SDL_GetRenderDrawColor');
  Pointer(SDL_SetRenderDrawBlendMode):= _GetProcAddress('SDL_SetRenderDrawBlendMode');
  Pointer(SDL_GetRenderDrawBlendMode):= _GetProcAddress('SDL_GetRenderDrawBlendMode');
  Pointer(SDL_RenderClear):= _GetProcAddress('SDL_RenderClear');
  Pointer(SDL_RenderDrawPoint):= _GetProcAddress('SDL_RenderDrawPoint');
  Pointer(SDL_RenderDrawPoints):= _GetProcAddress('SDL_RenderDrawPoints');
  Pointer(SDL_RenderDrawLine):= _GetProcAddress('SDL_RenderDrawLine');
  Pointer(SDL_RenderDrawLines):= _GetProcAddress('SDL_RenderDrawLines');
  Pointer(SDL_RenderDrawRect):= _GetProcAddress('SDL_RenderDrawRect');
  Pointer(SDL_RenderDrawRects):= _GetProcAddress('SDL_RenderDrawRects');
  Pointer(SDL_RenderFillRect):= _GetProcAddress('SDL_RenderFillRect');
  Pointer(SDL_RenderFillRects):= _GetProcAddress('SDL_RenderFillRects');
  Pointer(SDL_RenderCopy):= _GetProcAddress('SDL_RenderCopy');
  Pointer(SDL_RenderCopyEx):= _GetProcAddress('SDL_RenderCopyEx');
  Pointer(SDL_RenderReadPixels):= _GetProcAddress('SDL_RenderReadPixels');
  Pointer(SDL_RenderPresent):= _GetProcAddress('SDL_RenderPresent');
  Pointer(SDL_DestroyTexture):= _GetProcAddress('SDL_DestroyTexture');
  Pointer(SDL_DestroyRenderer):= _GetProcAddress('SDL_DestroyRenderer');
  Pointer(SDL_GL_BindTexture):= _GetProcAddress('SDL_GL_BindTexture');
  Pointer(SDL_GL_UnbindTexture):= _GetProcAddress('SDL_GL_UnbindTexture');
  Pointer(SDL_UpdateYUVTexture):= _GetProcAddress('SDL_UpdateYUVTexture');

  Pointer(SDL_GetKeyboardFocus):= _GetProcAddress('SDL_GetKeyboardFocus');
  Pointer(SDL_GetKeyboardState):= _GetProcAddress('SDL_GetKeyboardState');
  Pointer(SDL_GetModState):= _GetProcAddress('SDL_GetModState');
  Pointer(SDL_SetModState):= _GetProcAddress('SDL_SetModState');
  Pointer(SDL_GetKeyFromScancode):= _GetProcAddress('SDL_GetKeyFromScancode');
  Pointer(SDL_GetScancodeFromKey):= _GetProcAddress('SDL_GetScancodeFromKey');
  Pointer(SDL_GetScancodeName):= _GetProcAddress('SDL_GetScancodeName');
  Pointer(SDL_GetScancodeFromName):= _GetProcAddress('SDL_GetScancodeFromName');
  Pointer(SDL_GetKeyName):= _GetProcAddress('SDL_GetKeyName');
  Pointer(SDL_GetKeyFromName):= _GetProcAddress('SDL_GetKeyFromName');
  Pointer(SDL_StartTextInput):= _GetProcAddress('SDL_StartTextInput');
  Pointer(SDL_IsTextInputActive):= _GetProcAddress('SDL_IsTextInputActive');
  Pointer(SDL_StopTextInput):= _GetProcAddress('SDL_StopTextInput');
  Pointer(SDL_SetTextInputRect):= _GetProcAddress('SDL_SetTextInputRect');
  Pointer(SDL_HasScreenKeyboardSupport):= _GetProcAddress('SDL_HasScreenKeyboardSupport');
  Pointer(SDL_IsScreenKeyboardShown):= _GetProcAddress('SDL_IsScreenKeyboardShown');

  Pointer(SDL_GetMouseFocus):= _GetProcAddress('SDL_GetMouseFocus');
  Pointer(SDL_GetMouseState):= _GetProcAddress('SDL_GetMouseState');
  Pointer(SDL_GetGlobalMouseState):= _GetProcAddress('SDL_GetGlobalMouseState');
  Pointer(SDL_GetRelativeMouseState):= _GetProcAddress('SDL_GetRelativeMouseState');
  Pointer(SDL_WarpMouseInWindow):= _GetProcAddress('SDL_WarpMouseInWindow');
  Pointer(SDL_WarpMouseGlobal):= _GetProcAddress('SDL_WarpMouseGlobal');
  Pointer(SDL_SetRelativeMouseMode):= _GetProcAddress('SDL_SetRelativeMouseMode');
  Pointer(SDL_CaptureMouse):= _GetProcAddress('SDL_CaptureMouse');
  Pointer(SDL_GetRelativeMouseMode):= _GetProcAddress('SDL_GetRelativeMouseMode');
  Pointer(SDL_CreateCursor):= _GetProcAddress('SDL_CreateCursor');
  Pointer(SDL_CreateColorCursor):= _GetProcAddress('SDL_CreateColorCursor');
  Pointer(SDL_CreateSystemCursor):= _GetProcAddress('SDL_CreateSystemCursor');
  Pointer(SDL_SetCursor):= _GetProcAddress('SDL_SetCursor');
  Pointer(SDL_GetCursor):= _GetProcAddress('SDL_GetCursor');
  Pointer(SDL_GetDefaultCursor):= _GetProcAddress('SDL_GetDefaultCursor');
  Pointer(SDL_FreeCursor):= _GetProcAddress('SDL_FreeCursor');
  Pointer(SDL_ShowCursor):= _GetProcAddress('SDL_ShowCursor');

  Pointer(SDL_NumJoysticks):= _GetProcAddress('SDL_NumJoysticks');
  Pointer(SDL_JoystickNameForIndex):= _GetProcAddress('SDL_JoystickNameForIndex');
  Pointer(SDL_JoystickOpen):= _GetProcAddress('SDL_JoystickOpen');
  Pointer(SDL_JoystickFromInstanceID):= _GetProcAddress('SDL_JoystickFromInstanceID');
  Pointer(SDL_JoystickName):= _GetProcAddress('SDL_JoystickName');
  Pointer(SDL_JoystickGetDeviceGUID):= _GetProcAddress('SDL_JoystickGetDeviceGUID');
  Pointer(SDL_JoystickGetGUID):= _GetProcAddress('SDL_JoystickGetGUID');
  Pointer(SDL_JoystickGetGUIDString):= _GetProcAddress('SDL_JoystickGetGUIDString');
  Pointer(SDL_JoystickGetGUIDFromString):= _GetProcAddress('SDL_JoystickGetGUIDFromString');
  Pointer(SDL_JoystickGetAttached):= _GetProcAddress('SDL_JoystickGetAttached');
  Pointer(SDL_JoystickInstanceID):= _GetProcAddress('SDL_JoystickInstanceID');
  Pointer(SDL_JoystickNumAxes):= _GetProcAddress('SDL_JoystickNumAxes');
  Pointer(SDL_JoystickNumBalls):= _GetProcAddress('SDL_JoystickNumBalls');
  Pointer(SDL_JoystickNumHats):= _GetProcAddress('SDL_JoystickNumHats');
  Pointer(SDL_JoystickNumButtons):= _GetProcAddress('SDL_JoystickNumButtons');
  Pointer(SDL_JoystickUpdate):= _GetProcAddress('SDL_JoystickUpdate');
  Pointer(SDL_JoystickEventState):= _GetProcAddress('SDL_JoystickEventState');
  Pointer(SDL_JoystickGetAxis):= _GetProcAddress('SDL_JoystickGetAxis');
  Pointer(SDL_JoystickGetHat):= _GetProcAddress('SDL_JoystickGetHat');
  Pointer(SDL_JoystickGetBall):= _GetProcAddress('SDL_JoystickGetBall');
  Pointer(SDL_JoystickGetButton):= _GetProcAddress('SDL_JoystickGetButton');
  Pointer(SDL_JoystickClose):= _GetProcAddress('SDL_JoystickClose');
  Pointer(SDL_JoystickCurrentPowerLevel):= _GetProcAddress('SDL_JoystickCurrentPowerLevel');

  Pointer(SDL_GameControllerAddMapping):= _GetProcAddress('SDL_GameControllerAddMapping');
  Pointer(SDL_GameControllerAddMappingsFromRW):= _GetProcAddress('SDL_GameControllerAddMappingsFromRW');
  Pointer(SDL_GameControllerMappingForGUID):= _GetProcAddress('SDL_GameControllerMappingForGUID');
  Pointer(SDL_GameControllerMapping):= _GetProcAddress('SDL_GameControllerMapping');
  Pointer(SDL_IsGameController):= _GetProcAddress('SDL_IsGameController');
  Pointer(SDL_GameControllerNameForIndex):= _GetProcAddress('SDL_GameControllerNameForIndex');
  Pointer(SDL_GameControllerOpen):= _GetProcAddress('SDL_GameControllerOpen');
  Pointer(SDL_GameControllerFromInstanceID):= _GetProcAddress('SDL_GameControllerFromInstanceID');
  Pointer(SDL_GameControllerName):= _GetProcAddress('SDL_GameControllerName');
  Pointer(SDL_GameControllerGetAttached):= _GetProcAddress('SDL_GameControllerGetAttached');
  Pointer(SDL_GameControllerGetJoystick):= _GetProcAddress('SDL_GameControllerGetJoystick');
  Pointer(SDL_GameControllerEventState):= _GetProcAddress('SDL_GameControllerEventState');
  Pointer(SDL_GameControllerUpdate):= _GetProcAddress('SDL_GameControllerUpdate');
  Pointer(SDL_GameControllerGetAxisFromString):= _GetProcAddress('SDL_GameControllerGetAxisFromString');
  Pointer(SDL_GameControllerGetStringForAxis):= _GetProcAddress('SDL_GameControllerGetStringForAxis');
  Pointer(SDL_GameControllerGetBindForAxis):= _GetProcAddress('SDL_GameControllerGetBindForAxis');
  Pointer(SDL_GameControllerGetAxis):= _GetProcAddress('SDL_GameControllerGetAxis');
  Pointer(SDL_GameControllerGetButtonFromString):= _GetProcAddress('SDL_GameControllerGetButtonFromString');
  Pointer(SDL_GameControllerGetStringForButton):= _GetProcAddress('SDL_GameControllerGetStringForButton');
  Pointer(SDL_GameControllerGetBindForButton):= _GetProcAddress('SDL_GameControllerGetBindForButton');
  Pointer(SDL_GameControllerGetButton):= _GetProcAddress('SDL_GameControllerGetButton');
  Pointer(SDL_GameControllerClose):= _GetProcAddress('SDL_GameControllerClose');


  Pointer(SDL_NumHaptics):= _GetProcAddress('SDL_NumHaptics');
  Pointer(SDL_HapticName):= _GetProcAddress('SDL_HapticName');
  Pointer(SDL_HapticOpen):= _GetProcAddress('SDL_HapticOpen');
  Pointer(SDL_HapticOpened):= _GetProcAddress('SDL_HapticOpened');
  Pointer(SDL_HapticIndex):= _GetProcAddress('SDL_HapticIndex');
  Pointer(SDL_MouseIsHaptic):= _GetProcAddress('SDL_MouseIsHaptic');
  Pointer(SDL_HapticOpenFromMouse):= _GetProcAddress('SDL_HapticOpenFromMouse');
  Pointer(SDL_JoystickIsHaptic):= _GetProcAddress('SDL_JoystickIsHaptic');
  Pointer(SDL_HapticOpenFromJoystick):= _GetProcAddress('SDL_HapticOpenFromJoystick');
  Pointer(SDL_HapticClose):= _GetProcAddress('SDL_HapticClose');
  Pointer(SDL_HapticNumEffects):= _GetProcAddress('SDL_HapticNumEffects');
  Pointer(SDL_HapticNumEffectsPlaying):= _GetProcAddress('SDL_HapticNumEffectsPlaying');
  Pointer(SDL_HapticQuery):= _GetProcAddress('SDL_HapticQuery');
  Pointer(SDL_HapticNumAxes):= _GetProcAddress('SDL_HapticNumAxes');
  Pointer(SDL_HapticEffectSupported):= _GetProcAddress('SDL_HapticEffectSupported');
  Pointer(SDL_HapticNewEffect):= _GetProcAddress('SDL_HapticNewEffect');
  Pointer(SDL_HapticUpdateEffect):= _GetProcAddress('SDL_HapticUpdateEffect');
  Pointer(SDL_HapticRunEffect):= _GetProcAddress('SDL_HapticRunEffect');
  Pointer(SDL_HapticStopEffect):= _GetProcAddress('SDL_HapticStopEffect');
  Pointer(SDL_HapticDestroyEffect):= _GetProcAddress('SDL_HapticDestroyEffect');
  Pointer(SDL_HapticGetEffectStatus):= _GetProcAddress('SDL_HapticGetEffectStatus');
  Pointer(SDL_HapticSetGain):= _GetProcAddress('SDL_HapticSetGain');
  Pointer(SDL_HapticSetAutocenter):= _GetProcAddress('SDL_HapticSetAutocenter');
  Pointer(SDL_HapticPause):= _GetProcAddress('SDL_HapticPause');
  Pointer(SDL_HapticUnpause):= _GetProcAddress('SDL_HapticUnpause');
  Pointer(SDL_HapticStopAll):= _GetProcAddress('SDL_HapticStopAll');
  Pointer(SDL_HapticRumbleSupported):= _GetProcAddress('SDL_HapticRumbleSupported');
  Pointer(SDL_HapticRumbleInit):= _GetProcAddress('SDL_HapticRumbleInit');
  Pointer(SDL_HapticRumblePlay):= _GetProcAddress('SDL_HapticRumblePlay');
  Pointer(SDL_HapticRumbleStop):= _GetProcAddress('SDL_HapticRumbleStop');

  Pointer(SDL_GetNumTouchDevices):= _GetProcAddress('SDL_GetNumTouchDevices');
  Pointer(SDL_GetTouchDevice):= _GetProcAddress('SDL_GetTouchDevice');
  Pointer(SDL_GetNumTouchFingers):= _GetProcAddress('SDL_GetNumTouchFingers');
  Pointer(SDL_GetTouchFinger):= _GetProcAddress('SDL_GetTouchFinger');

  Pointer(SDL_RecordGesture):= _GetProcAddress('SDL_RecordGesture');
  Pointer(SDL_SaveAllDollarTemplates):= _GetProcAddress('SDL_SaveAllDollarTemplates');
  Pointer(SDL_SaveDollarTemplate):= _GetProcAddress('SDL_SaveDollarTemplate');
  Pointer(SDL_LoadDollarTemplates):= _GetProcAddress('SDL_LoadDollarTemplates');

  Pointer(SDL_GetWindowWMInfo):= _GetProcAddress('SDL_GetWindowWMInfo');

  Pointer(SDL_PumpEvents):= _GetProcAddress('SDL_PumpEvents');
  Pointer(SDL_PeepEvents):= _GetProcAddress('SDL_PeepEvents');
  Pointer(SDL_HasEvent):= _GetProcAddress('SDL_HasEvent');
  Pointer(SDL_HasEvents):= _GetProcAddress('SDL_HasEvents');
  Pointer(SDL_FlushEvent):= _GetProcAddress('SDL_FlushEvent');
  Pointer(SDL_FlushEvents):= _GetProcAddress('SDL_FlushEvents');
  Pointer(SDL_PollEvent):= _GetProcAddress('SDL_PollEvent');
  Pointer(SDL_WaitEvent):= _GetProcAddress('SDL_WaitEvent');
  Pointer(SDL_WaitEventTimeout):= _GetProcAddress('SDL_WaitEventTimeout');
  Pointer(SDL_PushEvent):= _GetProcAddress('SDL_PushEvent');
  Pointer(SDL_SetEventFilter):= _GetProcAddress('SDL_SetEventFilter');
  Pointer(SDL_GetEventFilter):= _GetProcAddress('SDL_GetEventFilter');
  Pointer(SDL_AddEventWatch):= _GetProcAddress('SDL_AddEventWatch');
  Pointer(SDL_DelEventWatch):= _GetProcAddress('SDL_DelEventWatch');
  Pointer(SDL_FilterEvents):= _GetProcAddress('SDL_FilterEvents');
  Pointer(SDL_EventState):= _GetProcAddress('SDL_EventState');
  Pointer(SDL_RegisterEvents):= _GetProcAddress('SDL_RegisterEvents');
  Pointer(SDL_SetClipboardText):= _GetProcAddress('SDL_SetClipboardText');
  Pointer(SDL_GetClipboardText):= _GetProcAddress('SDL_GetClipboardText');
  Pointer(SDL_HasClipboardText):= _GetProcAddress('SDL_HasClipboardText');
  Pointer(SDL_GetCPUCount):= _GetProcAddress('SDL_GetCPUCount');
  Pointer(SDL_GetCPUCacheLineSize):= _GetProcAddress('SDL_GetCPUCacheLineSize');
  Pointer(SDL_HasRDTSC):= _GetProcAddress('SDL_HasRDTSC');
  Pointer(SDL_HasAltiVec):= _GetProcAddress('SDL_HasAltiVec');
  Pointer(SDL_HasMMX):= _GetProcAddress('SDL_HasMMX');
  Pointer(SDL_Has3DNow):= _GetProcAddress('SDL_Has3DNow');
  Pointer(SDL_HasSSE):= _GetProcAddress('SDL_HasSSE');
  Pointer(SDL_HasSSE2):= _GetProcAddress('SDL_HasSSE2');
  Pointer(SDL_HasSSE3):= _GetProcAddress('SDL_HasSSE3');
  Pointer(SDL_HasSSE41):= _GetProcAddress('SDL_HasSSE41');
  Pointer(SDL_HasSSE42):= _GetProcAddress('SDL_HasSSE42');
  Pointer(SDL_HasAVX):= _GetProcAddress('SDL_HasAVX');
  Pointer(SDL_HasAVX2):= _GetProcAddress('SDL_HasAVX2');
  Pointer(SDL_GetSystemRAM):= _GetProcAddress('SDL_GetSystemRAM');
  Pointer(SDL_GetBasePath):= _GetProcAddress('SDL_GetBasePath');
  Pointer(SDL_GetPrefPath):= _GetProcAddress('SDL_GetPrefPath');
  Pointer(SDL_LogSetAllPriority):= _GetProcAddress('SDL_LogSetAllPriority');
  Pointer(SDL_LogSetPriority):= _GetProcAddress('SDL_LogSetPriority');
  Pointer(SDL_LogGetPriority):= _GetProcAddress('SDL_LogGetPriority');
  Pointer(SDL_LogResetPriorities):= _GetProcAddress('SDL_LogResetPriorities');
  Pointer(SDL_Log):= _GetProcAddress('SDL_Log');
  Pointer(SDL_LogVerbose):= _GetProcAddress('SDL_LogVerbose');
  Pointer(SDL_LogDebug):= _GetProcAddress('SDL_LogDebug');
  Pointer(SDL_LogInfo):= _GetProcAddress('SDL_LogInfo');
  Pointer(SDL_LogWarn):= _GetProcAddress('SDL_LogWarn');
  Pointer(SDL_LogError):= _GetProcAddress('SDL_LogError');
  Pointer(SDL_LogCritical):= _GetProcAddress('SDL_LogCritical');
  Pointer(SDL_LogMessage):= _GetProcAddress('SDL_LogMessage');
  Pointer(SDL_LogMessageV):= _GetProcAddress('SDL_LogMessageV');
  Pointer(SDL_LogGetOutputFunction):= _GetProcAddress('SDL_LogGetOutputFunction');
  Pointer(SDL_LogSetOutputFunction):= _GetProcAddress('SDL_LogSetOutputFunction');


{$IFDEF WINDOWS}
  Pointer(SDL_SetWindowsMessageHook):= _GetProcAddress('SDL_SetWindowsMessageHook');
  Pointer(SDL_Direct3D9GetAdapterIndex):= _GetProcAddress('SDL_Direct3D9GetAdapterIndex');
  Pointer(SDL_RenderGetD3D9Device):= _GetProcAddress('SDL_RenderGetD3D9Device');
  Pointer(SDL_DXGIGetOutputInfo):= _GetProcAddress('SDL_DXGIGetOutputInfo');
{$IFEND}
{$IFDEF WINCE}
 Pointer(SDL_WinRTGetFSPathUNICODE):= TTSDL_WinRTGetFSPathUNICODE _GetProcAddress('SDL_WinRTGetFSPathUNICODE');
 Pointer(SDL_WinRTGetFSPathUTF8):= TTSDL_WinRTGetFSPathUTF8 _GetProcAddress('SDL_WinRTGetFSPathUTF8');
{$ENDIF}


 Pointer(SDL_Init):= _GetProcAddress('SDL_Init');
 Pointer(SDL_InitSubSystem):= _GetProcAddress('SDL_InitSubSystem');
 Pointer(SDL_QuitSubSystem):= _GetProcAddress('SDL_QuitSubSystem');
 Pointer(SDL_WasInit):= _GetProcAddress('SDL_WasInit');
 Pointer(SDL_Quit):= _GetProcAddress('SDL_Quit');

//------------------------------------------

  result:=true;
end;

procedure SDL2LIB_Finalize;
begin
  if (VarSDL2LibHandle <> InvalidLibHandle) then
    begin
      dynlibs.FreeLibrary(VarSDL2LibHandle);
      VarSDL2LibHandle := InvalidLibHandle;
    end;
end;


//========================================================================
//========================================================================
//========================================================================

initialization

finalization
  SDL2LIB_Finalize;

end.

