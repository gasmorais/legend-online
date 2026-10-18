package bottle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import mvc.module.bottle.BottleModel;
   import yishi.filter.UIFilter;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class BottleBottomIntergalBoxView extends BaseItemView implements Disposeable
   {
      
      private var _light:MovieClip;
      
      private var _index:int = -1;
      
      private var _getBoxBtn:IconButton;
      
      private var _flag:Boolean = false;
      
      public function BottleBottomIntergalBoxView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _light = ComponentFactory.Instance.creatCustomObject("bottle.CTBoxLight1");
         _light.width = 30;
         _light.height = 30;
         _light.stop();
         _light.mouseChildren = _light.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",onBoxClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",onBoxClick);
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         if(_flag)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("bottle.view.BottleFrame.tips"));
            return;
         }
         if(_index >= 0 && model.openCount < model.countRewardArr[_index].param)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("bottle.view.BottleFrame.tip2"));
            return;
         }
         if(_index >= 0 && model.openCount >= model.countRewardArr[_index].param && model.boxMarkArr[_index] == 0)
         {
            BottleManager.instance.sendOpenInfo(5,model.countRewardArr[_index].param);
            model.clickBoxIndex = _index;
         }
      }
      
      public function set boxIndex(param1:int) : void
      {
         _index = param1;
         _getBoxBtn = ComponentFactory.Instance.creatComponentByStylename("bottle.getBoxBtn" + (_index + 1));
         addChild(_getBoxBtn);
         if(_getBoxBtn)
         {
            _getBoxBtn.tipData = model.countRewardArr[_index];
         }
      }
      
      public function refreshStatus() : void
      {
         if(_light == null)
         {
            return;
         }
         buttonMode = false;
         _light.stop();
         _flag = false;
         if(_light.parent)
         {
            _light.parent.removeChild(_light);
         }
         if(model.countRewardArr.length <= 0)
         {
            return;
         }
         if(model.openCount >= model.countRewardArr[_index].param)
         {
            if(model.boxMarkArr[_index] == 0)
            {
               addChild(_light);
               _light.play();
               buttonMode = true;
            }
            else if(model.boxMarkArr[_index] == 1)
            {
               filters = [UIFilter.getGrayFilter()];
               _flag = true;
               buttonMode = true;
            }
         }
      }
      
      private function get model() : BottleModel
      {
         return BottleManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_getBoxBtn);
         _getBoxBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

