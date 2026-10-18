package pet.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.pet.PetData;
   import pet.common.PetAvatarView;
   
   public class PetComposeHeadView extends Sprite
   {
      
      private var _back:Image;
      
      private var _petView:PetAvatarView;
      
      private var _data:PetData;
      
      public function PetComposeHeadView()
      {
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("PetComposeHeadView.titleBack");
         _petView = new PetAvatarView();
         _petView.mouseEnabled = _petView.mouseChildren = false;
         _petView.x = 95;
         _petView.y = 195;
         addChild(_back);
         addChild(_petView);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_petView);
         _petView = null;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(param1)
         {
            _petView.data = param1.template;
         }
         else
         {
            _petView.data = null;
            _back.tipData = null;
         }
         _data = param1;
      }
      
      public function set petTips(param1:Object) : void
      {
         if(_back)
         {
            _back.tipData = param1;
         }
      }
      
      public function set backTipStyle(param1:String) : void
      {
         if(_back)
         {
            _back.tipStyle = param1;
         }
      }
      
      public function get back() : Image
      {
         return _back;
      }
      
      public function dispose() : void
      {
         uintView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

