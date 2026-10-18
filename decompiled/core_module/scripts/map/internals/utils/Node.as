package map.internals.utils
{
   public class Node
   {
      
      public var x:int;
      
      public var y:int;
      
      public var isInOpen:Boolean;
      
      public var isInClose:Boolean;
      
      public var g:int;
      
      public var h:int;
      
      public var f:int;
      
      public var parentNode:Node;
      
      public function Node(param1:int, param2:int)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.isInOpen = false;
         this.isInClose = false;
         this.g = 0;
         this.h = 0;
         this.f = 0;
         this.parentNode = null;
      }
      
      public function update(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
         this.isInOpen = false;
         this.isInClose = false;
         this.g = 0;
         this.h = 0;
         this.f = 0;
         this.parentNode = null;
      }
   }
}

