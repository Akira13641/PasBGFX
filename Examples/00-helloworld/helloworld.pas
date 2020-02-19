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
  ExampleRunner in '../Common/ExampleRunner.pas',
  BGFX in '../../Source/BGFX.pas';

{$I logo.inc}

procedure Render;
begin
  // Use the debug font to print information about this example.
  bgfx_dbg_text_clear(0, False);

  bgfx_dbg_text_image(
    Max(TExampleRunner.Width div 2 div 8, 20) - 20,
    Max(TExampleRunner.Height div 2 div 16, 6) - 6,
    40,
    12,
    @LogoData[0],
    160
  );

  bgfx_dbg_text_printf(
    0,
    1,
    $0f,
    'Color can be changed with ANSI ' + #27'[9;me'#27'[10;ms'#27'[11;mc'#27'[12;ma'#27'[13;mp'#27'[14;me'#27'[0m' + ' codes too.'
  );

  bgfx_dbg_text_printf(
    80,
    1,
    $0f,
    #27'[;0m    '#27'[;1m    '#27'[; 2m    '#27'[; 3m    '#27'[; 4m    '#27'[; 5m    '#27'[; 6m    '#27'[; 7m    '#27'[0m'
  );
  bgfx_dbg_text_printf(
    80,
    2,
    $0f,
    #27'[;8m    '#27'[;9m    '#27'[;10m    '#27'[;11m    '#27'[;12m    '#27'[;13m    '#27'[;14m    '#27'[;15m    '#27'[0m'
  );

  bgfx_dbg_text_printf(0, 3, $1f, 'PasBGFX/Examples/00-helloworld');
  bgfx_dbg_text_printf(0, 4, $3f, 'Description: Initialization and debug text with the Pascal API.');
end;

begin
  TExampleRunner.Initialize('PasBGFX Hello World');
  TExampleRunner.Run(@Render);
  TExampleRunner.Finalize();
end.
