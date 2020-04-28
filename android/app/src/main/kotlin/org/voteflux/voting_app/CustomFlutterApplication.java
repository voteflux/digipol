package org.voteflux.voting_app;

import io.flutter.app.FlutterApplication;
import com.instabug.instabugflutter.InstabugFlutterPlugin;
import java.util.ArrayList;

public class WrappedFlutterApplication extends FlutterApplication {
  @Override
  public void onCreate() {
    super.onCreate();
    ArrayList<String> invocationEvents = new ArrayList<>();
    invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_SHAKE);
    new InstabugFlutterPlugin().start(WrappedFlutterApplication.this, "dfdea6cecd71ae7d94d60d24dc881ff3", invocationEvents);
  }
}
