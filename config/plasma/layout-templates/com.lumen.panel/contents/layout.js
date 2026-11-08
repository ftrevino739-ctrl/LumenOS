// This template adds a new panel. It does not edit or remove existing panels.
var panel = new Panel;
panel.location = "bottom";
panel.height = Math.round(gridUnit * 3);

panel.addWidget("org.kde.plasma.kickoff");
panel.addWidget("org.kde.plasma.taskmanager");
panel.addWidget("org.kde.plasma.systemtray");
panel.addWidget("org.kde.plasma.digitalclock");
