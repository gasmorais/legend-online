package battle.view.bottom
{
   import battle.BattleManager;
   import battle.view.ui.ChildCommonSkillItemListView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import managers.ChildNswarManager;
   import org.aswing.KeyboardManager;
   import utils.LogicUtils;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class ChildCommonBottomBar extends Component
   {
      
      private var _back:Bitmap;
      
      private var _hpTxt:FilterFrameText;
      
      private var _spTxt:FilterFrameText;
      
      private var _skillList:ChildCommonSkillItemListView;
      
      private var _selfBloodView:ChildSelfBloodView;
      
      private var _selfSpView:SelfSpView;
      
      private var _leftAwakenFigure:ChildSelfChangeView;
      
      private var _ballRotate:Boolean;
      
      private var _childNswarHbox:HBox;
      
      private var _childNswarAddList:Vector.<ChildNswarCallIcon>;
      
      public function ChildCommonBottomBar(param1:Boolean = true)
      {
         super();
         _ballRotate = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:ChildNswarCallIcon = null;
         var _loc4_:int = 0;
         var _loc1_:Boolean = battleModel.battleType == 3911;
         var _loc2_:int = 54;
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("battle.AbysmHpValueText");
         _spTxt = ComponentFactory.Instance.creatComponentByStylename("battle.AbysmMpValueText");
         _skillList = new ChildCommonSkillItemListView();
         _leftAwakenFigure = new ChildSelfChangeView();
         if(_loc1_)
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.battle.nswarBg");
            _selfBloodView = new ChildSelfBloodView(this,-238 - _loc2_,-91);
            _selfSpView = new SelfSpView(this,100,145 + _loc2_,-90);
            _skillList.x = -135 - _loc2_;
            _skillList.y = -65;
            _leftAwakenFigure.x = -272 - _loc2_;
            _leftAwakenFigure.y = -159;
            _hpTxt.x -= _loc2_;
            _spTxt.x += _loc2_;
            _childNswarHbox = ComponentFactory.Instance.creatComponentByStylename("battle.childnswar.bottom.HBox");
            _childNswarHbox.beginChanges();
            _childNswarAddList = new Vector.<ChildNswarCallIcon>();
            _loc4_ = 0;
            while(_loc4_ < 2)
            {
               _loc3_ = new ChildNswarCallIcon(_loc4_ + 3);
               _childNswarAddList[_loc4_] = _loc3_;
               _childNswarHbox.addChild(_loc3_);
               _loc4_++;
            }
            _childNswarHbox.commitChanges();
            nswarBattleHandler();
         }
         else
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.battle.AbysmBattleBack");
            _selfBloodView = new ChildSelfBloodView(this,-238,-91);
            _selfSpView = new SelfSpView(this,100,145,-90);
            _skillList.x = -135;
            _skillList.y = -65;
            _leftAwakenFigure.x = -272;
            _leftAwakenFigure.y = -159;
         }
         addChild(_back);
         _back.x = -_back.width * 0.5;
         _back.y = -_back.height;
         addChild(_hpTxt);
         addChild(_spTxt);
         addChild(_skillList);
         if(_childNswarHbox != null)
         {
            addChild(_childNswarHbox);
         }
         addChild(_leftAwakenFigure);
         _leftAwakenFigure.direction = 1;
         if(selfInfo)
         {
            _leftAwakenFigure.updateTo(selfInfo.changeValue);
         }
         showVesselBall();
         onHeroSpChanged(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
         if(selfInfo)
         {
            selfInfo.addEventListener("AWAKEN",onHeroSpChanged);
         }
         KeyboardManager.getInstance().addEventListener("keyDown",__onKeyDownHandler);
         NotificationManager.instance.addEventListener("sceneEffectClose",onSceneEffecCloseHandler);
         NotificationManager.instance.addEventListener("childNswar.Event.Battle",nswarBattleHandler);
      }
      
      private function nswarBattleHandler(param1:NotificationEvent = null) : void
      {
         var _loc5_:String = null;
         var _loc2_:ChildNswarCallIcon = null;
         if(!_childNswarAddList)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:SimpleDictionary = ChildNswarManager.Instance.model.battleInfo.battleRoleList;
         var _loc6_:int = int(BattleManager.getInstance().battleModel.selfSide);
         _loc3_ = 3;
         while(_loc3_ < 5)
         {
            _loc5_ = _loc6_ + "_" + _loc3_;
            _loc2_ = _childNswarAddList[_loc3_ - 3];
            _loc2_.updateView(_loc4_[_loc5_]);
            _loc3_++;
         }
      }
      
      private function __onKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode != 32)
         {
            return;
         }
         if(_leftAwakenFigure)
         {
            _leftAwakenFigure.onKeyDown(param1);
         }
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
         if(_selfSpView)
         {
            _selfSpView.setRotation(param1);
         }
      }
      
      private function showVesselBall() : void
      {
         _selfBloodView.showBall(_ballRotate);
         _selfSpView.showBall(_ballRotate);
      }
      
      private function onHeroSpChanged(param1:RoleEvent) : void
      {
         var _loc2_:int = int(selfInfo.awaken);
         _selfSpView.updateHeroSp(_loc2_);
         _spTxt.text = String(_loc2_);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(!selfInfo)
         {
            return;
         }
         var _loc2_:Number = Number(selfInfo.bloodA);
         _selfBloodView.updateHeroHp(_loc2_);
         _hpTxt.text = String(_loc2_);
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         if(selfInfo)
         {
            selfInfo.removeEventListener("AWAKEN",onHeroSpChanged);
         }
         KeyboardManager.getInstance().removeEventListener("keyDown",__onKeyDownHandler);
         NotificationManager.instance.removeEventListener("sceneEffectClose",onSceneEffecCloseHandler);
         NotificationManager.instance.removeEventListener("childNswar.Event.Battle",nswarBattleHandler);
      }
      
      private function get selfInfo() : HeroRoleInfo
      {
         return battleModel.selfChildHeroInfo;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_spTxt);
         _spTxt = null;
         ObjectUtils.disposeObject(_skillList);
         _skillList = null;
         ObjectUtils.disposeObject(_selfSpView);
         _selfSpView = null;
         ObjectUtils.disposeObject(_selfBloodView);
         _selfBloodView = null;
         ObjectUtils.disposeObject(_leftAwakenFigure);
         _leftAwakenFigure = null;
         ObjectUtils.disposeObject(_childNswarHbox);
         _childNswarHbox = null;
         LogicUtils.disposeDisplayCollection(_childNswarAddList);
         _childNswarAddList = null;
         super.dispose();
      }
   }
}

