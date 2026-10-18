package battle.view.bottom
{
   import battle.BattleManager;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yzhkof.debug.log;
   
   public class SelfAwakenView extends Component
   {
      
      private var _figureMc:MovieClip;
      
      private var _figureContainer:Sprite;
      
      private var _poolLine:MovieClip;
      
      private var _tween:TweenMax;
      
      private var _currentAwaken:int = 0;
      
      private var _awakenBgMc:MovieClip;
      
      private var _awakenTxtMc:ScaleFrameImage;
      
      private var _job:int = 1;
      
      private var _hero:HeroRoleInfo;
      
      private var _hasPet:Boolean = false;
      
      private var _mask:MovieClip;
      
      private var _battleModel:BattleModel = BattleManager.getInstance().battleModel;
      
      private var _darkColor:ColorTransform = new ColorTransform(0.75,0.75,0.75);
      
      private var _normalColor:ColorTransform = new ColorTransform();
      
      private var _uifilter:IBuildingFilter = new SimpleBuildingFilter();
      
      public var useSkill700001:Boolean;
      
      public var useSkill700002:Boolean;
      
      private var _isMouseOver:Boolean;
      
      private var _skillEnable:Boolean = false;
      
      private var _lastClick:Number = 0;
      
      private var _direction:int = 1;
      
      public function SelfAwakenView(param1:int)
      {
         _job = param1;
         if(_job == 100)
         {
            _job = 1;
         }
         if(_battleModel)
         {
            _hero = _battleModel.selfHero as HeroRoleInfo;
         }
         if(_hero && _hero.petRoleInfo)
         {
            _hasPet = true;
         }
         if(!_hasPet)
         {
            this.mouseEnabled = false;
         }
         if(_hero.heroInfo && _hero.heroInfo.dragonTalkerInfo.isDragonTalker)
         {
            _job = 4;
         }
         super();
         initView();
         addEvent();
         this.mouseChildren = false;
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipDirctions = "0";
         this.tipGapH = 0;
         this.tipGapV = 5;
         this.isFollowMouse = false;
         enable();
         updateStateTxtView();
         updateTips();
      }
      
      private function initView() : void
      {
         _figureContainer = new Sprite();
         addChild(_figureContainer);
         if(ArmyManager.instance.thane.grades >= 50)
         {
            _figureMc = ComponentFactory.Instance.creat("asset.battle.AwakenProgress50" + _job);
            _figureContainer.addChild(_figureMc);
            _figureMc.gotoAndStop(1);
            _figureMc.x = -(_figureMc.width >> 1);
            _poolLine = ComponentFactory.Instance.creat("asset.battle.VesselPoolLineMC");
            _mask = ComponentFactory.Instance.creat("asset.battle.AwakenMask" + _job);
            _awakenBgMc = ComponentFactory.Instance.creatCustomObject("battle.PetAwakenEffect");
            _awakenTxtMc = ComponentFactory.Instance.creatComponentByStylename("battle.awakenImage");
            _figureContainer.addChild(_poolLine);
            addChild(_awakenBgMc);
            addChild(_awakenTxtMc);
            _poolLine.mask = _mask;
            _figureContainer.addChild(_mask);
            _figureContainer.mouseChildren = _figureContainer.mouseEnabled = false;
            _awakenBgMc.gotoAndStop(1);
            _awakenTxtMc.setFrame(1);
            _awakenBgMc.visible = false;
            _awakenTxtMc.visible = false;
            _awakenTxtMc.x = -(_awakenTxtMc.width >> 1);
            _mask.x = -(_mask.width >> 1);
            _poolLine.x = -(_poolLine.width >> 1) + 15;
            _poolLine.alpha = 0.6;
            switch(_job - 1)
            {
               case 0:
                  _awakenBgMc.y = 26;
                  _awakenTxtMc.y = -2;
                  _mask.y = 24;
                  _poolLine.y = 117;
                  break;
               case 1:
                  _awakenBgMc.y = 19;
                  _awakenTxtMc.y = -10;
                  _mask.y = 12;
                  _mask.x = -60;
                  _poolLine.y = 117;
                  break;
               case 2:
                  _awakenBgMc.y = 20;
                  _awakenTxtMc.y = -8;
                  _mask.y = 19;
                  _poolLine.y = 117;
                  break;
               case 3:
                  _awakenBgMc.y = 8;
                  _awakenTxtMc.y = -20;
                  _mask.x = -70;
                  _mask.y = 0;
                  _poolLine.x = -70;
                  _poolLine.y = 117;
            }
         }
         else
         {
            _figureMc = ComponentFactory.Instance.creat("asset.battle.AwakenProgress" + _job);
            _figureContainer.addChild(_figureMc);
            _figureMc.gotoAndStop(1);
            _figureMc.x = -(_figureMc.width >> 1);
         }
      }
      
      public function addEvent() : void
      {
         this.addEventListener("click",__rightFigureClickHandler);
         this.addEventListener("mouseMove",__rightFigureOverHandler);
         this.addEventListener("rollOut",__rightFigureOutHandler);
         this.addEventListener("rollOver",__rollOverHandler);
         _hero.addEventListener("AWAKEN",__onSelfAwakenChangedHandler);
         _hero.addEventListener("isLiving",__livingHandler);
         NotificationManager.instance.addEventListener("battleComplete",__battleEndHandler);
         NotificationManager.instance.addEventListener("skillCd",__skillEnabeleHandler);
         NotificationManager.instance.addEventListener("USE_SKILL_RESULT",_skillResultHandler);
         NotificationManager.instance.addEventListener("restrictChanged",__restrictChangeHandler);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.addEventListener("ACTION_SKILL_BattleNotic",__skillUse);
      }
      
      public function removeEvent() : void
      {
         this.removeEventListener("click",__rightFigureClickHandler);
         this.removeEventListener("mouseMove",__rightFigureOverHandler);
         this.removeEventListener("rollOut",__rightFigureOutHandler);
         this.removeEventListener("rollOver",__rollOverHandler);
         if(_hero)
         {
            _hero.removeEventListener("AWAKEN",__onSelfAwakenChangedHandler);
            _hero.removeEventListener("isLiving",__livingHandler);
         }
         NotificationManager.instance.removeEventListener("battleComplete",__battleEndHandler);
         NotificationManager.instance.removeEventListener("skillCd",__skillEnabeleHandler);
         NotificationManager.instance.removeEventListener("USE_SKILL_RESULT",_skillResultHandler);
         NotificationManager.instance.removeEventListener("restrictChanged",__restrictChangeHandler);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.removeEventListener("ACTION_SKILL_BattleNotic",__skillUse);
      }
      
      private function __skillEnable(param1:NotificationEvent) : void
      {
         if(param1 && param1.data == true)
         {
            NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
            _skillEnable = true;
         }
      }
      
      private function __skillUse(param1:NotificationEvent) : void
      {
         var _loc2_:SkillTempInfo = null;
         if(param1.data is SkillTempInfo)
         {
            _loc2_ = param1.data as SkillTempInfo;
            if(_loc2_.TemplateId == 700001)
            {
               useSkill700001 = true;
               update();
            }
            else if(_loc2_.TemplateId == 700002)
            {
               useSkill700002 = true;
               update();
            }
         }
      }
      
      private function __rightFigureClickHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:SkillTempInfo = null;
         if(!isRight)
         {
            return;
         }
         if(_battleModel.isOver)
         {
            return;
         }
         if(!_hero)
         {
            return;
         }
         if(_hero.restricted)
         {
            return;
         }
         if(_hero.bloodA <= 0)
         {
            return;
         }
         if(!this.buttonMode)
         {
            return;
         }
         if(this.useSkill700001)
         {
            return;
         }
         var _loc3_:Number = getTimer();
         if(_loc3_ - _lastClick < 3000)
         {
            return;
         }
         if(_hero.canMorph())
         {
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(700001);
            NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",_loc2_);
            log({},"skill:700001, time:" + getTimer());
            _lastClick = _loc3_;
         }
         else if(_hero.canCancelMorph())
         {
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(700002);
            NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",_loc2_);
            log({},"skill:700002, time:" + getTimer());
            _lastClick = _loc3_;
         }
         if(BattleManager.getInstance().battleModel.getAutoFightFlag() == 1)
         {
            BattleManager.getInstance().battleModel.setAutoFight(2);
         }
      }
      
      public function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:SkillTempInfo = null;
         if(param1.keyCode != 32)
         {
            return;
         }
         if(!_skillEnable)
         {
            return;
         }
         if(!isRight)
         {
            return;
         }
         if(_battleModel.isOver)
         {
            return;
         }
         if(!_hero)
         {
            return;
         }
         if(_hero.restricted)
         {
            return;
         }
         if(_hero.bloodA <= 0)
         {
            return;
         }
         if(!this.buttonMode)
         {
            return;
         }
         if(this.useSkill700001)
         {
            return;
         }
         var _loc3_:Number = getTimer();
         if(_loc3_ - _lastClick < 3000)
         {
            return;
         }
         if(_hero.canMorph())
         {
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(700001);
            NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",_loc2_);
            log({},"skill:700001, time:" + getTimer());
            _lastClick = _loc3_;
            if(BattleManager.getInstance().battleModel.getAutoFightFlag() == 1)
            {
               BattleManager.getInstance().battleModel.setAutoFight(2);
            }
         }
      }
      
      private function __rightFigureOverHandler(param1:MouseEvent) : void
      {
         if(!isRight)
         {
            return;
         }
         if(param1)
         {
            _isMouseOver = true;
         }
         Mouse.cursor = "auto";
         if(!buttonMode)
         {
            return;
         }
         if(_isMouseOver)
         {
            mouseOver();
         }
      }
      
      private function __rightFigureOutHandler(param1:MouseEvent) : void
      {
         if(!isRight)
         {
            return;
         }
         _isMouseOver = false;
         mouseOut();
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(!isRight)
         {
            return;
         }
         update();
      }
      
      private function mouseOver() : void
      {
         Mouse.cursor = "button";
         _uifilter.setBuildingOverFilter(this);
      }
      
      private function mouseOut() : void
      {
         Mouse.cursor = "auto";
         if(_hero && !_hero.isLiving)
         {
            this.filters = [UIFilter.getBlackFilter()];
         }
         else
         {
            this.filters = null;
         }
      }
      
      private function __onSelfAwakenChangedHandler(param1:RoleEvent) : void
      {
         tweenTo(_hero.awaken);
      }
      
      private function __livingHandler(param1:RoleEvent) : void
      {
         if(!_hero.isLiving)
         {
            useSkill700001 = false;
            useSkill700002 = false;
            stopMc();
         }
         update();
      }
      
      public function __battleEndHandler(param1:Event) : void
      {
         update();
      }
      
      private function __skillEnabeleHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data.skillId);
         if(_loc2_ == 700001)
         {
            useSkill700001 = false;
            update();
         }
         else if(_loc2_ == 700002)
         {
            useSkill700002 = false;
            update();
         }
      }
      
      private function _skillResultHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data.skillId);
         var _loc3_:Boolean = Boolean(param1.data.result);
         if(!_loc3_)
         {
            if(_loc2_ == 700001 && useSkill700001)
            {
               useSkill700001 = false;
            }
            else if(_loc2_ == 700002 && useSkill700002)
            {
               useSkill700002 = false;
            }
         }
         update();
      }
      
      private function __restrictChangeHandler(param1:NotificationEvent) : void
      {
         update();
      }
      
      public function updateTo(param1:int) : void
      {
         var _loc2_:int = Math.floor(param1 * 100 / 3000);
         _currentAwaken = param1;
         tweenCompleted(param1);
      }
      
      public function tweenTo(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 == _currentAwaken)
         {
            return;
         }
         _currentAwaken = param1;
         killTween();
         if(_poolLine)
         {
            _poolLine.visible = true;
         }
         if(_figureMc)
         {
            _loc2_ = Math.floor(param1 * 100 / 3000);
            _tween = TweenMax.to(_figureMc,0.5,{
               "frame":_loc2_,
               "onUpdate":tweenUpdate,
               "onComplete":tweenCompleted,
               "onCompleteParams":[param1]
            });
         }
         if(param1 == 0)
         {
            update();
         }
      }
      
      private function killTween() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
      }
      
      private function tweenCompleted(param1:int) : void
      {
         if(isDie)
         {
            return;
         }
         killTween();
         refreshMc();
         tweenUpdate();
         update();
         updateTips();
      }
      
      private function refreshMc() : void
      {
         var _loc1_:MovieClip = null;
         var _loc3_:int = 0;
         if(isDie)
         {
            return;
         }
         var _loc6_:int = Math.floor(_currentAwaken * 100 / 3000);
         _figureMc.gotoAndStop(_loc6_);
         var _loc4_:Boolean = _currentAwaken >= 3000;
         var _loc2_:MovieClip = _figureMc["bg"] as MovieClip;
         _loc2_.visible = _loc4_;
         if(_loc4_)
         {
            _loc2_.play();
         }
         else
         {
            _loc2_.gotoAndStop(1);
         }
         var _loc5_:MovieClip = _figureMc["body"] as MovieClip;
         if(_loc5_)
         {
            _loc5_.play();
         }
         if(_poolLine)
         {
            _poolLine.play();
         }
         _loc3_ = 1;
         while(_loc3_ < 5)
         {
            if(!_figureMc["ball" + _loc3_])
            {
               break;
            }
            _loc1_ = _figureMc["ball" + _loc3_] as MovieClip;
            _loc1_.visible = _loc4_;
            if(_loc4_)
            {
               _loc1_.play();
            }
            else
            {
               _loc1_.gotoAndStop(1);
            }
            _loc3_++;
         }
         if(_poolLine)
         {
            if(_currentAwaken == 0)
            {
               _poolLine.visible = false;
            }
            else
            {
               _poolLine.visible = true;
            }
         }
      }
      
      private function playMc() : void
      {
      }
      
      private function updateTips() : void
      {
         var _loc1_:String = null;
         if(!_hero || !_hero.petRoleInfo)
         {
            this.tipData = "";
            return;
         }
         _loc1_ = LanguageMgr.GetTranslation("battle.awaken");
         _loc1_ = LanguageMgr.GetTranslation("public.colon",_loc1_);
         _loc1_ += toArialBold(_currentAwaken + " / " + 3000);
         if(isRight)
         {
            if(_hero.canCancelMorph())
            {
               _loc1_ += "\n" + LanguageMgr.GetTranslation("SelfAwakenView.spaceKey2");
            }
            else
            {
               _loc1_ += "\n" + LanguageMgr.GetTranslation("SelfAwakenView.spaceKey");
            }
         }
         this.tipData = _loc1_;
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function tweenUpdate() : void
      {
         if(isDie)
         {
            return;
         }
         if(_figureMc && _poolLine && _figureMc["pos"])
         {
            _poolLine.y = _figureMc.y + _figureMc["pos"].y;
         }
      }
      
      public function updateStateTxtView() : void
      {
         hideStateView();
         if(isRestrict)
         {
            return;
         }
         if(_hero.canMorph() && !useSkill700001)
         {
            showAwakenState();
         }
         else if(_hero.canCancelMorph() && !useSkill700002)
         {
            showUnAwakenState();
         }
      }
      
      private function hideStateView() : void
      {
         if(_awakenBgMc)
         {
            _awakenBgMc.visible = false;
            _awakenBgMc.stop();
         }
         if(_awakenTxtMc)
         {
            _awakenTxtMc.visible = false;
         }
      }
      
      private function showAwakenState() : void
      {
         if(!isRight)
         {
            return;
         }
         if(_awakenBgMc)
         {
            _awakenBgMc.visible = true;
            _awakenBgMc.play();
         }
         if(_awakenTxtMc)
         {
            _awakenTxtMc.visible = true;
            _awakenTxtMc.setFrame(1);
         }
      }
      
      private function showUnAwakenState() : void
      {
         if(!isRight)
         {
            return;
         }
         if(_awakenBgMc)
         {
            _awakenBgMc.visible = false;
            _awakenBgMc.stop();
         }
         if(_awakenTxtMc)
         {
            _awakenTxtMc.visible = true;
            _awakenTxtMc.setFrame(2);
         }
      }
      
      public function enable() : void
      {
         this.buttonMode = false;
         dark();
         mouseOut();
         if(isRestrict)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(!useSkill700001 && !useSkill700002 && (_hero.canMorph() || Boolean(_hero.canCancelMorph())))
         {
            _loc1_ = true;
         }
         if(isRight && _loc1_)
         {
            buttonMode = true;
         }
         if(_loc1_)
         {
            light();
            if(_isMouseOver)
            {
               mouseOver();
            }
         }
         if(!_hero.isLiving)
         {
            stopMc();
         }
         else
         {
            refreshMc();
         }
      }
      
      private function get isRestrict() : Boolean
      {
         if(!_hero)
         {
            return true;
         }
         if(_hero.restricted || !_hero.isLiving)
         {
            return true;
         }
         return false;
      }
      
      private function get isRight() : Boolean
      {
         return direction != -1;
      }
      
      private function dark() : void
      {
         var _loc1_:MovieClip = _poolLine;
         if(_loc1_)
         {
            _loc1_.transform.colorTransform = _darkColor;
         }
         if(_figureMc && _figureMc["body"])
         {
            _loc1_ = _figureMc["body"] as MovieClip;
            _loc1_.transform.colorTransform = _darkColor;
         }
      }
      
      private function light() : void
      {
         var _loc1_:MovieClip = _poolLine;
         if(_loc1_)
         {
            _loc1_.transform.colorTransform = _normalColor;
         }
         if(_figureMc && _figureMc["body"])
         {
            _loc1_ = _figureMc["body"] as MovieClip;
            _loc1_.transform.colorTransform = _normalColor;
         }
      }
      
      public function stopMc() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            if(!_figureMc["ball" + _loc2_])
            {
               break;
            }
            _loc1_ = _figureMc["ball" + _loc2_] as MovieClip;
            _loc1_.stop();
            _loc2_++;
         }
         _loc1_ = _figureMc["bg"] as MovieClip;
         if(_loc1_)
         {
            _loc1_.stop();
         }
         _loc1_ = _figureMc["body"] as MovieClip;
         if(_loc1_)
         {
            _loc1_.stop();
         }
         if(_poolLine)
         {
            _poolLine.stop();
         }
         if(_awakenBgMc)
         {
            _awakenBgMc.stop();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true);
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
         _figureContainer.scaleX = param1;
         if(param1 == -1)
         {
            if(_awakenBgMc)
            {
               _awakenBgMc.stop();
               _awakenBgMc.visible = false;
            }
            if(_awakenTxtMc)
            {
               _awakenTxtMc.visible = false;
            }
         }
      }
      
      public function update() : void
      {
         enable();
         updateStateTxtView();
      }
      
      private function get isDragonTalker() : Boolean
      {
         return DragonTalkerManager.instance.model.isDragonTalker;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_figureMc);
         _figureMc = null;
         ObjectUtils.disposeViolentMc(_figureContainer);
         _figureContainer = null;
         ObjectUtils.disposeViolentMc(_poolLine);
         _poolLine = null;
         ObjectUtils.disposeViolentMc(_awakenBgMc);
         _awakenBgMc = null;
         ObjectUtils.disposeObject(_awakenTxtMc);
         _awakenTxtMc = null;
         ObjectUtils.disposeViolentMc(_mask);
         _mask = null;
         killTween();
         _uifilter = null;
         _battleModel = null;
         _hero = null;
         _darkColor = null;
         _normalColor = null;
         _tween = null;
         super.dispose();
      }
   }
}

