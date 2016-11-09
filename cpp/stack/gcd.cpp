#include <iostream>
using namespace std;

int gcd(int a, int b){

	if(a == 0) return b;
	else if (b == 0) return a;
	else if(b > a) return gcd(b, a);
	else return gcd(b, a%b);
}

int main(){
	int a;
	int b;
	cin >> a;
	cin >> b;
	
	
	cout << gcd(a, b);
	return 0;
}

