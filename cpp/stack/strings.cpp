#include <iostream>
#include <string>
#include <cstring>
using namespace std;

int main() {
    // put your code here
	string s, p;

	
	getline(cin, s);
	bool begin = true;
	p = s;
	int i, k;
	for(i = 0, k = 0; s[i] != '\0'; i++)
	{
		if(s[i] != ' ') begin = false;
		if(s[i] == ' ' && (s[i + 1] == ' ' || s[i + 1] == '\0' || begin)) {}
		else 
		{
			p[k] = s[i];
			k++;
		} 
		
	}
	
	p = p.substr(0, k);
	cout << p;
    return 0;
}