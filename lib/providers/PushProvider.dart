import 'package:firebase_messaging/firebase_messaging.dart';

class PushProvider {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  initNotfy() {
    _fcm.requestNotificationPermissions(); 
    //Token Get
    _fcm.getToken().then((token){
        print('FCM Token Gerado: $token');
    });
    _fcm.configure(
      //Aplicativo em Primeiro plano
      // ignore: missing_return
      onMessage: (info){
        print('ON MESSAGE||INFO MESSAGE: $info');
      },
      //Aplicativo Encerrado
      // ignore: missing_return
      onLaunch: (info){
        print('ON LAUNCH||INFO MESSAGE: $info');
      },
      //Aplicativo em Segundo plano
      // ignore: missing_return      
      onResume: (info){
        print('ON RESUME||INFO MESSAGE: $info');
      },
    );
    
    
  }
}
