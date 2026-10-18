package monsterexplore.view
{
   import battle.utils.DelayCalling;
   import battle.utils.Helpers;
   import battle.view.ui.IHpStrip;
   import battle.view.ui.StripUIView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.FrameLabel;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import mvc.controler.MonsterControler;
   import mvc.controler.PetChallengeController;
   import mvc.module.monsterexplore.MonsterExploreBattleInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import utils.LogicUtils;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   import yishi.utils.StringHelper;
   
   public class MonsterExploreBattleAvatarView extends Component
   {
      
      public static const STOP:String = "STOP";
      
      public static const REPEAT:String = "REPEAT";
      
      public static const GOTO:String = "GOTO";
      
      public static const WAIT_AND_GOTO:String = "WAIT_AND_GOTO";
      
      private var _currentType:String;
      
      private var _labels:Array;
      
      private var _labesDic:Dictionary;
      
      private var _data:MonsterExploreBattleInfo;
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _stripView:IHpStrip;
      
      private var _booldBack:MovieClip;
      
      private var _hpUpdateMc:MovieClip;
      
      private var _hpText:FilterFrameText;
      
      private var _delayCall:DelayCalling;
      
      private var _expUpdateMc:MovieClip;
      
      private var _expText:FilterFrameText;
      
      private var _rebornMc:MovieClip;
      
      private var _levelUpMc:MovieClip;
      
      private var prePath:String;
      
      private var swfPath:String;
      
      public var side:int;
      
      public var index:int;
      
      private var preTempId:int;
      
      private var preHp:int;
      
      public function MonsterExploreBattleAvatarView(param1:int, param2:int)
      {
         super();
         side = param1;
         index = param2;
         initView();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationItemView.nameTxt");
         _hpText = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationItemView.hpText");
         _hpUpdateMc = ComponentFactory.Instance.creatCustomObject("MonsterExploreBattleAvatarView.BloodUpdateAsset");
         _expText = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.expText");
         _expUpdateMc = ComponentFactory.Instance.creatCustomObject("MonsterExploreBattleAvatarView.expUpdateAsset");
         _rebornMc = ComponentFactory.Instance.creatCustomObject("MonsterExploreBattleAvatarView.rebornMc");
         _levelUpMc = ComponentFactory.Instance.creatCustomObject("MonsterExploreBattleAvatarView.levelUpMc");
         _expUpdateMc.container.addChild(_expText);
         _expUpdateMc.stop();
         _hpUpdateMc.container.addChild(_hpText);
         _hpUpdateMc.stop();
         _rebornMc.stop();
         _rebornMc.visible = false;
         _levelUpMc.stop();
         _levelUpMc.visible = false;
      }
      
      private function initMovie() : void
      {
         var _loc1_:FrameLabel = null;
         var _loc2_:int = 0;
         _labesDic = new Dictionary();
         if(!_body)
         {
            return;
         }
         _labels = _body.currentLabels;
         _loc2_ = 0;
         while(_loc2_ < _labels.length)
         {
            if(_loc2_ != 0)
            {
               _loc1_ = _labels[_loc2_ - 1] as FrameLabel;
               _labesDic[_loc1_.name] = int(_labels[_loc2_].frame) - _loc1_.frame;
            }
            _loc2_++;
         }
         _loc1_ = _labels[_labels.length - 1] as FrameLabel;
         if(_loc1_)
         {
            _labesDic[_loc1_.name] = _body.totalFrames + 1 - _loc1_.frame;
         }
         _loc1_ = null;
         _body.mouseChildren = _body.mouseEnabled = false;
      }
      
      public function actionAndPlay(param1:String, param2:String = null, param3:String = null, param4:int = 5, param5:Boolean = false) : void
      {
         var type:String = param1;
         var repeatType:String = param2;
         var nextType:String = param3;
         var waitFrame:int = param4;
         var isStop:Boolean = param5;
         if(_labesDic == null || !_body || _body.currentLabels.length <= 0 || Boolean(StringHelper.isNullOrEmpty(type)))
         {
            return;
         }
         if(_currentType && _currentType != type)
         {
            _body.addFrameScript(getTagFinalFrame(_currentType) - 1,function():void
            {
            });
         }
         _currentType = type;
         _delayCall && _delayCall.cancel();
         repeatType = repeatType || getDefaultRepeatType(type);
         nextType = nextType || "Stand";
         _body.gotoAndPlay(type);
         switch(repeatType)
         {
            case "STOP":
               if(_labesDic[type] <= 1)
               {
                  _body.gotoAndStop(type);
               }
               else
               {
                  Helpers.addOneTimeScript(_body,getTagFinalFrame(type) - 1,function():void
                  {
                     if(_body)
                     {
                        _body.stop();
                     }
                  });
               }
               break;
            case "WAIT_AND_GOTO":
               Helpers.addOneTimeScript(_body,getTagFinalFrame(type) - 1,function():void
               {
                  if(!_body)
                  {
                     return;
                  }
                  _body.stop();
                  if(_currentType.indexOf("Attack") != -1)
                  {
                     attackOverUpdate();
                  }
                  _delayCall = Helpers.delayCall(function():void
                  {
                     if(data.hp > 0)
                     {
                        actionAndPlay(nextType);
                     }
                  },waitFrame);
               });
               break;
            case "GOTO":
               Helpers.addOneTimeScript(_body,getTagFinalFrame(type) - 1,function():void
               {
                  actionAndPlay(nextType);
               });
               break;
            case "REPEAT":
               if(isStop)
               {
                  if(_body)
                  {
                     _body.gotoAndStop(type);
                  }
               }
               else
               {
                  _body.addFrameScript(getTagFinalFrame(type) - 1,function():void
                  {
                     actionAndPlay(type,"REPEAT");
                  });
               }
         }
      }
      
      private function getDefaultRepeatType(param1:String) : String
      {
         switch(param1)
         {
            case "Stand":
            case "Walk":
            case "Ready":
               break;
            case "Failed":
            case "Die":
               return "STOP";
            case "Victory":
               return "WAIT_AND_GOTO";
            default:
               return "WAIT_AND_GOTO";
         }
         return "REPEAT";
      }
      
      private function attackOverUpdate() : void
      {
         if(!_body)
         {
            return;
         }
         if(data.hp == 0 && _currentType.indexOf("Attack") != -1)
         {
            _body.addFrameScript(getTagFinalFrame("Die") - 1,function():void
            {
               AttackOverUpateHp();
               _body.stop();
            });
            _body.gotoAndPlay("Die");
         }
         else
         {
            AttackOverUpateHp();
         }
      }
      
      private function AttackOverUpateHp() : void
      {
         var hpChange:int;
         var hpStr:String = "";
         var i:int = 0;
         while(i < data.damages.length)
         {
            hpChange = int(data.damages[i]);
            hpStr += "-" + hpChange + " HP" + "\n";
            i = i + 1;
         }
         _hpText.htmlText = hpStr;
         data.damages = [];
         if(!StringHelper.isNullOrEmpty(hpStr))
         {
            _hpUpdateMc.addFrameScript(_hpUpdateMc.totalFrames - 1,function():void
            {
               _hpText.text = "";
               _hpUpdateMc.stop();
               updateHpStrip();
            });
            _hpUpdateMc.gotoAndPlay(1);
         }
         else
         {
            updateHpStrip();
         }
      }
      
      private function getTagFinalFrame(param1:String) : int
      {
         var _loc3_:FrameLabel = null;
         for each(var _loc4_:FrameLabel in _labels)
         {
            if(_loc4_.name == param1)
            {
               _loc3_ = _loc4_;
            }
         }
         var _loc2_:int = int(_labesDic[param1]);
         if(_loc3_)
         {
            return _loc3_.frame + _loc2_ - 1;
         }
         return _loc2_;
      }
      
      public function getLabelFrameNum(param1:String) : int
      {
         return int(_labesDic[param1]);
      }
      
      public function get data() : MonsterExploreBattleInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterExploreBattleInfo) : void
      {
         _data = param1;
         if(_data && data.tempInfo)
         {
            _nameTxt.text = param1.name;
            _nameTxt.x = -_nameTxt.textWidth / 2;
            if(data.tempInfo is MonsterTempInfo)
            {
               swfPath = PathManager.solveRolePath((data.tempInfo as MonsterTempInfo).ResPath);
            }
            else if(data.tempInfo is PawnTemplate)
            {
               swfPath = PathManager.solveRolePath((data.tempInfo as PawnTemplate).Swf);
            }
            if(prePath != swfPath)
            {
               refreshAvatar(swfPath);
            }
            prePath = swfPath;
            refreshHpView();
            preHp = data.hp;
            preTempId = data.templateId;
         }
         else
         {
            clean();
         }
      }
      
      private function refreshAvatar(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         clearBody();
         if(data.tempInfo is MonsterTempInfo && monsterControl.monsterDefineDic[param1])
         {
            createBody();
         }
         else if(data.tempInfo is PawnTemplate && petchallengeController.armyPawnDefineDic[data.templateId])
         {
            createBody();
         }
         else
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyScale();
            LoaderManagerII.instance.load(param1,1,8,__loadedCompleteHandler);
         }
         if(_body)
         {
            addChild(_body);
            addChild(_nameTxt);
            addChild(_hpUpdateMc);
            if(data && data.isMonster)
            {
               addChild(_expUpdateMc);
               addChild(_rebornMc);
               addChild(_levelUpMc);
            }
            if(side == 2)
            {
               _body.scaleX = -1;
            }
            _loc2_ = _body["pos_head"] as MovieClip;
            if(_loc2_)
            {
               _hpUpdateMc.y = _loc2_.y;
               _expUpdateMc.y = _loc2_.y;
            }
         }
      }
      
      public function refreshExpView(param1:int) : void
      {
         var expValue:int = param1;
         _expText.htmlText = "+" + expValue + " EXP";
         _expUpdateMc.addFrameScript(_expUpdateMc.totalFrames - 1,function():void
         {
            _expUpdateMc.stop();
            _expText.text = "";
         });
         _expUpdateMc.gotoAndPlay(1);
      }
      
      private function refreshHpView() : void
      {
         var _loc1_:MovieClip = null;
         if(!_booldBack)
         {
            _booldBack = ComponentFactory.Instance.creatCustomObject("asset.MonsterExploreBattleAvatarView.bloodAsset");
            _loc1_ = ComponentFactory.Instance.creat("asset.MonsterExploreBattleAvatarView.BottomHpStripAsset");
            _stripView = new StripUIView(_loc1_,data.maxHp,data.hp,16275472);
            _loc1_ = null;
            addChild(_booldBack);
            _booldBack.strip_pos.visible = false;
            _booldBack.addChild(_stripView.getView());
         }
         if(exploreModel.exploreState != 2)
         {
            _hpText.text = "";
            _hpUpdateMc.stop();
            updateHpStrip();
            stateMcCheck();
         }
         else if(data.hp < 0)
         {
            this.visible = false;
         }
      }
      
      private function stateMcCheck() : void
      {
         if(checkReborn())
         {
            _rebornMc.addFrameScript(_rebornMc.totalFrames - 1,function():void
            {
               _rebornMc.stop();
               _rebornMc.visible = false;
            });
            _rebornMc.visible = true;
            _rebornMc.gotoAndPlay(1);
         }
         if(checkLevelUp())
         {
            _levelUpMc.addFrameScript(_levelUpMc.totalFrames - 1,function():void
            {
               _levelUpMc.stop();
               _levelUpMc.visible = false;
            });
            _levelUpMc.visible = true;
            _levelUpMc.gotoAndPlay(1);
         }
      }
      
      private function updateHpStrip() : void
      {
         if(_stripView)
         {
            _stripView.maxValue = data.maxHp;
            _stripView.currentValue = data.hp > 0 ? data.hp : 0;
         }
         this.visible = data.hp <= 0 ? false : true;
      }
      
      private function checkReborn() : Boolean
      {
         if(exploreModel.exploreState == 0 && Boolean(data.isMonster))
         {
            if(exploreModel.nodeSwitchMcState)
            {
               return true;
            }
            if(preTempId == data.templateId && preHp > 0)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function checkLevelUp() : Boolean
      {
         if(exploreModel.exploreState == 3 && Boolean(data.isMonster) && data.hp > 0)
         {
            if(exploreModel.levelIdAry.indexOf(index) != -1)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function __loadedCompleteHandler(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         var _loc5_:Class = null;
         var _loc3_:ApplicationDomain = null;
         var _loc4_:LoaderContext = null;
         clearBody();
         if(isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         if(data.tempInfo is MonsterTempInfo)
         {
            _loc5_ = monsterControl.monsterDefineDic[swfPath] as Class;
         }
         else if(data.tempInfo is PawnTemplate)
         {
            _loc5_ = petchallengeController.armyPawnDefineDic[data.templateId] as Class;
         }
         if(!_loc5_)
         {
            if(param2)
            {
               _loc3_ = new ApplicationDomain(ApplicationDomain.currentDomain);
               _loc4_ = new LoaderContext(false,_loc3_);
               disposeLoader();
               _loader = new Loader();
               _loader.contentLoaderInfo.addEventListener("complete",__contentComplete);
               _loader.loadBytes(param2 as ByteArray,_loc4_);
            }
         }
         else
         {
            createBody();
         }
      }
      
      private function __contentComplete(param1:Event) : void
      {
         var _loc3_:Class = null;
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__contentComplete);
         if(data.tempInfo is MonsterTempInfo)
         {
            _loc3_ = monsterControl.monsterDefineDic[swfPath] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset" + (data.tempInfo as MonsterTempInfo).ResPath))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("slg.resource.movie.MovieAsset" + (data.tempInfo as MonsterTempInfo).ResPath) as Class;
               monsterControl.monsterDefineDic[swfPath] = _loc3_;
            }
         }
         else if(data.tempInfo is PawnTemplate)
         {
            _loc3_ = petchallengeController.armyPawnDefineDic[data.templateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset" + (data.tempInfo as PawnTemplate).Swf))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("slg.resource.movie.MovieAsset" + (data.tempInfo as PawnTemplate).Swf) as Class;
               petchallengeController.armyPawnDefineDic[data.templateId] = _loc3_;
            }
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function createBody() : void
      {
         var _loc2_:Class = null;
         var _loc1_:MovieClip = null;
         if(!data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         clearBody();
         if(data.tempInfo is MonsterTempInfo)
         {
            _loc2_ = monsterControl.monsterDefineDic[swfPath] as Class;
         }
         else if(data.tempInfo is PawnTemplate)
         {
            _loc2_ = petchallengeController.armyPawnDefineDic[data.templateId] as Class;
         }
         if(_loc2_)
         {
            _body = new _loc2_();
            _body.soundTransform = SharedManager.instance.getSkillSoundTransform();
            setBodyScale();
            addChild(_body);
            addChild(_nameTxt);
            addChild(_hpUpdateMc);
            if(data && data.isMonster)
            {
               addChild(_expUpdateMc);
               addChild(_rebornMc);
               addChild(_levelUpMc);
            }
            _loc1_ = _body["pos_head"] as MovieClip;
            if(_loc1_)
            {
               _hpUpdateMc.y = _loc1_.y;
               _expUpdateMc.y = _loc1_.y;
            }
            if(side == 2)
            {
               _body.scaleX = -1;
            }
            initMovie();
         }
      }
      
      public function setBodyScale(param1:Number = 1) : void
      {
         if(!_body)
         {
            return;
         }
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = param1;
      }
      
      public function getPosLeg() : Point
      {
         var _loc1_:MovieClip = null;
         if(_body && _body["pos_leg"])
         {
            _loc1_ = _body["pos_leg"] as MovieClip;
            return new Point(_loc1_.x,_loc1_.y);
         }
         return new Point(0,0);
      }
      
      private function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeObject(_body);
         _body = null;
         if(_booldBack)
         {
            ObjectUtils.disposeViolentMc(_booldBack);
         }
         _booldBack = null;
         ObjectUtils.disposeViolentMc(_stripView as Sprite);
         _stripView = null;
         _nameTxt.text = "";
         prePath = "";
         preHp = 0;
         preTempId = 0;
      }
      
      private function disposeLoader() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__contentComplete);
            _loader.unloadAndStop(false);
            _loader = null;
         }
      }
      
      private function clearBody() : void
      {
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      private function get monsterControl() : MonsterControler
      {
         return FrameControllerManager.instance.monsterController;
      }
      
      private function get petchallengeController() : PetChallengeController
      {
         return FrameControllerManager.instance.petchallengeController;
      }
      
      override public function dispose() : void
      {
         disposeLoader();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeViolentMc(_booldBack);
         _booldBack = null;
         ObjectUtils.disposeViolentMc(_hpUpdateMc);
         _hpUpdateMc = null;
         ObjectUtils.disposeViolentMc(_stripView as Sprite);
         _stripView = null;
         ObjectUtils.disposeObject(_hpText);
         _hpText = null;
         ObjectUtils.disposeViolentMc(_expUpdateMc);
         _expUpdateMc = null;
         ObjectUtils.disposeViolentMc(_levelUpMc);
         _levelUpMc = null;
         ObjectUtils.disposeViolentMc(_rebornMc);
         _rebornMc = null;
         ObjectUtils.disposeObject(_expText);
         _expText = null;
         if(_delayCall)
         {
            _delayCall.cancel();
         }
         LogicUtils.disposeDisplayCollection(_labesDic);
         _labesDic = null;
         LogicUtils.disposeDisplayCollection(_labels);
         _labels = null;
         super.dispose();
      }
   }
}

