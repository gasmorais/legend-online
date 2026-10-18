package yishi.view.tips
{
   import mvc.module.pet.PetData;
   import yishi.manager.PlayerManager;
   
   public class PetCompareTip extends BaseTip
   {
      
      private var _selfPetTip:PetTip;
      
      private var _currentTip:PetTip;
      
      public function PetCompareTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _selfPetTip = new PetTip();
         _selfPetTip.type = 1;
         _currentTip = new PetTip();
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:PetData = null;
         var _loc1_:PetData = null;
         if(_selfPetTip.parent)
         {
            _selfPetTip.parent.removeChild(_selfPetTip);
         }
         if(_currentTip.parent)
         {
            _currentTip.parent.removeChild(_currentTip);
         }
         _currentTip.state = false;
         if(tipData is Array || tipData is Vector.<PetData>)
         {
            _loc1_ = tipData[0] as PetData;
            _loc2_ = tipData[1] as PetData;
            _selfPetTip.type = 2;
            _currentTip.type = 3;
         }
         else
         {
            _loc2_ = tipData as PetData;
            _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.enterWarPet;
            _selfPetTip.type = 1;
            _currentTip.type = 0;
         }
         if(!_loc1_ || _loc1_ == _loc2_ || _loc1_.petId == _loc2_.petId && _loc1_.userId == _loc2_.userId)
         {
            addChild(_currentTip);
            _currentTip.x = 0;
         }
         else
         {
            _currentTip.state = true;
            addChild(_selfPetTip);
            addChild(_currentTip);
            _selfPetTip.x = 290;
            _currentTip.x = 0;
         }
         _currentTip.tipData = _loc2_;
         _selfPetTip.tipData = _loc1_;
      }
      
      override public function set direction(param1:int) : void
      {
         if(!_currentTip)
         {
            return;
         }
         if(!_selfPetTip)
         {
            return;
         }
         switch(param1)
         {
            case 0:
            case 2:
            case 5:
            case 7:
               _currentTip.x = 0;
               _selfPetTip.x = 290;
               break;
            case 1:
            case 3:
            case 4:
            case 6:
               _selfPetTip.x = 0;
               _currentTip.x = 290;
         }
         if(!_selfPetTip.parent)
         {
            _currentTip.x = 0;
         }
      }
      
      override public function dispose() : void
      {
         if(_currentTip)
         {
            _currentTip.dispose();
         }
         _currentTip = null;
         if(_selfPetTip)
         {
            _selfPetTip.dispose();
         }
         _selfPetTip = null;
         super.dispose();
      }
   }
}

