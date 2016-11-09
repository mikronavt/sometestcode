#include <iostream>

using namespace std;

char *getline() {
    // put your code here
	char * str = new char[10000];
	char c;
	int i = 0;
	
	while(cin.get(c)){
		* (str + i) = c;
		if(c == '\0' || c == '\n') break;
		i++;
	}
	*(str + i) = '\0';
	
	char * result_str = new char[i + 1];
	for(int j = 0; j <= i; j++){
		*(result_str + j) = *(str + j);
	}
	delete[] str;
	return result_str;
}

int main(){
	cout << getline();
	return 0;
}
