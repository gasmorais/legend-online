package battle.view.roles
{
   import battle.BattleManager;
   import battle.actions.ReadyAction;
   import battle.data.BufferDamageData;
   import battle.data.DannyEffectData;
   import battle.events.BattleEvent;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.EffectContainer;
   import battle.skillsys.effect.LibEffect;
   import battle.skillsys.effect.MovieClipEffect;
   import battle.skillsys.helper.BloodHelper;
   import battle.utils.Helpers;
   import battle.view.buffer.BufferContainer;
   import battle.view.buffer.BufferIconFactory;
   import battle.view.buffer.BufferIconOnRole;
   import battle.view.buffer.BufferLastEffect;
   import battle.view.skill.QteSuccessAnimation;
   import battle.view.ui.BossBottomStrip;
   import battle.view.ui.DamageNumView;
   import battle.view.ui.IHpStrip;
   import battle.view.ui.SkillUseItemCell;
   import battle.view.ui.StripUIView;
   import battle.view.utils.CollectionEffect;
   import battle.view.utils.DepthSprite;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.BaseManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.TimerUtils;
   
   public class RoleViewBase extends DepthSprite
   {
      
      public static const LOADING_STATE:int = 0;
      
      public static const LOAD_COMPLETE_STATE:int = 1;
      
      public static const HIDE_MODE:int = -1;
      
      public static const SHOW_MODE:int = 1;
      
      protected var _info:RoleInfo;
      
      private var _backEffectContainer:EffectContainer;
      
      private var _body:Sprite;
      
      protected var _movieContainer:Sprite;
      
      protected var _loadingState:int = 0;
      
      protected var _roleInfoView:MovieClip;
      
      private var _middleContainer:Sprite;
      
      private var _effectContainer:EffectContainer;
      
      private var _bufferContainer:BufferContainer;
      
      private var _multiLordsBuffer:BufferIconOnRole;
      
      private var _multiLordsBufferInfo:BufferTemplateInfo;
      
      private var _bufferLastEffects:Vector.<BufferLastEffect>;
      
      protected var _stripView:IHpStrip;
      
      private var _loadingView:MovieClip;
      
      private var _roleLoaded:Boolean;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      protected var _heroNameTxt:FilterFrameText;
      
      protected var _heroServiceTxt:FilterFrameText;
      
      protected var _nameContainer:Sprite;
      
      protected var _bufferGoodStateHbox:HBox;
      
      protected var _bufferBadStateHbox:HBox;
      
      protected var _bufferGoodImage:Image;
      
      protected var _bufferBadImage:Image;
      
      protected var _bufferGoodText:FilterFrameText;
      
      protected var _bufferBadText:FilterFrameText;
      
      protected var _bufferResistMc:MovieClip;
      
      private var _fateSkillEffect:DisplayObject;
      
      private var _isLockInfoView:Boolean = false;
      
      protected var _shade:DisplayObject;
      
      private var _shadeW:Number = 0;
      
      private var _initViewId:uint;
      
      protected var _disposed:Boolean;
      
      protected var _displayMode:int;
      
      private var _arrangePriority:Boolean;
      
      protected var _roleInfoViewVisible:Boolean = true;
      
      private var heroCollectionEffect:MovieClipEffect;
      
      private var _collectionEffect:CollectionEffect;
      
      private var _skillUsedFlag:MovieClip;
      
      private var _skillItemUseCell:SkillUseItemCell;
      
      protected var _readySkillTemp:SkillTempInfo;
      
      private var _qteSuccessAnimation:QteSuccessAnimation;
      
      private var _skillAimMc:MovieClip;
      
      public function RoleViewBase(param1:RoleInfo)
      {
         _info = param1;
         super();
         _displayMode = -1;
         _backEffectContainer = new EffectContainer();
         _backEffectContainer.mouseChildren = _backEffectContainer.mouseEnabled = false;
         _body = new Sprite();
         _body.mouseChildren = _body.mouseEnabled = false;
         addChild(_body);
         _movieContainer = new Sprite();
         _body.addChild(_movieContainer);
         _middleContainer = new Sprite();
         addChild(_middleContainer);
         _middleContainer.mouseChildren = _middleContainer.mouseEnabled = false;
         _effectContainer = new EffectContainer();
         addChild(_effectContainer);
         _effectContainer.mouseChildren = _effectContainer.mouseEnabled = false;
         _bufferLastEffects = new Vector.<BufferLastEffect>();
         mouseEnabled = false;
         if(BattleModel.battleUILoaded)
         {
            delayInitView();
         }
         else
         {
            NotificationManager.instance.addEventListener("battleUILoaded",onBattleUILoaded,false,100);
         }
         NotificationManager.instance.addEventListener("battleMusicOnOff",onBattleMusicOnOff);
      }
      
      public function displayMode(param1:int) : void
      {
         if(param1 == -1)
         {
            if(!battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            if(_fateSkillEffect)
            {
               ObjectUtils.disposeObject(_fateSkillEffect);
            }
            _fateSkillEffect = null;
         }
         else if(_info.startload && _displayMode == -1)
         {
            if(battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            addFateSkillEffect();
         }
         else if(!_info.startload)
         {
            if(battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            addFateSkillEffect();
         }
      }
      
      public function load() : void
      {
      }
      
      public function get heroServiceTxt() : FilterFrameText
      {
         return _heroServiceTxt;
      }
      
      public function set heroServiceTxt(param1:FilterFrameText) : void
      {
         _heroServiceTxt = param1;
      }
      
      public function get heroNameTxt() : FilterFrameText
      {
         return _heroNameTxt;
      }
      
      public function set heroNameTxt(param1:FilterFrameText) : void
      {
         _heroNameTxt = param1;
      }
      
      private function onBattleMusicOnOff(param1:BattleEvent) : void
      {
         if(_info.actionMovieClip)
         {
            _info.actionMovieClip.soundTransform = SharedManager.instance.getSkillSoundTransform();
         }
      }
      
      private function onBattleUILoaded(param1:BattleEvent) : void
      {
         NotificationManager.instance.removeEventListener("battleUILoaded",onBattleUILoaded);
         delayInitView();
      }
      
      protected function delayInitView() : void
      {
         var _loc2_:MovieClip = null;
         if(_disposed)
         {
            return;
         }
         addFateSkillEffect();
         if(!_shade)
         {
            _shade = ComponentFactory.Instance.creat("asset.battle.RoleShadeMC");
         }
         _shade.alpha = 0.7;
         addChildAt(_shade,0);
         if(_shadeW != 0)
         {
            initShadeScale(_shadeW);
         }
         addChildAt(_backEffectContainer,1);
         if(!_roleInfoView)
         {
            _roleInfoView = ComponentFactory.Instance.creatCustomObject("asset.battle.PawnBottomAsset");
         }
         if(!_heroNameTxt)
         {
            _heroNameTxt = ComponentFactory.Instance.creatComponentByStylename("battle.HeroNameTxt");
         }
         _heroNameTxt.setFrame(1);
         _heroNameTxt.filters = [];
         if(!_heroServiceTxt)
         {
            _heroServiceTxt = ComponentFactory.Instance.creatComponentByStylename("battle.HeroServiceTxt");
         }
         _heroServiceTxt.filters = [];
         _heroServiceTxt.text = "";
         _roleInfoView.container.addChild(_heroNameTxt);
         _roleInfoView.container.addChild(_heroServiceTxt);
         addChild(_roleInfoView);
         if(!_bufferResistMc)
         {
            _bufferResistMc = ComponentFactory.Instance.creatCustomObject("battle.bufferResistMc");
         }
         addChild(_bufferResistMc);
         _bufferResistMc.gotoAndStop(1);
         if(_stripView)
         {
            _stripView.dispose();
         }
         _stripView = null;
         if(_info is HeroRoleInfo && HeroRoleInfo(_info).type == 3 && _info.face == 2)
         {
            _stripView = new BossBottomStrip(BattleModel.getBossHpStripNum(HeroRoleInfo(_info).heroInfo.templateId),0,16275472);
            (_stripView as BossBottomStrip)._toSetWidth = true;
            _stripView.getView().width = 69;
         }
         else
         {
            _loc2_ = ClassUtils.CreatInstance("asset.battle.BottomHpStripAsset");
            _stripView = new StripUIView(_loc2_,_info.blood,_info.blood,16275472);
            _loc2_ = null;
         }
         _roleInfoView.addChild(_stripView.getView());
         _roleInfoView.strip_pos.visible = false;
         _roleInfoView.y = -20;
         if(!_bufferGoodStateHbox)
         {
            _bufferGoodStateHbox = ComponentFactory.Instance.creatComponentByStylename("battle.bufferStateHbox");
         }
         if(!_bufferBadStateHbox)
         {
            _bufferBadStateHbox = ComponentFactory.Instance.creatComponentByStylename("battle.bufferStateHbox");
         }
         if(!_bufferGoodImage)
         {
            _bufferGoodImage = ComponentFactory.Instance.creatComponentByStylename("battle.bufferGoodImage");
         }
         if(!_bufferBadImage)
         {
            _bufferBadImage = ComponentFactory.Instance.creatComponentByStylename("battle.bufferBadImage");
         }
         if(!_bufferGoodText)
         {
            _bufferGoodText = ComponentFactory.Instance.creatComponentByStylename("battle.bufferGoodText");
         }
         if(!_bufferBadText)
         {
            _bufferBadText = ComponentFactory.Instance.creatComponentByStylename("battle.bufferBadText");
         }
         _roleInfoView.addChild(_bufferGoodStateHbox);
         _roleInfoView.addChild(_bufferBadStateHbox);
         _bufferBadStateHbox.addChild(_bufferBadImage);
         _bufferBadStateHbox.addChild(_bufferBadText);
         _bufferGoodStateHbox.addChild(_bufferGoodImage);
         _bufferGoodStateHbox.addChild(_bufferGoodText);
         _bufferGoodStateHbox.visible = false;
         _bufferBadStateHbox.visible = false;
         var _loc1_:int = -80;
         if(checkCanshowBuffIcon())
         {
            if(_info.multiLordsInspireLevel > 0)
            {
               _multiLordsBufferInfo = new BufferTemplateInfo();
               _multiLordsBufferInfo.Icon = "/inspire.png";
               _multiLordsBufferInfo.BufferName = LanguageMgr.GetTranslation("battle.view.roles.RoleViewBase.multiLordsBufferInfo.Tips",_info.multiLordsInspireLevel * 5);
               if(battleModel.battleType == 315)
               {
                  _multiLordsBufferInfo.BufferName = LanguageMgr.GetTranslation("battle.view.roles.RoleViewBase.multiLordsBufferInfo.Tips2",_info.multiLordsInspireLevel * 10);
               }
               _multiLordsBufferInfo.MultiLordsInspireLevel = _info.multiLordsInspireLevel;
               _multiLordsBuffer = new BufferIconOnRole(_multiLordsBufferInfo.Icon,_multiLordsBufferInfo);
               _multiLordsBuffer.x = _loc1_;
               _multiLordsBuffer.y = -5;
               _roleInfoView.addChild(_multiLordsBuffer);
               _loc1_ = -120;
            }
            _bufferContainer = new BufferContainer();
            _bufferContainer.x = _loc1_;
            _bufferContainer.y = -5;
            _roleInfoView.addChild(_bufferContainer);
         }
         _stripView.maxValue = _info.totalBloodA;
         _stripView.currentValue = _info.bloodA;
         Helpers.setChildPos(_stripView.getView(),_roleInfoView.strip_pos,true);
         _roleInfoView.bgMc.visible = true;
         setRoleInfoViewVisible(_roleInfoViewVisible);
         createView();
         reFreshViewPositionByInfo();
         addEvent();
         updataByFace();
      }
      
      private function addFateSkillEffect() : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc9_:* = null;
         var _loc1_:* = null;
      }
      
      private function fateSkillComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_disposed)
         {
            return;
         }
         if(_fateSkillEffect)
         {
            ObjectUtils.disposeObject(_fateSkillEffect);
            _fateSkillEffect = null;
         }
         _fateSkillEffect = param2 as DisplayObject;
         if(!_fateSkillEffect)
         {
            return;
         }
         addChildAt(_fateSkillEffect,0);
      }
      
      protected function refreshNameView() : void
      {
         var _loc2_:int = 0;
         if(BattleManager.getInstance().battleModel)
         {
            _loc2_ = BattleManager.getInstance().battleModel.battleType;
         }
         var _loc1_:String = info.battleServerName;
         if(_loc1_ && isShowServiceNameBattleType(_loc2_))
         {
            _heroServiceTxt.text = "[" + _loc1_ + "]";
         }
         else
         {
            _heroServiceTxt.text = "";
         }
      }
      
      private function isShowServiceNameBattleType(param1:int) : Boolean
      {
         switch(param1)
         {
            case 10:
            case 32:
            case 308:
            case 296:
            case 3848:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function get info() : RoleInfo
      {
         return _info;
      }
      
      protected function addEvent() : void
      {
         _info.addEventListener("action",__action);
         _info.addEventListener("pointChange",__point);
         _info.addEventListener("die",__die);
         _info.addEventListener("scaleX",__scaleX);
         _info.addEventListener("FACE_CHANGE",__faceChange);
         _info.addEventListener("bloodChange",__blood);
         _info.addEventListener("bloodChangeS",__bloodChangedSecurity);
         _info.addEventListener("direction_change",__directionChange);
         _info.addEventListener("effectcPlay",__effectcPlay);
         _info.addEventListener("SHOW_BUFFER",__showBuffer);
         if(checkCanshowBuffIcon())
         {
            _info.addEventListener("REFRESH_BUFFER",__reFreshBuffer);
            _info.addEventListener("REFRESH_BUFFER_TURN",__reFreshBufferTurn);
         }
      }
      
      private function checkCanshowBuffIcon() : Boolean
      {
         if(BattleManager.getInstance().battleModel.battleType == 35 || BattleManager.getInstance().battleModel.battleType == 3844 || BattleManager.getInstance().battleModel.battleType == 3845 || BattleManager.getInstance().battleModel.battleType == 3847 || BattleManager.getInstance().battleModel.battleType == 3864 || BattleManager.getInstance().battleModel.battleType == 3866 || BattleManager.getInstance().battleModel.battleType == 3867 || BattleManager.getInstance().battleModel.battleType == 3868 || BattleManager.getInstance().battleModel.battleType == 3889 || BattleManager.getInstance().battleModel.battleType == 3869 || BattleManager.getInstance().battleModel.battleType == 349 || _info != BattleManager.getInstance().battleModel.selfHero)
         {
            return true;
         }
         return false;
      }
      
      private function __faceChange(param1:RoleEvent) : void
      {
         updataByFace();
      }
      
      private function updataByFace() : void
      {
         var _loc1_:int = int(info.face);
         if(_loc1_ == 2)
         {
            info.direction = "left";
         }
         else
         {
            info.direction = "right";
         }
      }
      
      private function setRoleAllContainerScaleX(param1:Number) : void
      {
         _backEffectContainer.scaleX = _effectContainer.scaleX = _movieContainer.scaleX = param1;
      }
      
      private function __showBuffer(param1:RoleEvent) : void
      {
         var _loc2_:String = null;
         var _loc13_:int = 0;
         var _loc11_:BattleEffect = null;
         var _loc3_:Point = null;
         var _loc7_:BufferLastEffect = null;
         var _loc10_:Boolean = false;
         var _loc8_:int = 0;
         var _loc6_:BufferDamageData = BufferDamageData(param1.data);
         var _loc9_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc6_.templateId);
         if(!_loc9_)
         {
            return;
         }
         if(_loc9_ && _loc9_.AttackType == 322 && _loc9_.AttackWay == 4)
         {
            if(_bufferResistMc)
            {
               _bufferResistMc.gotoAndPlay(1);
            }
            return;
         }
         var _loc5_:Array = _loc9_.getAddEffectArr();
         _loc2_ = _loc5_[0];
         _loc13_ = int(_loc5_[1]);
         if(_loc2_ && !battleModel.isHideOtherInBattle(info))
         {
            _loc11_ = BufferIconFactory.getInstance().getBufferEffectII(_loc2_);
            _loc3_ = _info.getSpecialPos(_loc13_);
            _loc11_.getDisplayObject().x = _loc3_.x;
            _loc11_.getDisplayObject().y = _loc3_.y;
            _effectContainer.addEffect(_loc11_);
         }
         var _loc4_:Array = _loc9_.getLastEffectArr();
         var _loc12_:String = _loc4_[0];
         if(_loc12_)
         {
            _loc8_ = 0;
            while(_loc8_ < _bufferLastEffects.length)
            {
               _loc7_ = _bufferLastEffects[_loc8_];
               if(_loc7_.bufferData.templateId == _loc6_.templateId)
               {
                  _loc10_ = true;
                  break;
               }
               _loc8_++;
            }
            if(!_loc10_)
            {
               _loc7_ = new BufferLastEffect(_info,_loc6_,_effectContainer,_loc12_);
               _loc7_.show();
               _bufferLastEffects.push(_loc7_);
            }
         }
         setBufferStateCount();
      }
      
      private function setBufferStateCount() : void
      {
         var _loc3_:BufferTemplateInfo = null;
         _bufferGoodStateHbox.visible = _bufferBadStateHbox.visible = false;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         for each(var _loc4_:BufferDamageData in info.getBuffers())
         {
            if(_loc4_.currentTurn > 0)
            {
               if(info as HeroRoleInfo)
               {
                  name = (info as HeroRoleInfo).heroInfo.nickName;
               }
               _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc4_.templateId);
               if(_loc3_)
               {
                  if(!(!_loc3_.Icon || _loc3_.Icon.length <= 0))
                  {
                     if(!(_loc3_.CountWay == -1 && _loc3_.ValidCount == -1))
                     {
                        if(_loc3_.AttackData == 1 && _loc3_.Dispel == 0)
                        {
                           _loc2_++;
                        }
                        else if(_loc3_.AttackData == 2 && _loc3_.Dispel == 0)
                        {
                           _loc1_++;
                        }
                     }
                  }
               }
            }
         }
         if(_loc2_ > 0)
         {
            _bufferGoodText.text = _loc2_.toString();
            _bufferGoodStateHbox.visible = true;
         }
         if(_loc1_ > 0)
         {
            _bufferBadStateHbox.x = _loc2_ > 0 ? 0 : -35;
            _bufferBadText.text = _loc1_.toString();
            _bufferBadStateHbox.visible = true;
         }
      }
      
      private function __reFreshBuffer(param1:RoleEvent) : void
      {
         var _loc2_:BufferTemplateInfo = null;
         var _loc4_:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
         for each(var _loc3_:BufferDamageData in param1.data)
         {
            _loc2_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc3_.templateId);
            if(_loc2_ && _loc2_.AttackType == 322 && _loc2_.AttackWay == 4)
            {
               if(_bufferResistMc)
               {
                  _bufferResistMc.gotoAndPlay(1);
               }
            }
            if(_loc3_.currentTurn > 0)
            {
               _loc4_.push(_loc3_);
            }
         }
         if(getRoleIsRightBoss() && BattleManager.getInstance().battleUIView)
         {
            BattleManager.getInstance().battleUIView.reFreshBuffer(_loc4_);
         }
         else
         {
            _bufferContainer.reFreshBuffer(_loc4_);
         }
         setBufferStateCount();
      }
      
      private function getRoleIsRightBoss() : Boolean
      {
         var _loc2_:Dictionary = null;
         if(BattleManager.getInstance().battleModel)
         {
            _loc2_ = BattleManager.getInstance().battleModel.armyInfoRight.getHeros;
         }
         if(_loc2_ != null)
         {
            for each(var _loc1_:HeroRoleInfo in _loc2_)
            {
               if(_loc1_ && info.livingId == _loc1_.livingId && info is HeroRoleInfo && HeroRoleInfo(info).type == 3)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function __reFreshBufferTurn(param1:RoleEvent = null) : void
      {
         if(getRoleIsRightBoss() && BattleManager.getInstance().battleUIView)
         {
            BattleManager.getInstance().battleUIView.refreshTurn();
         }
         else
         {
            _bufferContainer.refreshTurn();
         }
      }
      
      private function removeLastEffect(param1:int) : void
      {
         var _loc2_:BufferLastEffect = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _bufferLastEffects.length)
         {
            _loc2_ = _bufferLastEffects[_loc3_];
            if(_loc2_.bufferData.templateId == param1)
            {
               _bufferLastEffects.splice(_loc3_,1);
               _loc2_.dispose();
               break;
            }
            _loc3_++;
         }
      }
      
      public function addBufferActionEffect(param1:int) : void
      {
         var _loc5_:BattleEffect = null;
         var _loc3_:Point = null;
         if(_disposed)
         {
            return;
         }
         if(battleModel.isHideOtherInBattle(info))
         {
            return;
         }
         var _loc7_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1);
         var _loc4_:Array = _loc7_.getActionEffectArr();
         var _loc2_:String = _loc4_[0];
         var _loc6_:int = int(_loc4_[1]);
         if(_loc2_)
         {
            _loc5_ = BufferIconFactory.getInstance().getBufferEffectII(_loc2_);
            _loc3_ = _info.getSpecialPos(_loc6_);
            _loc5_.getDisplayObject().x = _loc3_.x;
            _loc5_.getDisplayObject().y = _loc3_.y;
            _effectContainer.addEffect(_loc5_);
         }
      }
      
      private function __effectcPlay(param1:RoleEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_ is DannyEffectData)
         {
            if(!(_loc2_ as DannyEffectData).isPlayEffect)
            {
               return;
            }
         }
         else if(battleModel.isHideOtherInBattle(info))
         {
            return;
         }
         var _loc3_:LibEffect = new LibEffect(_loc2_.effect);
         var _loc4_:DisplayObject = _loc3_.getDisplayObject();
         _loc4_.x = _loc2_.x || 0;
         _loc4_.y = _loc2_.y || 0;
         _effectContainer.addEffect(_loc3_,_loc2_.repeat || 1);
      }
      
      protected function removeEvent() : void
      {
         if(_info)
         {
            _info.removeEventListener("action",__action);
            _info.removeEventListener("pointChange",__point);
            _info.removeEventListener("die",__die);
            _info.removeEventListener("scaleX",__scaleX);
            _info.removeEventListener("effectcPlay",__effectcPlay);
            _info.removeEventListener("REFRESH_BUFFER",__reFreshBuffer);
            _info.removeEventListener("REFRESH_BUFFER_TURN",__reFreshBufferTurn);
            _info.removeEventListener("SHOW_BUFFER",__showBuffer);
            _info.removeEventListener("FACE_CHANGE",__faceChange);
            _info.removeEventListener("bloodChange",__blood);
            _info.removeEventListener("bloodChangeS",__bloodChangedSecurity);
            _info.removeEventListener("direction_change",__directionChange);
         }
         NotificationManager.instance.removeEventListener("battleMusicOnOff",onBattleMusicOnOff);
      }
      
      private function __action(param1:RoleEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         action.apply(null,_loc2_);
      }
      
      public function initPos(param1:Point) : void
      {
         updateDepthInfo();
         if(_info.face == 2)
         {
            info.direction = "left";
         }
         else
         {
            info.direction = "right";
         }
         this.x = _info.point.x;
         this.y = _info.point.y + -pointZ;
      }
      
      private function __point(param1:RoleEvent) : void
      {
         updateDepthInfo();
         if(this.x > _info.point.x)
         {
            info.direction = "left";
         }
         else if(this.x == _info.point.x)
         {
            if(_info.face == 2)
            {
               info.direction = "left";
            }
            else
            {
               info.direction = "right";
            }
         }
         else
         {
            info.direction = "right";
         }
         this.x = _info.point.x;
         this.y = _info.point.y + -pointZ;
      }
      
      private function reFreshViewPositionByInfo() : void
      {
         updateDepthInfo();
         this.x = _info.point.x;
         this.y = _info.point.y + -pointZ;
      }
      
      private function updateDepthInfo() : void
      {
         if(_disposed)
         {
            return;
         }
         pointZ = _info.pointZ;
         pointY = _info.point.y;
         if(_info == BattleManager.getInstance().battleModel.selfHero)
         {
            pointY += 1;
         }
         if(_info is PetRoleInfo)
         {
            pointY += 2;
         }
         if(_arrangePriority)
         {
            pointY += 2;
         }
      }
      
      public function setArrangePriority(param1:Boolean) : void
      {
         _arrangePriority = param1;
         updateDepthInfo();
      }
      
      protected function __die(param1:RoleEvent) : void
      {
         _bufferGoodStateHbox.removeAllChild();
         _bufferBadStateHbox.removeAllChild();
         var _loc2_:* = BattleManager.getInstance().battleUIView;
         if(getRoleIsRightBoss() && _loc2_)
         {
            _loc2_.bufferDispose(info);
         }
      }
      
      public function clearEffectWhenDie() : void
      {
         var _loc1_:BufferLastEffect = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _bufferLastEffects.length)
         {
            _loc1_ = _bufferLastEffects[_loc2_];
            _loc1_.dispose();
            _loc2_++;
         }
         _bufferLastEffects = new Vector.<BufferLastEffect>();
         removeSkillAimFlag();
         removeSkillFlag();
      }
      
      private function __scaleX(param1:RoleEvent) : void
      {
         if(param1.data > 0)
         {
            info.direction = "left";
         }
         else
         {
            info.direction = "right";
         }
      }
      
      protected function createView() : void
      {
         if(battleModel.isHideOtherInBattle(info))
         {
            return;
         }
         TimerUtils.setTimeout(addLoadingView,50);
      }
      
      private function addLoadingView() : void
      {
         if(_disposed)
         {
            return;
         }
         if(!_roleLoaded && _movieContainer)
         {
            _loadingView = ComponentFactory.Instance.creat("asset.battle.RoleLoadingView");
            _movieContainer.addChild(_loadingView);
         }
      }
      
      protected function removeLoadingView() : void
      {
         if(_loadingView && _movieContainer.contains(_loadingView))
         {
            _movieContainer.removeChild(_loadingView);
            _loadingView.stop();
            _loadingView = null;
         }
         _roleLoaded = true;
      }
      
      private function action(param1:String, param2:String = null, param3:String = "Stand", param4:int = 5, param5:Boolean = false) : void
      {
         _info.actionMovie.actionAndPlay(param1,param2,param3,param4,param5);
         if(param1 == "Stand")
         {
            if(_info.face == 2)
            {
               info.direction = "left";
            }
            else
            {
               info.direction = "right";
            }
         }
      }
      
      public function addEffect(param1:BattleEffect, param2:int = 1, param3:int = 1) : void
      {
         if(!SharedManager.instance.allowAttactedEffect)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         if(battleModel.isHideOtherInBattle(info))
         {
            return;
         }
         if(param3 == 1)
         {
            _effectContainer.addEffect(param1,param2);
         }
         else
         {
            _backEffectContainer.addEffect(param1,param2);
         }
      }
      
      public function get effectContainer() : EffectContainer
      {
         return _effectContainer;
      }
      
      public function get loadingState() : int
      {
         return _loadingState;
      }
      
      public function get movieContainer() : Sprite
      {
         return _movieContainer;
      }
      
      public function get backEffectContainer() : EffectContainer
      {
         return _backEffectContainer;
      }
      
      public function get roleInfoView() : MovieClip
      {
         return _roleInfoView;
      }
      
      public function get middleContainer() : Sprite
      {
         return _middleContainer;
      }
      
      public function setRoleInfoViewVisible(param1:Boolean) : void
      {
         _roleInfoViewVisible = param1;
         if(_roleInfoView)
         {
            if(!_info.isLiving)
            {
               if(_info is HeroRoleInfo && HeroRoleInfo(_info).type != 3)
               {
                  setBloodStripVisible(false,true);
               }
               else
               {
                  _roleInfoView.visible = false;
               }
            }
            else
            {
               _roleInfoView.visible = _roleInfoViewVisible;
               if(_bufferContainer)
               {
                  _bufferContainer.visible = _roleInfoViewVisible;
               }
               if(_stripView && _stripView.getView())
               {
                  _stripView.getView().visible = _roleInfoViewVisible;
               }
               if(_roleInfoView.bgMc)
               {
                  _roleInfoView.bgMc.visible = _roleInfoViewVisible;
               }
            }
         }
      }
      
      public function setBloodStripVisible(param1:Boolean, param2:Boolean = false) : void
      {
         if(_multiLordsBuffer)
         {
            _multiLordsBuffer.visible = param1;
         }
         if(!_roleInfoView)
         {
            return;
         }
         if(_info && !_info.canTakeDamage)
         {
            _roleInfoView.visible = false;
            return;
         }
         if(param2)
         {
            _roleInfoView.visible = true;
            if(_bufferContainer)
            {
               _bufferContainer.visible = false;
            }
            if(_stripView && _stripView.getView())
            {
               _stripView.getView().visible = false;
            }
            if(_roleInfoView.strip_pos)
            {
               _roleInfoView.strip_pos.visible = false;
            }
            if(_roleInfoView.bgMc)
            {
               _roleInfoView.bgMc.visible = false;
            }
            return;
         }
         _roleInfoView.visible = param1;
      }
      
      protected function __blood(param1:RoleEvent) : void
      {
         var _loc6_:DamageNumView = null;
         var _loc3_:HeroRoleInfo = null;
         if(!(_info && _info.map))
         {
            return;
         }
         var _loc11_:int = int(param1.data.displayBlood);
         var _loc5_:Boolean = param1.data.havoc as Boolean;
         var _loc8_:int = _loc5_ ? 2 : 1;
         var _loc9_:Boolean = Boolean(param1.data.selfCause);
         var _loc10_:int = int(param1.data.bloodType);
         var _loc2_:Boolean = Boolean(param1.data.isParry);
         var _loc7_:Boolean = Boolean(param1.data.isFire);
         if(_loc11_ == 0 && _loc10_ != 7)
         {
            return;
         }
         if(_loc10_ == 6)
         {
            if(_loc11_ < 0)
            {
               _loc6_ = new DamageNumView(Math.abs(_loc11_),_loc8_,false,_loc9_,_loc2_,_loc7_);
            }
            else if(_loc11_ > 0)
            {
               _loc6_ = new DamageNumView(Math.abs(_loc11_),_loc8_,true,_loc9_,_loc2_);
            }
            _loc3_ = BattleManager.getInstance().battleModel.getWorldBoss();
            if(_loc3_ && this.info == _loc3_)
            {
               BloodHelper.worldBossBloodCached += param1.data.blood;
            }
         }
         else
         {
            if(!(_loc10_ == 8 || _loc10_ == 7))
            {
               if(_loc10_ == 10)
               {
                  if(info is HeroRoleInfo && HeroRoleInfo(info).type == 3 && BattleManager.getInstance().battleModel.battleType == 310 && _stripView is BossBottomStrip)
                  {
                     BossBottomStrip(_stripView).resetView();
                  }
                  updateStrip();
                  return;
               }
               if(_loc10_ == 21)
               {
                  updateStrip();
                  return;
               }
               return;
            }
            _loc6_ = new DamageNumView(0,_loc8_,false,_loc9_,_loc2_);
         }
         if(_loc9_ && !param1.data.isDefault)
         {
            if(_loc5_)
            {
               _info.map.shakeScreen(4,24);
            }
            else
            {
               _info.map.shakeScreen(4,12);
            }
         }
         if(_loc8_ != 1)
         {
            if(_info == BattleManager.getInstance().battleModel.selfHero)
            {
               BattleManager.getInstance().battleScene.playRedScreen();
            }
         }
         var _loc4_:Point = new Point(0,-130);
         _loc4_ = this.localToGlobal(_loc4_);
         _loc4_ = _info.map.effectContainer.globalToLocal(_loc4_);
         _loc6_.x = _loc4_.x;
         _loc6_.y = _loc4_.y;
         if(_loc8_ == 2)
         {
            _loc6_.y = _loc4_.y - 50;
         }
         this._info.map.effectContainer.addChild(_loc6_);
         updateStrip();
      }
      
      private function __bloodChangedSecurity(param1:RoleEvent) : void
      {
         updateStrip();
      }
      
      protected function updateStrip() : void
      {
         if(_stripView)
         {
            if(_info is HeroRoleInfo && HeroRoleInfo(_info).type == 3 && _info.face == 2 && battleModel.battleType == 17 && BaseManager.instance.wordBossInvincibleState)
            {
               _stripView.maxValue = _info.totalBloodA;
               _stripView.currentValue = _info.totalBloodA;
               return;
            }
            _stripView.maxValue = _info.totalBloodA;
            _stripView.currentValue = _info.bloodA;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         ObjectUtils.disposeObject(_fateSkillEffect);
         _fateSkillEffect = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(fateSkillComplete);
         NotificationManager.instance.removeEventListener("battleUILoaded",onBattleUILoaded);
         removeSkillFlag();
         if(parent)
         {
            parent.removeChild(this);
         }
         _disposed = true;
         removeEvent();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         for each(var _loc1_:BufferLastEffect in _bufferLastEffects)
         {
            _loc1_.dispose();
         }
         _bufferLastEffects = null;
         if(_heroNameTxt)
         {
            _heroNameTxt.dispose();
         }
         _heroNameTxt = null;
         if(_heroServiceTxt)
         {
            _heroServiceTxt.dispose();
         }
         _heroServiceTxt = null;
         ObjectUtils.disposeViolentMc(_roleInfoView);
         if(_roleInfoView)
         {
            _roleInfoView.stop();
         }
         _roleInfoView = null;
         ObjectUtils.disposeViolentMc(_stripView as Sprite);
         _stripView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_bufferContainer)
         {
            _bufferContainer.dispose();
         }
         _backEffectContainer = null;
         ObjectUtils.disposeAllChildren(_movieContainer);
         _movieContainer = null;
         ObjectUtils.disposeAllChildren(_middleContainer);
         _middleContainer = null;
         ObjectUtils.disposeViolentMc(_loadingView);
         _loadingView = null;
         ObjectUtils.disposeAllChildren(_nameContainer);
         _nameContainer = null;
         ObjectUtils.disposeObject(_bufferGoodImage);
         _bufferGoodImage = null;
         ObjectUtils.disposeObject(_bufferBadImage);
         _bufferBadImage = null;
         ObjectUtils.disposeObject(_bufferGoodText);
         _bufferGoodText = null;
         ObjectUtils.disposeObject(_bufferBadText);
         _bufferBadText = null;
         ObjectUtils.disposeObject(_bufferGoodStateHbox);
         _bufferGoodStateHbox = null;
         ObjectUtils.disposeObject(_bufferBadStateHbox);
         _bufferBadStateHbox = null;
         ObjectUtils.disposeViolentMc(_bufferResistMc);
         _bufferResistMc = null;
         _effectContainer = null;
         _bufferContainer = null;
         ObjectUtils.disposeViolentMc(_multiLordsBuffer);
         _multiLordsBuffer = null;
         _multiLordsBufferInfo = null;
         _info.dispose();
         _info = null;
      }
      
      protected function __directionChange(param1:RoleEvent) : void
      {
         if(param1.data == "left")
         {
            setRoleAllContainerScaleX(-1);
         }
         else
         {
            setRoleAllContainerScaleX(1);
         }
      }
      
      public function get isLockInfoView() : Boolean
      {
         return _isLockInfoView;
      }
      
      public function set isLockInfoView(param1:Boolean) : void
      {
         _isLockInfoView = param1;
      }
      
      public function get body() : Sprite
      {
         return _body;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         if(_isLockInfoView && _roleInfoView)
         {
            _roleInfoView.x -= param1 - _x;
         }
         _x = param1;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         if(_isLockInfoView && _roleInfoView)
         {
            _roleInfoView.y -= param1 - _y;
         }
         _y = param1;
      }
      
      public function addCollectionEffect(param1:Boolean = true) : void
      {
         if(_disposed)
         {
            return;
         }
         if(_collectionEffect)
         {
            _collectionEffect.dispose();
            _collectionEffect = null;
            _info.removeActionByType("Ready");
         }
         if(param1)
         {
            _collectionEffect = new CollectionEffect(backEffectContainer,_effectContainer,HeroRoleInfo(_info).heroInfo.templateInfo.Job);
         }
         new ReadyAction(_info);
      }
      
      public function removeCollectionEffect() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_collectionEffect)
         {
            _collectionEffect.dispose();
            _collectionEffect = null;
         }
         _info.removeActionByType("Ready");
      }
      
      public function updateQteCollectionEffect() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_collectionEffect)
         {
            _collectionEffect.updateToQteState();
         }
      }
      
      public function setColorTransform(param1:int = 0) : void
      {
         if(_disposed)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               _movieContainer.transform.colorTransform = new ColorTransform();
               break;
            case 1:
               _movieContainer.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,55);
               break;
            case 2:
               _movieContainer.transform.colorTransform = new ColorTransform(1,1,1,1,55);
         }
      }
      
      public function addSkillFlag(param1:SkillTempInfo) : void
      {
         _readySkillTemp = param1;
         if(param1)
         {
            if(param1.Icons != null && param1.Icons.length > 0)
            {
               addSkillFlagByIconPath(IconFactory.getTecIconByIcon(param1.Icons));
            }
         }
      }
      
      public function addSkillFlagByIconPath(param1:String) : void
      {
         var _loc3_:Point = null;
         if(_disposed)
         {
            return;
         }
         var _loc2_:int = -175;
         if(info)
         {
            _loc3_ = info.getSpecialPos(1);
            if(_loc3_ && _loc3_.y != 0)
            {
               _loc2_ = _loc3_.y - 33;
            }
         }
         ObjectUtils.disposeObject(_skillItemUseCell);
         _skillItemUseCell = null;
         _skillItemUseCell = new SkillUseItemCell();
         _skillItemUseCell.hideBorder();
         _skillItemUseCell.data = param1;
         _skillItemUseCell.flash();
         _skillItemUseCell.y = _loc2_;
         _skillItemUseCell.x = -20;
         _effectContainer.addChild(_skillItemUseCell);
      }
      
      public function removeSkillFlag() : void
      {
         _readySkillTemp = null;
         if(_disposed)
         {
            return;
         }
         if(_qteSuccessAnimation)
         {
            _qteSuccessAnimation.dispose();
            _qteSuccessAnimation = null;
         }
         if(_skillItemUseCell && _skillItemUseCell.parent)
         {
            _skillItemUseCell.dispose();
            _skillItemUseCell = null;
         }
      }
      
      public function cancelReadyState() : Boolean
      {
         removeCollectionEffect();
         removeSkillFlag();
         if(info.actionMovie.currentLabels == "Ready")
         {
            info.action("Stand");
            return true;
         }
         return false;
      }
      
      public function showQteSuccessEffect(param1:Point, param2:Point) : void
      {
         if(_disposed)
         {
            return;
         }
         if(_qteSuccessAnimation)
         {
            _qteSuccessAnimation.dispose();
            _qteSuccessAnimation = null;
         }
         var _loc3_:Sprite = _effectContainer;
         _qteSuccessAnimation = new QteSuccessAnimation(_loc3_,param1,param2);
         _qteSuccessAnimation.play();
      }
      
      public function addSkillAimFlag() : void
      {
         var _loc1_:String = null;
         if(_disposed)
         {
            return;
         }
         if(_skillAimMc)
         {
            if(_skillAimMc.parent)
            {
               _skillAimMc.parent.removeChild(_skillAimMc);
            }
         }
         if(_info.face == 1)
         {
            _loc1_ = "asset.battle.SkillUsedSelectedAsset1";
         }
         else
         {
            _loc1_ = "asset.battle.SkillUsedSelectedAsset2";
         }
         _skillAimMc = ComponentFactory.Instance.creat(_loc1_);
         _backEffectContainer.addChild(_skillAimMc);
      }
      
      public function updateShadowPos() : void
      {
      }
      
      public function removeBuffer(param1:int) : void
      {
         if(_disposed)
         {
            return;
         }
         info.removeBufferById(param1);
         removeLastEffect(param1);
      }
      
      public function removeSkillAimFlag() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_skillAimMc && _skillAimMc.parent)
         {
            _backEffectContainer.removeChild(_skillAimMc);
         }
         _skillAimMc = null;
      }
      
      protected function initShadeScale(param1:Number = 0) : void
      {
         var _loc2_:Number = NaN;
         _shadeW = param1;
         if(param1 != 0 && _shade)
         {
            _loc2_ = param1 / _shade.width * 1.5;
            _shade.width *= _loc2_;
            _shade.height *= _loc2_;
         }
      }
      
      public function get stripView() : IHpStrip
      {
         return _stripView;
      }
      
      protected function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

