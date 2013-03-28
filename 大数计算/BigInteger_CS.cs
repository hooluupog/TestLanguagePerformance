using System;
using System.Globalization;
using System.Diagnostics;
using System.Numerics;

public class CSBigInteger
{
 public static void Main()
 {
	string a = Console.ReadLine();
	string b = Console.ReadLine();
	Stopwatch sw = new Stopwatch();
	sw.Start();
	BigInteger c = BigInteger.Parse(a);
	BigInteger d = BigInteger.Parse(b);
	BigInteger e = c*d;
	Console.WriteLine(e.ToString());
	sw.Stop();
	Console.WriteLine("\n" +sw.ElapsedMilliseconds + "ms");
 }
}