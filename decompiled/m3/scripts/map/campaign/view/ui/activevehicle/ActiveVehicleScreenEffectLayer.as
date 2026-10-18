package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.PhysicsEvent;
   import map.internals.effect.RedScreen;
   
   public class ActiveVehicleScreenEffectLayer extends Component
   {
      
      private var _redScreen:RedScreen = new RedScreen();
      
      private var _model:CampaignMapModel = CampaignManager.instance.mapModel;
      
      public function ActiveVehicleScreenEffectLayer()
      {
         this.mouseChildren = this.mouseEnabled = false;
         super();
         if(!_model)
         {
            return;
         }
         if(_model.selfMemberData)
         {
            addEvent();
         }
         else
         {
            _model.addEventListener("addGarrison",__addPlayerHandler);
         }
      }
      
      private function __addPlayerHandler(param1:Event) : void
      {
         if(_model && _model.selfMemberData)
         {
            _model.removeEventListener("addGarrison",__addPlayerHandler);
            addEvent();
         }
      }
      
      private function addEvent() : void
      {
         if(_model && _model.selfMemberData)
         {
            __checkRedScreenHandler();
            _model.selfMemberData.addEventListener("UPDATE_CUR_HP",__checkRedScreenHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("addGarrison",__addPlayerHandler);
            if(_model.selfMemberData)
            {
               _model.selfMemberData.removeEventListener("UPDATE_CUR_HP",__checkRedScreenHandler);
            }
         }
      }
      
      private function __checkRedScreenHandler(param1:PhysicsEvent = null) : void
      {
         if(!_model.selfMemberData)
         {
            return;
         }
         if(_model.selfMemberData.curHp <= _model.selfMemberData.totalHp * 0.2 && _model.selfMemberData.curHp > 0)
         {
            if(!_redScreen.parent)
            {
               addChild(_redScreen);
               _redScreen.play();
            }
         }
         else if(_redScreen.parent)
         {
            removeChild(_redScreen);
            _redScreen.stop();
         }
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         if(_redScreen)
         {
            _redScreen.resize(_loc1_,_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_redScreen)
         {
            _redScreen.dispose();
            _redScreen = null;
         }
         super.dispose();
      }
   }
}

