#include <iostream>
using namespace std;

unsigned strlen(const char *str) {
	
	
	int length;
	for(length = 0; *str!='\0'; ++str)  {
		length++;
	}
    // put your code here
	return length;
}

int main(){
	const char c[] = "";
	cout << c;
	cout << strlen(c);
	return 0;
}