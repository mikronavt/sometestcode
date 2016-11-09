#include <iostream>
using namespace std;

int min_index(int **mt, int m, int n) {
	int index = 0;
	int min = mt[0][0];
	for(int i = 0; i < m; i++)
	{
		for(int j = 0; j < n; j++) 
		{
			if(mt[i][j] < min) 
			{
				min = mt[i][j];
				index = i;
			}
		}
	}
	return index;
}



void swap_min(int **mt, int m, int n) {
    // put your code here
	int index = min_index(mt, m, n);
	
	for(int i = 0; i < n; i++) 
	{
		int k = mt[0][i];
		mt[0][i] = mt[index][i];
		mt[index][i] = k;
	}
	
}



int main(){
	int m = 2, n = 5;
	int **mt = new int*[m];
	mt[0] = new int[m * n];
	
	for (int i = 1; i != m; ++i)
		mt[i] = mt[i - 1] + n;
	
	for (int i = 0; i < m; ++i)
	{
		for(int j = 0; j < n; ++j)
			cin >> mt[i][j];
	}
	
	for (int i = 0; i < m; ++i)
	{
		for(int j = 0; j < n; ++j)
			cout << mt[i][j] << " ";
		cout << endl;;
	}
	swap_min(mt, m, n);
	
	cout << endl;
	
	for (int i = 0; i < m; ++i)
	{
		for(int j = 0; j < n; ++j)
			cout << mt[i][j] << " ";
		cout << endl;;
	}
	return 0;
}

