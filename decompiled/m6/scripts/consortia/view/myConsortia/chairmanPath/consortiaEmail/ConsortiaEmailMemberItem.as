package consortia.view.myConsortia.chairmanPath.consortiaEmail
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.consortia.ConsortiaDutyLevel;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ConsortiaEmailMemberItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _checkBoxBack:ScaleFrameImage;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _dutyTxt:FilterFrameText;
      
      private var _data:ThaneInfo;
      
      private var _selected:Boolean;
      
      public function ConsortiaEmailMemberItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _checkBoxBack = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.checkBoxBg");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("writeemail.consortiaEmailMemberItem.nickNameTxt");
         _dutyTxt = ComponentFactory.Instance.creatComponentByStylename("writeemail.consortiaEmailMemberItem.dutyTxt");
         addChild(_checkBoxBack);
         addChild(_nickNameTxt);
         addChild(_dutyTxt);
         buttonMode = true;
         selected = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         selected = !selected;
         dispatchEvent(new ConsortiaEvent("MEMBERLIST_SELECTED_CHANGE",null,true));
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         _nickNameTxt.text = _data.nickName;
         _dutyTxt.text = ConsortiaDutyLevel.getDutyByButyLevel(_data.dutyId);
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(data && data.dutyId == 1)
         {
            return;
         }
         _selected = param1;
         if(_selected)
         {
            _checkBoxBack.setFrame(2);
         }
         else
         {
            _checkBoxBack.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _checkBoxBack = null;
         _nickNameTxt = null;
         _dutyTxt = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

