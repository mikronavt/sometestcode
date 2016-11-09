#include <iostream>
using namespace std;

int main() {
	
	long double a = 0;
	long double b = 1;
	long double c;
	long double fib;
	long double m;
	cin >> fib;
	cin >> m;
	
	cout << fib;
	if(fib == 0) c = a;
	else if(fib == 1) c = b;
	else {
		for(long double i = 2; i <= fib; i++){
			c = (a + b) % m;
			a = b;
			b = c;
		}
	}
	cout << c;

	return 0;
}
