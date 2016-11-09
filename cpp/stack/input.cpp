#include <iostream>
using namespace std;

int input(){
	int a;
	cin >> a;
	if(a != 0) 
	{
		input();
		cout << a << " ";
	}
	return 0;
}

int main(){
	input();
	
	return 0;
}