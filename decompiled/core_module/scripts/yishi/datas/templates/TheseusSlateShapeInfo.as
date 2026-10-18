package yishi.datas.templates
{
   public class TheseusSlateShapeInfo
   {
      
      private static const SHAPE_CONFIGS:Array = [{
         "shapeId":1,
         "name":"T 型",
         "width":3,
         "height":2,
         "grid":"1,1,1|0,1,0",
         "icon":"石板_4a.png"
      },{
         "shapeId":2,
         "name":"十字型",
         "width":2,
         "height":3,
         "grid":"1,0|1,1|0,1",
         "icon":"石板_4b.png"
      },{
         "shapeId":3,
         "name":"L 型",
         "width":2,
         "height":3,
         "grid":"1,0|1,0|1,1",
         "icon":"石板_4c.png"
      },{
         "shapeId":4,
         "name":"L 型变种",
         "width":2,
         "height":2,
         "grid":"1,0|1,1",
         "icon":"石板_3b.png"
      },{
         "shapeId":5,
         "name":"横条",
         "width":3,
         "height":1,
         "grid":"1,1,1",
         "icon":"石板_2.png"
      },{
         "shapeId":6,
         "name":"竖条",
         "width":1,
         "height":2,
         "grid":"1|1",
         "icon":"石板_3a.png"
      },{
         "shapeId":7,
         "name":"正方形",
         "width":1,
         "height":1,
         "grid":"1",
         "icon":"石板_1.png"
      }];
      
      public var shapeId:int;
      
      public var shapeName:String;
      
      public var width:int;
      
      public var height:int;
      
      public var gridData:String;
      
      public var rotateType:int;
      
      public var iconName:String;
      
      private var _gridArray:Array;
      
      public function TheseusSlateShapeInfo()
      {
         super();
         _gridArray = [];
      }
      
      public function initFromConfig(param1:int) : void
      {
         var _loc2_:Object = null;
         this.shapeId = param1;
         if(param1 >= 1 && param1 <= 7)
         {
            _loc2_ = SHAPE_CONFIGS[param1 - 1];
            this.shapeName = _loc2_.name;
            this.width = _loc2_.width;
            this.height = _loc2_.height;
            this.gridData = _loc2_.grid;
            this.iconName = _loc2_.icon;
            this.rotateType = 1;
            parseGridData();
         }
      }
      
      public function parseGridData() : void
      {
         var _loc1_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         if(!gridData || gridData.length == 0)
         {
            return;
         }
         _gridArray = [];
         var _loc3_:Array = gridData.split("|");
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc1_].split(",");
            _loc4_ = [];
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               _loc4_.push(parseInt(_loc5_[_loc2_]));
               _loc2_++;
            }
            _gridArray.push(_loc4_);
            _loc1_++;
         }
         height = _gridArray.length;
         if(height > 0)
         {
            width = _gridArray[0].length;
         }
      }
      
      public function isOccupied(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 || param1 >= height || param2 < 0 || param2 >= width)
         {
            return false;
         }
         return _gridArray[param1][param2] == 1;
      }
      
      public function getRotatedGrid(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         if(param1 == 0)
         {
            return _gridArray;
         }
         var _loc2_:Array = [];
         var _loc4_:int = param1 % 4;
         var _loc10_:Array = _gridArray;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = [];
            _loc8_ = int(_loc10_.length);
            _loc9_ = int(_loc10_[0].length);
            _loc7_ = 0;
            while(_loc7_ < _loc9_)
            {
               _loc3_ = [];
               _loc6_ = _loc8_ - 1;
               while(_loc6_ >= 0)
               {
                  _loc3_.push(_loc10_[_loc6_][_loc7_]);
                  _loc6_--;
               }
               _loc2_.push(_loc3_);
               _loc7_++;
            }
            _loc10_ = _loc2_;
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getRotatedSize(param1:int) : Object
      {
         if(param1 % 2 == 0)
         {
            return {
               "width":width,
               "height":height
            };
         }
         return {
            "width":height,
            "height":width
         };
      }
      
      public function getIconName() : String
      {
         return this.iconName;
      }
   }
}

