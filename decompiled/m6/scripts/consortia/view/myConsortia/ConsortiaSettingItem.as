package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.module.consortia.ConsortiaDutyInfo;
   import yishi.manager.ConsortiaManager;
   
   public class ConsortiaSettingItem extends Sprite implements Disposeable
   {
      
      private var _txt:FilterFrameText;
      
      private var _btn1:SelectedButton;
      
      private var _btn2:SelectedButton;
      
      private var _btn3:SelectedButton;
      
      private var _btn4:SelectedButton;
      
      private var _line:MutipleImage;
      
      private var _index:int;
      
      private var _num:int;
      
      private var _isChairman:Boolean;
      
      private var arr:Array = [8,5,19,18,4,17,13,2,44,45,43,41,47,20,46];
      
      public function ConsortiaSettingItem(param1:int, param2:Boolean)
      {
         _index = param1;
         _isChairman = param2;
         _num = arr[_index];
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingItem.txt");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingItem.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingItem.btn2");
         _btn3 = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingItem.btn3");
         _btn4 = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingItem.btn4");
         _line = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingItem.line");
         addChild(_txt);
         addChild(_btn1);
         addChild(_btn2);
         addChild(_btn3);
         addChild(_btn4);
         addChild(_line);
         refreshView();
         if(_isChairman)
         {
            addEvent();
         }
      }
      
      private function addEvent() : void
      {
         _btn2.addEventListener("click",__btn2ClickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn2.removeEventListener("click",__btn2ClickHandler);
      }
      
      private function __btn2ClickHandler(param1:MouseEvent) : void
      {
         ConsortiaSocketOutManager.updateRights(_num);
      }
      
      public function refreshView() : void
      {
         var _loc3_:ConsortiaDutyInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         _txt.text = LanguageMgr.GetTranslation("ConsortiaSettingItem.txt.text" + _index);
         _txt.y = 10 - 5 * _txt.numLines;
         _btn1.selected = ConsortiaDutyInfo.chairman.indexOf(_num) != -1;
         _btn2.selected = ConsortiaDutyInfo.vicePresident.indexOf(_num) != -1;
         _btn3.selected = ConsortiaDutyInfo.officer.indexOf(_num) != -1;
         _btn4.selected = ConsortiaDutyInfo.Elite.indexOf(_num) != -1;
         _btn1.enable = false;
         _btn2.enable = false;
         _btn3.enable = false;
         _btn4.enable = false;
         if(_num == 45 || _num == 41 || _num == 20 || _num == 46 || _num == 43)
         {
            if(_isChairman)
            {
               _btn2.enable = true;
            }
            _loc3_ = ConsortiaDutyInfo(ConsortiaManager.instance.model.consortiaDutyList[2]);
            if(_loc3_ && _loc3_.rightsStr)
            {
               _loc2_ = _loc3_.rightsStr.split(",");
               if(_loc2_.length > 0)
               {
                  for each(var _loc1_:String in _loc2_)
                  {
                     _loc4_ = parseInt(_loc1_);
                     if(_loc4_ == _num)
                     {
                        _btn2.selected = true;
                     }
                  }
               }
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_btn1);
         _btn1 = null;
         ObjectUtils.disposeObject(_btn2);
         _btn2 = null;
         ObjectUtils.disposeObject(_btn3);
         _btn3 = null;
         ObjectUtils.disposeObject(_btn4);
         _btn4 = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

