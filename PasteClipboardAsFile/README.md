# Paste Clipboard As File

Right-click empty space in any folder and drop whatever is on the clipboard into that folder as a file.

## Overview

Windows lets you paste a *file* into a folder, but not the *content* of the clipboard. Screenshots are the usual pain: you take one, and there is no way to get a PNG on disk without opening an editor and doing Save As. This adds a single context menu entry that does it in one click.

The script detects what the clipboard holds and picks the format, in this priority order:

| Clipboard holds | Result |
|---|---|
| Files (copied in Explorer) | the files are copied into the folder, original names kept |
| Image (screenshot, copy from an editor) | `Obraz ze schowka.png` |
| Text | `Tekst ze schowka.txt`, UTF-8 |
| Nothing usable | a message box, no file written |

Nothing is ever overwritten. If the name is taken, the script appends `(1)`, `(2)` and so on. After the file is written, Explorer selects it and enters rename mode, so you type the name you actually want and press Enter.

The created names are Polish because that is what the machines using this run. Change the `-BaseName` values in the script if you want different ones.

## Requirements

- Windows 10 or Windows 11
- PowerShell 7 (`pwsh`) or Windows PowerShell 5.1 - the script works on both
- Administrator rights for the registry import (the entry is machine-wide)

## Setup

1. Create `C:\IT\!AHK` and put both files there.

   ```cmd
   mkdir "C:\IT\!AHK"
   curl -L -o "C:\IT\!AHK\PasteClipboardAsFile.ps1" https://raw.githubusercontent.com/szymontex/AHK/main/PasteClipboardAsFile/PasteClipboardAsFile.ps1
   curl -L -o "C:\IT\!AHK\PasteClipboardAsFile.reg" https://raw.githubusercontent.com/szymontex/AHK/main/PasteClipboardAsFile/PasteClipboardAsFile.reg
   ```

2. Check for PowerShell 7.

   ```cmd
   where pwsh
   ```

   If it is not found, edit `PasteClipboardAsFile.reg` and replace `pwsh ` with `powershell.exe ` on the `command` line.

3. Import the entry. This needs administrator rights: the `.reg` targets `HKEY_CLASSES_ROOT`, so Windows redirects the write to `HKLM\SOFTWARE\Classes` and every user of the machine gets the menu entry.

   ```cmd
   reg import "C:\IT\!AHK\PasteClipboardAsFile.reg"
   ```

4. Verify.

   ```cmd
   reg query "HKLM\SOFTWARE\Classes\Directory\Background\shell\PasteClipboardAsFile\command" /ve
   ```

No reboot, no Explorer restart, no logout. The entry is live immediately.

## Usage

Take a screenshot, open any folder, right-click the empty background.

**On Windows 11 the entry sits under "Show more options"** (or press Shift + right-click to get the full menu directly). Registry-based verbs like this one do not appear in the new compact Windows 11 menu - only packaged shell extensions do. On Windows 10 it appears in the menu directly.

## Uninstall

```cmd
reg delete "HKLM\SOFTWARE\Classes\Directory\Background\shell\PasteClipboardAsFile" /f
```

The two files under `C:\IT\!AHK` can then be deleted.

## How it works

`PasteClipboardAsFile.reg` registers a verb under `Directory\Background\shell`, which is the context menu of a folder's empty background. Its `command` runs the PowerShell script with `%V`, the path of the folder that was right-clicked, passed as `-Folder`.

The script uses `System.Windows.Forms.Clipboard` for detection, so it needs a thread in single-threaded apartment (STA) state. Both PowerShell 7 and Windows PowerShell 5.1 run STA by default on Windows, which is why no `-STA` switch is needed.

Rename mode is triggered through the Shell COM interface: the script walks open Explorer windows, finds the one showing the target folder, calls `SelectItem` on the new file and sends `F2`. If no Explorer window shows that folder, the file is still created and nothing is sent.

## Notes

- The clipboard is per-session. A script run over a remote shell reads that session's clipboard, not the clipboard of the person logged in at the console, so this cannot be smoke-tested end-to-end over SSH or WinRM.
- Text files are written UTF-8 with a byte order mark, which is what `WriteAllText` with `UTF8Encoding` produces.

## Ready-to-paste install prompt (Polish)

For handing to an operator or to an agent running on the target machine:

```text
Zainstaluj na tym komputerze pozycję menu kontekstowego Explorera "Wklej ze schowka jako plik".

Co to robi: klikasz prawym na puste miejsce w folderze i zawartość schowka ląduje
w tym folderze jako plik. Obraz (zrzut ekranu) zapisuje się jako PNG, tekst jako
.txt, a skopiowane pliki są kopiowane. Nowy plik od razu wchodzi w tryb zmiany
nazwy, więc wpisujesz nazwę i zatwierdzasz Enterem. Nic nie jest nadpisywane -
przy kolizji nazw dokłada "(1)", "(2)".

Źródło: https://github.com/szymontex/AHK/tree/main/PasteClipboardAsFile

Kroki:

1. Utwórz folder i pobierz do niego dwa pliki:
   mkdir "C:\IT\!AHK"
   curl -L -o "C:\IT\!AHK\PasteClipboardAsFile.ps1" https://raw.githubusercontent.com/szymontex/AHK/main/PasteClipboardAsFile/PasteClipboardAsFile.ps1
   curl -L -o "C:\IT\!AHK\PasteClipboardAsFile.reg" https://raw.githubusercontent.com/szymontex/AHK/main/PasteClipboardAsFile/PasteClipboardAsFile.reg

2. Sprawdź, czy jest PowerShell 7:
   where pwsh
   Jeśli nie ma, otwórz PasteClipboardAsFile.reg w notatniku i w linii command
   zamień "pwsh " na "powershell.exe ". Skrypt działa na PowerShell 5.1 też.

3. Zaimportuj wpis. Wymaga uprawnień administratora:
   reg import "C:\IT\!AHK\PasteClipboardAsFile.reg"

4. Sprawdź, czy wpis jest:
   reg query "HKLM\SOFTWARE\Classes\Directory\Background\shell\PasteClipboardAsFile\command" /ve

5. Test: zrób zrzut ekranu klawiszem PrintScreen, otwórz dowolny folder i kliknij
   prawym na puste miejsce. Na Windows 11 ta pozycja jest pod "Pokaż więcej opcji"
   albo od razu w pełnym menu pod Shift + prawy przycisk - wpisy z rejestru nie
   pokazują się w nowym, skróconym menu Windows 11. Powinien powstać plik PNG i
   od razu włączyć się zmiana nazwy.

6. Powtórz test dla tekstu: skopiuj coś Ctrl+C z notatnika i kliknij ponownie.
   Powinien powstać plik .txt z tą treścią.

Restart nie jest potrzebny, ani wylogowanie, ani restart Explorera.

Odinstalowanie:
   reg delete "HKLM\SOFTWARE\Classes\Directory\Background\shell\PasteClipboardAsFile" /f

Wymagania: Windows 10 albo 11, uprawnienia administratora do punktu 3,
PowerShell 7 albo 5.1.
```

## License

MIT, same as the rest of this repository.
