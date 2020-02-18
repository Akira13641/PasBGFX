(*
  Copyright 2020 Akira13641
  License: http://www.opensource.org/licenses/BSD-2-Clause
  This is a port of the BGFX C99 API "Hello World" example to Free Pascal.
*)

program HelloWorld;

{$mode ObjFPC}

uses
  SysUtils,
  Math,
  SDL2Lib in '../Common/SDL2/SDL2Lib.pas',
  BGFX in '../../Source/BGFX.pas';

{$I logo.inc}

var
  Quit: Boolean = False;
  Width: UInt16 = 1280;
  Height: UInt16 = 720;
  Debug: UInt16 = BGFX_DEBUG_TEXT;
  Reset: UInt16 = BGFX_RESET_VSYNC;
  PD: bgfx_platform_data_t;
  Init: bgfx_init_t;
  Encoder: Pbgfx_encoder_t;
  WMI: TSDL_SysWMinfo;
  Window: PSDL_Window = nil;
  Event: TSDL_Event;

begin
  //Initialize SDL2 and create a basic window with it for BGFX rendering.
  SDL2LIB_Initialize();

  if SDL_Init(SDL_INIT_VIDEO) < 0 then begin
    WriteLn(Format('SDL2 initialization error: %s\n', [SDL_GetError()]));
  end else begin
    Window := SDL_CreateWindow('PasBGFX Hello World', SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WIDTH, HEIGHT, SDL_WINDOW_SHOWN);
    if Window = nil then
      WriteLn(Format('SDL2 window creation error: %s\n', [SDL_GetError()]));
  end;

  SDL_VERSION(WMI.version);
  if SDL_GetWindowWMInfo(Window, @WMI) = SDL_FALSE then
    Halt(1);

  // Some platform-specific window boilerplate.
  // TODO: Add an ifdef here for OSX also...
  {$if Defined(Windows)}
    PD.nwh := Pointer(WMI.win.window);
  {$elseif Defined(Linux)}
    PD.ndt = WMI.info.x11.display;
    PD.nwh = Pointer(WMI.info.x11.window);
  {$endif}

  // Tell bgfx about the platform and window, then initialize it.
  bgfx_set_platform_data(@PD);

  bgfx_init_ctor(@Init);

  bgfx_init(@Init);
  bgfx_reset(Width, Height, Reset, Init.resolution.format);

  // Enable debug text.
  bgfx_set_debug(Debug);

  // Set the default "background" color.
  bgfx_set_view_clear(0, BGFX_CLEAR_COLOR or BGFX_CLEAR_DEPTH, $303030ff, 1.0, 0);

  // Initialize our SDL event record.
  Event := Default(TSDL_Event);

  // Start our rendering loop.
  while not Quit do begin
    while SDL_PollEvent(@Event) <> 0 do begin
      if Event.type_ = SDL_QUITEV then
        Quit := True;

      // Set the default viewport.
      bgfx_set_view_rect(0, 0, 0, Width, Height);

      // This dummy draw call is here to make sure that view 0 is cleared
      // if no other draw calls are submitted to it.
      Encoder := bgfx_encoder_begin(True);
      bgfx_encoder_touch(Encoder, 0);
      bgfx_encoder_end(Encoder);

      // Use the debug font to print information about this example.
      bgfx_dbg_text_clear(0, False);
      bgfx_dbg_text_image(Max(Width div 2 div 8, 20) - 20, Max(Height div 2 div 16, 6) - 6, 40, 12, @LogoData[0], 160);

      bgfx_dbg_text_printf(0, 1, $0f, 'Color can be changed with ANSI ' + #27'[9;me'#27'[10;ms'#27'[11;mc'#27'[12;ma'#27'[13;mp'#27'[14;me'#27'[0m' + ' codes too.');

      bgfx_dbg_text_printf(80, 1, $0f, #27'[;0m    '#27'[;1m    '#27'[; 2m    '#27'[; 3m    '#27'[; 4m    '#27'[; 5m    '#27'[; 6m    '#27'[; 7m    '#27'[0m');
      bgfx_dbg_text_printf(80, 2, $0f, #27'[;8m    '#27'[;9m    '#27'[;10m    '#27'[;11m    '#27'[;12m    '#27'[;13m    '#27'[;14m    '#27'[;15m    '#27'[0m');

      bgfx_dbg_text_printf(0, 3, $1f, 'PasBGFX/Examples/00-helloworld');
      bgfx_dbg_text_printf(0, 4, $3f, 'Description: Initialization and debug text with the Pascal API.');

      // Advance to the next frame. The rendering thread will be kicked to
      // process the submitted rendering primitives.
      bgfx_frame(False);
    end;
  end;

  // Shutdown BGFX.
  bgfx_shutdown();

  // Free the SDL2 window.
  SDL_DestroyWindow(Window);

  // Shutdown SDL2.
  SDL_Quit();
end.
