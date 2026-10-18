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
   
   public class TimeVortexCrackRewardView extends Sprite implements Disposeable
   {
      
      public static const MAX_COUNT:int = 4;
      
      public static const MIN_WIDTH:int = 72;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _dropInfos:Vector.<TimeVortexDropTemplateInfo>;
      
      public function TimeVortexCrackRewardView()
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
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:TimeVortexDropTemplateInfo = null;
         var _loc1_:Number = NaN;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         if(_dropInfos)
         {
            _loc3_ = int(_dropInfos.length);
            _loc3_ = _loc3_ > 4 ? 4 : _loc3_;
            _loc7_ = _loc3_ > 4 ? 0 : 4 - _loc3_;
            _loc1_ = _loc7_ * 72 * 0.5;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexCrackRewardView.BaseItemView");
               _loc5_ = new GoodsInfo();
               _loc6_ = _dropInfos[_loc4_];
               _loc5_.templateId = _loc6_.TemplateId;
               _loc5_.count = _loc6_.Count;
               _loc5_.templateId = _loc6_.TemplateId;
               _loc2_.data = _loc5_;
               _loc2_.x = _loc1_ + _loc4_ * 72;
               _loc2_.y = 0;
               _itemList.push(_loc2_);
               addChild(_loc2_);
               _loc4_++;
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

