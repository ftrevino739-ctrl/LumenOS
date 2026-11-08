# Instalar Lumen junto a Windows (dual boot)

> **Estado:** esta guía describe el procedimiento previsto. La ISO de Lumen aún no ha pasado una compilación completa ni pruebas de instalación en una máquina virtual. No la uses todavía para modificar un disco físico.

## La opción más segura

Si tu PC tiene un segundo SSD/HDD, instala Lumen en ese disco y deja intacto el disco de Windows. Es la forma más sencilla de aislar ambos sistemas.

Si solo tienes un disco, crea espacio no asignado desde Windows y deja que el instalador de Kubuntu/Lumen use exclusivamente ese espacio. Haz una copia de seguridad externa antes de cambiar particiones: ningún procedimiento de dual boot garantiza riesgo cero.

## Preparación en Windows 10/11

1. Copia tus documentos importantes a un disco externo o nube y comprueba que puedes abrir la copia.
2. Guarda la clave de recuperación de BitLocker/Device Encryption si está activado. No continúes sin ella.
3. Comprueba el cifrado en Configuración → Privacidad y seguridad → Cifrado del dispositivo, o busca Administrar BitLocker desde Inicio. La disponibilidad depende de la edición y el equipo.
4. Comprueba que Windows arranca en modo UEFI: pulsa Win + R, escribe msinfo32 y revisa Modo de BIOS: UEFI.
5. Abre Administración de discos (clic derecho en Inicio → Administración de discos).
6. Clic derecho en la partición grande C: → Reducir volumen. Reduce solo el espacio que quieras dedicar a Lumen. Como referencia, reserva 80 GB como mínimo práctico; 100–150 GB ofrece más margen.
7. Deja ese espacio como No asignado. No crees un volumen nuevo, no lo formatees y no borres las particiones EFI, Recovery o MSR de Windows.
8. Desactiva Inicio rápido antes de compartir el disco con Linux. En Terminal/PowerShell como administrador ejecuta: powercfg /h off. Esto también desactiva hibernación. Para revertirlo: powercfg /h on.
9. Reinicia Windows una vez y confirma que sigue arrancando normalmente.

## Instalación cuando la ISO de Lumen esté validada

1. Crea un USB de arranque de 8 GB o más con la ISO oficial de Lumen. La escritura borra el contenido del USB; selecciona con cuidado la unidad USB correcta.
2. Arranca el USB desde el menú UEFI de arranque (la tecla depende del fabricante).
3. Elige Try / Probar si aparece. Antes de instalar, comprueba Wi-Fi, audio, pantalla, teclado y touchpad.
4. Abre el instalador. En el paso de disco, elige únicamente una opción explícita como Install alongside Windows / Instalar junto a Windows, si aparece y reconoce correctamente Windows.
5. Comprueba el resumen de particiones antes de confirmar. Debe conservar las particiones de Windows y usar el espacio libre reservado para Lumen.
6. Si el instalador solo ofrece Erase disk / Borrar disco, si no detecta Windows, si muestra BitLocker como bloqueo, o si no puedes identificar el disco/particiones, cancela y apaga. No elijas borrar disco ni improvises con particionado manual.
7. Completa la instalación solo después de revisar cuidadosamente el resumen. Al reiniciar, el menú de arranque debería permitir elegir Lumen o Windows. También puedes usar el menú UEFI del fabricante para seleccionar Windows.

## BitLocker y recuperación

- Conserva la clave de recuperación fuera del PC.
- No borres ni formatees la partición EFI de Windows; el instalador puede reutilizarla para los archivos de arranque sin formatearla.
- Si aparece una advertencia de BitLocker o el instalador no puede reconocer el disco, detente. No desactives el cifrado a ciegas ni continúes con una instalación que proponga borrar el disco.
- Cambios en firmware/UEFI o en el orden de arranque pueden provocar que Windows solicite la clave de recuperación. Tenla a mano.
- Si el equipo es administrado por escuela/empresa, consulta al administrador antes de cambiar el arranque o el cifrado.

## Volver a usar solo Windows

Selecciona Windows Boot Manager desde el menú UEFI. No borres particiones Linux hasta identificar con certeza cuáles son: eliminar la partición equivocada puede dejar Windows sin arranque. La desinstalación de Lumen y la recuperación del menú UEFI se documentarán después de probar el instalador en VM.

## Referencias oficiales

- [Instalar Ubuntu junto a otro sistema operativo](https://ubuntu.com/desktop/docs/en/latest/tutorial/install-ubuntu-desktop/)
- [BitLocker durante la instalación](https://github.com/ubuntu/ubuntu-desktop-documentation/blob/main/docs/reference/bitlocker-during-ubuntu-installation.md)
- [Descargar Kubuntu](https://www.kubuntu.org/download/)
