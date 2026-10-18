package consortia.view.minos
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.BitmapData;
   import utils.LogicUtils;
   
   public class MinosBitDataUtils
   {
      
      private static var _ins:MinosBitDataUtils;
      
      public var lockTypes:Array = [];
      
      public var openTypes:Array = [];
      
      public var chooseTypes:Array = [];
      
      public var probarTypes:Array = [];
      
      public var empety:BitmapData;
      
      public function MinosBitDataUtils()
      {
         super();
      }
      
      public static function get Ins() : MinosBitDataUtils
      {
         if(_ins == null)
         {
            _ins = new MinosBitDataUtils();
         }
         return _ins;
      }
      
      public function init() : void
      {
         empety = ComponentFactory.Instance.creatBitmap("asset.minos.empty").bitmapData;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            lockTypes[_loc1_] = ComponentFactory.Instance.creatBitmap("asset.minos.lock" + (_loc1_ + 1)).bitmapData;
            _loc1_++;
         }
         lockTypes[3] = ComponentFactory.Instance.creatBitmap("asset.minos.first").bitmapData;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            openTypes[_loc1_] = ComponentFactory.Instance.creatBitmap("asset.minos.open" + (_loc1_ + 1)).bitmapData;
            _loc1_++;
         }
         openTypes[3] = ComponentFactory.Instance.creatBitmap("asset.minos.first").bitmapData;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            chooseTypes[_loc1_] = ComponentFactory.Instance.creatBitmap("asset.minos.choose" + (_loc1_ + 1)).bitmapData;
            _loc1_++;
         }
         chooseTypes[2] = ComponentFactory.Instance.creatBitmap("asset.minos.choose2").bitmapData;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            probarTypes[_loc1_] = ComponentFactory.Instance.creatBitmap("asset.minos.probar" + (_loc1_ + 1)).bitmapData;
            _loc1_++;
         }
      }
      
      public function clear() : void
      {
         LogicUtils.disposeDisplayCollection(lockTypes);
         LogicUtils.disposeDisplayCollection(openTypes);
         LogicUtils.disposeDisplayCollection(chooseTypes);
         LogicUtils.disposeDisplayCollection(probarTypes);
      }
   }
}

