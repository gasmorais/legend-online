package abysm.view
{
   import abysm.view.item.AbysmBossHeadItemView;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import mvc.module.outyard.AbysmModel;
   import utils.LogicUtils;
   import yishi.manager.OutyardManager;
   
   public class AbysmBossView extends Sprite implements Disposeable
   {
      
      private var _itemList:Array;
      
      private var _itemPosList:Array = [{
         "x":45,
         "y":0
      },{
         "x":0,
         "y":78
      },{
         "x":68,
         "y":188
      },{
         "x":162,
         "y":188
      },{
         "x":231,
         "y":78
      },{
         "x":186,
         "y":0
      }];
      
      public function AbysmBossView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:AbysmBossHeadItemView = null;
         var _loc2_:int = 0;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new AbysmBossHeadItemView(_loc2_);
            addChild(_loc1_);
            _loc1_.x = _itemPosList[_loc2_].x;
            _loc1_.y = _itemPosList[_loc2_].y;
            _itemList.push(_loc1_);
            _loc2_ += 1;
         }
      }
      
      public function upData() : void
      {
         var _loc1_:AbysmBossHeadItemView = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.info = abysmInfo.bossList[_loc2_];
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

