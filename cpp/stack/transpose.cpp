#include <cstddef>  // size_t
#include <iostream>
using namespace std;

int ** transpose(const int * const * m, size_t r, size_t c) {
    // put your code here
	int **trans = new int*[c];
	trans[0] = new int[c * r];
	
	for(int i = 1; i < c; ++i)
		trans[i] = trans[i - 1] + r;
		
	for(int i = 0; i < r; i++)
	{
		for(int j = 0; j < c; j++)
			trans[j][i] = m[i][j];
	}
	
	return trans;
	
}

int main(){
	int r = 2, c = 5;
	int **m = new int*[r];
	m[0] = new int[r * c];
	
	for (int i = 1; i != r; ++i)
		m[i] = m[i - 1] + c;
	
	for (int i = 0; i < r; ++i)
	{
		for(int j = 0; j < c; ++j)
			cin >> m[i][j];
	}
	
	for (int i = 0; i < r; ++i)
	{
		for(int j = 0; j < c; ++j)
			cout << m[i][j] << " ";
		cout << endl;;
	}
	
	
	int **trans = new int*[c];
	trans[0] = new int[c * r];
	
	for(int i = 1; i < c; ++i)
		trans[i] = trans[i - 1] + r;
	
	trans = transpose(m, r, c);
	
	cout << endl;
	
	for(int i = 0; i < c; ++i)
	{
		for(int j = 0; j < r; ++j)
			cout << trans[i][j] << " ";
		cout << endl;
	}
	

	return 0;
}