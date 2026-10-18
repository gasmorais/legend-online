package battle.view.bottom
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import managers.PetSacristyManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class PetSacristyAwakenView extends Sprite
   {
      
      private var _awakenMax:Number = 100;
      
      private var _awakenMovie:MovieClip;
      
      private var _childAwakenValue:int = -1;
      
      private var _valueText:FilterFrameText;
      
      public function PetSacristyAwakenView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _awakenMovie = ComponentFactory.Instance.creatCustomObject("asset.battle.SacristyAwakenMC");
         _awakenMovie.scaleX = 0.618;
         _awakenMovie.scaleY = 0.618;
         addChild(_awakenMovie);
         _valueText = ComponentFactory.Instance.creatComponentByStylename("battle.SacristyAwakenValueText");
         addChild(_valueText);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_PET_POWER",__updatePetPower);
         __updatePetPower(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_PET_POWER",__updatePetPower);
      }
      
      private function __updatePetPower(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(PetSacristyManager.instance.awake);
         _valueText.text = String(_loc2_);
         updateChildAwaken(_loc2_);
      }
      
      public function updateChildAwaken(param1:int) : void
      {
         if(_childAwakenValue == param1)
         {
            return;
         }
         _childAwakenValue = param1;
         var _loc2_:int = Math.ceil(_childAwakenValue * 100 / _awakenMax);
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         gotoAndStop(_loc2_);
         if(_childAwakenValue >= _awakenMax)
         {
            effectVisible = true;
         }
         else
         {
            effectVisible = false;
         }
      }
      
      private function gotoAndStop(param1:int) : void
      {
         if(_awakenMovie)
         {
            _awakenMovie.gotoAndStop(param1);
         }
      }
      
      public function set effectVisible(param1:Boolean) : void
      {
         if(!_awakenMovie)
         {
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_awakenMovie);
         _awakenMovie = null;
         ObjectUtils.disposeObject(_valueText);
         _valueText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

