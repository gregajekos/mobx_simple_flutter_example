import 'package:mobx/mobx.dart';

/**VKLJUČITI JE POTREBNO GENERIRANO DATOTEKO, to naredimo s komando:
 * flutter packages pub run build_runner build
 *
 *(Potrebno poklicati ob vsaki spremembi razreda)
 *
 * ali pa s komando, ki samodejno spremlja spremembe
 *
 * flutter packages pub run build_runner watch
 *
 *
 * Če pride do konfliktov pa lahko vse počistimo:
 *
 * flutter packages pub run build_runner watch --delete-conflicting-outputs
 */
part 'TimeTask.g.dart';

class TimeTask = _TimeTask with _$TimeTask;

abstract class _TimeTask with Store {
  @observable
  int time = 0;

  int nonObservableTime = new DateTime.now().millisecondsSinceEpoch;

  @action
  void updateTime() {
    time = new DateTime.now().millisecondsSinceEpoch;

    //DA VIDIMO, DA SE S TO NIČ NE DOGAJA, KER NI DEFINIRANA IN SE SPREMENI OB VSAKEM INTERVALU
    nonObservableTime=time;
  }
}
