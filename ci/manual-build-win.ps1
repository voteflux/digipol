& { 
	flutter upgrade
	flutter clean
	flutter cache repair
	flutter pub get
	flutter build apk --release
	((flutter test > tmp.test-out.tmp) -or (echo "testing failed :("))
}
