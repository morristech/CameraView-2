PACKAGE = de.markusfisch.android.cameraviewdemo
APK = app/build/outputs/apk/debug/app-debug.apk

all: debug install start

debug:
	./gradlew assembleDebug

lint:
	./gradlew lintDebug

findbugs:
	./gradlew findBugs

infer: clean
	infer -- ./gradlew assembleDebug

sonarqube:
	./gradlew sonarqube

release: lint findbugs
	./gradlew assembleRelease

aar: clean
	./gradlew :cameraview:assembleRelease

install:
	adb $(TARGET) install -r $(APK)

start:
	adb $(TARGET) shell 'am start -n $(PACKAGE)/.activity.MainActivity'

uninstall:
	adb $(TARGET) uninstall $(PACKAGE)

clean:
	./gradlew clean
