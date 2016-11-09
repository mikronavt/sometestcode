#include <iostream>
using namespace std;

int main() {
	// your code goes here
	int fib;
	int a = 0;
	int b = 1;
	int c;
	cin >> fib;
	if( fib == 0) c = a; 
	else if(fib == 1) c = b;
	else {
		for(int i = 2; i <= fib; i++){
		
			c = a + b;
			a = b;
			b = c;
		}
	}
	
	cout << c;
	
	return 0;
}