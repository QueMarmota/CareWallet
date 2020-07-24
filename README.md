# Carewallet

#### Proyecto personal para gestionar mis gastos

En esta app no maneje base de datos , al contrario maneje una clase la cual engloba los datos que va necesitar la app, la clase que gestiona todos los datos es **MonthsModel** el cual lo paso a json con encode y lo aguardo en cadena con sharedPerences y cuando inicia la app le hago decode para obtener los datos en una clase padre en globa a las clases hijas.

**Dependencias:**
+ fl_chart: ^0.10.1
+ shared_preferences: ^0.5.8# CareWallet
