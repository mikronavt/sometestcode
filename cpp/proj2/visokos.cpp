#include <iostream>
using namespace std;

int main() {
	
	int A =	0;
	int B = 0;
	int sum = 0;
	cin >> A;
	cin >> B;
	
	for (int i = A; i < B; i++) {
		if((i%4 == 0 && i%100 != 0) || i%400 == 0)
			sum++;
	}
	
	cout << sum;
}
	