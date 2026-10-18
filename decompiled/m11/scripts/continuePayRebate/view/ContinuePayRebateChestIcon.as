package continuePayRebate.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.utils.FlickerHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ContinuePayRebateChestIcon extends Sprite implements Disposeable
   {
      
      private var _cheseIcon:BaseButton;
      
      private var _rewardState:Image;
      
      private var _data:FunnyBagData;
      
      public function ContinuePayRebateChestIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cheseIcon = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestIcon.cheseIcon");
         _rewardState = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestIcon.rewardState");
         addChild(_cheseIcon);
         addChild(_rewardState);
         _rewardState.mouseChildren = _rewardState.mouseEnabled = false;
      }
      
      private function initEvent() : void
      {
         _cheseIcon.addEventListener("click",__onMouseClick);
      }
      
      private function removeEvent() : void
      {
         _cheseIcon.removeEventListener("click",__onMouseClick);
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.status == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("continuePayRebate.mainframe.hasReward"));
            return;
         }
         if(_data.status == 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("continuePayRebate.mainframe.cannotReward"));
            return;
         }
         FunnyManager.instance.selectedId = _data.activeId;
         FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         _data = param1;
         _cheseIcon.tipData = _data;
         _rewardState.visible = _data.status == 2;
         _cheseIcon.enable = _data.status != 2;
         if(_data.status == 1)
         {
            FlickerHelper.setFilcker2(_cheseIcon);
         }
         else
         {
            FlickerHelper.clearFilcker(_cheseIcon);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         FlickerHelper.clearFilcker(_cheseIcon);
         ObjectUtils.disposeObject(_cheseIcon);
         _cheseIcon = null;
         ObjectUtils.disposeObject(_rewardState);
         _rewardState = null;
         if(_data)
         {
            _data = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
   }
}

