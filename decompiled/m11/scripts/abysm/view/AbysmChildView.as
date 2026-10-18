package abysm.view
{
   import abysm.view.item.AbysmChildItemHeadView;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import mvc.module.outyard.AbysmModel;
   import utils.LogicUtils;
   import yishi.manager.OutyardManager;
   
   public class AbysmChildView extends Sprite implements Disposeable
   {
      
      private var _itemList:Array;
      
      public function AbysmChildView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:AbysmChildItemHeadView = null;
         var _loc2_:int = 0;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new AbysmChildItemHeadView(_loc2_);
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc1_.x = _loc2_ % 2 * 60;
            _loc1_.y = Math.floor(_loc2_ / 2) * 55;
            _loc2_ += 1;
         }
      }
      
      public function upData() : void
      {
         var _loc1_:AbysmChildItemHeadView = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.info = abysmInfo.childList[_loc2_];
            _loc2_ += 1;
         }
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get abysmInfo() : AbysmModel
      {
         return OutyardManager.instance.abysmModel;
      }
   }
}

