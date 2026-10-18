package yishi.view.tips.rune
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.BitmapData;
   
   public class StoneBitGM
   {
      
      private static var _ins:StoneBitGM;
      
      private var _bitDatas:Array = [];
      
      public function StoneBitGM()
      {
         var _loc1_:BitmapData = null;
         var _loc2_:int = 0;
         super();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmapData("asset.army.stone.shape" + _loc2_);
            _bitDatas.push(_loc1_);
            _loc2_++;
         }
      }
      
      public static function get Ins() : StoneBitGM
      {
         if(_ins == null)
         {
            _ins = new StoneBitGM();
         }
         return _ins;
      }
      
      public function getbitData(param1:int) : BitmapData
      {
         return _bitDatas[param1];
      }
   }
}

