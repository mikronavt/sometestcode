#include <iostream>
using namespace std;

int strstr(const char *str, const char *pattern) {
	int pointer;
	
	for(pointer = 0; *(str + pointer) != '\0'; pointer++)
	{
		for(int i = 0; *(str + pointer + i) == *(pattern + i) ; i++)
		{
			if(*(pattern + i + 1) == '\0') return pointer;
		}
	}
    // put your code here
	return -1;
}

int main(){
	char to[] = "Huil";
	char from[] = "lo";
	cout << strstr(to, from);
	return 0;
}