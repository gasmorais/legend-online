package map.outercity.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.SmallMapBar;
   import manager.LanguageMgr;
   import map.internals.event.OuterCityEvent;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.manager.OuterCitySocketOutManager;
   import map.outercity.view.mapphysics.ArmyView;
   import map.outercity.view.mapphysics.MapPhysicsCastle;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.UserArmy;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class OuterCityPkMediator implements IMediator, IEnterFrame
   {
      
      private var _pkArmy:UserArmy;
      
      private var _targetPoint:Point = new Point();
      
      private var _curPoint:Point = new Point();
      
      private var _selfArmy:Sprite;
      
      private var _pkFlag:MovieClip;
      
      private var _isListening:Boolean = true;
      
      private var _count:int;
      
      private var _prePoint:Point = new Point();
      
      public function OuterCityPkMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _selfArmy = param1 as Sprite;
         _pkFlag = ComponentFactory.Instance.creatCustomObject("asset.map.SelectTargetAsset");
         OuterCityManager.instance.model.addEventListener("selectPkArmy",__selectPkArmyHandler);
         OuterCityManager.instance.mapView.addEventListener("mouseOut",__mouseOutHandler);
         OuterCityManager.instance.mapView.addEventListener("mouseOver",__mouseOverHandler);
         StageReferance.stage.addEventListener("keyDown",__keyDownHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         OuterCityManager.instance.mapView.removeEventListener("mouseOut",__mouseOutHandler);
         OuterCityManager.instance.mapView.removeEventListener("mouseOver",__mouseOverHandler);
         OuterCityManager.instance.model.removeEventListener("selectPkArmy",__selectPkArmyHandler);
         StageReferance.stage.removeEventListener("keyDown",__keyDownHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _isListening = false;
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _isListening = true;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(_isListening && param1.keyCode == 88 && !KeyBoardRegister.instance.checkInputTxt())
         {
            SmallMapBar.instance.clickAttackButton();
         }
         param1.stopImmediatePropagation();
      }
      
      private function __selectPkArmyHandler(param1:OuterCityEvent) : void
      {
         _pkArmy = param1.data as UserArmy;
         lock();
      }
      
      private function lock() : void
      {
         if(_pkArmy)
         {
            (_pkArmy.armyView as ArmyView).avatarView.addChildAt(_pkFlag,0);
            EnterFrameManager.instance.registeEnterFrame(this);
            _targetPoint.x = _pkArmy.armyView.x;
            _targetPoint.y = _pkArmy.armyView.y;
            _prePoint.x = _targetPoint.x;
            _prePoint.y = _targetPoint.y;
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",new Point(_pkArmy.armyView.x,_pkArmy.armyView.y)));
         }
         else
         {
            unLock();
         }
      }
      
      private function unLock() : void
      {
         _count = 0;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_pkFlag && _pkFlag.parent)
         {
            _pkFlag.parent.removeChild(_pkFlag);
         }
         NotificationManager.instance.removeEventListener("CLICK_MAP",__mouseDownHandler);
      }
      
      private function __mouseDownHandler(param1:NotificationEvent) : void
      {
         if(param1.data is MapPhysicsCastle)
         {
            return;
         }
         unLock();
      }
      
      public function enterFrame() : void
      {
         var _loc4_:BaseArmy = null;
         var _loc3_:int = 0;
         var _loc2_:String = null;
         _count = _count + 1;
         if(_count == 1)
         {
            NotificationManager.instance.addEventListener("CLICK_MAP",__mouseDownHandler);
         }
         if(_pkArmy.armyView)
         {
            _targetPoint.x = _pkArmy.armyView.x;
            _targetPoint.y = _pkArmy.armyView.y;
            _prePoint.x = _targetPoint.x;
            _prePoint.y = _targetPoint.y;
         }
         else
         {
            _targetPoint.x = _prePoint.x;
            _targetPoint.y = _prePoint.y;
            _loc4_ = OuterCityManager.instance.model.getWorldArmyByUserId(_pkArmy.userId);
            if(_loc4_)
            {
               _pkArmy = _loc4_ as UserArmy;
               lock();
            }
         }
         if(_count % 25 == 0)
         {
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",new Point(_targetPoint.x,_targetPoint.y)));
         }
         _curPoint.x = _selfArmy.x;
         _curPoint.y = _selfArmy.y;
         var _loc1_:int = Point.distance(_targetPoint,_curPoint);
         if(_loc1_ < 50)
         {
            unLock();
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID);
            if(_loc3_ > 0 && _pkArmy.baseHero.consortiaID == _loc3_)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCityPkMediator.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_pkArmy.state == 2)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command05");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            OuterCitySocketOutManager.sendPvpAttack(_pkArmy.baseHero.userId);
         }
      }
   }
}

