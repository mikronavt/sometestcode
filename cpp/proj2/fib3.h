#include <iostream>
using namespace std;

int main() {
	
	int a = 0;
	int b = 1;
	int c;
	int fib;
	cin >> fib;
	
	if(fib == 0) c = a;
	else if(fib == 1) c = b;
	else {
		for(int i = 2; i <= fib; i++){
			c = (a + b) % 10;
			a = b;
			b = c;
		}
	}
	cout << c;

	return 0;
}
