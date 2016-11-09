#include <iostream>
using namespace std;

int foo(){
	int a;
	cout << "Hello" << endl;
	cin >> a;
	return 2;
}

int bar() {
	int * m[1];
	m[3] = (int *) &foo;
	return 1;
}

int main() {
	bar();
	
	return 0;
}