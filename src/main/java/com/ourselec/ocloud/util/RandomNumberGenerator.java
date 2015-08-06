package com.ourselec.ocloud.util;

import java.util.Random;

public class RandomNumberGenerator {
	/**
	* 这是典型的随机洗牌算法。
	* 流程是从备选数组中选择一个放入目标数组中，将选取的数组从备选数组移除（放至最后，并缩小选择区域）
	* 算法时间复杂度O(n)
	* @return 随机8为不重复数组
	*/
	public static String generateNumber() {
	String no="";
	//初始化备选数组
	int[] defaultNums = new int[10];
	for (int i = 0; i < defaultNums.length; i++) {
	defaultNums[i] = i;
	}

	Random random = new Random();
	int[] nums = new int[LENGTH];
	//默认数组中可以选择的部分长度
	int canBeUsed = 10;
	//填充目标数组
	for (int i = 0; i < nums.length; i++) {
	//将随机选取的数字存入目标数组
	int index = random.nextInt(canBeUsed);
	nums[i] = defaultNums[index];
	//将已用过的数字扔到备选数组最后，并减小可选区域
	swap(index, canBeUsed - 1, defaultNums);
	canBeUsed--;
	}
	if (nums.length>0) {
	for (int i = 0; i < nums.length; i++) {
	no+=nums[i];
	}
	}

	return no;
	}
	private static final int LENGTH = 8;

	private static void swap(int i, int j, int[] nums) {
	int temp = nums[i];
	nums[i] = nums[j];
	nums[j] = temp;
	}

	public static String generateNumber2() {
	String no="";
	int num[]=new int[8];
	int c=0;
	for (int i = 0; i < 8; i++) {
	num[i] = new Random().nextInt(10);
	c = num[i];
	for (int j = 0; j < i; j++) {
	if (num[j] == c) {
	i--;
	break;
	}
	}
	}
	if (num.length>0) {
	for (int i = 0; i < num.length; i++) {
	no+=num[i];
	}
	}
	return no;
	}

	public static void main(String[] args) {
	

		int leng = 8;
		char [] pw = new char[leng];
		Random rm = new Random();
		for(int i = 0; i < leng; i++){
		pw[i] = (char)(rm.nextInt(10)+48);
		}
		for(int i = 0; i < 1; i++){
		pw[i] = (char)(rm.nextInt(26)+97);
		}
		String str1  = new String(pw);
		System.out.println(str1); 
	} 
	
	public static String Key(){
		String key = null;
		int leng = 8;
		char [] pw = new char[leng];
		Random rm = new Random();
		for(int i = 0; i < leng; i++){
		pw[i] = (char)(rm.nextInt(10)+48);
		}
		for(int i = 0; i < 1; i++){
		pw[i] = (char)(rm.nextInt(26)+97);
		}
		key = new String(pw);
		return key; 
	}
	
	public static String GetDeviceId(){
		int leng = 13;
		 Random r = new Random();
		  int i = 0;
		  String str = "";
		  String s = null;
		  while (i < leng) {    //这个地方的30控制产生几位随机数，这里是产生30位随机数
		   switch (r.nextInt(36)) {
		    case (0): s = "0"; break;
		    case (1): s = "1"; break;
		    case (2): s = "2"; break;
		    case (3): s = "3"; break;
		    case (4): s = "4"; break;
		    case (5): s = "5"; break;
		    case (6): s = "6"; break;
		    case (7): s = "7"; break;
		    case (8): s = "8"; break;
		    case (9): s = "9"; break;
		    case (10): s = "a"; break;
		    case (11): s = "b"; break;
		    case (12): s = "c"; break;
		    case (13): s = "d"; break;
		    case (14): s = "e"; break;
		    case (15): s = "f"; break;
		    case (16): s = "g"; break;
		    case (17): s = "h"; break;
		    case (18): s = "i"; break;
		    case (19): s = "j"; break;
		    case (20): s = "k"; break;
		    case (21): s = "m"; break;
		    case (23): s = "n"; break;
		    case (24): s = "o"; break;
		    case (25): s = "p"; break;
		    case (26): s = "q"; break;
		    case (27): s = "r"; break;
		    case (28): s = "s"; break;
		    case (29): s = "t"; break;
		    case (30): s = "u"; break;
		    case (31): s = "v"; break;
		    case (32): s = "w"; break;
		    case (33): s = "l"; break;
		    case (34): s = "x"; break;
		    case (35): s = "y"; break;
		    case (36): s = "z"; break;
		    case (37): s = "A"; break;
		    case (38): s = "B"; break;
		    case (39): s = "C"; break;
		    case (40): s = "D"; break;
		    case (41): s = "E"; break;
		    case (42): s = "F"; break;
		    case (43): s = "G"; break;
		    case (44): s = "H"; break;
		    case (45): s = "I"; break;
		    case (46): s = "L"; break;
		    case (47): s = "J"; break;
		    case (48): s = "K"; break;
		    case (49): s = "M"; break;
		    case (50): s = "N"; break;
		    case (51): s = "O"; break;
		    case (52): s = "P"; break;
		    case (53): s = "Q"; break;
		    case (54): s = "R"; break;
		    case (55): s = "S"; break;
		    case (56): s = "T"; break;
		    case (57): s = "U"; break;
		    case (58): s = "V"; break;
		    case (59): s = "W"; break;
		    case (60): s = "X"; break;
		    case (61): s = "Y"; break;
		    case (62): s = "Z"; break;
		   }
		   i++;
		   str = s + str;
		  }
		return str; 
	}
}
