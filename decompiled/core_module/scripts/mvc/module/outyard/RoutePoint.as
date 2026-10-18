package mvc.module.outyard
{
   public class RoutePoint
   {
      
      private var _id:int;
      
      public var row:int;
      
      public var col:int;
      
      public var lineArr:Array;
      
      public function RoutePoint()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
         switch(_id - 1)
         {
            case 0:
               row = 0;
               col = 1;
               lineArr = [2,4];
               break;
            case 1:
               row = 0;
               col = 2;
               lineArr = [1,5,3];
               break;
            case 2:
               row = 0;
               col = 3;
               lineArr = [2,6];
               break;
            case 3:
               row = 1;
               col = 1;
               lineArr = [10,1,7,5];
               break;
            case 4:
               row = 1;
               col = 2;
               lineArr = [2,4,8,6];
               break;
            case 5:
               row = 1;
               col = 3;
               lineArr = [3,5,9,11];
               break;
            case 6:
               row = 2;
               col = 1;
               lineArr = [4,8];
               break;
            case 7:
               row = 2;
               col = 2;
               lineArr = [7,5,9];
               break;
            case 8:
               row = 2;
               col = 3;
               lineArr = [6,8];
               break;
            case 9:
               row = 1;
               col = 0;
               lineArr = [4];
               break;
            case 10:
               row = 1;
               col = 4;
               lineArr = [6];
         }
      }
   }
}

