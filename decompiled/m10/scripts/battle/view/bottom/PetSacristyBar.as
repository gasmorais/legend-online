package battle.view.bottom
{
   import battle.view.ui.PetSacristyItemListView;
   import battle.view.ui.SelfBufferView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import yishi.datas.BattleModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.TimerUtils;
   
   public class PetSacristyBar extends Sprite
   {
      
      private var _back:Bitmap;
      
      private var _skillList:PetSacristyItemListView;
      
      private var _petAwakenView:PetSacristyAwakenView;
      
      private var _bufferContainer:SelfBufferView;
      
      private var _selfBloodView:SelfBloodView;
      
      private var _battleModel:BattleModel;
      
      private var _textBack:Bitmap;
      
      private var _ballRotate:Boolean;
      
      public function PetSacristyBar(param1:Boolean = true)
      {
         super();
         _ballRotate = param1;
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.sacristy.skillBg");
         _back.x = -_back.width * 0.5;
         _back.y = -_back.height;
         addChild(_back);
         _petAwakenView = new PetSacristyAwakenView();
         _petAwakenView.x = 116;
         _petAwakenView.y = -142;
         addChild(_petAwakenView);
         _bufferContainer = new SelfBufferView();
         _bufferContainer.x = -132;
         _bufferContainer.y = -104;
         addChild(_bufferContainer);
         _skillList = new PetSacristyItemListView();
         _skillList.x = -168;
         _skillList.y = -68;
         addChild(_skillList);
         _textBack = ComponentFactory.Instance.creatBitmap("asset.battle.sacristy.BottomTextBack");
         addChild(_textBack);
         _selfBloodView = new SelfBloodView(this,-238,-89,1);
         addChild(_selfBloodView.heroHpNumContainer);
         showVesselBall();
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("sceneEffectClose",onSceneEffecCloseHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("sceneEffectClose",onSceneEffecCloseHandler);
      }
      
      private function onSceneEffecCloseHandler(param1:Event) : void
      {
         setBallRotation(false);
      }
      
      private function setBallRotation(param1:Boolean) : void
      {
         if(_selfBloodView)
         {
            _selfBloodView.setRotation(param1);
         }
      }
      
      private function showVesselBall() : void
      {
         _selfBloodView.showBall(_ballRotate);
      }
      
      public function getSelfBloodView() : SelfBloodView
      {
         return _selfBloodView;
      }
      
      public function getSkillList() : PetSacristyItemListView
      {
         return _skillList;
      }
      
      private function onSettingBtnClick(param1:MouseEvent) : void
      {
         TimerUtils.setTimeout(openFrame,10);
      }
      
      private function openFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selfBloodView);
         _selfBloodView = null;
         ObjectUtils.disposeObject(_skillList);
         _skillList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_textBack);
         _textBack = null;
         ObjectUtils.disposeObject(_petAwakenView);
         _petAwakenView = null;
         ObjectUtils.disposeObject(_bufferContainer);
         _bufferContainer = null;
         _battleModel = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

