package fish.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import events.FishEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishForkInfo;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishSigInfo;
   import mvc.module.fish.FishSigModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class FishView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _fishBagBtn:BaseButton;
      
      private var _fishList:Vector.<FishSigleView>;
      
      private var _catchFishMc:MovieClip;
      
      private var _mask:Sprite;
      
      private var flag:Boolean = true;
      
      private var _forkMCs:Vector.<MovieClip>;
      
      private var _forkType:int;
      
      private var catchFishList:Array = [];
      
      private var isSetFire:Boolean = true;
      
      private var _catch:Array;
      
      private var _border:Array;
      
      private var index:int;
      
      private var forkX:Number;
      
      private var forkY:Number;
      
      private var rageSuccessFlag:Boolean = true;
      
      private var _tempIdArr:Array = [];
      
      private var _tempId:int;
      
      private var _animeCount:int = 0;
      
      public function FishView()
      {
         super();
         initView();
         addEvent();
         __updateFishPoolHandler(null);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.fish.FishViewBg");
         _fishBagBtn = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.fishBagBtn");
         _catchFishMc = ComponentFactory.Instance.creatCustomObject("fish.FishView.catchFishMc");
         _fishBagBtn.tipData = LanguageMgr.GetTranslation("fish.FishFrame.bagBtn");
         addChild(_bg);
         if(!model.isSelf)
         {
         }
         addChild(_catchFishMc);
         _fishList = new Vector.<FishSigleView>();
         _forkMCs = new Vector.<MovieClip>();
         initCatchFishMc();
         initMask();
         setInit();
         _forkType = model.fishForkInfo.type;
      }
      
      private function initCatchFishMc() : void
      {
         _catchFishMc["small1"].gotoAndStop(1);
         _catchFishMc["small2"].gotoAndStop(1);
         gaff.gotoAndStop(1);
         fork(gaff).gotoAndStop(1);
         gaffLeft.gotoAndStop(1);
         gaffRight.gotoAndStop(1);
         fork(gaffLeft).gotoAndStop(1);
         fork(gaffRight).gotoAndStop(1);
         gaffLeft.visible = false;
         gaffRight.visible = false;
         _forkMCs.push(gaff);
         _forkMCs.push(gaffLeft);
         _forkMCs.push(gaffRight);
      }
      
      private function initMask() : void
      {
         _mask = new Sprite();
         _mask.graphics.beginFill(0);
         _mask.graphics.drawRect(6,-90,820,450);
         _mask.graphics.endFill();
         addChild(_mask);
         this.mask = _mask;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_FISH_INFO",__updateFishInfoHandler);
         NotificationManager.instance.addEventListener("UPDATE_FISH_FORK",__updateFishFORKHandler);
         model.addEventListener("UPDATE_FISH_POOL",__updateFishPoolHandler);
         _fishBagBtn.addEventListener("click",__fishBagHandler);
      }
      
      private function __fishBagHandler(param1:MouseEvent) : void
      {
         var _loc2_:FishBagFrame = ComponentFactory.Instance.creatComponentByStylename("fish.FishBagFrame");
         _loc2_.show();
      }
      
      private function creatFishList() : void
      {
         var _loc2_:FishSigleView = null;
         for each(var _loc1_:FishSigModel in model.fishSigsModel)
         {
            _loc2_ = ObjectPool.getObject(FishSigleView) as FishSigleView;
            _loc1_.fishSigInfo.fish = _loc2_;
            _loc1_.addEventListener("FISH_SIG",__fishSigHandler);
            _fishList.push(_loc2_);
            addChild(_loc2_);
         }
      }
      
      private function disposeFishList() : void
      {
         var _loc2_:FishSigleView = null;
         for each(var _loc1_:FishSigModel in model.fishSigsModel)
         {
            _loc2_ = _loc1_.fishSigInfo.fish;
            _loc1_.fishSigInfo.fish = null;
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
      }
      
      protected function __fishSigHandler(param1:FishEvent) : void
      {
         var _loc2_:FishSigInfo = null;
         var _loc3_:FishSigModel = param1.target as FishSigModel;
         if(index == 0)
         {
            _loc2_ = _loc3_.catchFishSigInfo;
            if(_loc2_)
            {
               if(isPowerFork)
               {
                  if(!isExist(_loc2_.channelId))
                  {
                     addFishSigInfo(_loc2_);
                  }
               }
               else
               {
                  addFishSigInfo(_loc2_);
               }
               setSpeedState(_loc2_);
            }
         }
      }
      
      private function isBlock(param1:FishSigInfo) : Boolean
      {
         return param1.fishTempInfo.IsBlock == 1;
      }
      
      private function addFishSigInfo(param1:FishSigInfo) : void
      {
         var _loc2_:Array = null;
         catchFishList.push(param1);
         if(!isBlock(param1) && param1.channelId != 1)
         {
            param1.catchState = 1;
            if(param1.fishState != 3)
            {
               _loc2_ = [];
               _loc2_.push(2);
               _loc2_.push(param1.fishId);
               FishManager.instance.fishAction(11,_loc2_);
            }
         }
      }
      
      private function isExist(param1:int) : Boolean
      {
         for each(var _loc2_:FishSigInfo in catchFishList)
         {
            if(!isBlock(_loc2_))
            {
               if(_loc2_.channelId == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function get gaff() : MovieClip
      {
         return _catchFishMc["gaff"];
      }
      
      private function get gaffLeft() : MovieClip
      {
         return _catchFishMc["gaff1"];
      }
      
      private function get gaffRight() : MovieClip
      {
         return _catchFishMc["gaff2"];
      }
      
      private function fork(param1:MovieClip) : MovieClip
      {
         return param1["fork"];
      }
      
      private function isPlayOver(param1:MovieClip) : Boolean
      {
         return param1.currentFrame == param1.totalFrames;
      }
      
      private function setFireState(param1:FishSigInfo) : void
      {
         param1.fish.fishMc.gotoAndPlay("fire");
      }
      
      private function setSpeedState(param1:FishSigInfo) : void
      {
         param1.fish.fishMc.gotoAndPlay("speed");
      }
      
      private function setNormalState(param1:FishSigInfo) : void
      {
         param1.fish.fishMc.gotoAndPlay("normal");
      }
      
      private function get isThreeFork() : Boolean
      {
         return model.fishForkInfo.type == 1;
      }
      
      private function get isPowerFork() : Boolean
      {
         return model.fishForkInfo.type == 2;
      }
      
      private function __updateFishFORKHandler(param1:NotificationEvent) : void
      {
         var _loc2_:FishSigInfo = null;
         if(model.isForkState(0))
         {
            if(_catchFishMc)
            {
               gaff.rotation = model.fishForkInfo.rotation;
               if(isThreeFork)
               {
                  gaffLeft.rotation = model.leftForkInfo.rotation;
                  gaffRight.rotation = model.rightForkInfo.rotation;
               }
            }
         }
         else if(!model.isSelf)
         {
            if(model.isForkState(3) && isSetFire)
            {
               if(_catchFishMc)
               {
                  gaff.rotation = model.fishForkInfo.rotation;
                  gaff.gotoAndStop(model.fishForkInfo.frame);
               }
               for each(var _loc3_:FishSigModel in model.fishSigsModel)
               {
                  _loc2_ = _loc3_.fishSigInfo;
                  if(_loc2_.catchState == 3)
                  {
                     if(_loc2_.fish && _loc2_.fish.fishMc)
                     {
                        setFireState(_loc2_);
                        isSetFire = false;
                        break;
                     }
                  }
               }
            }
         }
      }
      
      private function __updateFishPoolHandler(param1:FishEvent) : void
      {
         if(_catchFishMc)
         {
            if(isThreeFork)
            {
               gaffLeft.visible = true;
               gaffRight.visible = true;
               model.threeOver = false;
               model.powerOver = true;
            }
            else
            {
               if(isPowerFork)
               {
                  model.powerOver = false;
               }
               else
               {
                  model.powerOver = true;
               }
               gaffLeft.visible = false;
               gaffRight.visible = false;
               model.threeOver = true;
            }
            for each(var _loc2_:MovieClip in _forkMCs)
            {
               fork(_loc2_).gotoAndStop(model.fishForkInfo.type + 1);
            }
         }
      }
      
      private function __updateFishInfoHandler(param1:NotificationEvent) : void
      {
         if(_fishList.length == 0)
         {
            creatFishList();
         }
         for each(var _loc2_:FishSigModel in model.fishSigsModel)
         {
            _loc2_.updateFish();
         }
      }
      
      private function startCatch() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = null;
         model.setAllForkState(1);
         playCatchFishMc();
         _loc2_ = 0;
         while(_loc2_ < _forkMCs.length)
         {
            _loc1_ = _forkMCs[_loc2_];
            if(_loc1_.visible)
            {
               _loc1_.rotation = model.fishForkList[_loc2_].rotation;
               _loc1_.gotoAndPlay(1);
               _loc1_.addEventListener("enterFrame",__enterFrameHanlder);
            }
            _loc2_++;
         }
      }
      
      private function playCatchFishMc() : void
      {
         _catchFishMc.gotoAndPlay("fish");
         _catchFishMc["small1"].gotoAndPlay(1);
         _catchFishMc["small2"].gotoAndPlay(1);
      }
      
      private function stopCatchFishMc() : void
      {
         _catchFishMc.gotoAndPlay(1);
         _catchFishMc["small1"].gotoAndStop(1);
         _catchFishMc["small2"].gotoAndStop(1);
      }
      
      private function catchBack(param1:int) : void
      {
         var _loc2_:int = _forkMCs[param1].currentFrame;
         _forkMCs[param1].gotoAndPlay(200 - _loc2_);
         model.setForkState(param1,2);
      }
      
      public function clickView() : void
      {
         if(!model.isSelf)
         {
            return;
         }
         if(flag)
         {
            flag = false;
            startCatch();
         }
      }
      
      public function helpOver() : void
      {
         catchBack(0);
         playCatchFishMc();
         gaff.rotation = model.fishForkInfo.rotation;
         gaff.addEventListener("enterFrame",__helpOverFrameHanlder);
      }
      
      private function __helpOverFrameHanlder(param1:Event) : void
      {
         if(isPlayOver(gaff))
         {
            model.helpSuccess = false;
            model.helpOver();
         }
      }
      
      public function rageFish() : void
      {
         var _loc1_:FishSigInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         if(catchFishList.length == 1 && model.fishForkInfo.type == 0)
         {
            _loc1_ = catchFishList[0] as FishSigInfo;
            if(_loc1_.fishState == 3)
            {
               _loc3_ = int(model.fishForkInfo.rotation);
               model.fishForkInfo.frame = gaff.currentFrame;
               _loc2_ = [];
               _loc2_.push(1);
               _loc2_.push(_loc1_.fishId);
               _loc2_.push(_loc3_);
               _loc2_.push(gaff.currentFrame);
               FishManager.instance.fishAction(11,_loc2_);
               _loc1_.catchState = 3;
               gaff.stop();
               model.setAllForkState(3);
               setFireState(_loc1_);
               dispatchEvent(new FishEvent("FISH_RAGE"));
               model.rage = true;
            }
            else
            {
               model.rage = false;
            }
         }
      }
      
      private function forkInfo(param1:Event) : int
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case gaff:
               _loc2_ = 0;
               break;
            case gaffLeft:
               _loc2_ = 1;
               break;
            case gaffRight:
               _loc2_ = 2;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function setInit() : void
      {
         var _loc1_:int = 0;
         _catch = [];
         _border = [];
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _catch.push(true);
            _border.push(true);
            _loc1_++;
         }
      }
      
      private function get isHaveBlock() : Boolean
      {
         for each(var _loc1_:FishSigInfo in catchFishList)
         {
            if(isBlock(_loc1_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function isTouchBorder() : void
      {
         if(forkX <= -10 || forkX >= 840 || forkY >= 370)
         {
            if(_border[index])
            {
               catchBack(index);
               _border[index] = false;
               if(isPowerFork)
               {
                  model.powerOver = true;
               }
            }
         }
      }
      
      private function __enterFrameHanlder(param1:Event) : void
      {
         var _loc2_:FishSigInfo = null;
         var _loc3_:Array = null;
         var _loc5_:MovieClip = param1.currentTarget as MovieClip;
         index = forkInfo(param1);
         var _loc6_:FishForkInfo = model.fishForkList[index];
         forkX = _loc6_.x;
         forkY = _loc6_.y;
         if(catchFishList.length == 0 || !model.threeOver || !model.powerOver)
         {
            if(_loc6_.isCatch)
            {
               if(_border[index])
               {
                  catchBack(index);
                  _border[index] = false;
               }
            }
            else if(isPowerFork)
            {
               if(isHaveBlock)
               {
                  if(_border[index])
                  {
                     catchBack(index);
                     _border[index] = false;
                     model.powerOver = true;
                  }
               }
               else
               {
                  isTouchBorder();
               }
            }
            else
            {
               isTouchBorder();
            }
            if(_loc6_.state != 2)
            {
               _loc6_.state = 1;
               for each(var _loc4_:FishSigModel in model.fishSigsModel)
               {
                  if(_loc4_.fishSigInfo.isCatch)
                  {
                     _loc4_.dispatchEvent(new FishEvent("FISH_SIG"));
                  }
               }
            }
         }
         else if(_catch[index])
         {
            if(isPowerFork)
            {
               rageFish();
               model.rage = false;
            }
            else
            {
               rageFish();
               if(!model.rage)
               {
                  catchBack(index);
               }
            }
            _catch[index] = false;
         }
         else if(model.isRageSuccess)
         {
            if(rageSuccessFlag)
            {
               rageSuccessFlag = false;
               model.isRageSuccess = false;
               catchBack(index);
               _loc2_ = catchFishList[0] as FishSigInfo;
               _loc2_.catchState = 1;
            }
         }
         if(isPlayOver(_loc5_))
         {
            _loc5_.stop();
            _loc5_.removeEventListener("enterFrame",__enterFrameHanlder);
            if(isThreeFork)
            {
               _loc6_.state = 4;
               model.threeCount++;
               if(model.threeCount == 3)
               {
                  model.threeOver = true;
                  model.threeCount = 0;
               }
               if(!model.threeOver)
               {
                  return;
               }
               model.setAllForkState(0);
               stopCatchFishMc();
            }
            else
            {
               model.setAllForkState(0);
               stopCatchFishMc();
            }
            if(catchFishList.length > 0)
            {
               _loc3_ = [];
               for each(_loc2_ in catchFishList)
               {
                  if(!isBlock(_loc2_))
                  {
                     _loc2_.fishState = -1;
                     _loc2_.catchState = 0;
                     _loc3_.push(_loc2_.fishId);
                  }
               }
               if(model.rage)
               {
                  model.rageOver();
                  if(model.isPointHelp)
                  {
                     model.isPointHelp = false;
                     FishManager.instance.fishAction(7,[1]);
                  }
                  else
                  {
                     FishManager.instance.fishAction(9);
                  }
               }
               else
               {
                  FishManager.instance.fishAction(10,_loc3_);
               }
               playIcon();
               for each(_loc2_ in catchFishList)
               {
                  setNormalState(_loc2_);
               }
               for each(_loc6_ in model.fishForkList)
               {
                  _loc6_.isCatch = false;
                  _loc6_.count = 0;
               }
               catchFishList.length = 0;
            }
            else
            {
               FishManager.instance.fishAction(10);
            }
            setInit();
            flag = true;
            rageSuccessFlag = true;
            model.initConst();
         }
      }
      
      private function playIcon() : void
      {
         _tempIdArr = [];
         _tempId = 0;
         var _loc2_:Boolean = false;
         if(model.rage)
         {
            _loc2_ = Boolean(model.rage);
            model.rage = false;
         }
         for each(var _loc1_:FishSigInfo in catchFishList)
         {
            if(!isBlock(_loc1_))
            {
               _tempIdArr.push(_loc1_.fishTempInfo.RewardId);
               if(_loc2_)
               {
                  if(model.isRageReward)
                  {
                     model.isRageReward = false;
                     _tempIdArr.push(_loc1_.fishTempInfo.RageId1);
                  }
               }
            }
         }
      }
      
      private function createIconAnime() : void
      {
         if(_tempIdArr[_tempIdArr.length - _animeCount - 1])
         {
            _tempId = _tempIdArr[_tempIdArr.length - _animeCount - 1];
         }
         var _loc1_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         _loc1_.icon = IconFactory.getGoodsIconByTID(_tempId);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var fishAnimePoint:Point;
         var bagPoint:Point;
         var icon:BaseIconView = param1;
         if(!_catchFishMc)
         {
            return;
         }
         fishAnimePoint = this.localToGlobal(new Point(_catchFishMc.x,_catchFishMc.y));
         icon.x = fishAnimePoint.x + 70;
         icon.y = fishAnimePoint.y + 100;
         icon.mouseChildren = icon.mouseEnabled = false;
         bagPoint = this.localToGlobal(new Point(_fishBagBtn.x,_fishBagBtn.y));
         if(icon)
         {
            _animeCount = _animeCount + 1;
            TweenMax.to(icon,2,{
               "delay":_animeCount * 0.3,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":bagPoint.x + 40,
                  "y":bagPoint.y + 30
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeIn,
               "onUpdate":function():void
               {
                  if(!icon.parent)
                  {
                     StageReferance.stage.addChild(icon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[icon]
            });
         }
         if(_tempIdArr.length > _animeCount)
         {
            createIconAnime();
         }
      }
      
      private function _moveComplete(param1:BaseIconView) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         if(_tempIdArr.length <= _animeCount)
         {
            _animeCount = 0;
         }
         ObjectUtils.disposeObject(param1);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_FISH_INFO",__updateFishInfoHandler);
         NotificationManager.instance.removeEventListener("UPDATE_FISH_FORK",__updateFishFORKHandler);
         model.removeEventListener("UPDATE_FISH_POOL",__updateFishPoolHandler);
         _fishBagBtn.removeEventListener("click",__fishBagHandler);
         if(gaff)
         {
            gaff.removeEventListener("enterFrame",__enterFrameHanlder);
            gaff.removeEventListener("enterFrame",__helpOverFrameHanlder);
         }
         if(gaffLeft)
         {
            gaffLeft.removeEventListener("enterFrame",__enterFrameHanlder);
         }
         if(gaffRight)
         {
            gaffRight.removeEventListener("enterFrame",__enterFrameHanlder);
         }
         for each(var _loc1_:FishSigModel in model.fishSigsModel)
         {
            _loc1_.removeEventListener("FISH_SIG",__fishSigHandler);
         }
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      public function get fishBagBtn() : BaseButton
      {
         return _fishBagBtn;
      }
      
      public function dispose() : void
      {
         TweenMax.killAll(true);
         removeEvent();
         if(_catchFishMc)
         {
            _catchFishMc.stop();
         }
         if(gaff)
         {
            gaff.stop();
         }
         if(gaffLeft)
         {
            gaffLeft.stop();
         }
         if(gaffRight)
         {
            gaffRight.stop();
         }
         _forkMCs = null;
         catchFishList = null;
         disposeFishList();
         if(_fishList)
         {
            _fishList = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_fishBagBtn);
         _fishBagBtn = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(gaff);
         ObjectUtils.disposeObject(gaffLeft);
         ObjectUtils.disposeObject(gaffRight);
         ObjectUtils.disposeObject(_catchFishMc);
         _catchFishMc = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get playermodel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

