package pet.lookup
{
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.pet.PetData;
   import pet.property.MorphingSkillView;
   import pet.property.PetShowView;
   
   public class PetLookUpFrame extends Frame
   {
      
      private var _topView:PetShowView;
      
      private var _bottomView:MorphingSkillView;
      
      private var _isSelf:Boolean;
      
      public function PetLookUpFrame()
      {
         super();
         initView();
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         _isSelf = param1;
         if(_topView)
         {
            _topView.isSelf = param1;
         }
      }
      
      private function initView() : void
      {
         _topView = new PetShowView();
         _topView.isSelf = _isSelf;
         _topView.state = 3;
         _bottomView = new MorphingSkillView(false);
         _bottomView.y = 273;
         addToContent(_topView);
         addToContent(_bottomView);
      }
      
      public function set data(param1:PetData) : void
      {
         if(_topView)
         {
            _topView.data = param1;
         }
         if(_bottomView)
         {
            _bottomView.data = param1;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         super.dispose();
      }
   }
}

