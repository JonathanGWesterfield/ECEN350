extern long long int lab02d(long long int num);

int main(void)
{
	int *a = (int*)lab02d(2);
	printf("The Address is %x \n", a);
    return 0;
}
