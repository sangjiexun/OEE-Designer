package org.point85.app;

import org.apache.log4j.PropertyConfigurator;
import org.point85.app.designer.DesignerApplication;
import org.point85.app.monitor.MonitorApplication;
import org.point85.domain.persistence.PersistenceService;

import javafx.application.Application;
import javafx.stage.Stage;

public class OeeApplication extends Application {
	private static final String DESIGNER_APP = "DESIGNER";
	private static final String MONITOR_APP = "MONITOR";

	private static final int IDX_APP = 0;
	private static final int IDX_JDBC = 1;
	private static final int IDX_USER = 2;
	private static final int IDX_PASSWORD = 3;

	// Designer application
	private DesignerApplication designerApp;

	// Monitor application
	private MonitorApplication monitorApp;

	@Override
	public void start(Stage primaryStage) throws Exception {
		Parameters parameters = getParameters();

		String appId = parameters.getRaw().get(IDX_APP);

		if (appId.equals(DESIGNER_APP)) {
			designerApp = new DesignerApplication();
			designerApp.start(primaryStage);
		} else if (appId.equals(MONITOR_APP)) {
			monitorApp = new MonitorApplication();
			monitorApp.start(primaryStage);
		} else {
			throw new Exception("Unknown application id " + appId);
		}
	}

	@Override
	public void stop() {
		if (designerApp != null) {
			designerApp.stop();
		} else if (monitorApp != null) {
			monitorApp.stop();
		}
		System.exit(0);
	}

	/**
	 * Main entry point
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		// DESIGNER jdbc:sqlserver://localhost:1433;databaseName=OEE Point85 Point85 
		// MONITOR jdbc:sqlserver://localhost:1433;databaseName=OEE Point85 Point85
		
		// configure log4j
		PropertyConfigurator.configure("log4j.properties");

		// create the EMF
		PersistenceService.instance().initialize(args[IDX_JDBC], args[IDX_USER], args[IDX_PASSWORD]);

		// start GUI
		launch(args);
	}

}