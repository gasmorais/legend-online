package map.internals.utils
{
   import flash.geom.Rectangle;
   
   public class QTree
   {
      
      private var q1:QTree;
      
      private var q2:QTree;
      
      private var q3:QTree;
      
      private var q4:QTree;
      
      public var parent:QTree;
      
      public var root:QTree;
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var deep:Number;
      
      public var area:Rectangle;
      
      public var data:Array;
      
      public function QTree(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = 5, param6:QTree = null)
      {
         super();
         area = new Rectangle(param1,param2,param3,param4);
         data = [];
         x = param1;
         y = param2;
         width = param3;
         height = param4;
         deep = param5;
         if(!param6)
         {
            root = this;
         }
         else
         {
            root = param6;
         }
         createChildren();
      }
      
      private function createChildren() : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc1_:int = 0;
         if(deep > 0)
         {
            _loc3_ = this.width / 2;
            _loc2_ = this.height / 2;
            _loc1_ = deep - 1;
            q1 = new QTree(x + _loc3_,y + _loc2_,_loc3_,_loc2_,_loc1_,root);
            q2 = new QTree(x,y + _loc2_,_loc3_,_loc2_,_loc1_,root);
            q3 = new QTree(x,y,_loc3_,_loc2_,_loc1_,root);
            q4 = new QTree(x + _loc3_,y,_loc3_,_loc2_,_loc1_,root);
            q1.parent = q2.parent = q3.parent = q4.parent = this;
         }
      }
      
      public function add(param1:Object, param2:Number, param3:Number) : QTree
      {
         if(!isIn(param2,param3))
         {
            return null;
         }
         if(hasChildren)
         {
            return q1.add(param1,param2,param3) || q2.add(param1,param2,param3) || q3.add(param1,param2,param3) || q4.add(param1,param2,param3);
         }
         data.push(param1);
         return this;
      }
      
      public function remove(param1:Object, param2:Number = NaN, param3:Number = NaN) : QTree
      {
         var _loc4_:int = 0;
         if(!isIn(param2,param3))
         {
            return null;
         }
         if(hasChildren)
         {
            return q1.remove(param1,param2,param3) || q2.remove(param1,param2,param3) || q3.remove(param1,param2,param3) || q4.remove(param1,param2,param3);
         }
         _loc4_ = data.indexOf(param1);
         if(_loc4_ >= 0)
         {
            data.splice(_loc4_,1);
            return this;
         }
         return null;
      }
      
      public function readd(param1:Object, param2:Number, param3:Number) : QTree
      {
         var _loc4_:QTree = null;
         if(!isIn(param2,param3))
         {
            _loc4_ = root.add(param1,param2,param3);
            if(_loc4_)
            {
               remove(param1);
               return _loc4_;
            }
         }
         return this;
      }
      
      public function find(param1:Rectangle, param2:Array = null) : Array
      {
         if(!param2)
         {
            param2 = [];
         }
         if(!this.area.intersects(param1))
         {
            return param2;
         }
         if(hasChildren)
         {
            q1.find(param1,param2);
            q2.find(param1,param2);
            q3.find(param1,param2);
            q4.find(param1,param2);
         }
         else
         {
            param2.push.apply(null,data);
         }
         return param2;
      }
      
      private function get hasChildren() : Boolean
      {
         return q1 && q2 && q3 && q4;
      }
      
      private function isIn(param1:Number, param2:Number) : Boolean
      {
         if(isNaN(param1) || isNaN(param2))
         {
            return true;
         }
         return param1 >= this.x && param1 < this.x + this.width && (param2 >= this.y && param2 < this.y + this.height);
      }
      
      public function dispose() : void
      {
         data.length = 0;
         if(hasChildren)
         {
            q1.dispose();
            q2.dispose();
            q3.dispose();
            q4.dispose();
         }
         data = null;
         area = null;
         q1 = q2 = q3 = q4 = null;
      }
   }
}

