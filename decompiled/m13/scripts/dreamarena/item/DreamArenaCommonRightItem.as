package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   
   public class DreamArenaCommonRightItem extends Component
   {
      
      protected var _heroBack:ScaleBitmapImage;
      
      protected var _line2:Image;
      
      protected var _line1:Image;
      
      protected var _hasSelectBtn:IconButton;
      
      protected var _selectBtn:IconButton;
      
      public function DreamArenaCommonRightItem()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _heroBack = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.heroBack");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.line2");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.lien1");
         _hasSelectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.hasSelectBtn");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.selectBtn");
         addChild(_heroBack);
         addChild(_line1);
         addChild(_line2);
         addChild(_selectBtn);
         addChild(_hasSelectBtn);
         _hasSelectBtn.enable = false;
      }
      
      protected function addEvent() : void
      {
         _selectBtn.addEventListener("click",_selectBtnClickHandler);
      }
      
      protected function removeEvent() : void
      {
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",_selectBtnClickHandler);
         }
      }
      
      protected function _selectBtnClickHandler(param1:MouseEvent) : void
      {
      }
      
      protected function refreshSelect(param1:Boolean) : void
      {
         _line1.visible = _line2.visible = param1;
         _selectBtn.visible = !param1;
         _hasSelectBtn.visible = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_heroBack);
         _heroBack = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_hasSelectBtn);
         _hasSelectBtn = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         super.dispose();
      }
   }
}

