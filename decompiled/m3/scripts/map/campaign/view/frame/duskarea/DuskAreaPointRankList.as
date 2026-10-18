package map.campaign.view.frame.duskarea
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import utils.LogicUtils;
   
   public class DuskAreaPointRankList extends Sprite implements Disposeable
   {
      
      private var _rankItemList:Array;
      
      public function DuskAreaPointRankList()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankItemList = [];
      }
      
      public function refreshMemberList(param1:Array) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _rankItemList.length)
         {
            getItemByIndex(_loc3_).data = null;
            _loc3_++;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            getItemByIndex(_loc3_).data = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function getItemByIndex(param1:int) : DuskAreaPointRankItem
      {
         var _loc2_:DuskAreaPointRankItem = null;
         if(_rankItemList.length - 1 >= param1)
         {
            return _rankItemList[param1];
         }
         _loc2_ = new DuskAreaPointRankItem();
         _loc2_.y = param1 * 30 + 2;
         addChild(_loc2_);
         _rankItemList.push(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_rankItemList);
         _rankItemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
   }
}

