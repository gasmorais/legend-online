package com.pickgliss
{
   import flash.net.LocalConnection;
   
   public class GC
   {
      
      public function GC()
      {
         super();
      }
      
      public static function doClearance() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(error:Error)
         {
         }
      }
   }
}

