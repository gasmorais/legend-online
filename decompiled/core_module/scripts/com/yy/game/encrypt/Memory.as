package com.yy.game.encrypt
{
   import flash.net.LocalConnection;
   import flash.system.System;
   
   internal class Memory
   {
      
      public function Memory()
      {
         super();
      }
      
      public static function gc() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
      
      public static function get used() : uint
      {
         return System.totalMemory;
      }
   }
}

