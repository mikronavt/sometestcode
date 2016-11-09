#include <iostream>
using namespace std;

void strcat(char *to, const char *from) {
	int to_length = 0;
	for(; *to!='\0'; ++to)  {
		to_length++;
		//cout << to;
	}
	for(; *from!='\0'; ++from){
		
		*to = *from;
		to++;
		to_length++;
	}
	*to = '\0';
	to = to - to_length;
	cout << to;
	
  }
  
int main(){
	char to[] = "aa\\0ppp";
	char from[] = "kkk\\0";
	//cout << to << " " << from;
	strcat(to, from);
return 0;
}