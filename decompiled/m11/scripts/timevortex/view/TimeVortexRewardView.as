package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.timevortex.TimeVortexDropTemplateInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class TimeVortexRewardView extends Sprite implements Disposeable
   {
      
      public static const MAX_COUNT:int = 3;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _dropInfos:Vector.<TimeVortexDropTemplateInfo>;
      
      public function TimeVortexRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemList = new Vector.<BaseItemView>();
      }
      
      private function uninitView() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _dropInfos = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get dropInfos() : Vector.<TimeVortexDropTemplateInfo>
      {
         return _dropInfos;
      }
      
      public function set dropInfos(param1:Vector.<TimeVortexDropTemplateInfo>) : void
      {
         _dropInfos = param1;
         initList();
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:TimeVortexDropTemplateInfo = null;
         var _loc3_:int = 0;
         if(_dropInfos)
         {
            _loc2_ = int(_dropInfos.length);
            _loc2_ = _loc2_ > 3 ? 3 : _loc2_;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
               _loc4_ = new GoodsInfo();
               _loc5_ = _dropInfos[_loc3_];
               _loc4_.templateId = _loc5_.TemplateId;
               _loc4_.count = _loc5_.Count;
               _loc4_.templateId = _loc5_.TemplateId;
               _loc1_.data = _loc4_;
               _loc1_.x = _loc3_ * 52;
               _loc1_.y = 0;
               _itemList.push(_loc1_);
               addChild(_loc1_);
               _loc3_++;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

