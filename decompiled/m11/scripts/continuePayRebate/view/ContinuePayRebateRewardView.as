package continuePayRebate.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import managers.FunnyManager;
   
   public class ContinuePayRebateRewardView extends Sprite implements Disposeable
   {
      
      private var _back:MutipleImage;
      
      private var _vbox:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _data:FunnyData;
      
      private var _itemVec:Vector.<ContinuePayRebateRewardItem>;
      
      public function ContinuePayRebateRewardView()
      {
         super();
         _itemVec = new Vector.<ContinuePayRebateRewardItem>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.reward.back");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.reward.vbox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.reward.panel");
         addChild(_back);
         addChild(_panel);
         _panel.setView(_vbox);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         var _loc5_:FunnyData = null;
         var _loc4_:int = 0;
         if(!_data || !_loc5_)
         {
            return;
         }
         if(_data.bagList.length == 0)
         {
            return;
         }
         _loc5_ = FunnyManager.instance.selectedFunnyData;
         var _loc3_:int = int(_loc5_.bagList.length);
         for each(var _loc2_:ContinuePayRebateRewardItem in _itemVec)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc5_.bagList[_loc4_].id == _loc2_.data.id)
               {
                  _loc2_.data = _loc5_.bagList[_loc4_];
               }
               _loc4_++;
            }
         }
      }
      
      public function set data(param1:FunnyData) : void
      {
         var _loc2_:ContinuePayRebateRewardItem = null;
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         _vbox.disposeAllChildren();
         for each(var _loc3_:FunnyBagData in _data.bagList)
         {
            _loc2_ = new ContinuePayRebateRewardItem();
            _loc2_.data = _loc3_;
            _vbox.addChild(_loc2_);
            _itemVec.push(_loc2_);
         }
         _panel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         _data = null;
         _itemVec = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

