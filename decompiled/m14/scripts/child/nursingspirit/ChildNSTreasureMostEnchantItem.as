package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class ChildNSTreasureMostEnchantItem extends Component
   {
      
      private var _resiIcon:ScaleFrameImage;
      
      private var _selectedImage:Image;
      
      private var _selected:Boolean;
      
      private var _index:int;
      
      private var _quardList:Array;
      
      public function ChildNSTreasureMostEnchantItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _resiIcon = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantItem.resiIcon");
         _selectedImage = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantItem.selectedImage");
         _quardList = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.PetTypeList").split("|");
         addChild(_resiIcon);
         addChild(_selectedImage);
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedImage.visible = _selected;
         _selectedImage.tipData = _resiIcon.tipData = _quardList[_index];
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _resiIcon.setFrame(_index + 1);
         _resiIcon.tipData = _quardList[_index];
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_resiIcon);
         _resiIcon = null;
         ObjectUtils.disposeObject(_selectedImage);
         _selectedImage = null;
         super.dispose();
      }
   }
}

