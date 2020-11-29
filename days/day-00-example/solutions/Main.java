import java.util.Scanner;

class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int sum_all = 0;
        int sum_odd = 0;

        while (true)  {
            try {
                int num = scanner.nextInt();
                sum_all += num;
                sum_odd += num % 2 == 1 ? num : 0;
            } catch (Exception e) {
                break;
            }
        }
        System.out.println(sum_all);
        System.out.println(sum_odd);
        scanner.close();
    }
}
