(*
  Copyright 2020 Akira13641
  License: http://www.opensource.org/licenses/BSD-2-Clause

  This unit implements a basic high-level cross-platform example runner
  around an SDL2 window.
*)

unit ExampleRunner;

{$mode ObjFPC}
{$modeswitch AdvancedRecords}

interface

uses
  SysUtils,
  Math,
  SDL2Lib in './SDL2/SDL2Lib.pas',
  BGFX in '../../Source/BGFX.pas';

type
  // Type alias for a basic parameterless rendering procedure
  // intended to be called in a loop.
  TRenderProc = procedure;

  // A basic cross-platform static example runner.
  TExampleRunner = record
  public const
    DEFAULT_WIDTH = 1280;
    DEFAULT_HEIGHT = 720;
    DEFAULT_CLEAR_COLOR = $303030ff;
    DEBUG = BGFX_DEBUG_TEXT;
    RESET = BGFX_RESET_VSYNC;
  public class var
    Width, Height: UInt16;
    ClearColor: UInt32;
    PlatformData: bgfx_platform_data_t;
    Init: bgfx_init_t;
    Encoder: Pbgfx_encoder_t;
    WindowModeInfo: TSDL_SysWMinfo;
    Window: PSDL_Window;
    Event: TSDL_Event;
  public
    // Creates an SDL2 window and initializes BGFX in a fully platform-agnostic way.
    class procedure Initialize(const AWidth: UInt16 = DEFAULT_WIDTH;
                               const AHeight: UInt16 = DEFAULT_HEIGHT;
                               const AClearColor: UInt32 = DEFAULT_CLEAR_COLOR); static;
    // Calls `RenderProc` in a loop until receiving an `SDL_QUITEV` message in `Event`.
    class procedure Run(const RenderProc: TRenderProc); static;
    // Closes the SDL2 window and then finalizes both SDL2 and BGFX.
    class procedure Finalize; static;
  end;

implementation

class procedure TExampleRunner.Initialize(const AWidth: UInt16 = DEFAULT_WIDTH;
                                          const AHeight: UInt16 = DEFAULT_HEIGHT;
                                          const AClearColor: UInt32 = DEFAULT_CLEAR_COLOR);
begin
  // Assign the user-provided parameters to our internal window state variables.
  Width := AWidth;
  Height := AHeight;
  ClearColor := AClearColor;

  // Initialize SDL2 and create a basic window with it for BGFX rendering.
  SDL2LIB_Initialize();

  if SDL_Init(SDL_INIT_VIDEO) < 0 then begin
    WriteLn(Format('SDL2 initialization error: %s'#10, [SDL_GetError()]));
  end else begin
    Window := SDL_CreateWindow('PasBGFX Hello World', SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, Width, Height, SDL_WINDOW_SHOWN);
    if Window = nil then
      WriteLn(Format('SDL2 window creation error: %s'#10, [SDL_GetError()]));
  end;

  SDL_VERSION(WindowModeInfo.Version);
  if SDL_GetWindowWMInfo(Window, @WindowModeInfo) = SDL_FALSE then
    Halt(1);

  // Some platform-specific window boilerplate.
  {$if Defined(Windows)}
    PlatformData.NWH := Pointer(WindowModeInfo.Win.Window);
  {$elseif Defined(Linux)}
    PlatformData.NDT := WindowModeInfo.Info.X11.Display;
    PlatformData.NWH := Pointer(WindowModeInfo.Info.X11.Window);
  {$elseif Defined(Darwin)}
    PlatformData.NWH := Pointer(WMI.Info.Cocoa.Window);
  {$endif}

  // Tell BGFX about the platform and window, then initialize it.
  bgfx_set_platform_data(@PlatformData);

  bgfx_init_ctor(@Init);

  bgfx_init(@Init);

  bgfx_reset(Width, Height, Reset, Init.Resolution.Format);

  // Enable debug text.
  bgfx_set_debug(Debug);

  // Set the default "background" color.
  bgfx_set_view_clear(0, BGFX_CLEAR_COLOR or BGFX_CLEAR_DEPTH, ClearColor, 1.0, 0);

  // Initialize our SDL2 event record.
  Event := Default(TSDL_Event);
end;

class procedure TExampleRunner.Run(const RenderProc: TRenderProc);
var Quit: Boolean = False;
begin
  // Start up the main rendering loop.
  while not Quit do begin
    while SDL_PollEvent(@Event) <> 0 do begin
      if Event.type_ = SDL_QUITEV then
        Quit := True;

      // Reset the viewport.
      bgfx_set_view_rect(0, 0, 0, Width, Height);

      // This dummy draw call ensures that the viewport is cleared if no other draw calls are submitted to it.
      Encoder := bgfx_encoder_begin(True);
      bgfx_encoder_touch(Encoder, 0);
      bgfx_encoder_end(Encoder);

      // Call `RenderProc` so it can do whatever actual drawing it needs to.
      RenderProc();

      // Advance to the next frame. The rendering thread will be kicked to
      // process the submitted rendering primitives.
      bgfx_frame(False);
    end;
  end;
end;

class procedure TExampleRunner.Finalize;
begin
  // Shut down BGFX.
  bgfx_shutdown();

  // Free the SDL2 window.
  SDL_DestroyWindow(Window);

  // Shut down SDL2.
  SDL_Quit();
end;

end.