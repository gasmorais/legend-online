package mvc.module.theseus
{
   public class TheseusSlateShapeInfo
   {
      
      public static const SHAPE_I:int = 1;
      
      public static const SHAPE_L:int = 2;
      
      public static const SHAPE_T:int = 3;
      
      public static const SHAPE_S:int = 4;
      
      public static const SHAPE_Z:int = 5;
      
      public static const SHAPE_O:int = 6;
      
      public static const SHAPE_J:int = 7;
      
      public static const ROTATE_0:int = 0;
      
      public static const ROTATE_90:int = 1;
      
      public static const ROTATE_180:int = 2;
      
      public static const ROTATE_270:int = 3;
      
      private var _shapeId:int;
      
      private var _baseGrid:Array;
      
      public function TheseusSlateShapeInfo(param1:int = 0)
      {
         super();
         _shapeId = param1;
         initBaseGrid();
      }
      
      private function initBaseGrid() : void
      {
         switch(_shapeId - 1)
         {
            case 0:
               _baseGrid = [[1,1,1],[0,1,0]];
               break;
            case 1:
               _baseGrid = [[1,0],[1,1],[0,1]];
               break;
            case 2:
               _baseGrid = [[0,1],[0,1],[1,1]];
               break;
            case 3:
               _baseGrid = [[1,0],[1,1]];
               break;
            case 4:
               _baseGrid = [[1,1,1]];
               break;
            case 5:
               _baseGrid = [[1,1]];
               break;
            case 6:
               _baseGrid = [[1]];
               break;
            default:
               _baseGrid = [[1]];
         }
      }
      
      public function getRotatedGrid(param1:int) : Array
      {
         var _loc3_:int = 0;
         if(!_baseGrid)
         {
            return null;
         }
         var _loc2_:Array = _baseGrid;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = rotateGrid(_loc2_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getRotatedSize(param1:int) : Object
      {
         var _loc2_:Array = getRotatedGrid(param1);
         if(!_loc2_ || _loc2_.length == 0)
         {
            return {
               "width":0,
               "height":0
            };
         }
         return {
            "width":_loc2_[0].length,
            "height":_loc2_.length
         };
      }
      
      private function rotateGrid(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         if(!param1 || param1.length == 0)
         {
            return param1;
         }
         var _loc7_:int = int(param1.length);
         var _loc5_:int = int(param1[0].length);
         var _loc4_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc3_ = [];
            _loc6_ = _loc7_ - 1;
            while(_loc6_ >= 0)
            {
               _loc3_.push(param1[_loc6_][_loc2_]);
               _loc6_--;
            }
            _loc4_.push(_loc3_);
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get shapeId() : int
      {
         return _shapeId;
      }
      
      public function set shapeId(param1:int) : void
      {
         _shapeId = param1;
         initBaseGrid();
      }
      
      public function get baseGrid() : Array
      {
         return _baseGrid;
      }
   }
}

