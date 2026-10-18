package consortia.view.minos.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MinosManager;
   import yishi.datas.templates.MinosNodeTempInfo;
   import yishi.manager.NotificationManager;
   
   public class MinosDiffChoseItem extends Sprite
   {
      
      private var _btn:SelectedButton;
      
      private var _txt:FilterFrameText;
      
      private var _isSelect:Boolean;
      
      private var _temp:MinosNodeTempInfo;
      
      public function MinosDiffChoseItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.SingleSelectButton");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.diffTxt");
         addChild(_btn);
         addChild(_txt);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickhandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickhandler);
      }
      
      private function clickhandler(param1:MouseEvent) : void
      {
         if(!_temp)
         {
            return;
         }
         isSelect = true;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(_isSelect == param1)
         {
            _btn.selected = _isSelect;
            return;
         }
         _isSelect = param1;
         _btn.selected = _isSelect;
         if(_isSelect && _temp)
         {
            _loc2_ = int(MinosManager.ins.model.currDiff);
            if(_loc2_ != _temp.NodeGrade)
            {
               MinosManager.ins.model.currDiff = _temp.NodeGrade;
               NotificationManager.instance.sendNotification("minos_EVENT_CHOOSE_DIFF",_loc2_);
            }
         }
      }
      
      public function get temp() : MinosNodeTempInfo
      {
         return _temp;
      }
      
      public function set temp(param1:MinosNodeTempInfo) : void
      {
         _temp = param1;
         if(_temp)
         {
            _txt.setFrame(_temp.NodeGrade);
            _txt.text = LanguageMgr.GetTranslation("minos.diff" + _temp.NodeGrade,_temp.GardenValue);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
   }
}

