package secretary.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.SecretaryManager;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.secretary.SecretaryData;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   
   public class AltarIcon extends Sprite
   {
      
      private var _selectBtn:SelectedButton;
      
      private var _icon:ScaleFrameImage;
      
      private var _select:Boolean;
      
      private var _type:int;
      
      public function AltarIcon(param1:int)
      {
         _type = param1;
         super();
         initView();
         initEvent();
      }
      
      public function get select() : Boolean
      {
         return _select;
      }
      
      public function set select(param1:Boolean) : void
      {
         _select = param1;
         _selectBtn.selected = _select;
         if(_select)
         {
            _icon.setFrame(_type * 2);
         }
         else
         {
            _icon.setFrame(_type * 2 - 1);
         }
      }
      
      private function initView() : void
      {
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("secretary.viewitem.selectbtn1");
         _icon = ComponentFactory.Instance.creatComponentByStylename("secrearytary.altar.icon");
         addChild(_selectBtn);
         addChild(_icon);
         _icon.setFrame(_type * 2 - 1);
      }
      
      private function initEvent() : void
      {
         _selectBtn.addEventListener("click",__pointSelectedHandler);
         MsgMan.addObserver("secretary_item_AltarIcon",this,__onSelectChangeHandler);
      }
      
      private function get modelConsortia() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function __pointSelectedHandler(param1:MouseEvent) : void
      {
         modelConsortia.altarWorshipIndex = _type;
         MsgMan.notifyObserver("secretary_item_AltarIcon",_type);
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      private function __onSelectChangeHandler(param1:String, param2:Object) : void
      {
         select = _type == int(param2);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("secretary_item_AltarIcon",this,__onSelectChangeHandler);
         _selectBtn.removeEventListener("click",__pointSelectedHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

