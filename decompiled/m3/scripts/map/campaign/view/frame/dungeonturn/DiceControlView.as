package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DungeoTurnManager;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   
   public class DiceControlView extends Frame
   {
      
      private var _bg:Image;
      
      private var _diceView:DiceView2;
      
      private var _cancelIconButton:IconButton;
      
      private var _selectIconButton:IconButton;
      
      public function DiceControlView()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceControlView.bg");
         _diceView = ComponentFactory.Instance.creatCustomObject("dungeonturn.DiceControlView.diceView");
         _cancelIconButton = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceControlView.cancelIconButton");
         _selectIconButton = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceControlView.selectIconButton");
         addToContent(_bg);
         addToContent(_diceView);
         addToContent(_cancelIconButton);
         addToContent(_selectIconButton);
         _selectIconButton.enable = false;
         titleText = LanguageMgr.GetTranslation("dungeoturn.choseDice");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectIconButton.addEventListener("click",_selectIconButtonClickHandler);
         _cancelIconButton.addEventListener("click",_cancelIconButtonClickHandler);
         NotificationManager.instance.addEventListener("DUNGEO_TURN_ROLL",_closeFrame);
         NotificationManager.instance.addEventListener("DUNGEO_ROLL_SELECTED",_refreshView);
      }
      
      private function _refreshView(param1:Event) : void
      {
         _selectIconButton.enable = true;
      }
      
      private function _selectIconButtonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _diceView.currentNum;
         DungeoTurnManager.instance.model.isByControl = true;
         DungeoTurnManager.instance.rollDice(_loc2_);
      }
      
      private function _cancelIconButtonClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function _closeFrame(param1:Event) : void
      {
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_selectIconButton)
         {
            _selectIconButton.removeEventListener("click",_selectIconButtonClickHandler);
         }
         if(_cancelIconButton)
         {
            _cancelIconButton.removeEventListener("click",_cancelIconButtonClickHandler);
         }
         NotificationManager.instance.removeEventListener("DUNGEO_TURN_ROLL",_closeFrame);
         NotificationManager.instance.removeEventListener("DUNGEO_ROLL_SELECTED",_refreshView);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_diceView);
         _diceView = null;
         ObjectUtils.disposeObject(_cancelIconButton);
         _cancelIconButton = null;
         ObjectUtils.disposeObject(_selectIconButton);
         _selectIconButton = null;
         super.dispose();
      }
   }
}

