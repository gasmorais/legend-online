package sqmemory.page
{
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import sqmemory.item.SqmemoryItem;
   
   public class SqmemoryBasePage extends Sprite
   {
      
      public function SqmemoryBasePage()
      {
         super();
      }
      
      protected function createNote(param1:String, param2:Array, param3:Array, param4:Boolean = false) : SqmemoryItem
      {
         var _loc6_:SqmemoryItem = null;
         var _loc5_:String = null;
         var _loc8_:int = 0;
         var _loc7_:Array = null;
         if(param1 == "#" && param2.length > 1)
         {
            _loc6_ = new SqmemoryItem(param3[1]);
            _loc5_ = LanguageMgr.GetTranslation(param2[1]);
         }
         else if(param1 != null && param1.length >= 1)
         {
            _loc8_ = int(param3[0]);
            _loc6_ = new SqmemoryItem(_loc8_);
            _loc7_ = param1.split(",");
            if(param4)
            {
               _loc7_[0] = _loc7_[0].substr(0,10);
            }
            _loc7_.unshift(param2[0]);
            _loc5_ = LanguageMgr.GetTranslation.apply(this,_loc7_);
         }
         if(_loc6_)
         {
            _loc6_.updateView(_loc5_);
         }
         return _loc6_;
      }
   }
}

