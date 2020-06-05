using System;
using System.Collections;
using System.Text;
using MyExtensions;

namespace alg1 {
    class Program {
        static void Main (string[] args) {
            Console.WriteLine ("First decimal number: ");
            int a = Int32.Parse (Console.ReadLine ());
            Console.WriteLine ("Second decimal number: ");
            int b = Int32.Parse (Console.ReadLine ());
            BitArray bits1 = new BitArray (BitConverter.GetBytes (a));
            BitArray bits2 = new BitArray (BitConverter.GetBytes (b));
            Console.WriteLine ($"First number in binary:   {bits1.ToBitString()}");
            Console.WriteLine ($"Second number in binary:  {bits2.ToBitString()}");
            BitArray reg = new BitArray (64);
            for (int i = 0; i < bits1.Length; ++i)
                reg[i] = bits1[i];
            Console.WriteLine ($"Register value:\n{reg.ToBitString()}");
            Console.WriteLine ($"Next steps:");
            for (int i = 0; i < 32; ++i) {
                int lsb = reg[0] ? 1 : 0;
                reg = reg.RightShift (1);
                Console.WriteLine ($"{reg.ToBitString()} ][ {lsb}");
                if (lsb == 1) {
                    Console.WriteLine (reg.ToBitString());
                    Console.WriteLine ("+");
                    Console.WriteLine (bits2.ToBitString());
                    Console.WriteLine ("_________________________________________________________________");
                    BitArray n = new BitArray (64);
                    for (int l = 0; l < 32; ++l)
                        n[l] = reg[31 + l];

                    BitArray one32 = new BitArray (BitConverter.GetBytes (1));
                    BitArray one64 = new BitArray (BitConverter.GetBytes (Convert.ToInt64(1)));
                    BitArray result = new BitArray (64);
                    for (int j = 0; j < 32; ++j) {
                        BitArray diff = new BitArray (BitConverter.GetBytes (((n.RightShift (j)).And (one64)).ToUInt64 () + ((bits2.RightShift (j)).And (one32)).ToUInt64 () + (result.RightShift (j)).ToUInt64 ()));
                        result.Xor (diff.Xor (result.RightShift (j))).LeftShift (j);
                    }

                    for (int k = 0; k < 32; ++k)
                        reg[k + 31] = result[k];
                    Console.WriteLine (reg.ToBitString ());
                }
            }
            Console.WriteLine ($"Binary result is:\n{bits2.ToBitString()}");
            Console.WriteLine ($"Conslusion: {a} * {b} = {a * b}");
        }
    }
}
namespace MyExtensions {
    static class BitArrayExtensions {
        static public string ToBitString (this BitArray bits) {
            var sb = new StringBuilder ();
            for (int i = bits.Count - 1; i >= 0; --i) {
                char c = bits[i] ? '1' : '0';
                sb.Append (c);
            }
            return sb.ToString ();
        }
        static public long ToUInt64 (this BitArray bitArray) {
            var array = new byte[8];
            bitArray.CopyTo (array, 0);
            return BitConverter.ToInt64 (array, 0);
        }
    }
}